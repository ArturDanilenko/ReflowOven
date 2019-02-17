;
; count.asm: Shows counter in the seven segment displays of DE2 board
; by Jesus Calvino-Fraga, 2008-2011
;
$MODDE2
;

CSEG
org 0000H
   ljmp MyProgram

; The DE2 is running at 11.11MHz @ one clock per cycle!  Therefore, we need big
; loops to wait 1 second!  One machine cycle takes 90ns.
Wait1s:
	mov R2, #59
L3: mov R1, #250
L2: mov R0, #250
L1: djnz R0, L1 ; 2 machine cycles-> 2*90ns*250=45us
    djnz R1, L2 ; 45us*250=0.0113s
    djnz R2, L3 ; 0.0113s*89=1s (approximately)
    ret

MyProgram:
    mov SP, #7FH ; Set the stack pointer to the begining of idata
    ; Initialize our BCD counter to zero
	MOV R3, #00H 
	MOV R4, #00H
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDG, #0

forever:
	; Display the 16-bit number stored in R3-R4
	mov a,R4
	anl a,#0FH
	mov dptr,#Disp7Seg
	movc a, @a+dptr
	mov HEX0, a
	
	mov a,R4
	swap a
	anl a,#0FH
	mov dptr,#Disp7Seg
	movc a, @a+dptr
	mov HEX1, a
	
	mov a,R3
	anl a,#0FH
	mov dptr,#Disp7Seg
	movc a, @a+dptr
	mov HEX2, a
	
	mov a,R3
	swap a
	anl a,#0FH
	mov dptr,#Disp7Seg
	movc a, @a+dptr
	mov HEX3, a

	lcall Wait1s
	
	;Increment R3-R4 in BCD!
	mov a, R4
	add a, #1
	da a
	mov R4, a
	mov a, R3
	addc a, #0
	da a
	mov R3, a

    sjmp forever


 ; The table below holds the LED patterns for each digit.
; Zero turns the LED on.
Disp7Seg:
	DB 11000000B ; 0
	DB 11111001B ; 1
	DB 10100100B ; 2
	DB 10110000B ; 3
	DB 10011001B ; 4
	DB 10010010B ; 5
	DB 10000010B ; 6
	DB 11111000B ; 7
	DB 10000000B ; 8
	DB 10010000B ; 9
	DB 10001000B ; A
	DB 10000011B ; B
	DB 11000110B ; C
	DB 10100001B ; D
	DB 10000110B ; E
	DB 10001110B ; F
END
