;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (May  5 2015) (MSVC)
; This file was generated Wed Oct 21 09:02:15 2015
;--------------------------------------------------------
$name step
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _dostep
	public _step_and_break
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_P0             DATA 0x80
_SP             DATA 0x81
_DPL            DATA 0x82
_DPH            DATA 0x83
_PCON           DATA 0x87
_TCON           DATA 0x88
_TMOD           DATA 0x89
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_P1             DATA 0x90
_SCON           DATA 0x98
_SBUF           DATA 0x99
_P2             DATA 0xa0
_IE             DATA 0xa8
_P3             DATA 0xb0
_IP             DATA 0xb8
_PSW            DATA 0xd0
_ACC            DATA 0xe0
_B              DATA 0xf0
_T2CON          DATA 0xc8
_RCAP2L         DATA 0xca
_RCAP2H         DATA 0xcb
_TL2            DATA 0xcc
_TH2            DATA 0xcd
_DPS            DATA 0x86
_DPH1           DATA 0x85
_DPL1           DATA 0x84
_HEX0           DATA 0x91
_HEX1           DATA 0x92
_HEX2           DATA 0x93
_HEX3           DATA 0x94
_HEX4           DATA 0x8e
_HEX5           DATA 0x8f
_LEDRA          DATA 0xe8
_LEDRB          DATA 0x95
_SWA            DATA 0xe8
_SWB            DATA 0x95
_KEY            DATA 0xf8
_P0MOD          DATA 0x9a
_P1MOD          DATA 0x9b
_P2MOD          DATA 0x9c
_P3MOD          DATA 0x9d
_LCD_CMD        DATA 0xd8
_LCD_DATA       DATA 0xd9
_LCD_MOD        DATA 0xda
_JCMD           DATA 0xc0
_JBUF           DATA 0xc1
_JCNT           DATA 0xc2
_REP_ADD_L      DATA 0xf1
_REP_ADD_H      DATA 0xf2
_REP_VALUE      DATA 0xf3
_DEBUG_CALL_L   DATA 0xfa
_DEBUG_CALL_H   DATA 0xfb
_BPC            DATA 0xfc
_BPS            DATA 0xfd
_BPAL           DATA 0xfe
_BPAH           DATA 0xff
_LBPAL          DATA 0xfa
_LBPAH          DATA 0xfb
_XRAMUSEDAS     DATA 0xc3
_FLASH_CMD      DATA 0xdb
_FLASH_DATA     DATA 0xdc
_FLASH_MOD      DATA 0xdd
_FLASH_ADD0     DATA 0xe1
_FLASH_ADD1     DATA 0xe2
_FLASH_ADD2     DATA 0xe3
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_SM2            BIT 0x9d
_SM1            BIT 0x9e
_SM0            BIT 0x9f
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P2_7           BIT 0xa7
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES             BIT 0xac
_ET2            BIT 0xad
_EA             BIT 0xaf
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_5           BIT 0xb5
_P3_6           BIT 0xb6
_P3_7           BIT 0xb7
_RXD            BIT 0xb0
_TXD            BIT 0xb1
_INT0           BIT 0xb2
_INT1           BIT 0xb3
_T0             BIT 0xb4
_T1             BIT 0xb5
_WR             BIT 0xb6
_RD             BIT 0xb7
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS             BIT 0xbc
_PT2            BIT 0xbd
_P              BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_T2CON_0        BIT 0xc8
_T2CON_1        BIT 0xc9
_T2CON_2        BIT 0xca
_T2CON_3        BIT 0xcb
_T2CON_4        BIT 0xcc
_T2CON_5        BIT 0xcd
_T2CON_6        BIT 0xce
_T2CON_7        BIT 0xcf
_CP_RL2         BIT 0xc8
_C_T2           BIT 0xc9
_TR2            BIT 0xca
_EXEN2          BIT 0xcb
_TCLK           BIT 0xcc
_RCLK           BIT 0xcd
_EXF2           BIT 0xce
_TF2            BIT 0xcf
_LEDRA_0        BIT 0xe8
_LEDRA_1        BIT 0xe9
_LEDRA_2        BIT 0xea
_LEDRA_3        BIT 0xeb
_LEDRA_4        BIT 0xec
_LEDRA_5        BIT 0xed
_LEDRA_6        BIT 0xee
_LEDRA_7        BIT 0xef
_SWA_0          BIT 0xe8
_SWA_1          BIT 0xe9
_SWA_2          BIT 0xea
_SWA_3          BIT 0xeb
_SWA_4          BIT 0xec
_SWA_5          BIT 0xed
_SWA_6          BIT 0xee
_SWA_7          BIT 0xef
_KEY_0          BIT 0xf8
_KEY_1          BIT 0xf9
_KEY_2          BIT 0xfa
_KEY_3          BIT 0xfb
_LCD_RW         BIT 0xd8
_LCD_EN         BIT 0xd9
_LCD_RS         BIT 0xda
_LCD_ON         BIT 0xdb
_LCD_BLON       BIT 0xdc
_JRXRDY         BIT 0xc0
_JTXRDY         BIT 0xc1
_JRXEN          BIT 0xc2
_JTXEN          BIT 0xc3
_JTXFULL        BIT 0xc4
_JRXFULL        BIT 0xc5
_JTXEMPTY       BIT 0xc6
_JTDI           BIT 0xc7
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Interrupt vectors
;--------------------------------------------------------
	CSEG at 0xc003
	ljmp	_step_and_break
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'step_and_break'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\step.c:41: void step_and_break (void) interrupt 0 _naked
;	-----------------------------------------
;	 function step_and_break
;	-----------------------------------------
_step_and_break:
;	naked function: no prologue.
;	.\step.c:43: BPC=0x00; // Dissable breakpoints and single step    	
	mov	_BPC,#0x00
