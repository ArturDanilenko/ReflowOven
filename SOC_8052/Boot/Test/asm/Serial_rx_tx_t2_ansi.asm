$MODDE2
org 0000H
   ljmp MyProgram

DSEG at 30H
buffer: ds 30

FREQ   EQU 33333333
BAUD   EQU 115200
T2LOAD EQU 65536-(FREQ/(32*BAUD))

CSEG

InitSerialPort:
	; Configure serial port and baud rate
	clr TR2 ; Disable timer 2
	mov T2CON, #30H ; RCLK=1, TCLK=1 
	mov RCAP2H, #high(T2LOAD)  
	mov RCAP2L, #low(T2LOAD)
	setb TR2 ; Enable timer 2
	mov SCON, #52H
	ret

putchar:
    JNB TI, putchar
    CLR TI
    MOV SBUF, a
    RET

SendString:
    CLR A
    MOVC A, @A+DPTR
    JZ SSDone
    LCALL putchar
    INC DPTR
    SJMP SendString
SSDone:
    ret

SendBuffer:
    mov R0, #Buffer
SendBuffer1:
    MOV A, @R0
    JZ SendBufferDone
    LCALL putchar
    INC R0
    SJMP SendBuffer1
SendBufferDone:
    ret
    
Question:
    DB  01bh, '[31;1m', 'What is your name?', 0AH, 0DH, 01bh, '[30m', 0
Hello:
	DB 0AH, 0DH, 01bh, '[34m', 'Hello ', 0
nlcr:
	DB 0AH, 0DH, 0

getchar:
    jnb RI, getchar
    clr RI
    mov a, SBUF
    lcall putchar
    ret

GeString:
    mov R0, #buffer
GSLoop:
    lcall getchar
    push acc
    clr c
    subb a, #10H
    pop acc
    jc GSDone
    MOV @R0, A
    inc R0
    cjne R0, #(buffer+29), GSLoop ; Prevent buffer overrun
GSDone:
    clr a
    mov @R0, a
    ret
    
MyProgram:
    MOV SP, #7FH
    mov LEDRA, #0
    mov LEDRB, #0
    mov LEDRC, #0
    mov LEDG, #0
    
    LCALL InitSerialPort
    MOV DPTR, #Question
    
    LCALL SendString
    lcall GeString
    
    mov dptr, #Hello
    lcall SendString
    
    lcall SendBuffer
    
    mov dptr, #nlcr
    LCALL SendString
    
Forever:
    SJMP Forever
END
