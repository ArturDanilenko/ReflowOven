; This program tests the LTC2308 avaliable in the newer version of the DE1-SoC board.
; Access to the input pins of the ADC is avalible at connector J15. Here is the top
; view of the connector:
;
; +--+
; |  | <-- Red power button
; +--+
;
; +-----+-----+
; + GND | IN7 |
; +-----+-----+H
; + IN6 | IN5 |
; +-----+-----+
; + IN4 | IN3 |
; +-----+-----+
; + IN2 | IN1 |
; ------+-----+
; + IN0 | 5V  |
; +-----+-----+
;      J15
; 
; Displays the result using the 7-segment displays and also sends it via the serial port to PUTTy.
;
; (c) Jesus Calvino-Fraga 2019
;
$NOLIST
$MODDE1SOC
$LIST

; Bits used to access the LTC2308
LTC2308_MISO bit 0xF8 ; Read only bit
LTC2308_MOSI bit 0xF9 ; Write only bit
LTC2308_SCLK bit 0xFA ; Write only bit
LTC2308_ENN  bit 0xFB ; Write only bit

;BUTTONS
button1		equ P2.1
button2		equ P2.2
button3		equ P2.3
button4		equ P2.4
button5		equ P2.5
;STATES
Select 		equ 0
RAMPTOSOAK	equ 1
PREHEAT		equ 2
RAMPTOPEAK	equ 3
REFLOW		equ 4
COOLING		equ 5
PARAM equ 4

CLK EQU 33333333
BAUD EQU 57600
TIMER_2_RELOAD EQU (65536-(CLK/(32*BAUD)))
TIMER_0_1ms EQU (65536-(CLK/(12*1000)))

;;
;;
;; PUSH BUTTON DEFINITIONS
;;
;;
TIMER0_RATE   EQU 4096     ; 2048Hz squarewave (peak amplitude of CEM-1203 speaker)
TIMER0_RELOAD EQU ((65536-(CLK/(12*TIMER0_RATE)))) ; The prescaler in the CV-8052 is 12 unlike the AT89LP51RC2 where is 1.
TIMER0_RELOADXL EQU (5*TIMER0_RELOAD)
TIMER2_RATE   EQU 1000    ; 1000Hz, for a timer tick of 1ms
TIMER2_RELOAD EQU ((65536-(CLK/(12*TIMER2_RATE))))
TIMER_1_RELOAD EQU (256-((2*CLK)/(12*32*BAUD)))


; Reset vector
org 0x0000
    ljmp MainProgram

; External interrupt 0 vector (not used in this code)
org 0x0003
	reti

; Timer/Counter 0 overflow interrupt vector
org 0x000B
	ljmp Timer0_ISR

; External interrupt 1 vector (not used in this code)
org 0x0013
	reti

; Timer/Counter 1 overflow interrupt vector (not used in this code)
org 0x001B
	reti

; Serial port receive/transmit interrupt vector (not used in this code)
org 0x0023 
	reti
	
; Timer/Counter 2 overflow interrupt vector
org 0x002B
	ljmp Timer2_ISR
	
SOUNDOUT     equ P1.0
UPDOWN        equ SWA.0

; Reset vector


; In the 8051 we can define direct access variables starting at location 0x30 up to location 0x7F
dseg at 0x30
Count1ms:     ds 2 ; Used to determine when half second has passed
BCD_counter:  ds 1 ; The BCD counter incrememted in the ISR and displayed in the main loop
Seconds:  ds 1
Minutes: ds 1
pwm: ds 1
x:   	ds 4
y:   	ds 4
bcd: 	ds 5
buffer: ds 30
vResult:	ds 2
cTemp:	ds 2
hTemp:	ds 3
tTemp: 	ds 3
realTemp: ds 3
;FSM Variables
temp_soak: ds 1
time_soak: ds 1
temp_refl: ds 1
time_refl: ds 1
temp: ds 1
timer: ds 1
state: ds 1
sec: ds 1
Aseconds: ds 1
WorkingTime: ds 1
Temperature: ds 1
SpeakerTimer: ds 1
shortbeepflag: ds 1
longbeepflag: ds 1
actuallylongbeepflag: ds 1
; In the 8051 we have variables that are 1-bit in size.  We can use the setb, clr, jb, and jnb
; instructions with these variables.  This is how you define a 1-bit variable:
bseg
half_seconds_flag: dbit 1 ; Set to one in the ISR every time 500 ms had passed
PwmFlag: dbit 1
mf: dbit 1

