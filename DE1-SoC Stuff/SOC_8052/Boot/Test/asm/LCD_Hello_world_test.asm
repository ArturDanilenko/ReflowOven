$MODDE2
org 0
   ljmp mycode
   
Wait40us:
	mov R0, #149
X1: 
	nop
	nop
	nop
	nop
	nop
	nop
	djnz R0, X1 ; 9 machine cycles-> 9*30ns*149=40us
    ret

LCD_command:
	mov	LCD_DATA, A
	clr	LCD_RS
	nop
	nop
	setb LCD_EN ; Enable pulse should be at least 230 ns
	nop
	nop
	nop
	nop
	nop
	nop
	clr	LCD_EN
	ljmp Wait40us

LCD_put:
	mov	LCD_DATA, A
	setb LCD_RS
	nop
	nop
	setb LCD_EN ; Enable pulse should be at least 230 ns
	nop
	nop
	nop
	nop
	nop
	nop
	clr	LCD_EN
	ljmp Wait40us
		    
mycode:
    mov SP, #7FH
    clr a
    mov LEDRA, a
    mov LEDRB, a
    mov LEDRC, a
    mov LEDG, a

	mov dptr, #Banner
	mov R5, #low(0x8101)
	mov R6, #high(0x8101)
	lcall Copy_Code_to_Xdata
	mov dptr, #0x8100
	mov a, R4
	movx @dptr, a

    ; Turn LCD on, and wait a bit.
    setb LCD_ON
    clr LCD_EN  ; Default state of enable must be zero
    lcall Wait40us
    
    mov LCD_MOD, #0xff ; Use LCD_DATA as output port
    clr LCD_RW ;  Only writing to the LCD in this code.
	
	mov a, #0ch ; Display on command
	lcall LCD_command
	mov a, #38H ; 8-bits interface, 2 lines, 5x7 characters
	lcall LCD_command
	mov a, #01H ; Clear screen (Warning, very slow command!)
	lcall LCD_command
    
    ; Delay loop needed for 'clear screen' command above (1.6ms at least!)
    mov R1, #40
Clr_loop:
	lcall Wait40us
	djnz R1, Clr_loop

	; Move to first column of second row	
	mov a, #0c0H
	lcall LCD_command
		
	; Display message loop
	mov dptr, #Hello
Send_msg:
	clr a
	movc a, @a+dptr
	jz forever
	inc dptr
	lcall LCD_put
	sjmp Send_msg
    
forever:
    mov dptr, #0x8000
	movx a, @dptr
	jz forever
	
continue:
	mov R7, a ; Number of bytes in buffer

	; Move to first column of first row	
	mov a, #080H
	lcall LCD_command
	
Display_loop:
	inc dptr
	movx a, @dptr
	lcall LCD_put
    djnz R7, Display_loop	

	; Acknoledge the received message
	mov dptr, #0x8000
	clr a
	movx @dptr, a
	
	; Send the response
	mov dptr, #OK
	mov R5, #low(0x8101)
	mov R6, #high(0x8101)
	lcall Copy_Code_to_Xdata
	mov dptr, #0x8100
	mov a, R4
	movx @dptr, a
	
	sjmp forever


Copy_Code_to_Xdata:
	mov R4, #0 ; the counter
Copy_loop:
	clr a
	movc a,@dptr+a
	jz donecopy
	inc dptr
	push dpl
	push dph
	mov dpl, R5
	mov dph, R6
	movx @dptr, a
	inc dptr
	mov R6, dph
	mov R5, dpl
	pop dph
	pop dpl
	inc R4
	sjmp Copy_loop
donecopy:
	ret
		
Hello:
	DB 'Hello, world!'
	DB 0
OK:
	DB 'The message was received ok.'
	DB 0
BANNER:
	DB '*********************************************************\r\n'
	DB '*           Shared memory communication test            *\r\n'
	DB '*             (c) Jesus Calvino-Fraga 2015              *\r\n'
	DB '*********************************************************\r\n'
	DB 0
	
end