;	.\step.c:123: _endasm;
	
     ; Save the IE register and disable interrupts ASAP since the user code
     ; may have interrupts running which may modify the internal RAM
	        push IE
	        mov IE, #0
	  clr EA
	
        ; Save the user DPTR on the stack so it can be used to address XRAM.
	        push DPH
	        push DPL
	
        ; Save user program registers
	        mov DPTR,#_A_save
	        movx @DPTR,A
	
	        mov DPTR,#_PSW_save
	        mov A,PSW
	        movx @DPTR,A
	
	        mov DPTR,#_B_save
	        mov A,B
	        movx @DPTR,A
	
	        mov DPTR,#_DPL_save
	        pop ACC
	        movx @DPTR,A
	        mov DPTR,#_DPH_save
	        pop ACC
	        movx @DPTR,A
	
	        mov DPTR,#_IE_save
	        pop ACC
	        movx @DPTR,A
	
        ;The address of the next instruction is in the stack
	        mov DPTR,#_PC_save+1
	        pop ACC
	        movx @DPTR,A
	        mov DPTR,#_PC_save
	        pop ACC
	        movx @DPTR,A
	
        ;NOW we can save the user stack pointer
	        mov DPTR,#_SP_save
	        mov A,SP
	        movx @DPTR,A
	
        ; Save the user internal ram.
	        mov DPTR,#_iram_save
	        mov PSW,#0 ; Select register bank 0.
	        mov A,R0 ; Save R0.
	        movx @DPTR,A
	        mov R0,#1
	sab_l:
	        inc DPTR
	        mov A,@R0
	        movx @DPTR,A
	        inc R0
	        cjne R0,#128,sab_l
	
        ;Tell the monitor that the code got here
	        mov DPTR,#_gotbreak
	        mov A,#1
	        movx @DPTR,A
	
        ; Now the tricky part... going back to the monitor
	
        ; Initialize the monitor stack
	        mov sp,#_stack_start - 1
	
        ; Call the monitor hardware initialization
	        lcall __c51_external_startup
	
        ; Notice that crt0 initialization is skiped, otherwise the expanded RAM
        ; variables holding important variables will be clear.
	
        ; Go directly to the main routine
	        ljmp _main
	
	    
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function 'dostep'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\step.c:127: void dostep (void) _naked
;	-----------------------------------------
;	 function dostep
;	-----------------------------------------
_dostep:
;	naked function: no prologue.
;	.\step.c:201: _endasm;
	
        ; Restore the user internal ram.
	        mov R0,#127
	        mov DPTR,#(_iram_save+127)
	ds_l:
	        movx A,@DPTR
	        mov @R0,A
	        dec DPL
	        djnz R0,ds_l
	        movx A,@DPTR
	        mov @R0,A
	
        ; Restore user registers
	        mov DPTR,#_IE_save
	        movx A,@DPTR
	        mov IE, A
	
	        mov DPTR,#_B_save
	        movx A,@DPTR
	        mov B,A
	
	        mov DPTR,#_PSW_save
	        movx A,@DPTR
	        mov PSW,A
	
	        mov DPTR,#_SP_save
	        movx A,@DPTR
	        mov SP,A
	
  ;Put the user code start in the stack. The reti or ret at the end will get us there.
	        mov DPTR,#_step_start
	        movx A,@DPTR
	        push ACC
	        inc DPTR
	        movx A,@DPTR
	        push ACC
	
	        mov DPTR,#_DPL_save
	        movx A,@DPTR
	        push ACC
	        mov DPTR,#_DPH_save
	        movx A,@DPTR
	        push ACC
	
        ; Here use the accumulator to check if it is a go or a step
	        mov DPTR,#_gostep ; 1 is "go" 0 is step
	        movx A,@DPTR
	        jz ds_2
	
        ; go - restore the user accumulator.
	        mov DPTR,#_A_save
	        movx A,@DPTR
	
        ; and pop the user DPTR from the stack.
	        pop DPH
	        pop DPL
	
	        mov _BPC, #0x10 ; Enable break points
	
	        reti
	
	ds_2:
        ; step - restore the user accumulator.
	        mov DPTR,#_A_save
	        movx A,@DPTR
	
        ; pop the user DPTR from the user stack.
	        pop DPH
	        pop DPL
	
	        mov _BPC, #0x20 ; instructs to execute the reti, the following instruction, and then break
	        reti ; 'Return' to the user.
;	naked function: no epilogue.
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST

	CSEG

end
