;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Wed Jun 13 15:37:36 2018
;--------------------------------------------------------
$name AD7928_test
$optc51 --model-small
$printf_float
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
	public _SevenSeg
	public _main
	public _MyDelay
	public _Wait1ms
	public _DisplayFloat
	public _AD7928RW
	public __c51_external_startup
	public _de2_8052_crt0
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
_AD7928_MISO    BIT 0xf8
_AD7928_MOSI    BIT 0xf9
_AD7928_SCLK    BIT 0xfa
_AD7928_EN_N    BIT 0xfb
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_DisplayFloat_buff_1_50:
	ds 6
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
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
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
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
;Allocation info for local variables in function 'de2_8052_crt0'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:/Source/call51/Bin/../include/mcs51/CV_8052.h:303: void de2_8052_crt0 (void) _naked
;	-----------------------------------------
;	 function de2_8052_crt0
;	-----------------------------------------
_de2_8052_crt0:
;	naked function: no prologue.
;	C:/Source/call51/Bin/../include/mcs51/CV_8052.h:372: _endasm;
	
	
	 rseg R_GSINIT
	 public _crt0
	_crt0:
	 mov sp,#_stack_start-1
	 lcall __c51_external_startup
	 mov a,dpl
	 jz __c51_init_data
	 ljmp __c51_program_startup
	__c51_init_data:
	
; Initialize xdata variables
	
	 mov dpl, #_R_XINIT_start
	 mov dph, #(_R_XINIT_start>>8)
	 mov _DPL1, #_R_IXSEG_start
	 mov _DPH1, #(_R_IXSEG_start>>8)
	 mov r0, #_R_IXSEG_size
	 mov r1, #(_R_IXSEG_size>>8)
	
	XInitLoop?repeat?:
	 mov a, r0
	 orl a, r1
	 jz XInitLoop?done?
	 clr a
	 mov _DPS, #0 ; Using dpl, dph
	 movc a,@a+dptr
	 inc dptr
	 mov _DPS, #1 ; Using DPL1, DPH1
	 movx @dptr, a
	 inc dptr
	 dec r0
	 cjne r0, #0xff, XInitLoop?repeat?
	 dec r1
	 sjmp XInitLoop?repeat?
	
	XInitLoop?done?:
	