;longbeepflag: dbit 1

cseg	
BJTBase equ P0.0
ELCD_RS equ P1.2
ELCD_RW equ P1.3
ELCD_E  equ P1.4
ELCD_D4 equ P1.5
ELCD_D5 equ P1.6
ELCD_D6 equ P1.7
ELCD_D7 equ P0.6

CE_ADC	EQU P0.2
MY_MOSI EQU P0.0
MY_MISO EQU P2.0
MY_SCLK EQU P0.1

PWMout equ P0.3

$NOLIST
$include(IncludeFile0205.inc) ; A library of LCD related functions and utility macros
$include(math32.inc)
$LIST

InitialString: db '\r\nLTC2308 test program\r\n', 0
MyString: db 'Helo213qwq', 0
Hello_World: ;indent to separate numbers in the putty
    DB  '\r','\n', 0
helpfulspace:
	DB ' ', 0 

; Look-up table for the 7-seg displays. (Segments are turn on with zero) 
T_7seg:
    DB 40H, 79H, 24H, 30H, 19H, 12H, 02H, 78H, 00H, 10H
    
; Displays a BCD number in HEX1-HEX0
Display_BCD_7_Seg:
	
	mov dptr, #T_7seg
	
;	mov x, realTemp
;	mov x+1, realTemp+1
;	mov x+2, #0
;	mov x+3, #0
	
;	lcall hex2bcd
;	mov realTemp+1, bcd + 1
;	mov realTemp, bcd
	
	mov a, realTemp+1
	anl a, #0FH
	movc a, @a+dptr
	mov HEX5, a

	mov a, realTemp
	swap a
	anl a, #0FH
	movc a, @a+dptr
	mov HEX4, a
	
	mov a, realTemp
	anl a, #0FH
	movc a, @a+dptr
	mov HEX3, a
	
	mov HEX1, #0b0011100
	mov HEX0, #0b1000110
	
	ret

; Display the 4-digit bcd stored in [R3,R2] using the 7-segment displays


; Send a 4-digit BCD number stored in [R3,R2] to the serial port	

	
; Wait 1 millisecond using Timer 0
Wait1ms:
	clr	TR0
	mov	a,#0xF0
	anl	a,TMOD
	orl	a,#0x01
	mov	TMOD,a
	mov	TH0, #high(TIMER_0_1ms)
	mov	TL0, #low(TIMER_0_1ms)
	clr	TF0
	setb TR0
	jnb	TF0,$
	clr	TR0
	ret
	
; Wait R2 milliseconds
MyDelay:
	lcall Wait1ms
    djnz R2, MyDelay
	ret
	
Timer0_Init:
	mov a, TMOD
	anl a, #0xf0 ; Clear the bits for timer 0
	orl a, #0x01 ; Configure timer 0 as 16-timer
	mov TMOD, a
	mov TH0, #high(TIMER0_RELOAD)
	mov TL0, #low(TIMER0_RELOAD)
	; Enable the timer and interrupts
    setb ET0  ; Enable timer 0 interrupt
    setb TR0  ; Start timer 0
	ret

;---------------------------------;
; ISR for timer 0.  Set to execute;
; every 1/4096Hz to generate a    ;
; 2048 Hz square wave at pin P3.7 ;
;---------------------------------;
Timer0_ISR:
;	clr TF0  ; According to the data sheet this is done for us already.

	mov TH0, #high(TIMER0_RELOAD) ; Timer 0 doesn't have autoreload in the CV-8052
	mov TL0, #low(TIMER0_RELOAD) 
;	mov a, actuallylongbeepflag
;	add a, #1
;	cjne a, #2, LoadLongTimeReload
	cpl SoundOut
