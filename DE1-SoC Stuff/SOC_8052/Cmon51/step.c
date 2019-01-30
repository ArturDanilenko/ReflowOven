/*
CMON51: C Monitor for the 8051
Copyright (C) 2005-2015  Jesus Calvino-Fraga / jesusc at ece.ubc.ca

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
*/

#include <CV_8052.h>

extern volatile xdata char iram_save[128];
extern volatile xdata unsigned char A_save;
extern volatile xdata unsigned char PSW_save;
extern volatile xdata unsigned char B_save;
extern volatile xdata unsigned char IE_save;
extern volatile xdata unsigned int  DPL_save;
extern volatile xdata unsigned int  DPH_save;
extern volatile xdata unsigned char SP_save;
extern volatile xdata unsigned int  PC_save;
extern volatile xdata unsigned char gotbreak;
extern volatile xdata unsigned int  step_start;
extern volatile xdata unsigned char saved_jmp[3];
extern volatile xdata unsigned char saved_int[3];

//This is the function that enters after just one assembly instruction of user code
//is executed in single step mode.  Don't be deceived by the interupt number here, as c51 will
//use the number defined in the external function prototype in the main file of each processor.
//For instance, some ports (p89v51rd2 and at89c51ed2) are using interrupt vector 0 to save some
//code space.
void step_and_break (void) interrupt 0 _naked
{
	BPC=0x00; // Dissable breakpoints and single step    	
    _asm 
    	; Save the IE register and disable interrupts ASAP since the user code
    	; may have interrupts running which may modify the internal RAM
        push	IE
        mov IE, #0
		clr		EA
		
        ; Save the user DPTR on the stack so it can be used to address XRAM.
        push    DPH
        push    DPL

        ; Save user program registers
        mov     DPTR,#_A_save
        movx    @DPTR,A

        mov     DPTR,#_PSW_save
        mov     A,PSW
        movx    @DPTR,A

        mov     DPTR,#_B_save
        mov     A,B
        movx    @DPTR,A

        mov     DPTR,#_DPL_save
        pop     ACC
        movx    @DPTR,A
        mov     DPTR,#_DPH_save
        pop     ACC
        movx    @DPTR,A
        
        mov     DPTR,#_IE_save
        pop     ACC
        movx    @DPTR,A

        ;The address of the next instruction is in the stack
        mov     DPTR,#_PC_save+1
        pop     ACC
        movx    @DPTR,A
        mov     DPTR,#_PC_save
        pop     ACC
        movx    @DPTR,A

        ;NOW we can save the user stack pointer
        mov     DPTR,#_SP_save
        mov     A,SP
        movx    @DPTR,A

        ; Save the user internal ram.
        mov     DPTR,#_iram_save
        mov     PSW,#0  ; Select register bank 0.
        mov     A,R0    ; Save R0.
        movx    @DPTR,A
        mov     R0,#1
sab_l:
        inc     DPTR
        mov     A,@R0
        movx    @DPTR,A
        inc     R0
        cjne    R0,#128,sab_l

        ;Tell the monitor that the code got here
        mov     DPTR,#_gotbreak
        mov     A,#1
        movx    @DPTR,A

        ; Now the tricky part... going back to the monitor
        
        ; Initialize the monitor stack
        mov     sp,#_stack_start - 1
        
        ; Call the monitor hardware initialization
        lcall   __c51_external_startup
        
        ; Notice that crt0 initialization is skiped, otherwise the expanded RAM
        ; variables holding important variables will be clear.

        ; Go directly to the main routine
        ljmp    _main

    _endasm;
}

//Run one instruction of user code or go.  The interrupts are already disabled.
void dostep (void) _naked
{
_asm
        ; Restore the user internal ram.
        mov     R0,#127
        mov     DPTR,#(_iram_save+127)
ds_l:
        movx    A,@DPTR
        mov     @R0,A
        dec     DPL
        djnz    R0,ds_l
        movx    A,@DPTR
        mov     @R0,A

        ; Restore user registers
        mov     DPTR,#_IE_save
        movx    A,@DPTR
        mov     IE, A
        
        mov     DPTR,#_B_save
        movx    A,@DPTR
        mov     B,A

        mov     DPTR,#_PSW_save
        movx    A,@DPTR
        mov     PSW,A

        mov     DPTR,#_SP_save
        movx    A,@DPTR
        mov     SP,A

		;Put the user code start in the stack.  The reti or ret at the end will get us there.
        mov     DPTR,#_step_start
        movx    A,@DPTR
        push    ACC
        inc     DPTR
        movx    A,@DPTR
        push    ACC

        mov     DPTR,#_DPL_save
        movx    A,@DPTR
        push    ACC
        mov     DPTR,#_DPH_save
        movx    A,@DPTR
        push    ACC
        
        ; Here use the accumulator to check if it is a go or a step
        mov     DPTR,#_gostep ; 1 is "go" 0 is step
        movx    A,@DPTR
        jz      ds_2

        ; go - restore the user accumulator.
        mov     DPTR,#_A_save
        movx    A,@DPTR

        ; and pop the user DPTR from the stack.
        pop     DPH
        pop     DPL
 
        mov _BPC, #0x10 ; Enable break points
        
        reti

ds_2:
        ; step - restore the user accumulator.
        mov     DPTR,#_A_save
        movx    A,@DPTR

        ; pop the user DPTR from the user stack.
        pop     DPH
        pop     DPL
        
        mov _BPC, #0x20 ; instructs to execute the reti, the following instruction, and then break
       	reti			; 'Return' to the user.
_endasm;
}
