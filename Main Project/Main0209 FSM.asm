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
; +-----+-----+
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
TIMER2_RATE   EQU 1000     ; 1000Hz, for a timer tick of 1ms
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
	
SOUND_OUT     equ P1.0
UPDOWN        equ SWA.0

; Reset vector


; In the 8051 we can define direct access variables starting at location 0x30 up to location 0x7F
dseg at 0x30
Count1ms:     ds 2 ; Used to determine when half second has passed
BCD_counter:  ds 1 ; The BCD counter incrememted in the ISR and displayed in the main loop
Seconds:  ds 1
x:   	ds 4
y:   	ds 4
bcd: 	ds 5
buffer: ds 30
vResult:	ds 2
cTemp:	ds 2
hTemp:	ds 3
tTemp: 	ds 3
;FSM Variables
temp_soak: ds 1
time_soak: ds 1
temp_refl: ds 1
time_refl: ds 1
temp: ds 1
timer: ds 1
state: ds 1
sec: ds 1
; In the 8051 we have variables that are 1-bit in size.  We can use the setb, clr, jb, and jnb
; instructions with these variables.  This is how you define a 1-bit variable:
bseg
half_seconds_flag: dbit 1 ; Set to one in the ISR every time 500 ms had passed
mf: dbit 1

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

PWM equ P0.3

$NOLIST
$include(IncludeFile0205.inc) ; A library of LCD related functions and utility macros
$include(math32.inc)
$LIST

InitialString: db '\r\nLTC2308 test program\r\n', 0
MyString: db 'Helo213qwq', 0
Hello_World: ;indent to separate numbers in the putty
    DB  '\r','\n', 0

; Look-up table for the 7-seg displays. (Segments are turn on with zero) 
T_7seg:
    DB 40H, 79H, 24H, 30H, 19H, 12H, 02H, 78H, 00H, 10H

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
;	cpl SOUND_OUT ; Connect speaker to P3.7!
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

Inc_Done:
	; Check if half second has passed
	mov a, Count1ms+0
	cjne a, #low(500), Timer2_ISR_done ; Warning: this instruction changes the carry flag!
	mov a, Count1ms+1
	cjne a, #high(500), Timer2_ISR_done
	
	; 500 milliseconds have passed.  Set a flag so the main program knows
	setb half_seconds_flag ; Let the main program know half second had passed
	; Toggle LEDR0 so it blinks
	cpl LEDRA.0
	cpl TR0 ; Enable/disable timer/counter 0. This line creates a beep-silence-beep-silence sound.
	; Reset to zero the milli-seconds counter, it is a 16-bit variable
	clr a
;	mov x+0, Temp_soak+0
;	mov x+1, Temp_soak+1
;	Load_Y(1)
;	lcall mul32
;	lcall hex2bcd
;	Send_BCD(bcd+1)
;	Send_BCD(bcd)
	mov Count1ms+0, a
	mov Count1ms+1, a
	; Increment the BCD counter
	
	

	mov a, Seconds
	lcall ReadTemperature
	jb UPDOWN, Timer2_ISR_decrement
	add a, #0x01
	sjmp Timer2_ISR_da
Timer2_ISR_decrement:
	add a, #0x99 ; Adding the 10-complement of -1 is like subtracting 1.
Timer2_ISR_da:
	da a ; Decimal adjust instruction.  Check datasheet for more details!
	mov Seconds, a
	
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
  ;FSM Variables  ==================
    mov temp_soak, #230
	mov time_soak, #60
	mov temp_refl, #230
	mov time_refl, #45
	
	mov temp, #25
	mov timer, #0x00
	mov state, #0x00
	mov sec, #0x00
;========================
  ;  lcall InitSerialPort
     	mov P0MOD, #11111111b ; P0.0 to P0.6 are outputs.  ('1' makes the pin output)
    ; We use pins P1.0 and P1.1 as outputs also.  Configure accordingly.
    mov P1MOD, #11111111b ; P1.0 and P1.0 are outputs
    lcall ELCD_4BIT
  ;  clr EX1
    setb EA

	Set_Cursor(1,1)
	Send_Constant_String(#MyString)
	cpl LEDRA.4
	setb half_seconds_flag
	mov Seconds, #0x5
forever:;============================FOREVER===========================================================
	mov a, SWA ; read the channel to convert from the switches
	anl a, #00000111B ; We need only the last three bits since there are only eight channels
	mov b, a
	lcall LTC2308_RW  ; Read the channel from the ADC
	lcall hex2bcd16   ; Convert to bcd
;	lcall Display_BCD1 ; Display using the 7-segment displays
;	lcall SendNumber  ; Send to serial port
;	jnb BJTBase, pinpressed
	mov R2, #250
	;lcall MyDelay
	;Wait_Milli_Seconds(#25)
	;Wait_Milli_Seconds(#250)
	
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
loop_a:
	jnb half_seconds_flag, forever
loop_b:
	clr half_seconds_flag ; We clear this flag in the main loop, but it is set in the ISR for timer 2
;	Set_Cursor(1, 14)     ; the place in the LCD where we want the BCD counter value
;	Display_BCD(Seconds)
;	cpl LEDRA.4
    mov a, state
	cjne a, #select, SkipSetup
	cpl LEDRA.5
	jnb button1, nextstate
	jnb button2, TempSoakAdjust
;	jnb button3, TimeSoakAdjust
;	jnb button4, TempReflowAdjust
;	jnb button5, TimeRelfowAdjust
	;Wait_Milli_Seconds(#50)
		
	
SkipSetup:;=====================CHANGE  OF STATES==============================================
	ljmp forever
nextstate: ;=====================CHANGE  OF STATES==============================================
	Wait_Milli_Seconds(#50)
	mov a, state
	add a, #1
	cjne a, #6, NoStateReset
	mov state, #0
	cpl LEDRA.7
	ljmp SkipSetup
NoStateReset:;=====================STATE OVERFLOW==============================================
	mov state, a
	cpl LEDRA.7
	ljmp SkipSetup	
TempSoakAdjust:
	Wait_Milli_Seconds(#50)
	mov a, temp_soak
	add a, #1
	cpl LEDRA.6
	cjne a, #240, TempSoakOverflow
	mov temp_soak, #25
	ljmp SkipSetup
;TimeSoakAdjust:
;	ljmp SkipSetup
;TempReflowAdjust:
;	ljmp SkipSetup
;TimeReflowAdjust:
;	ljmp SkipSetup
TempSoakOverflow:
	mov temp_soak, a
	ljmp SkipSetup
ReadTemperature: 
	Read_ADC_Channel(0)
	volt2ctemp(cTemp) 
	Read_ADC_Channel(6)
	volt2htemp(hTemp)
	
	mov a, hTemp
	add a, cTemp
	mov hTemp, a

	Set_Cursor(2,1)
	Display_BCD(hTemp+1)
	Set_Cursor(2,3)
	Display_BCD(hTemp)
	Set_Cursor(2,5)
	Display_BCD(cTemp)
	Send_BCD(cTemp+1)
	Send_BCD(cTemp)
	mov DPTR, #Hello_World
	lcall SendString
	Send_BCD(hTemp+1)
	Send_BCD(hTemp)
	mov DPTR, #Hello_World
	lcall SendString
ret
callnextstate: 
	lcall nextstate
end