;	mov actuallylongbeepflag, a
;	reti
;LoadLongTimeReload:
	
	reti

;---------------------------------;
; Routine to initialize the ISR   ;
; for timer 2                     ;
;---------------------------------;

Timer2_Init:
	mov T2CON, #0 ; Stop timer/counter.  Autoreload mode.
	mov TH2, #high(TIMER2_RELOAD)
	mov TL2, #low(TIMER2_RELOAD)
	; Set the reload value
	mov RCAP2H, #high(TIMER2_RELOAD)
	mov RCAP2L, #low(TIMER2_RELOAD)
	cpl LEDRA.1
	; Init One millisecond interrupt counter.  It is a 16-bit variable made with two 8-bit parts
	clr a
	mov Count1ms+0, a
	mov Count1ms+1, a
	; Enable the timer and interrupts
    setb ET2  ; Enable timer 2 interrupt
    setb TR2  ; Enable timer 2

	ret

;---------------------------------;
; ISR for timer 2                 ;
;---------------------------------;
Timer2_ISR:
	clr TF2  ; Timer 2 doesn't clear TF2 automatically. Do it in ISR
;	cpl P1.1 ; To check the interrupt rate with oscilloscope. It must be precisely a 1 ms pulse.
	
	; The two registers used in the ISR must be saved in the stack
	push acc
	push psw
	
	; Increment the 16-bit one mili second counter
	inc Count1ms+0    ; Increment the low 8-bits first
	mov a, Count1ms+0 ; If the low 8-bits overflow, then increment high 8-bits

	jnz Inc_Done
	inc Count1ms+1

Inc_Done:;===========================================ISR MAIN=============================================
	; Check if half second has passed
	mov a, Count1ms+0
	cjne a, #low(250), ISR_done ; Warning: this instruction changes the carry flag!
	mov a, Count1ms+1
	cjne a, #high(250), ISR_done
	
	; 500 milliseconds have passed.  Set a flag so the main program knows
	setb half_seconds_flag ; Let the main program know half second had passed
	; Toggle LEDR0 so it blinks
	;=====================Timer 0 controls============================================
	;cpl LEDRA.0
	mov a, state
	cjne a, #0, DoPwm
	sjmp DontDo
DoPwm:
	lcall pwmmodule
DontDo:
	Set_Cursor(2, 15)     ; the place in the LCD where we want the BCD counter value
	Display_BCD(state)
	;Display_BCD(speakertimer)
	mov a, shortbeepflag
	cjne a, #0, Beep
	mov a, actuallylongbeepflag
	cjne a, #0, Beep
;	clr TR0
	sjmp skiptheskip
ISR_done:
	ljmp Timer2_ISR_done
Beep:
	setb TR0
	;clr soundout
	cpl LEDRA.6
	mov a, SpeakerTimer
	add a, #0x01
	cjne a, #0x02, KeepGoing
	clr a
	mov SpeakerTimer, a
	mov shortbeepflag, #0
	clr TR0
	;setb soundout
		cpl LEDRA.0
	sjmp skiptheskip
KeepGoing: 
	mov SpeakerTimer, a
	sjmp skipbeep
skiptheskip:
;	clr TR0 ; Enable/disable timer/counter 0. This line creates a beep-silence-beep-silence sound.
	; Reset to zero the milli-seconds counter, it is a 16-bit variable
cpl LEDRA.3
	mov a, longbeepflag
	cjne a, #0, LongBeep1
;	clr TR0
	sjmp skipbeep
LongBeep1:
	setb TR0
;	clr soundout
	mov a, SpeakerTimer
	add a, #0x01
	cjne a, #0x05, KeepGoing1
	clr a
	mov SpeakerTimer, a
	mov longbeepflag, #0
	clr TR0
;	setb soundout
	cpl LEDRA.2
	;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%where tf do we jump
KeepGoing1: 
	mov SpeakerTimer, a
	cpl TR0
;	setb soundout
	
skipbeep:
	
;	sjmp skipbeep
skipmorebeeps:
	clr a
	;=====================Display=============================================
	mov x+0, Aseconds+0
	mov x+1, #0
	mov x+2, #0
	mov x+3, #0