; Clear xdata variables
	 mov _DPS, #0 ; Make sure we are using dpl, dph
	 mov dpl, #_R_XSEG_start
	 mov dph, #(_R_XSEG_start>>8)
	 mov r4, #_R_XSEG_size
	 mov r5, #(_R_XSEG_size>>8)
	
	XClearLoop?repeat?:
	 mov a, r4
	 orl a, r5
	 jz XClearLoop?done?
	 clr a
	 movx @dptr, a
	 inc dptr
	 dec r4
	 cjne r4, #0xff, XClearLoop?repeat?
	 dec r5
	 sjmp XClearLoop?repeat?
	
	XClearLoop?done?:
	 lcall _R_DINIT_start ; Initialize data/idata variables
	
	__c51_program_startup:
	 lcall _main
	
	forever?home?:
	 sjmp forever?home?
	
	 
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:21: unsigned char _c51_external_startup(void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:23: setbaud_timer2(TIMER_2_RELOAD);
	mov	dptr,#0xFFF7
	lcall	_setbaud_timer2
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:25: LEDRA=0x00;
	mov	_LEDRA,#0x00
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:26: LEDRB=0x00;
	mov	_LEDRB,#0x00
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:29: AD7928_MOSI=0;
	clr	_AD7928_MOSI
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:30: AD7928_SCLK=1;
	setb	_AD7928_SCLK
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:31: AD7928_EN_N=1;
	setb	_AD7928_EN_N
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:33: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'AD7928RW'
;------------------------------------------------------------
;x                         Allocated to registers r2 r3 
;i                         Allocated to registers r4 
;------------------------------------------------------------
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:37: unsigned int AD7928RW (unsigned int x)
;	-----------------------------------------
;	 function AD7928RW
;	-----------------------------------------
_AD7928RW:
	mov	r2,dpl
	mov	r3,dph
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:40: AD7928_EN_N=0;
	clr	_AD7928_EN_N
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:41: do {
	mov	r4,#0x10
L004003?:
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:42: AD7928_MOSI = x & 0x8000;
	mov	a,r3
	rlc	a
	mov	_AD7928_MOSI,c
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:43: AD7928_SCLK = 0;
	clr	_AD7928_SCLK
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:44: x <<= 1;
	mov	a,r3
	xch	a,r2
	add	a,acc
	xch	a,r2
	rlc	a
	mov	r3,a
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:45: if(AD7928_MISO) x += 1; 
	jnb	_AD7928_MISO,L004002?
	inc	r2
	cjne	r2,#0x00,L004013?
	inc	r3
L004013?:
L004002?:
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:46: AD7928_SCLK = 1;
	setb	_AD7928_SCLK
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:47: } while(--i);
	djnz	r4,L004003?
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:48: AD7928_EN_N=1;
	setb	_AD7928_EN_N
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:49: return ((x>>1)&0xfff);
	mov	a,r3
	clr	c
	rrc	a
	xch	a,r2
	rrc	a
	xch	a,r2
	mov	r3,a
	mov	dpl,r2
	mov	a,#0x0F
	anl	a,r3
	mov	dph,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'DisplayFloat'
;------------------------------------------------------------
;v                         Allocated to registers r2 r3 r4 r5 
;buff                      Allocated with name '_DisplayFloat_buff_1_50'
;------------------------------------------------------------
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:54: void DisplayFloat (float v)
;	-----------------------------------------
;	 function DisplayFloat
;	-----------------------------------------
_DisplayFloat:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:57: sprintf(buff, "%5.3f", v);
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_DisplayFloat_buff_1_50
	push	acc
	mov	a,#(_DisplayFloat_buff_1_50 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:58: HEX3=SevenSeg[buff[0]-'0'];
	mov	a,_DisplayFloat_buff_1_50
	add	a,#0xd0
	mov	dptr,#_SevenSeg
	movc	a,@a+dptr
	mov	_HEX3,a
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:59: HEX2=SevenSeg[buff[2]-'0'];
	mov	a,(_DisplayFloat_buff_1_50 + 0x0002)
	add	a,#0xd0
	mov	dptr,#_SevenSeg
	movc	a,@a+dptr
	mov	_HEX2,a
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:60: HEX1=SevenSeg[buff[3]-'0'];
	mov	a,(_DisplayFloat_buff_1_50 + 0x0003)
	add	a,#0xd0
	mov	dptr,#_SevenSeg
	movc	a,@a+dptr
	mov	_HEX1,a
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:61: HEX0=SevenSeg[buff[4]-'0'];
	mov	a,(_DisplayFloat_buff_1_50 + 0x0004)
	add	a,#0xd0
	mov	dptr,#_SevenSeg
	movc	a,@a+dptr
	mov	_HEX0,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Wait1ms'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:64: void Wait1ms (void)
;	-----------------------------------------
;	 function Wait1ms
;	-----------------------------------------
_Wait1ms:
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:66: TR0=0;
	clr	_TR0
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:67: TMOD=(TMOD &0xf0)|0x01; // Timer 0: GATE=0, C/T*=0, M1=0, M0=1: 16-bit timer
	mov	a,#0xF0
	anl	a,_TMOD
	orl	a,#0x01
	mov	_TMOD,a
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:68: TH0=HIGH(TIMER_0_1ms);
	mov	_TH0,#0xF5
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:69: TL0=LOW(TIMER_0_1ms);
	mov	_TL0,#0x27
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:70: TF0=0;
	clr	_TF0
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:71: TR0=1;
	setb	_TR0
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:72: while(TF0==0);
L006001?:
	jnb	_TF0,L006001?
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:73: TR0=0;
	clr	_TR0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'MyDelay'
;------------------------------------------------------------
;msec                      Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:76: void MyDelay (unsigned int msec)
;	-----------------------------------------
;	 function MyDelay
;	-----------------------------------------
_MyDelay:
	mov	r2,dpl
	mov	r3,dph
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:78: do {
L007001?:
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:79: Wait1ms();
	push	ar2
	push	ar3
	lcall	_Wait1ms
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:80: } while (--msec);
	dec	r2
	cjne	r2,#0xff,L007008?
	dec	r3
L007008?:
	mov	a,r2
	orl	a,r3
	jnz	L007001?
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;val                       Allocated to registers r2 r3 
;v                         Allocated to registers r4 r5 r6 r7 
;------------------------------------------------------------
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:83: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:88: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:90: printf("CV-8052 test program for the AD7928 in the DE1-SoC\r\n");
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:92: while (1)
L008002?:
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:105: val|=((SWA & 0b_111) << 10); // Select channel using the switches
	mov	a,#0x07
	anl	a,_SWA
	add	a,acc
	add	a,acc
	mov	r3,a
	mov	r2,#0x00
	orl	ar2,#0x10
	orl	ar3,#0x83
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:106: val=AD7928RW(val);
	mov	dpl,r2
	mov	dph,r3
	lcall	_AD7928RW
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:107: v=(val*5.0)/4095.0;
	mov	r2,dpl
	mov  r3,dph
	push	ar2
	push	ar3
	lcall	___uint2fs
	mov	r4,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	mov	dptr,#0x0000
	mov	b,#0xA0
	mov	a,#0x40
	lcall	___fsmul
	mov	r4,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0xF0
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x45
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	___fsdiv
	mov	r4,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:108: printf("val[%d]=0x%04x, V=%5.3f\r", SWA & 0b_111, val, v);
	mov	a,#0x07
	anl	a,_SWA
	mov	r0,a
	mov	r1,#0x00
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar2
	push	ar3
	push	ar0
	push	ar1
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf5
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:109: DisplayFloat(v);
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	_DisplayFloat
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:110: HEX5=SevenSeg[SWA & 0b_111]; // Display the channel number
	mov	a,#0x07
	anl	a,_SWA
	mov	dptr,#_SevenSeg
	movc	a,@a+dptr
	mov	_HEX5,a
;	C:\Source\SOC_8052\ADC_Test\AD7928_test.c:111: MyDelay(500);
	mov	dptr,#0x01F4
	lcall	_MyDelay
	ljmp	L008002?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_SevenSeg:
	db 0xc0	; 192 	À
	db 0xf9	; 249 
	db 0xa4	; 164 	¤
	db 0xb0	; 176 	°
	db 0x99	; 153 	™
	db 0x92	; 146 	’
	db 0x82	; 130 	‚
	db 0xf8	; 248 
	db 0x80	; 128 	€
	db 0x90	; 144 
__str_0:
	db '%5.3f'
	db 0x00
__str_1:
	db 0x1B
	db '[2J'
	db 0x00
__str_2:
	db 'CV-8052 test program for the AD7928 in the DE1-SoC'
	db 0x0D
	db 0x0A
	db 0x00
__str_3:
	db 'val[%d]=0x%04x, V=%5.3f'
	db 0x0D
	db 0x00

	CSEG

end
