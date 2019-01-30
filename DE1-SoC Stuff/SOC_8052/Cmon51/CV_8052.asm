;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (May  5 2015) (MSVC)
; This file was generated Wed Oct 21 09:02:15 2015
;--------------------------------------------------------
$name CV_8052
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
	public _write_sfr_PARM_2
	public _bitn
	public _sfrn
	public _getchar
	public __c51_external_startup
	public _main
	public _de2_8052_crt0
	public _append_txbuff
	public _pos
	public _putc
	public _putnl
	public _get_txbuff
	public _add_nlcursor_txbuff
	public _add_char_txbuff
	public _add_cursor_txbuff
	public _add_byte_txbuff
	public _add_word_txbuff
	public _add_wordnl_txbuff
	public _add_str_txbuff
	public _flush_txbuff
	public _update_txbuff
	public _read_sfr
	public _write_sfr
	public _restorePC
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
_pos:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
_getchar_c_1_38:
	ds 1
_getchar_j_1_38:
	ds 1
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_write_sfr_PARM_2:
	ds 1
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
_append_txbuff:
	DBIT	1
_update_txbuff_saved_append_txbuff_1_64:
	DBIT	1
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
	CSEG at 0xc000
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
;	.\CV_8052.c:30: volatile bit append_txbuff=0;
	clr	_append_txbuff
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'de2_8052_crt0'
;------------------------------------------------------------
;------------------------------------------------------------
;	c:/source/call51/bin/../include/mcs51/CV_8052.h:303: void de2_8052_crt0 (void) _naked
;	-----------------------------------------
;	 function de2_8052_crt0
;	-----------------------------------------
_de2_8052_crt0:
;	naked function: no prologue.
;	c:/source/call51/bin/../include/mcs51/CV_8052.h:372: _endasm;
	
	
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
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\CV_8052.c:144: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	using	0
;	.\CV_8052.c:148: _endasm; //All the work is done in cmon51.c
	
	  ljmp _do_cmd
	 
	ret
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\CV_8052.c:151: unsigned char _c51_external_startup(void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
;	.\CV_8052.c:158: _endasm;
	
	  mov _DEBUG_CALL_L,#(_step_and_break)
	  mov _DEBUG_CALL_H,#(_step_and_break >> 8)
  ;lcall _R_DINIT_start ; Initialize data/idata variables
	 
;	.\CV_8052.c:160: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getchar'
;------------------------------------------------------------
;c                         Allocated with name '_getchar_c_1_38'
;j                         Allocated with name '_getchar_j_1_38'
;------------------------------------------------------------
;	.\CV_8052.c:163: char getchar(void)
;	-----------------------------------------
;	 function getchar
;	-----------------------------------------
_getchar:
;	.\CV_8052.c:167: while(rxcount==0); // Wait for data to arrive
L005001?:
	mov	dptr,#_rxcount
	movx	a,@dptr
	mov	r2,a
	jz	L005001?
;	.\CV_8052.c:168: c=rxbuff[0];
	mov	dptr,#_rxbuff
	movx	a,@dptr
	mov	_getchar_c_1_38,a
;	.\CV_8052.c:169: for(j=1; rxbuff[j]!=0; j++) rxbuff[j-1]=rxbuff[j];
	mov	_getchar_j_1_38,#0x01
L005004?:
	mov	a,_getchar_j_1_38
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r2,a
	jz	L005007?
	mov	a,_getchar_j_1_38
	dec	a
	add	a,#_rxbuff
	mov	r2,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	r3,a
	mov	a,_getchar_j_1_38
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r4,a
	mov	dpl,r2
	mov	dph,r3
	movx	@dptr,a
	inc	_getchar_j_1_38
	sjmp	L005004?
L005007?:
;	.\CV_8052.c:170: rxbuff[j-1]=0;
	mov	a,_getchar_j_1_38
	dec	a
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	clr	a
	movx	@dptr,a
;	.\CV_8052.c:171: rxcount--;
	mov	dptr,#_rxcount
	movx	a,@dptr
	dec	a
	mov	dptr,#_rxcount
	movx	@dptr,a
;	.\CV_8052.c:173: return c;
	mov	dpl,_getchar_c_1_38
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'putc'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	.\CV_8052.c:176: void putc (unsigned char c)
;	-----------------------------------------
;	 function putc
;	-----------------------------------------
_putc:
	mov	r2,dpl
;	.\CV_8052.c:178: while(txcount!=0);
L006001?:
	mov	dptr,#_txcount
	movx	a,@dptr
	mov	r3,a
	jnz	L006001?
;	.\CV_8052.c:179: txbuff[0]=c;
	mov	dptr,#_txbuff
	mov	a,r2
	movx	@dptr,a
;	.\CV_8052.c:180: txbuff[1]=0;
	mov	dptr,#(_txbuff + 0x0001)
	clr	a
	movx	@dptr,a
;	.\CV_8052.c:181: txcount=2;	
	mov	dptr,#_txcount
	mov	a,#0x02
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'putnl'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\CV_8052.c:184: void putnl (void)
;	-----------------------------------------
;	 function putnl
;	-----------------------------------------
_putnl:
;	.\CV_8052.c:186: while(txcount!=0);
L007001?:
	mov	dptr,#_txcount
	movx	a,@dptr
	mov	r2,a
	jnz	L007001?
;	.\CV_8052.c:187: txbuff[0]='\r';
	mov	dptr,#_txbuff
	mov	a,#0x0D
	movx	@dptr,a
;	.\CV_8052.c:188: txbuff[1]='\n';
	mov	dptr,#(_txbuff + 0x0001)
	mov	a,#0x0A
	movx	@dptr,a
;	.\CV_8052.c:189: txbuff[2]=0;
	mov	dptr,#(_txbuff + 0x0002)
	clr	a
	movx	@dptr,a
;	.\CV_8052.c:190: txcount=3;	
	mov	dptr,#_txcount
	mov	a,#0x03
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'get_txbuff'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\CV_8052.c:193: void get_txbuff (void)
;	-----------------------------------------
;	 function get_txbuff
;	-----------------------------------------
_get_txbuff:
;	.\CV_8052.c:195: if(append_txbuff==1) return;
	jnb	_append_txbuff,L008003?
;	.\CV_8052.c:196: while(txcount!=0);
	ret
L008003?:
	mov	dptr,#_txcount
	movx	a,@dptr
	mov	r2,a
;	.\CV_8052.c:197: pos=0;
	jnz	L008003?
	mov	_pos,a
	mov	(_pos + 1),a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'add_nlcursor_txbuff'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\CV_8052.c:200: void add_nlcursor_txbuff (void)
;	-----------------------------------------
;	 function add_nlcursor_txbuff
;	-----------------------------------------
_add_nlcursor_txbuff:
;	.\CV_8052.c:202: txbuff[pos++]='\r';
	mov	r2,_pos
	mov	r3,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r2
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r3
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,#0x0D
	movx	@dptr,a
;	.\CV_8052.c:203: txbuff[pos++]='\n';
	mov	r2,_pos
	mov	r3,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r2
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r3
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,#0x0A
	movx	@dptr,a
;	.\CV_8052.c:204: txbuff[pos++]='>';
	mov	r2,_pos
	mov	r3,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r2
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r3
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,#0x3E
	movx	@dptr,a
;	.\CV_8052.c:205: txbuff[pos++]=' ';
	mov	r2,_pos
	mov	r3,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r2
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r3
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,#0x20
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'add_char_txbuff'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	.\CV_8052.c:208: void add_char_txbuff (char c)
;	-----------------------------------------
;	 function add_char_txbuff
;	-----------------------------------------
_add_char_txbuff:
	mov	r2,dpl
;	.\CV_8052.c:210: txbuff[pos++]=c;
	mov	r3,_pos
	mov	r4,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r3
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r4
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,r2
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'add_cursor_txbuff'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\CV_8052.c:213: void add_cursor_txbuff (void)
;	-----------------------------------------
;	 function add_cursor_txbuff
;	-----------------------------------------
_add_cursor_txbuff:
;	.\CV_8052.c:215: txbuff[pos++]='>';
	mov	r2,_pos
	mov	r3,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r2
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r3
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,#0x3E
	movx	@dptr,a
;	.\CV_8052.c:216: txbuff[pos++]=' ';
	mov	r2,_pos
	mov	r3,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r2
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r3
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,#0x20
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'add_byte_txbuff'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	.\CV_8052.c:219: void add_byte_txbuff (unsigned char c)
;	-----------------------------------------
;	 function add_byte_txbuff
;	-----------------------------------------
_add_byte_txbuff:
	mov	r2,dpl
;	.\CV_8052.c:221: txbuff[pos++]=hexval[c/0x10];
	mov	r3,_pos
	mov	r4,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r3
	add	a,#_txbuff
	mov	r3,a
	mov	a,r4
	addc	a,#(_txbuff >> 8)
	mov	r4,a
	mov	a,r2
	swap	a
	anl	a,#0x0f
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	dpl,r3
	mov	dph,r4
	movx	@dptr,a
;	.\CV_8052.c:222: txbuff[pos++]=hexval[c&0x0f];
	mov	r3,_pos
	mov	r4,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r3
	add	a,#_txbuff
	mov	r3,a
	mov	a,r4
	addc	a,#(_txbuff >> 8)
	mov	r4,a
	mov	a,#0x0F
	anl	a,r2
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	dpl,r3
	mov	dph,r4
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'add_word_txbuff'
;------------------------------------------------------------
;w                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	.\CV_8052.c:225: void add_word_txbuff (unsigned int w)
;	-----------------------------------------
;	 function add_word_txbuff
;	-----------------------------------------
_add_word_txbuff:
	mov	r2,dpl
	mov	r3,dph
;	.\CV_8052.c:227: add_byte_txbuff(w/0x100);
	mov	ar4,r3
	mov	dpl,r4
	push	ar2
	push	ar3
	lcall	_add_byte_txbuff
	pop	ar3
	pop	ar2
;	.\CV_8052.c:228: add_byte_txbuff(w%0x100);
	mov	dpl,r2
	ljmp	_add_byte_txbuff
;------------------------------------------------------------
;Allocation info for local variables in function 'add_wordnl_txbuff'
;------------------------------------------------------------
;w                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	.\CV_8052.c:231: void add_wordnl_txbuff (unsigned int w)
;	-----------------------------------------
;	 function add_wordnl_txbuff
;	-----------------------------------------
_add_wordnl_txbuff:
	mov	r2,dpl
	mov	r3,dph
;	.\CV_8052.c:233: add_byte_txbuff(w/0x100);
	mov	ar4,r3
	mov	dpl,r4
	push	ar2
	push	ar3
	lcall	_add_byte_txbuff
	pop	ar3
	pop	ar2
;	.\CV_8052.c:234: add_byte_txbuff(w%0x100);
	mov	dpl,r2
	lcall	_add_byte_txbuff
;	.\CV_8052.c:235: add_char_txbuff('\r');
	mov	dpl,#0x0D
	lcall	_add_char_txbuff
;	.\CV_8052.c:236: add_char_txbuff('\n');
	mov	dpl,#0x0A
	ljmp	_add_char_txbuff
;------------------------------------------------------------
;Allocation info for local variables in function 'add_str_txbuff'
;------------------------------------------------------------
;s                         Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	.\CV_8052.c:240: void add_str_txbuff (unsigned char * s)
;	-----------------------------------------
;	 function add_str_txbuff
;	-----------------------------------------
_add_str_txbuff:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	.\CV_8052.c:242: while(*s!=0)
L015001?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	jz	L015004?
;	.\CV_8052.c:244: txbuff[pos++]=*s;
	mov	r6,_pos
	mov	r7,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r6
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r7
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,r5
	movx	@dptr,a
;	.\CV_8052.c:245: s++;
	inc	r2
	cjne	r2,#0x00,L015001?
	inc	r3
	sjmp	L015001?
L015004?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'flush_txbuff'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\CV_8052.c:249: void flush_txbuff (void)
;	-----------------------------------------
;	 function flush_txbuff
;	-----------------------------------------
_flush_txbuff:
;	.\CV_8052.c:251: if(append_txbuff==1) return;
	jnb	_append_txbuff,L016002?
	ret
L016002?:
;	.\CV_8052.c:252: if(pos>0)
	mov	a,_pos
	orl	a,(_pos + 1)
	jz	L016008?
;	.\CV_8052.c:254: txbuff[pos++]=0;
	mov	r2,_pos
	mov	r3,(_pos + 1)
	mov	a,#0x01
	add	a,_pos
	mov	_pos,a
	clr	a
	addc	a,(_pos + 1)
	mov	(_pos + 1),a
	mov	a,r2
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r3
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	clr	a
	movx	@dptr,a
;	.\CV_8052.c:255: txcount=(pos<0x100)?pos:0xff;
	mov	a,#0x100 - 0x01
	add	a,(_pos + 1)
	jc	L016010?
	mov	r2,_pos
	mov	r3,(_pos + 1)
	sjmp	L016011?
L016010?:
	mov	r2,#0xFF
	mov	r3,#0x00
L016011?:
	mov	dptr,#_txcount
	mov	a,r2
	movx	@dptr,a
;	.\CV_8052.c:256: pos=0;
	clr	a
	mov	_pos,a
	mov	(_pos + 1),a
;	.\CV_8052.c:257: while(txcount!=0);
L016003?:
	mov	dptr,#_txcount
	movx	a,@dptr
	mov	r2,a
	jnz	L016003?
L016008?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'update_txbuff'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\CV_8052.c:261: void update_txbuff (void)
;	-----------------------------------------
;	 function update_txbuff
;	-----------------------------------------
_update_txbuff:
;	.\CV_8052.c:265: if(pos>8191) 
	clr	c
	mov	a,#0xFF
	subb	a,_pos
	mov	a,#0x1F
	subb	a,(_pos + 1)
	jnc	L017003?
;	.\CV_8052.c:267: saved_append_txbuff=append_txbuff;
	mov	c,_append_txbuff
	mov	_update_txbuff_saved_append_txbuff_1_64,c
;	.\CV_8052.c:268: append_txbuff=0;
	clr	_append_txbuff
;	.\CV_8052.c:269: flush_txbuff();
	lcall	_flush_txbuff
;	.\CV_8052.c:270: append_txbuff=saved_append_txbuff;
	mov	c,_update_txbuff_saved_append_txbuff_1_64
	mov	_append_txbuff,c
L017003?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'read_sfr'
;------------------------------------------------------------
;loc                       Allocated to registers 
;------------------------------------------------------------
;	.\CV_8052.c:274: unsigned char read_sfr (unsigned char loc)
;	-----------------------------------------
;	 function read_sfr
;	-----------------------------------------
_read_sfr:
	mov	_REP_VALUE,dpl
;	.\CV_8052.c:289: _endasm;
	
	  mov _REP_ADD_L,#(_asm_read_sfr+4)
	  mov _REP_ADD_H,#((_asm_read_sfr+4) >> 8)
	  orl _XRAMUSEDAS, #00000010B ; Enable byte replacement at the given address
	 _asm_read_sfr:
	  read_sfr_0xff data 0xff ; To avoid warning
	     nop ; Account for delay
	     nop
	     nop
	  mov dpl, read_sfr_0xff
	  anl _XRAMUSEDAS, #not(00000010B) ; Disable byte replacement at the given address
	  ret
	    
;	.\CV_8052.c:291: return 0; //Dummy return. DPL has the value
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'write_sfr'
;------------------------------------------------------------
;val                       Allocated with name '_write_sfr_PARM_2'
;loc                       Allocated to registers 
;------------------------------------------------------------
;	.\CV_8052.c:294: void write_sfr (unsigned char loc, unsigned char val)
;	-----------------------------------------
;	 function write_sfr
;	-----------------------------------------
_write_sfr:
	mov	_REP_VALUE,dpl
;	.\CV_8052.c:297: DPL= val;
	mov	_DPL,_write_sfr_PARM_2
;	.\CV_8052.c:309: _endasm;
	
	  mov _REP_ADD_L,#(_asm_write_sfr+5)
	  mov _REP_ADD_H,#((_asm_write_sfr+5) >> 8)
	  orl _XRAMUSEDAS, #00000010B
	    _asm_write_sfr:
	     nop
	     nop
	     nop
	  mov 0xff, dpl
	  anl _XRAMUSEDAS, #not(00000010B)
	  ret
	    
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'restorePC'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\CV_8052.c:312: void restorePC (void)
;	-----------------------------------------
;	 function restorePC
;	-----------------------------------------
_restorePC:
;	.\CV_8052.c:314: PC_save=0;
	mov	dptr,#_PC_save
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	ret
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_sfrn:
	db 0x80
	db 'P0'
	db 0x81
	db 'SP'
	db 0x82
	db 'DPL'
	db 0x83
	db 'DPH'
	db 0x87
	db 'PCON'
	db 0x88
	db 'TCON'
	db 0x89
	db 'TMOD'
	db 0x8A
	db 'TL0'
	db 0x8B
	db 'TL1'
	db 0x8C
	db 'TH0'
	db 0x8D
	db 'TH1'
	db 0x8E
	db 'HEX4'
	db 0x8F
	db 'HEX5'
	db 0x90
	db 'P1'
	db 0x91
	db 'H'
	db 'EX0'
	db 0x92
	db 'HEX1'
	db 0x93
	db 'HEX2'
	db 0x94
	db 'HEX3'
	db 0x95
	db 'LEDRB'
	db 0x95
	db 'SWB'
	db 0x96
	db 'HEX6'
	db 0x97
	db 'HEX7'
	db 0x98
	db 'SCON'
	db 0x99
	db 'SBUF'
	db 0x9A
	db 'P0MOD'
	db 0x9B
	db 'P1MOD'
	db 0x9C
	db 'P2MOD'
	db 0x9D
	db 'P3MOD'
	db 0xA0
	db 'P2'
	db 0xA8
	db 'IE'
	db 0xB0
	db 'P3'
	db 0xB8
	db 'IP'
	db 0xC8
	db 'T2CON'
	db 0xC9
	db 'T2MOD'
	db 0xCA
	db 'RCAP2L'
	db 0xCB
	db 'RCAP2H'
	db 0xCC
	db 'TL2'
	db 0xCD
	db 'TH2'
	db 0xD0
	db 'P'
	db 'SW'
	db 0xD8
	db 'LCDCMD'
	db 0xD9
	db 'LCDDATA'
	db 0xDA
	db 'LCDMOD'
	db 0xE0
	db 'ACC'
	db 0xE0
	db 'A'
	db 0xE8
	db 'LEDRA'
	db 0xE8
	db 'SWA'
	db 0xF0
	db 'B'
	db 0xF8
	db 'KEY'
	db 0x80
	db 0x00
	db 0x00
_bitn:
	db 0x88
	db 'IT0'
	db 0x89
	db 'IE0'
	db 0x8A
	db 'IT1'
	db 0x8B
	db 'IE1'
	db 0x8C
	db 'TR0'
	db 0x8D
	db 'TF0'
	db 0x8E
	db 'TR1'
	db 0x8F
	db 'TF1'
	db 0x98
	db 'RI'
	db 0x99
	db 'TI'
	db 0x9A
	db 'RB8'
	db 0x9B
	db 'TB8'
	db 0x9C
	db 'REN'
	db 0xA8
	db 'EX0'
	db 0xA9
	db 'ET0'
	db 0xAA
	db 'E'
	db 'X1'
	db 0xAB
	db 'ET1'
	db 0xAC
	db 'ES'
	db 0xAD
	db 'ET2'
	db 0xAF
	db 'EA'
	db 0xB8
	db 'PX0'
	db 0xB9
	db 'PT0'
	db 0xBA
	db 'PX1'
	db 0xBB
	db 'PT1'
	db 0xBC
	db 'PS'
	db 0xBD
	db 'PT2'
	db 0xD0
	db 'P'
	db 0xD1
	db 'F1'
	db 0xD2
	db 'OV'
	db 0xD3
	db 'RS0'
	db 0xD4
	db 'RS1'
	db 0xD5
	db 'F0'
	db 0xD6
	db 'A'
	db 'C'
	db 0xD7
	db 'CY'
	db 0xC8
	db 'CPRL2'
	db 0xC9
	db 'CT2'
	db 0xCA
	db 'TR2'
	db 0xCB
	db 'EXEN2'
	db 0xCC
	db 'TCLK'
	db 0xCD
	db 'RCLK'
	db 0xCE
	db 'EXF2'
	db 0xCF
	db 'TF2'
	db 0xD8
	db 'LCDRW'
	db 0xD9
	db 'LCDEN'
	db 0xDA
	db 'LCDR'
	db 'S'
	db 0xDB
	db 'LCDON'
	db 0xDC
	db 'LCDBLON'
	db 0xFF
	db 0x00
	db 0x00

	CSEG

end