;
;	Load_Y(1)
;	lcall mul32
	lcall hex2bcd
;	Send_BCD(bcd+1)
	
	Set_cursor(2,1)
	Display_BCD(bcd+1)
	Set_cursor(2,4)
;	Send_BCD(bcd)
	Display_BCD(bcd)
;	mov DPTR, #Hello_World
;	lcall SendString
;==============================================================================================
	mov Count1ms+0, a
	mov Count1ms+1, a
	; Increment the BCD counter
	
;	mov a, MyHope
;	add a, #1
;	mov MyHope, a
	
	lcall ReadTemperature
;	mov a, Seconds
;	jb UPDOWN, Timer2_ISR_decrement
;	add a, #0x01
	
	
	
Timer2_ISR_da:
	mov a, seconds
	add a, #1
	cjne a, #PARAM, NoTReset
	mov seconds, #0
	mov a, Aseconds
	add a, #1
	mov Aseconds, a
	sjmp skipresethere
NoTReset:
	mov seconds, a
skipresethere:
	
Timer2_ISR_done:
	pop psw
	pop acc
	reti
	

MainProgram:;============================MAIN===========================================================
    mov sp, #0x7f
    lcall Timer0_Init
    lcall Timer2_Init
    lcall Initialize_LEDs
    lcall Initialize_Serial_Port
    lcall Initialize_ADC
    lcall Timer0_Init
    lcall Timer2_Init
    lcall INIT_SPI
    clr TR0
;FSM Variables  ==================
  	clr a
  	mov temp_soak, a
    mov temp_soak, #0x82 ; Will remain in hex, 0x82 is orig value else is for debugging
	mov time_soak, #0x3c	 ;HAS TO BE IN HEX only convert to bcd for display!
	mov temp_refl, #0xdc ;230 0xdc is original, else debug
	mov time_refl, #0x14 ;65
	
	mov temp, #25
	mov timer, #0x00
	mov state, #0x00
	mov sec, #0x01
	mov minutes, #0
	mov mf, #0
	mov Aseconds, #0
	mov WorkingTime, #0x00
	mov shortbeepflag, #0
	mov longbeepflag, #0
	mov actuallylongbeepflag, #0
	mov speakertimer, #0
;========================
  ;  lcall InitSerialPort
  	;clr TR0
    mov P0MOD, #11111111b ; P0.0 to P0.6 are outputs.  ('1' makes the pin output)
    ; We use pins P1.0 and P1.1 as outputs also.  Configure accordingly.
    mov P1MOD, #11111111b ; P1.0 and P1.0 are outputs
    lcall ELCD_4BIT
  ;  clr EX1
    setb EA

