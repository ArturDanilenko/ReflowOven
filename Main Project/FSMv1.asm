$NOLIST
$MODLP51
$LIST
$include(---whatever lcd thing is called --)

;CLK 	EQU 22118400 
;TIMER0_RATE 	EQU 4096
;TIMER0_RELOAD	EQU ((65536-(CLK/TIMER0_RATE)))

RAMPTOSOAK	equ 1
PREHEAT		equ 2
RAMPTOPEAK	equ 3
REFLOW		equ 4
COOLING		equ 5

b1		equ P(pin assignment)
b2		equ 
b3		equ
b4		equ
b5		equ
		
dseg at 0x30
temp_soak: ds 1
time_soak: ds 1
temp_refl: ds 1
time_refl: ds 1
temp: ds 1
timer: ds 1
state: ds 1
sec: ds 1

;max temp 235
;if not @ 100C after 60s turn off

main:
	mov SP, #0x7F
	
	setb EA ;donno if i need to?
	
	mov temp_soak, #150
	mov time _soak, #60
	mov temp_refl, #230
	mov time_refl, #45
	
	mov temp, #25
	mov timer, #0x00
	mov state, #0x00
	mov sec, #0x00
	
	
	
	
select:
	jb Button0, b1 ; if the 'BOOT' button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
	jb Button0, b1 ; if the 'BOOT' button is not pressed skip
	jnb Button0, $		
	mov a, #0
	mov state, a
	ret

b1:
	jb Button1, b2 ; if the 'BOOT' button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
	jb Button1, b2 ; if the 'BOOT' button is not pressed skip
	jnb Button1, $		
	lcall set_temp_soak
	lcall display_loop
	ret

b2:	
	jb Button2, b3 ; if the 'BOOT' button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
	jb Button2, b3 ; if the 'BOOT' button is not pressed skip
	jnb Button2, $		
	lcall set_time_soak
	lcall display_loop
	ret
	
b3:
	jb Button3, b4 ; if the 'BOOT' button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
	jb Button3, b4 ; if the 'BOOT' button is not pressed skip
	jnb Button3, $		
	lcall set_temp_refl
	lcall display_loop
	ret
	
b4:
	jb Button4, b5 ; if the 'BOOT' button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
	jb Button4, b5 ; if the 'BOOT' button is not pressed skip
	jnb Button4, $		
	lcall set_time_refl
	lcall display_loop
	ret
	
set_temp_soak:
	mov a, temp_soak
	add a, #0x05
	cjne a, #0x175, display1
	mov a, #0x130
display1:
	mov temp_soak, a
	ret
	
set_time_soak:
	mov a, time_soak
	add a, #0x05
	cjne a, #0x125, display2
	mov a, #0x60
display2:
	mov time_soak, a
	ret
	
set_temp_refl:
	mov a, temp_refl
	add a, #0x05
	cjne a, #0x240, display3
	mov a, #0x220	
display3:
	mov temp_refl, a
	ret	
	
set_time_refl:
	mov a, time_refl
	add a, #0x05
	cjne a, #0x50, display4
	mov a, #0x45
display4:
	mov time_refl, a
	ret
	
display_loop:
	Set_Cursor(,)
	Display_BCD(temp_soak)
	Set_Cursor(,)
	Displa_BCD(time_soak)
	Set_Cursor(,)
	Display_BCD(temp_refl)
	Set_Cursor(,)
	Displa_BCD(time_refl)
	ret	

display_state:
	Set_Cursor(,)
	Display_BCD(state)
	ret
	
forever:
	mov a, state
	lcall display_state

state0:
	cjne a, #0, state1
	mov pwm, #0
	lcall select
	lcall display_state
    jb KEY.3, state0_done
    Wait_Milli_Seconds(#50); -----
    jnb KEY.3, $ ; Wait for key release
    mov timer, #0x0 ;---------------------------------
    mov state, #1
state0_done:
    ljmp forever
	
state1:
    cjne a, RAMPTOSOAK, state2

    mov pwm, #100
    mov sec, #0
    mov a, timer
    cjne a, #0x60, cont ;-----
    add, a, #0x01
    mov timer, a
cont:
    mov a, temp_soak ;-----
    clr c
    subb a, temp ;----
    jnc state1_done
    mov state, #2
state1_done:
    ljmp forever
    
state2:
    cjne a, PREHEAT, state3
    mov pwm, #20
    mov a, time_soak;-----
    clr c
    subb a, sec ;----
    jnc state2_done
    mov state, #3
state2_done:
    ljmp forever
    
state3:
	cjne a, RAMPTOPEAK, state4
	mov pwm, #100
	mov sec, #0
	mov a, temp_refl;----
	clr c
	subb a, temp;---
	jnc state3_done
	mov state, #4
state3_done:
	ljmp forever

state4:
	cjne a, REFLOW, state5
	mov pwm, #20
	mov a, time_refl;----
	clr c
	subb a, sec;---
	jnc state4_done
	mov state, #5
;set of the beeper 
state4_done:
	ljmp forever
	
state5:
	cjne a, COOLING, state0
	mov pwm, #0
	mov a, #0x60 ;----
	clr c
	subb a, temp ;---
	jnc state5_done
	mov state, #0

;beeper goes off
;reset timer before jumping back
;setb ..

state5_done:
	ljmp forever
