; Unfortunately the maximum baurate we can use with timer 1 is 57600
; so make sure you configure putty/matlab/python accordingly.
$NOLIST
$MODDE1SOC
$LIST

CLK EQU 33333333
BAUD EQU 57600
TIMER_1_RELOAD EQU (256-((2*CLK)/(12*32*BAUD)))
TIMER_10ms EQU (65536-(CLK/(12*100)))

cseg
	ljmp MainProgram

Initialize_Serial_Port:
	; Configure serial port and baud rate
	clr TR1 ; Disable timer 1
	anl TMOD, #0x0f ; Mask the bits for timer 1
	orl TMOD, #0x20 ; Set timer 1 in 8-bit auto reload mode
    orl PCON, #80H ; Set SMOD to 1
	mov TH1, #low(TIMER_1_RELOAD)
	mov TL1, #low(TIMER_1_RELOAD) 
	setb TR1 ; Enable timer 1
	mov SCON, #52H
	ret

putchar:
	jbc	TI,putchar_L1
	sjmp putchar
putchar_L1:
	mov	SBUF,a
	ret

SendString:
    clr a
    movc a, @a+dptr
    jz SendString_L1
    lcall putchar
    inc dptr
    sjmp SendString  
SendString_L1:
	ret

; Wait 10 millisecond using Timer 0
Wait10ms:
	clr	TR0
	mov	a,#0xF0
	anl	a,TMOD
	orl	a,#0x01
	mov	TMOD,a
	mov	TH0, #high(TIMER_10ms)
	mov	TL0, #low(TIMER_10ms)
	clr	TF0
	setb TR0
	jnb	TF0,$
	clr	TR0
	ret
	
; Wait R2 10-milliseconds
MyDelay:
	lcall Wait10ms
    djnz R2, MyDelay
	ret
	
Initialize_LEDs:
    ; Turn off LEDs
	mov	LEDRA,#0x00
	mov	LEDRB,#0x00
	ret
	
InitialString: db '\r\nHello, World!\r\n', 0

MainProgram:
    mov sp, #0x7f
    lcall Initialize_LEDs
    lcall Initialize_Serial_Port
    
    mov dptr, #InitialString
    lcall SendString

forever:
	mov R2, #50
	lcall MyDelay ; wait 0.5 seconds
	cpl LEDRA.0
	sjmp forever

end