;	Set_Cursor(1,1)F
;	Send_Constant_String(#MyString)
	cpl LEDRA.4
	setb half_seconds_flag
	mov Seconds, #0x50
	lcall DisplayVariables
;	cpl TR0
forever:;======================================================FOREVER===========================================================
	mov a, SWA ; read the channel to convert from the switches
	anl a, #00000111B ; We need only the last three bits since there are only eight channels
	mov b, a
	lcall LTC2308_RW  ; Read the channel from the ADC
	lcall hex2bcd16   ; Convert to bcd
;	lcall Display_BCD1 ; Display using the 7-segment displays
;	lcall SendNumber  ; Send to serial port
;	jnb BJTBase, pinpressed
	mov R2, #250
	
	jb KEY.1, loop_a  ; if the KEY1 button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit_DE1SoC.inc'
	jb KEY.1, loop_a  ; if the KEY1 button is not pressed skip
	jnb KEY.1, $	
	clr TR2 ; Stop timer 2
	clr a
	mov Count1ms+0, a
	mov Count1ms+1, a
	; Now clear the BCD counter
	mov BCD_counter, a
	setb TR2    ; Start timer 2
	sjmp loop_b ; Display the new value
loop_a:;======================================================FOREVER================================================
	jnb half_seconds_flag, forever
loop_b:;======================================================FOREVER================================================
	clr half_seconds_flag ; We clear this flag in the main loop, but it is set in the ISR for timer 2
;	Set_Cursor(2, 15)     ; the place in the LCD where we want the BCD counter value
	;Display_BCD(state)
;	Display_BCD(sec)
;	cpl LEDRA.4

    mov a, state
 ;=======================================================STATE 0========================================
ResetState:
	cjne a, #select, RampToSoakState
;Display Time Soak
	mov minutes, #0				;set timer to zero until state 1 is active
	mov seconds, #0
	jnb button1, Pathnextstate
	jnb button2, PathTempSoakAdjust
	jnb button3, PathTimeSoakAdjust
	jnb button4, PathTempReflowAdjust
	jnb button5, PathTimeReflowAdjust ; TimeReflowAdjust jump

	sjmp RampToSoakState
PathTempSoakAdjust:
	lcall TempSoakAdjust
	sjmp SkipSetup1
PathTimeSoakAdjust:
	lcall TimeSoakAdjust
	sjmp SkipSetup1
PathTimeReflowAdjust: 
	lcall TimeReflowAdjust
	sjmp SkipSetup1
PathTempReflowAdjust:
	lcall TempReflowAdjust
	sjmp SkipSetup1
PathNextState:
	ljmp nextstate
SkipSetup1:;=====================CHANGE  OF STATES==============================================
	ljmp forever

	;mov Seconds, #0x00
	;mov minutes, #0
RampToSoakState:	;==============================STATE 1================================================
	cjne a, #RampToSoak, PreHeatState
	mov WorkingTime, #0x28
	
  ;  mov sec, #0
 ;=============================Checking ih current temp has reaches soak temp==========================================   
	mov x, RealTemp
	mov x+1, #0
	mov x+2, #0
	mov x+3, #0

	mov a, temp_soak
	subb a, #0x0a
	mov temperature, a
	mov a, state
	mov y, temperature
	mov y+1, #0
	mov y+2, #0
	mov y+3, #0
	lcall x_lt_y
;====================================If its reached, move on to the next state, if not abort if 60 seconds passed=============
	jnb	mf, nextstatepath
	
	mov a, Aseconds
    cjne a, #0x3c, SkipSetup1
    mov y, #0x3c
	lcall x_lt_y
	jnb mf, skipsetup1
	
    ljmp abort

PreHeatState:;====================================================STATE 2===========================================
	cjne a, #PreHeat, RampToHeatState
	mov WorkingTime, #0x04
	mov a, Aseconds
	cjne a, Time_Soak, SkipSetup
	lcall nextstate
RampToHeatState:;====================================================STATE 3===========================================
	cjne a, #RampToPeak, ReflowState
	mov WorkingTime, #0x28
	mov x, RealTemp
	mov x+1, #0
	mov x+2, #0
	mov x+3, #0
	
	mov y, temp_refl
	mov y+1, #0
	mov y+2, #0
	mov y+3, #0
	lcall x_lt_y
			
	jnb	mf, nextstate
	sjmp SkipSetup
ReflowState:
 	cjne a, #Reflow, CoolingState

 	mov WorkingTime, #0x04
	
	;subb a, #0x0a
	;	mov a, Aseconds
   ; cjne a, #0x3c, nextstate
    mov y, RealTemp
    mov y + 1, #0
    mov y + 2, #0
    mov y + 3, #0
    
    Load_Y(0xeb)
	lcall x_lt_y
	jnb mf, nextstate
	
   ; ljmp abort
	mov a, Aseconds
	cjne a, Time_Refl, SkipSetup
	lcall nextstate
nextstatepath:
	sjmp nextstate
CoolingState:
	cjne a, #Cooling, SkipSetup
	mov WorkingTime, #0x00
	mov x, RealTemp
	mov x+1, #0
	mov x+2, #0
	mov x+3, #0

	mov y, #0x3c
	mov y+1, #0
	mov y+2, #0
	mov y+3, #0
	lcall x_lt_y
			
	jb	mf, nextstate
	
SkipSetup:;=====================CHANGE  OF STATES==============================================
	
	ljmp forever
nextstate: ;=====================CHANGE  OF STATES==============================================
	Wait_Milli_Seconds(#50)
	mov seconds, #0
	mov Aseconds, #0
	mov a, state
	add a, #1
	cjne a, #6, NoStateReset
	lcall longbeep
	mov state, #0
	

	ljmp SkipSetup
abort: ;=================================ABORT1=====================================================
	mov state, #0
	mov pwm, #0
	mov WorkingTime, #0x00
	mov Aseconds, #0
	clr Pwmout
	ljmp SkipSetup
;====================================================PATHS==(if ljmp is outside of bounds)==============================================

NoStateReset:;=====================STATE OVERFLOW==============================================
	mov state, a
	;cpl LEDRA.7
	cjne a, #5, SWAG4DAYZ
;	lcall actuallylongbeep
	lcall shortbeep
	sjmp skipswag
SWAG4DAYZ:
	lcall shortbeep
	;lcall actuallylongbeep
skipswag:	
	ljmp SkipSetup	

ReadTemperature: 
	Read_ADC_Channel(0)
	volt2ctemp(cTemp) 
;	mov cTemp, #25
	Read_ADC_Channel(3)
	volt2htemp(hTemp)
 
 	lcall addTemps
 ;======Display PUTTY=====================================================================================


	; this is a new line
;	mov DPTR, #Hello_World
;	lcall SendString

	
	; ============send oven temp to putty===============
	Send_BCD(realTemp+1)
	Send_BCD(realTemp)
	mov DPTR, #helpfulspace
	lcall SendString
	mov x, state
	lcall Hex2bcd
	mov state, bcd
	Send_BCD(state)	
;	Send_BCD(bcd+1)
;	Send_BCD(bcd)
	; ==================display oven temp on LCD==============
	Set_Cursor(2, 9)
	Display_BCD(realTemp+1)
	Set_Cursor(2, 11)
	Display_BCD(realTemp)
;	Set_Cursor(2, 9)
;	Display_BCD(bcd+1)
;	Set_Cursor(2, 11)
;	Display_BCD(bcd)
	mov DPTR, #Hello_World
	lcall SendString
	lcall Display_BCD_7_Seg
	
	; ================== send "hot temp" to putty===========
	mov DPTR, #Hello_World
	lcall SendString
;	Send_BCD(cTemp+1)
;	Send_BCD(cTemp)
	
		
	mov bcd + 0, RealTemp + 0
	mov bcd + 1, RealTemp + 1
	mov bcd+2, #0
	mov bcd+3, #0
	mov bcd+4, #0
	lcall bcd2hex
	mov RealTemp+0, x+0
	mov RealTemp+1,x+1
ret
    
DisplayVariables:
	set_cursor(1,5)
	mov x+0, Time_Soak + 0
	mov x+1, #0
	mov x+2, #0
	mov x+3, #0
	lcall hex2bcd
	Display_bcd(bcd+1)
	set_cursor(1,7)
	Display_bcd(bcd)
;Display Temp Soak	
	set_cursor(1,0)
	mov x+0, Temp_Soak + 0
	lcall hex2bcd
	Display_bcd(bcd+1)
	set_cursor(1,2)
	Display_bcd(bcd)
;display time Reflow
	mov x+0, Time_Refl + 0
	lcall hex2bcd
	set_cursor(1,15)
	Display_bcd(bcd)
;display temp reflow
	set_cursor(1,10)
	mov x+0, Temp_Refl + 0
	lcall hex2bcd
	Display_bcd(bcd+1)
	set_cursor(1,12)
	Display_bcd(bcd)
	ret
	
TempSoakAdjust:;=====================Soak Temperature adjustment==============================================
	Wait_Milli_Seconds(#50);
	mov a, temp_soak
	add a, #0x01
	;cpl LEDRA.6
	cjne a, #0xab, TempSoakNotOverflow ;0xab = 171
	mov temp_soak, #0x82 ;0x82 = 130
	set_cursor(1,0)
	mov x+0, Temp_Soak + 0
	lcall hex2bcd
	Display_bcd(bcd+1)
	set_cursor(1,2)
	Display_bcd(bcd)
	ret
	;ljmp SkipSetup
TempSoakNotOverflow:;=====================Soak Temperature no overflow==============================================
	mov temp_soak, a
	set_cursor(1,0)
	mov x+0, Temp_Soak + 0
	lcall hex2bcd
	Display_bcd(bcd+1)
	set_cursor(1,2)
	Display_bcd(bcd)
    ret
TimeSoakAdjust:;=====================Soak time Adjustment==============================================
	Wait_Milli_Seconds(#50)
	mov a, Time_Soak
	add a, #0x01
	cjne a, #0x79, TimeSoakNotOverflow;0x79=121
	mov time_soak, #0x3c ;0x3c=60
		set_cursor(1,5)
	mov x+0, Time_Soak + 0
	mov x+1, #0
	mov x+2, #0
	mov x+3, #0
	lcall hex2bcd
	Display_bcd(bcd+1)
	set_cursor(1,7)
	Display_bcd(bcd)
	ret
TimeSoakNotOverflow:;=====================Soak time no overflow==============================================
	mov time_soak, a
	set_cursor(1,5)
	mov x+0, Time_Soak + 0
	mov x+1, #0
	mov x+2, #0
	mov x+3, #0
	lcall hex2bcd
	Display_bcd(bcd+1)
	set_cursor(1,7)
	Display_bcd(bcd)
	ret
TempReflowAdjust:;=====================Reflow Temp adjusment=============================================
	Wait_Milli_Seconds(#50)
	mov a, Temp_Refl
	add a, #0x01
	cjne a, #0xe6, TempReflowNotOverflow ;0xe6 = 230 TBC POSSIBLY
	mov Temp_Refl, #0xd9 ;0xd9 = 217
	set_cursor(1,10)
	mov x+0, Temp_Refl + 0
	lcall hex2bcd
	Display_bcd(bcd+1)
	set_cursor(1,12)
	Display_bcd(bcd)
	ret
TempReflowNotOverflow:
	mov temp_refl, a
	set_cursor(1,10)
	mov x+0, Temp_Refl + 0
	lcall hex2bcd
	Display_bcd(bcd+1)
	set_cursor(1,12)
	Display_bcd(bcd)
	ret
TimeReflowAdjust:;=====================Reflow TIME adjusment=============================================
	Wait_Milli_Seconds(#50)
	mov a, Time_Refl
	add a, #0x01
	cjne a, #0x2e, TimeReflowNotOverflow ; 0x4c=76
	mov Time_Refl, #0x14 ;0x2d = 45
	mov x+0, Time_Refl + 0
	lcall hex2bcd
	set_cursor(1,15)
	Display_bcd(bcd)
	ret
TimeReflowNotOverflow:;=====================Soak time no overflow==============================================
	mov time_Refl, a
	mov x+0, Time_Refl + 0
	lcall hex2bcd
	set_cursor(1,15)
	Display_bcd(bcd)
	ret


PWMmodule:
	mov a, sec
;	
	cjne a, #40, DontReset
	mov sec, #0
BackUp:	
;	mov a, sec
	mov x, sec
	mov x+1, #0
	mov x+2, #0
	mov x+3, #0

	mov y, WorkingTime
	mov y+1, #0
	mov y+2, #0
	mov y+3, #0
	lcall x_lteq_y
;====================================If its reached, move on to the next state, if not abort if 60 seconds passed=============
	jb	mf, SetPwmFlagOn
	clr a
	mov PWMFlag, a
	
;	cpl SOUND_OUT ; Connect speaker to P3.7!
	sjmp Power
SetPwmFlagOn:

	setb PWMFlag
Power: 	
	mov a, sec
	add a, #1
	mov sec, a
;	cpl LEDRA.3
	mov a, PWMFlag
	cjne a, #0, TurnITON
	clr PWMout
	
	ret
	
TurnItOn:
	setb PWMout
	ret
	
DontReset:
	mov sec, a
	sjmp BackUp
shortbeep:
	mov ShortBeepFlag, #1
	cpl LEDRA.5
	ret
longbeep:
	mov LongBeepFlag, #1
	ret	
actuallylongbeep:
	;mov actuallylongbeepflag, #1
	ret
end