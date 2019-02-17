;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (May  5 2015) (MSVC)
; This file was generated Wed Oct 21 09:02:15 2015
;--------------------------------------------------------
$name cmon51
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
	public _add_byte_buff_PARM_2
	public _fillmem_PARM_3
	public _fillmem_PARM_2
	public _regframe
	public _cnw
	public _cnr
	public _nba
	public _maskbit
	public _hexval
	public _cmdlst
	public _breakorstep
	public _nlist
	public _disp_regs
	public _add_byte_buff
	public _getwordn
	public _cleanbuff
	public _dispmem
	public _modifymem
	public _putcnl
	public _outwordnl
	public _outcursor
	public _outbytenl
	public _getsn
	public _clearline
	public _go_pending
	public _trace_type
	public _break_address
	public _gostep
	public _saved_int
	public _saved_jmp
	public _step_start
	public _gotbreak
	public _PC_save
	public _LEDRB_save
	public _LEDRA_save
	public _SP_save
	public _DPH_save
	public _DPL_save
	public _IE_save
	public _B_save
	public _PSW_save
	public _A_save
	public _br
	public _iram_save
	public _breakpoint
	public _buff_hasdot
	public _buff_haseq
	public _keepediting
	public _validbyte
	public _dispmem_PARM_3
	public _dispmem_PARM_2
	public _modifymem_PARM_2
	public _cursor
	public _buff
	public _putsp
	public _chartohex
	public _fillmem
	public _do_cmd
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
_buff:
	ds 32
_cursor:
	ds 1
_modifymem_PARM_2:
	ds 1
_modifymem_j_1_105:
	ds 1
_modifymem_sloc0_1_0:
	ds 1
_modifymem_sloc1_1_0:
	ds 3
_dispmem_PARM_2:
	ds 2
_dispmem_PARM_3:
	ds 1
_dispmem_begin_1_113:
	ds 3
_dispmem_j_1_114:
	ds 2
_do_cmd_i_1_150:
	ds 2
_do_cmd_j_1_150:
	ds 2
_do_cmd_n_1_150:
	ds 2
_do_cmd_q_1_150:
	ds 2
_do_cmd_y_1_150:
	ds 1
_do_cmd_cmd_1_150:
	ds 1
_do_cmd_sloc0_1_0:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_fillmem_PARM_2:
	ds 2
_fillmem_PARM_3:
	ds 1
	rseg	R_OSEG
_add_byte_buff_PARM_2:
	ds 1
	rseg	R_OSEG
_nlist_q_1_135:
	ds 1
_nlist_sloc0_1_0:
	ds 3
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
_validbyte:
	DBIT	1
_keepediting:
	DBIT	1
_buff_haseq:
	DBIT	1
_buff_hasdot:
	DBIT	1
_breakpoint:
	DBIT	1
_do_cmd_p_bit_1_150:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
	XSEG at 0x8000
_rxcount: ds 1
	public _rxcount
	rseg R_XSEG
	XSEG at 0x8001
_rxbuff: ds 254
	public _rxbuff
	rseg R_XSEG
	XSEG at 0x8100
_txcount: ds 1
	public _txcount
	rseg R_XSEG
	XSEG at 0x8101
_txbuff: ds 254
	public _txbuff
	rseg R_XSEG
_iram_save:
	ds 128
_br:
	ds 8
_A_save:
	ds 1
_PSW_save:
	ds 1
_B_save:
	ds 1
_IE_save:
	ds 1
_DPL_save:
	ds 2
_DPH_save:
	ds 2
_SP_save:
	ds 1
_LEDRA_save:
	ds 1
_LEDRB_save:
	ds 1
_PC_save:
	ds 2
_gotbreak:
	ds 1
_step_start:
	ds 2
_saved_jmp:
	ds 3
_saved_int:
	ds 3
_gostep:
	ds 1
_break_address:
	ds 2
_trace_type:
	ds 1
_go_pending:
	ds 1
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
;Allocation info for local variables in function 'putsp'
;------------------------------------------------------------
;x                         Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;------------------------------------------------------------
;	.\cmon51.c:74: void putsp(unsigned char * x)
;	-----------------------------------------
;	 function putsp
;	-----------------------------------------
_putsp:
	using	0
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	.\cmon51.c:79: while(txcount!=0);
L002001?:
	mov	dptr,#_txcount
	movx	a,@dptr
	mov	r5,a
;	.\cmon51.c:80: while( ((*x)>0) && ((*x)<0x80) )
	jnz	L002001?
	mov	r5,a
	mov	r6,a
L002007?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r7,a
	jz	L002009?
	cjne	r7,#0x80,L002023?
L002023?:
	jnc	L002009?
;	.\cmon51.c:82: if(*x==(unsigned char)'\n') txbuff[j]='\r';
	cjne	r7,#0x0A,L002005?
	mov	a,r5
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r6
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,#0x0D
	movx	@dptr,a
L002005?:
;	.\cmon51.c:83: txbuff[j]=*x;
	mov	a,r5
	add	a,#_txbuff
	mov	r7,a
	mov	a,r6
	addc	a,#(_txbuff >> 8)
	mov	r0,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r1,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	mov	dpl,r7
	mov	dph,r0
	mov	a,r1
	movx	@dptr,a
;	.\cmon51.c:84: x++;
;	.\cmon51.c:85: j++;
	inc	r5
	cjne	r5,#0x00,L002007?
	inc	r6
	sjmp	L002007?
L002009?:
;	.\cmon51.c:87: txbuff[j]=0;
	mov	a,r5
	add	a,#_txbuff
	mov	dpl,a
	mov	a,r6
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	clr	a
	movx	@dptr,a
;	.\cmon51.c:88: txcount=(j<0x100)?j:0xff;
	mov	a,#0x100 - 0x01
	add	a,r6
	jc	L002012?
	mov	ar2,r5
	mov	ar3,r6
	sjmp	L002013?
L002012?:
	mov	r2,#0xFF
	mov	r3,#0x00
L002013?:
	mov	dptr,#_txcount
	mov	a,r2
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'clearline'
;------------------------------------------------------------
;j                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:91: void clearline (void)
;	-----------------------------------------
;	 function clearline
;	-----------------------------------------
_clearline:
;	.\cmon51.c:94: while(txcount!=0);
L003001?:
	mov	dptr,#_txcount
	movx	a,@dptr
	mov	r2,a
	jnz	L003001?
;	.\cmon51.c:95: txbuff[0]='\r';
	mov	dptr,#_txbuff
	mov	a,#0x0D
	movx	@dptr,a
;	.\cmon51.c:96: for(j=1; j<80; j++) txbuff[j]=' ';
	mov	r2,#0x01
L003004?:
	cjne	r2,#0x50,L003016?
L003016?:
	jnc	L003007?
	mov	a,r2
	add	a,#_txbuff
	mov	dpl,a
	clr	a
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,#0x20
	movx	@dptr,a
	inc	r2
	sjmp	L003004?
L003007?:
;	.\cmon51.c:97: txbuff[j]='\r';
	mov	a,r2
	add	a,#_txbuff
	mov	dpl,a
	clr	a
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	mov	a,#0x0D
	movx	@dptr,a
;	.\cmon51.c:98: txbuff[j+1]=0;
	mov	a,r2
	inc	a
	add	a,#_txbuff
	mov	dpl,a
	clr	a
	addc	a,#(_txbuff >> 8)
	mov	dph,a
	clr	a
	movx	@dptr,a
;	.\cmon51.c:99: txcount=j;
	mov	dptr,#_txcount
	mov	a,r2
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getsn'
;------------------------------------------------------------
;j                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:102: void getsn (void)
;	-----------------------------------------
;	 function getsn
;	-----------------------------------------
_getsn:
;	.\cmon51.c:106: while(rxcount==0); // Wait for data to arrive
L004001?:
	mov	dptr,#_rxcount
	movx	a,@dptr
	mov	r2,a
	jz	L004001?
;	.\cmon51.c:107: for(j=0; j<rxcount; j++)
	mov	r2,#0x00
L004007?:
	mov	dptr,#_rxcount
	movx	a,@dptr
	mov	r3,a
	clr	c
	mov	a,r2
	subb	a,r3
	jnc	L004010?
;	.\cmon51.c:109: if(j<(BUFFSIZE-1))
	cjne	r2,#0x1F,L004021?
L004021?:
	jnc	L004010?
;	.\cmon51.c:111: buff[j]=rxbuff[j];
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	a,r2
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r3,a
	mov	@r0,a
;	.\cmon51.c:107: for(j=0; j<rxcount; j++)
	inc	r2
	sjmp	L004007?
L004010?:
;	.\cmon51.c:118: buff[j]=0;
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x00
;	.\cmon51.c:119: rxcount=0;
	mov	dptr,#_rxcount
	clr	a
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'chartohex'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;i                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:122: unsigned char chartohex(char c)
;	-----------------------------------------
;	 function chartohex
;	-----------------------------------------
_chartohex:
;	.\cmon51.c:125: i=toupper(c)-'0';
	mov  r2,dpl
	push	ar2
	lcall	_islower
	mov	a,dpl
	pop	ar2
	jz	L005005?
	mov	a,#0xDF
	anl	a,r2
	mov	r3,a
	sjmp	L005006?
L005005?:
	mov	ar3,r2
L005006?:
	mov	a,r3
	add	a,#0xd0
;	.\cmon51.c:126: if(i>9) i-=7; //letter from A to F
	mov  r2,a
	add	a,#0xff - 0x09
	jnc	L005002?
	mov	a,r2
	add	a,#0xf9
	mov	r2,a
L005002?:
;	.\cmon51.c:127: return i;
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'outbytenl'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:130: void outbytenl(unsigned char x)
;	-----------------------------------------
;	 function outbytenl
;	-----------------------------------------
_outbytenl:
	mov	r2,dpl
;	.\cmon51.c:132: get_txbuff();
	push	ar2
	lcall	_get_txbuff
	pop	ar2
;	.\cmon51.c:133: add_byte_txbuff(x);
	mov	dpl,r2
	lcall	_add_byte_txbuff
;	.\cmon51.c:134: add_nlcursor_txbuff();
	lcall	_add_nlcursor_txbuff
;	.\cmon51.c:135: flush_txbuff();
	ljmp	_flush_txbuff
;------------------------------------------------------------
;Allocation info for local variables in function 'outcursor'
;------------------------------------------------------------
;------------------------------------------------------------
;	.\cmon51.c:138: void outcursor(void)
;	-----------------------------------------
;	 function outcursor
;	-----------------------------------------
_outcursor:
;	.\cmon51.c:140: get_txbuff();
	lcall	_get_txbuff
;	.\cmon51.c:141: add_cursor_txbuff();
	lcall	_add_cursor_txbuff
;	.\cmon51.c:142: flush_txbuff();
	ljmp	_flush_txbuff
;------------------------------------------------------------
;Allocation info for local variables in function 'outwordnl'
;------------------------------------------------------------
;val                       Allocated to registers r2 r3 
;------------------------------------------------------------
;	.\cmon51.c:145: void outwordnl (unsigned int val)
;	-----------------------------------------
;	 function outwordnl
;	-----------------------------------------
_outwordnl:
	mov	r2,dpl
	mov	r3,dph
;	.\cmon51.c:147: get_txbuff();
	push	ar2
	push	ar3
	lcall	_get_txbuff
	pop	ar3
	pop	ar2
;	.\cmon51.c:148: add_word_txbuff(val);
	mov	dpl,r2
	mov	dph,r3
	lcall	_add_word_txbuff
;	.\cmon51.c:149: add_nlcursor_txbuff();
	lcall	_add_nlcursor_txbuff
;	.\cmon51.c:150: flush_txbuff();
	ljmp	_flush_txbuff
;------------------------------------------------------------
;Allocation info for local variables in function 'putcnl'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:153: void putcnl(char c)
;	-----------------------------------------
;	 function putcnl
;	-----------------------------------------
_putcnl:
	mov	r2,dpl
;	.\cmon51.c:155: get_txbuff();
	push	ar2
	lcall	_get_txbuff
	pop	ar2
;	.\cmon51.c:156: add_char_txbuff(c);
	mov	dpl,r2
	lcall	_add_char_txbuff
;	.\cmon51.c:157: add_nlcursor_txbuff();
	lcall	_add_nlcursor_txbuff
;	.\cmon51.c:158: flush_txbuff();
	ljmp	_flush_txbuff
;------------------------------------------------------------
;Allocation info for local variables in function 'fillmem'
;------------------------------------------------------------
;len                       Allocated with name '_fillmem_PARM_2'
;val                       Allocated with name '_fillmem_PARM_3'
;begin                     Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	.\cmon51.c:162: void fillmem(unsigned char * begin,  unsigned int len, unsigned char val)
;	-----------------------------------------
;	 function fillmem
;	-----------------------------------------
_fillmem:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	.\cmon51.c:164: while(len)
	mov	r5,_fillmem_PARM_2
	mov	r6,(_fillmem_PARM_2 + 1)
L010001?:
	mov	a,r5
	orl	a,r6
	jz	L010004?
;	.\cmon51.c:166: *begin=val;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,_fillmem_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
;	.\cmon51.c:167: begin++;
;	.\cmon51.c:168: len--;
	dec	r5
	cjne	r5,#0xff,L010001?
	dec	r6
	sjmp	L010001?
L010004?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'modifymem'
;------------------------------------------------------------
;loc                       Allocated with name '_modifymem_PARM_2'
;ptr                       Allocated to registers r2 r3 r4 
;j                         Allocated with name '_modifymem_j_1_105'
;sloc0                     Allocated with name '_modifymem_sloc0_1_0'
;sloc1                     Allocated with name '_modifymem_sloc1_1_0'
;------------------------------------------------------------
;	.\cmon51.c:173: void modifymem(unsigned char * ptr,  char loc)
;	-----------------------------------------
;	 function modifymem
;	-----------------------------------------
_modifymem:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	.\cmon51.c:177: get_txbuff();
	push	ar2
	push	ar3
	push	ar4
	lcall	_get_txbuff
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:178: while(1)
	mov	a,#0x49
	cjne	a,_modifymem_PARM_2,L011054?
	mov	a,#0x01
	sjmp	L011055?
L011054?:
	clr	a
L011055?:
	mov	_modifymem_sloc0_1_0,a
	mov	a,#0x44
	cjne	a,_modifymem_PARM_2,L011056?
	mov	a,#0x01
	sjmp	L011057?
L011056?:
	clr	a
L011057?:
	mov	r6,a
L011022?:
;	.\cmon51.c:180: add_char_txbuff(loc);
	mov	dpl,_modifymem_PARM_2
	push	ar2
	push	ar3
	push	ar4
	push	ar6
	lcall	_add_char_txbuff
;	.\cmon51.c:181: add_char_txbuff(':');
	mov	dpl,#0x3A
	lcall	_add_char_txbuff
	pop	ar6
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:183: if((loc=='D')||(loc=='I'))
	mov	a,r6
	jnz	L011001?
	mov	a,_modifymem_sloc0_1_0
	jz	L011002?
L011001?:
;	.\cmon51.c:184: add_byte_txbuff((unsigned char)ptr);
	mov	dpl,r2
	push	ar2
	push	ar3
	push	ar4
	push	ar6
	lcall	_add_byte_txbuff
	pop	ar6
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp	L011003?
L011002?:
;	.\cmon51.c:186: add_word_txbuff((unsigned int)ptr);
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	push	ar4
	push	ar6
	lcall	_add_word_txbuff
	pop	ar6
	pop	ar4
	pop	ar3
	pop	ar2
L011003?:
;	.\cmon51.c:188: add_str_txbuff("=  ");
	mov	dptr,#__str_0
	mov	b,#0x80
	push	ar2
	push	ar3
	push	ar4
	push	ar6
	lcall	_add_str_txbuff
;	.\cmon51.c:189: flush_txbuff();
	lcall	_flush_txbuff
	pop	ar6
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:192: while(rxcount==0);
L011005?:
	mov	dptr,#_rxcount
	movx	a,@dptr
	mov	r7,a
	jz	L011005?
;	.\cmon51.c:193: if( (!isxdigit(rxbuff[0])) || (!isxdigit(rxbuff[1])) )
	mov	dptr,#_rxbuff
	movx	a,@dptr
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	push	ar6
	lcall	_isxdigit
	mov	a,dpl
	pop	ar6
	pop	ar4
	pop	ar3
	pop	ar2
	jz	L011017?
	mov	dptr,#(_rxbuff + 0x0001)
	movx	a,@dptr
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	push	ar6
	lcall	_isxdigit
	mov	a,dpl
	pop	ar6
	pop	ar4
	pop	ar3
	pop	ar2
	jz	L011062?
	ljmp	L011050?
L011062?:
L011017?:
;	.\cmon51.c:195: if (rxbuff[0]=='\'')
	mov	dptr,#_rxbuff
	movx	a,@dptr
	mov	r7,a
	cjne	r7,#0x27,L011012?
;	.\cmon51.c:197: for(j=1; (rxbuff[j]!=0) && (rxbuff[j]!='\''); j++) (*ptr++)=rxbuff[j];
	mov	ar7,r2
	mov	ar0,r3
	mov	ar1,r4
	mov	_modifymem_j_1_105,#0x01
L011025?:
	mov	a,_modifymem_j_1_105
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r5,a
	cjne	r5,#0x00,L011065?
	ljmp	L011052?
L011065?:
	mov	a,_modifymem_j_1_105
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r5,a
	cjne	r5,#0x27,L011066?
	ljmp	L011052?
L011066?:
	mov	a,_modifymem_j_1_105
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r5,a
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrput
	inc	dptr
	mov	r7,dpl
	mov	r0,dph
	mov	ar2,r7
	mov	ar3,r0
	mov	ar4,r1
	inc	_modifymem_j_1_105
	sjmp	L011025?
L011012?:
;	.\cmon51.c:199: else if (toupper(rxbuff[0])!='S')
	mov	dptr,#_rxbuff
	movx	a,@dptr
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	push	ar6
	lcall	_islower
	mov	a,dpl
	pop	ar6
	pop	ar4
	pop	ar3
	pop	ar2
	jz	L011035?
	mov	dptr,#_rxbuff
	movx	a,@dptr
	mov	r5,a
	anl	ar5,#0xDF
	sjmp	L011036?
L011035?:
	mov	dptr,#_rxbuff
	movx	a,@dptr
	mov	r5,a
L011036?:
	cjne	r5,#0x53,L011068?
	sjmp	L011009?
L011068?:
;	.\cmon51.c:201: rxcount=0;
	mov	dptr,#_rxcount
	clr	a
	movx	@dptr,a
;	.\cmon51.c:202: break; // get out of while(1) loop
	ljmp	L011023?
L011009?:
;	.\cmon51.c:204: else ptr++;
	inc	r2
	cjne	r2,#0x00,L011069?
	inc	r3
L011069?:
	ljmp	L011019?
;	.\cmon51.c:208: for(j=0; j<rxcount; j+=3)
L011050?:
	mov	_modifymem_sloc1_1_0,r2
	mov	(_modifymem_sloc1_1_0 + 1),r3
	mov	(_modifymem_sloc1_1_0 + 2),r4
	mov	_modifymem_j_1_105,#0x00
L011029?:
	mov	dptr,#_rxcount
	movx	a,@dptr
	mov	r5,a
	clr	c
	mov	a,_modifymem_j_1_105
	subb	a,r5
	jc	L011070?
	ljmp	L011053?
L011070?:
;	.\cmon51.c:210: if( (isxdigit(rxbuff[j])) && (isxdigit(rxbuff[j+1])) )
	mov	a,_modifymem_j_1_105
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	dpl,a
	push	ar6
	lcall	_isxdigit
	mov	a,dpl
	pop	ar6
	jz	L011031?
	mov	a,_modifymem_j_1_105
	inc	a
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	dpl,a
	push	ar6
	lcall	_isxdigit
	mov	a,dpl
	pop	ar6
	jz	L011031?
;	.\cmon51.c:212: (*ptr++)=chartohex(rxbuff[j])*0x10+chartohex(rxbuff[j+1]);
	push	ar6
	mov	a,_modifymem_j_1_105
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	dpl,a
	push	ar6
	lcall	_chartohex
	mov	r5,dpl
	pop	ar6
	mov	a,r5
	swap	a
	anl	a,#0xf0
	mov	r5,a
	mov	a,_modifymem_j_1_105
	inc	a
	add	a,#_rxbuff
	mov	dpl,a
	clr	a
	addc	a,#(_rxbuff >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	dpl,a
	push	ar5
	lcall	_chartohex
	mov	r6,dpl
	pop	ar5
	mov	a,r6
	add	a,r5
	mov	r5,a
	mov	dpl,_modifymem_sloc1_1_0
	mov	dph,(_modifymem_sloc1_1_0 + 1)
	mov	b,(_modifymem_sloc1_1_0 + 2)
	lcall	__gptrput
	inc	dptr
	mov	_modifymem_sloc1_1_0,dpl
	mov	(_modifymem_sloc1_1_0 + 1),dph
	mov	r2,_modifymem_sloc1_1_0
	mov	r3,(_modifymem_sloc1_1_0 + 1)
	mov	r4,(_modifymem_sloc1_1_0 + 2)
;	.\cmon51.c:219: flush_txbuff();
	pop	ar6
;	.\cmon51.c:212: (*ptr++)=chartohex(rxbuff[j])*0x10+chartohex(rxbuff[j+1]);
L011031?:
;	.\cmon51.c:208: for(j=0; j<rxcount; j+=3)
	inc	_modifymem_j_1_105
	inc	_modifymem_j_1_105
	inc	_modifymem_j_1_105
	ljmp	L011029?
L011052?:
	mov	ar2,r7
	mov	ar3,r0
	mov	ar4,r1
;	.\cmon51.c:219: flush_txbuff();
;	.\cmon51.c:208: for(j=0; j<rxcount; j+=3)
	sjmp	L011019?
L011053?:
	mov	r2,_modifymem_sloc1_1_0
	mov	r3,(_modifymem_sloc1_1_0 + 1)
	mov	r4,(_modifymem_sloc1_1_0 + 2)
L011019?:
;	.\cmon51.c:216: rxcount=0;
	mov	dptr,#_rxcount
	clr	a
	movx	@dptr,a
	ljmp	L011022?
L011023?:
;	.\cmon51.c:218: add_nlcursor_txbuff();
	lcall	_add_nlcursor_txbuff
;	.\cmon51.c:219: flush_txbuff();
	ljmp	_flush_txbuff
;------------------------------------------------------------
;Allocation info for local variables in function 'dispmem'
;------------------------------------------------------------
;len                       Allocated with name '_dispmem_PARM_2'
;loc                       Allocated with name '_dispmem_PARM_3'
;begin                     Allocated with name '_dispmem_begin_1_113'
;j                         Allocated with name '_dispmem_j_1_114'
;n                         Allocated to registers r3 
;i                         Allocated to registers r2 
;k                         Allocated to registers 
;------------------------------------------------------------
;	.\cmon51.c:223: void dispmem(unsigned char * begin,  unsigned int len, char loc)
;	-----------------------------------------
;	 function dispmem
;	-----------------------------------------
_dispmem:
	mov	_dispmem_begin_1_113,dpl
	mov	(_dispmem_begin_1_113 + 1),dph
	mov	(_dispmem_begin_1_113 + 2),b
;	.\cmon51.c:228: get_txbuff();
	lcall	_get_txbuff
;	.\cmon51.c:230: if(len==0) len=0x80;
	mov	a,_dispmem_PARM_2
	orl	a,(_dispmem_PARM_2 + 1)
	jnz	L012002?
	mov	_dispmem_PARM_2,#0x80
	clr	a
	mov	(_dispmem_PARM_2 + 1),a
L012002?:
;	.\cmon51.c:232: buff[16]=0;
	mov	(_buff + 0x0010),#0x00
;	.\cmon51.c:234: for(j=0; j<len; j++)
	mov	a,#0x49
	cjne	a,_dispmem_PARM_3,L012038?
	mov	a,#0x01
	sjmp	L012039?
L012038?:
	clr	a
L012039?:
	mov	r5,a
	mov	a,#0x44
	cjne	a,_dispmem_PARM_3,L012040?
	mov	a,#0x01
	sjmp	L012041?
L012040?:
	clr	a
L012041?:
	mov	r6,a
	clr	a
	mov	_dispmem_j_1_114,a
	mov	(_dispmem_j_1_114 + 1),a
L012018?:
	clr	c
	mov	a,_dispmem_j_1_114
	subb	a,_dispmem_PARM_2
	mov	a,(_dispmem_j_1_114 + 1)
	subb	a,(_dispmem_PARM_2 + 1)
	jc	L012042?
	ljmp	L012021?
L012042?:
;	.\cmon51.c:236: if(loc=='I')
	mov	a,r5
	jz	L012004?
;	.\cmon51.c:238: n=*(idata unsigned char *)((unsigned char)begin+j);
	mov	r3,_dispmem_begin_1_113
	mov	r4,#0x00
	mov	a,_dispmem_j_1_114
	add	a,r3
	mov	r3,a
	mov	a,(_dispmem_j_1_114 + 1)
	addc	a,r4
	mov	r4,a
	mov	ar0,r3
	mov	ar3,@r0
	sjmp	L012005?
L012004?:
;	.\cmon51.c:242: n=begin[j];
	mov	a,_dispmem_j_1_114
	add	a,_dispmem_begin_1_113
	mov	r4,a
	mov	a,(_dispmem_j_1_114 + 1)
	addc	a,(_dispmem_begin_1_113 + 1)
	mov	r2,a
	mov	r7,(_dispmem_begin_1_113 + 2)
	mov	dpl,r4
	mov	dph,r2
	mov	b,r7
	lcall	__gptrget
	mov	r3,a
L012005?:
;	.\cmon51.c:244: i=j&0xf;
	mov	a,#0x0F
	anl	a,_dispmem_j_1_114
;	.\cmon51.c:246: if(i==0) 
	mov	r2,a
	mov	r4,#0x00
	jnz	L012011?
;	.\cmon51.c:248: add_char_txbuff(loc);  //A letter to indicate Data, Xram, Code, Idata
	mov	dpl,_dispmem_PARM_3
	push	ar2
	push	ar3
	push	ar5
	push	ar6
	lcall	_add_char_txbuff
;	.\cmon51.c:249: add_char_txbuff(':');
	mov	dpl,#0x3A
	lcall	_add_char_txbuff
	pop	ar6
	pop	ar5
	pop	ar3
	pop	ar2
;	.\cmon51.c:250: if((loc=='D')||(loc=='I'))
	mov	a,r6
	jnz	L012006?
	mov	a,r5
	jz	L012007?
L012006?:
;	.\cmon51.c:251: add_byte_txbuff((unsigned char)begin+j);
	mov	r4,_dispmem_begin_1_113
	mov	a,_dispmem_j_1_114
	add	a,r4
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar5
	push	ar6
	lcall	_add_byte_txbuff
	pop	ar6
	pop	ar5
	pop	ar3
	pop	ar2
	sjmp	L012008?
L012007?:
;	.\cmon51.c:253: add_word_txbuff((unsigned int)begin+j);
	mov	r4,_dispmem_begin_1_113
	mov	r7,(_dispmem_begin_1_113 + 1)
	mov	a,_dispmem_j_1_114
	add	a,r4
	mov	dpl,a
	mov	a,(_dispmem_j_1_114 + 1)
	addc	a,r7
	mov	dph,a
	push	ar2
	push	ar3
	push	ar5
	push	ar6
	lcall	_add_word_txbuff
	pop	ar6
	pop	ar5
	pop	ar3
	pop	ar2
L012008?:
;	.\cmon51.c:254: add_str_txbuff(":  ");
	mov	dptr,#__str_1
	mov	b,#0x80
	push	ar2
	push	ar3
	push	ar5
	push	ar6
	lcall	_add_str_txbuff
	pop	ar6
	pop	ar5
	pop	ar3
	pop	ar2
L012011?:
;	.\cmon51.c:256: add_byte_txbuff(n);
	mov	dpl,r3
	push	ar2
	push	ar3
	push	ar5
	push	ar6
	lcall	_add_byte_txbuff
	pop	ar6
	pop	ar5
	pop	ar3
	pop	ar2
;	.\cmon51.c:257: add_char_txbuff(i==7?'-':' '); //A middle separator like the old good DOS debug
	cjne	r2,#0x07,L012024?
	mov	r4,#0x2D
	sjmp	L012025?
L012024?:
	mov	r4,#0x20
L012025?:
	mov	dpl,r4
	push	ar2
	push	ar3
	push	ar5
	push	ar6
	lcall	_add_char_txbuff
	pop	ar6
	pop	ar5
	pop	ar3
	pop	ar2
;	.\cmon51.c:259: if((n>0x20)&&(n<0x7f))
	mov	a,r3
	add	a,#0xff - 0x20
	jnc	L012013?
	cjne	r3,#0x7F,L012050?
L012050?:
	jnc	L012013?
;	.\cmon51.c:260: buff[i]=n;
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,ar3
	sjmp	L012014?
L012013?:
;	.\cmon51.c:262: buff[i]='.';
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x2E
L012014?:
;	.\cmon51.c:264: if(i==0xf)
	cjne	r2,#0x0F,L012020?
;	.\cmon51.c:266: add_str_txbuff("   ");
	mov	dptr,#__str_2
	mov	b,#0x80
	push	ar5
	push	ar6
	lcall	_add_str_txbuff
;	.\cmon51.c:267: add_str_txbuff(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_add_str_txbuff
;	.\cmon51.c:268: add_char_txbuff('\r');
	mov	dpl,#0x0D
	lcall	_add_char_txbuff
;	.\cmon51.c:269: add_char_txbuff('\n');
	mov	dpl,#0x0A
	lcall	_add_char_txbuff
;	.\cmon51.c:270: update_txbuff();
	lcall	_update_txbuff
	pop	ar6
	pop	ar5
L012020?:
;	.\cmon51.c:234: for(j=0; j<len; j++)
	inc	_dispmem_j_1_114
	clr	a
	cjne	a,_dispmem_j_1_114,L012054?
	inc	(_dispmem_j_1_114 + 1)
L012054?:
	ljmp	L012018?
L012021?:
;	.\cmon51.c:273: add_nlcursor_txbuff();
	lcall	_add_nlcursor_txbuff
;	.\cmon51.c:274: flush_txbuff();
	ljmp	_flush_txbuff
;------------------------------------------------------------
;Allocation info for local variables in function 'cleanbuff'
;------------------------------------------------------------
;j                         Allocated to registers r2 
;k                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:278: void cleanbuff (void)
;	-----------------------------------------
;	 function cleanbuff
;	-----------------------------------------
_cleanbuff:
;	.\cmon51.c:282: buff_haseq=0;
	clr	_buff_haseq
;	.\cmon51.c:283: buff_hasdot=0;
	clr	_buff_hasdot
;	.\cmon51.c:286: for(j=0; j<BUFFSIZE; j++)
	mov	r2,#0x00
L013013?:
	cjne	r2,#0x20,L013044?
L013044?:
	jnc	L013016?
;	.\cmon51.c:288: buff[j]=toupper(buff[j]);
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	dpl,@r0
	push	ar2
	push	ar0
	lcall	_islower
	mov	a,dpl
	pop	ar0
	pop	ar2
	jz	L013027?
	mov	a,r2
	add	a,#_buff
	mov	r1,a
	mov	ar3,@r1
	anl	ar3,#0xDF
	sjmp	L013028?
L013027?:
	mov	a,r2
	add	a,#_buff
	mov	r1,a
	mov	ar3,@r1
L013028?:
	mov	@r0,ar3
;	.\cmon51.c:289: if(isspace(buff[j])) buff[j]=0;
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	dpl,@r0
	push	ar2
	lcall	_isspace
	mov	a,dpl
	pop	ar2
	jz	L013002?
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x00
L013002?:
;	.\cmon51.c:290: if(buff[j]=='=')
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	ar3,@r0
	cjne	r3,#0x3D,L013007?
;	.\cmon51.c:292: buff[j]=0;
	mov	@r0,#0x00
;	.\cmon51.c:293: buff_haseq=1;
	setb	_buff_haseq
	sjmp	L013015?
L013007?:
;	.\cmon51.c:295: else if((buff[j]=='.')||(buff[j]=='_'))
	mov	ar3,@r0
	cjne	r3,#0x2E,L013050?
	sjmp	L013003?
L013050?:
	cjne	r3,#0x5F,L013015?
L013003?:
;	.\cmon51.c:297: buff[j]=0;
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x00
;	.\cmon51.c:298: buff_hasdot=1;
	setb	_buff_hasdot
L013015?:
;	.\cmon51.c:286: for(j=0; j<BUFFSIZE; j++)
	inc	r2
	sjmp	L013013?
L013016?:
;	.\cmon51.c:303: for(j=0, k=0; j<BUFFSIZE; j++)
	mov	r2,#0x00
	mov	r3,#0x00
L013017?:
	cjne	r3,#0x20,L013053?
L013053?:
	jnc	L013040?
;	.\cmon51.c:305: buff[k]=buff[j];
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	a,r3
	add	a,#_buff
	mov	r1,a
	mov	ar4,@r1
	mov	@r0,ar4
;	.\cmon51.c:306: if( ((buff[j]!=0)||(buff[j+1]!=0)) && buff[0]!=0) k++;
	mov	a,r4
	jnz	L013012?
	mov	a,r3
	inc	a
	add	a,#_buff
	mov	r0,a
	mov	a,@r0
	jz	L013019?
L013012?:
	mov	a,_buff
	jz	L013019?
	inc	r2
L013019?:
;	.\cmon51.c:303: for(j=0, k=0; j<BUFFSIZE; j++)
	inc	r3
	sjmp	L013017?
L013040?:
L013021?:
;	.\cmon51.c:308: for(; k<BUFFSIZE; k++) buff[k]=0;
	cjne	r2,#0x20,L013058?
L013058?:
	jnc	L013025?
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x00
	inc	r2
	sjmp	L013021?
L013025?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getwordn'
;------------------------------------------------------------
;word                      Allocated to registers r2 r3 
;------------------------------------------------------------
;	.\cmon51.c:312: unsigned int getwordn(void)
;	-----------------------------------------
;	 function getwordn
;	-----------------------------------------
_getwordn:
;	.\cmon51.c:314: unsigned int word=0;
	mov	r2,#0x00
	mov	r3,#0x00
;	.\cmon51.c:321: cursor++;
L014003?:
;	.\cmon51.c:316: for( ; buff[cursor]!=0; cursor++)
	mov	a,_cursor
	add	a,#_buff
	mov	r0,a
	mov	ar4,@r0
	cjne	r4,#0x00,L014012?
	sjmp	L014006?
L014012?:
;	.\cmon51.c:318: if(isxdigit(buff[cursor]))
	mov	dpl,r4
	push	ar2
	push	ar3
	lcall	_isxdigit
	mov	a,dpl
	pop	ar3
	pop	ar2
	jz	L014005?
;	.\cmon51.c:319: word=(word*0x10)+chartohex(buff[cursor]);
	mov	ar4,r2
	mov	a,r3
	swap	a
	anl	a,#0xf0
	xch	a,r4
	swap	a
	xch	a,r4
	xrl	a,r4
	xch	a,r4
	anl	a,#0xf0
	xch	a,r4
	xrl	a,r4
	mov	r5,a
	mov	a,_cursor
	add	a,#_buff
	mov	r0,a
	mov	dpl,@r0
	push	ar4
	push	ar5
	lcall	_chartohex
	mov	r6,dpl
	pop	ar5
	pop	ar4
	mov	r7,#0x00
	mov	a,r6
	add	a,r4
	mov	r2,a
	mov	a,r7
	addc	a,r5
	mov	r3,a
L014005?:
;	.\cmon51.c:316: for( ; buff[cursor]!=0; cursor++)
	inc	_cursor
	sjmp	L014003?
L014006?:
;	.\cmon51.c:321: cursor++;
	inc	_cursor
;	.\cmon51.c:322: return word;
	mov	dpl,r2
	mov	dph,r3
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'add_byte_buff'
;------------------------------------------------------------
;loc                       Allocated with name '_add_byte_buff_PARM_2'
;val                       Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:325: void add_byte_buff(unsigned char val, unsigned char loc)
;	-----------------------------------------
;	 function add_byte_buff
;	-----------------------------------------
_add_byte_buff:
	mov	r2,dpl
;	.\cmon51.c:327: txbuff[loc]=  hexval[val/0x10];
	mov	a,_add_byte_buff_PARM_2
	add	a,#_txbuff
	mov	r3,a
	clr	a
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
;	.\cmon51.c:328: txbuff[loc+1]=hexval[val&0x0f];
	mov	a,_add_byte_buff_PARM_2
	inc	a
	add	a,#_txbuff
	mov	r3,a
	clr	a
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
;Allocation info for local variables in function 'disp_regs'
;------------------------------------------------------------
;j                         Allocated to registers r4 
;bank                      Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:339: void disp_regs(void)
;	-----------------------------------------
;	 function disp_regs
;	-----------------------------------------
_disp_regs:
;	.\cmon51.c:343: get_txbuff();
	lcall	_get_txbuff
;	.\cmon51.c:344: add_str_txbuff(regframe);
	mov	dptr,#_regframe
	mov	b,#0x80
	lcall	_add_str_txbuff
;	.\cmon51.c:346: add_byte_buff(A_save,   3);
	mov	dptr,#_A_save
	movx	a,@dptr
	mov	r2,a
	mov	_add_byte_buff_PARM_2,#0x03
	mov	dpl,r2
	lcall	_add_byte_buff
;	.\cmon51.c:347: add_byte_buff(B_save,   10);
	mov	dptr,#_B_save
	movx	a,@dptr
	mov	r2,a
	mov	_add_byte_buff_PARM_2,#0x0A
	mov	dpl,r2
	lcall	_add_byte_buff
;	.\cmon51.c:348: add_byte_buff(SP_save,  17);
	mov	dptr,#_SP_save
	movx	a,@dptr
	mov	r2,a
	mov	_add_byte_buff_PARM_2,#0x11
	mov	dpl,r2
	lcall	_add_byte_buff
;	.\cmon51.c:349: add_byte_buff(IE_save,  24);
	mov	dptr,#_IE_save
	movx	a,@dptr
	mov	r2,a
	mov	_add_byte_buff_PARM_2,#0x18
	mov	dpl,r2
	lcall	_add_byte_buff
;	.\cmon51.c:350: add_byte_buff(DPH_save, 32);
	mov	dptr,#_DPH_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	dpl,r2
	mov	_add_byte_buff_PARM_2,#0x20
	lcall	_add_byte_buff
;	.\cmon51.c:351: add_byte_buff(DPL_save, 39);
	mov	dptr,#_DPL_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	dpl,r2
	mov	_add_byte_buff_PARM_2,#0x27
	lcall	_add_byte_buff
;	.\cmon51.c:352: add_byte_buff(PSW_save, 46);
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r2,a
	mov	_add_byte_buff_PARM_2,#0x2E
	mov	dpl,r2
	lcall	_add_byte_buff
;	.\cmon51.c:353: add_byte_buff((PC_save/0x100), 52);
	mov	dptr,#_PC_save
	movx	a,@dptr
	inc	dptr
	movx	a,@dptr
	mov	dpl,a
	mov	_add_byte_buff_PARM_2,#0x34
	lcall	_add_byte_buff
;	.\cmon51.c:354: add_byte_buff((PC_save%0x100), 54);
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	dpl,r2
	mov	_add_byte_buff_PARM_2,#0x36
	lcall	_add_byte_buff
;	.\cmon51.c:356: bank=(PSW_save/0x8)&0x3;
	mov	dptr,#_PSW_save
	movx	a,@dptr
	swap	a
	rl	a
;	.\cmon51.c:357: for(j=0; j<8; j++)
	anl	a,#(0x1f&0x03)
	mov	r2,a
	swap	a
	rr	a
	anl	a,#0xf8
	mov	r3,a
	mov	r4,#0x00
L016001?:
	cjne	r4,#0x08,L016010?
L016010?:
	jnc	L016004?
;	.\cmon51.c:359: add_byte_buff(iram_save[j+bank*8], 58+3+(7*j));
	mov	a,r3
	add	a,r4
	add	a,#_iram_save
	mov	dpl,a
	clr	a
	addc	a,#(_iram_save >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r5,a
	mov	a,r4
	mov	b,#0x07
	mul	ab
	add	a,#0x3D
	mov	_add_byte_buff_PARM_2,a
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_add_byte_buff
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:357: for(j=0; j<8; j++)
	inc	r4
	sjmp	L016001?
L016004?:
;	.\cmon51.c:361: txbuff[58+61]=('0'+bank);
	mov	a,#0x30
	add	a,r2
	mov	dptr,#(_txbuff + 0x0077)
	movx	@dptr,a
;	.\cmon51.c:363: append_txbuff=1;
	setb	_append_txbuff
;	.\cmon51.c:364: discnt=1;
	mov	_discnt,#0x01
	clr	a
	mov	(_discnt + 1),a
;	.\cmon51.c:365: unassemble(PC_save); //The next assembly instruction...
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	lcall	_unassemble
;	.\cmon51.c:366: append_txbuff=0;
	clr	_append_txbuff
;	.\cmon51.c:367: add_nlcursor_txbuff();
	lcall	_add_nlcursor_txbuff
;	.\cmon51.c:368: flush_txbuff();
	ljmp	_flush_txbuff
;------------------------------------------------------------
;Allocation info for local variables in function 'nlist'
;------------------------------------------------------------
;slist                     Allocated to registers r2 r3 r4 
;x                         Allocated to registers r5 
;q                         Allocated with name '_nlist_q_1_135'
;sloc0                     Allocated with name '_nlist_sloc0_1_0'
;------------------------------------------------------------
;	.\cmon51.c:371: unsigned char nlist (unsigned char * slist)
;	-----------------------------------------
;	 function nlist
;	-----------------------------------------
_nlist:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	.\cmon51.c:373: unsigned char x=0xff, q;
	mov	r5,#0xFF
;	.\cmon51.c:375: while(*slist)
L017006?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r6,a
	jz	L017008?
;	.\cmon51.c:377: if((*slist)>0x7f)
	mov	a,r6
	add	a,#0xff - 0x7F
	jnc	L017005?
;	.\cmon51.c:379: x=*(slist++);
	mov	ar5,r6
	inc	r2
	cjne	r2,#0x00,L017029?
	inc	r3
L017029?:
;	.\cmon51.c:380: for(q=0; (*slist<=0x7f) && (*slist==(unsigned char)buff[q]) ; q++) slist++;
	mov	_nlist_sloc0_1_0,r2
	mov	(_nlist_sloc0_1_0 + 1),r3
	mov	(_nlist_sloc0_1_0 + 2),r4
	mov	_nlist_q_1_135,#0x00
L017012?:
	mov	dpl,_nlist_sloc0_1_0
	mov	dph,(_nlist_sloc0_1_0 + 1)
	mov	b,(_nlist_sloc0_1_0 + 2)
	lcall	__gptrget
	mov  r7,a
	add	a,#0xff - 0x7F
	jc	L017026?
	mov	a,_nlist_q_1_135
	add	a,#_buff
	mov	r0,a
	mov	ar6,@r0
	mov	a,r7
	cjne	a,ar6,L017026?
	inc	_nlist_sloc0_1_0
	clr	a
	cjne	a,_nlist_sloc0_1_0,L017033?
	inc	(_nlist_sloc0_1_0 + 1)
L017033?:
	inc	_nlist_q_1_135
	sjmp	L017012?
L017026?:
	mov	r2,_nlist_sloc0_1_0
	mov	r3,(_nlist_sloc0_1_0 + 1)
	mov	r4,(_nlist_sloc0_1_0 + 2)
;	.\cmon51.c:381: if((*slist>0x7f)&&(buff[q]==0)) break;
	mov	dpl,_nlist_sloc0_1_0
	mov	dph,(_nlist_sloc0_1_0 + 1)
	mov	b,(_nlist_sloc0_1_0 + 2)
	lcall	__gptrget
	mov  r6,a
	add	a,#0xff - 0x7F
	jnc	L017005?
	mov	a,_nlist_q_1_135
	add	a,#_buff
	mov	r0,a
	mov	a,@r0
	jz	L017008?
L017005?:
;	.\cmon51.c:383: slist++;
	inc	r2
	cjne	r2,#0x00,L017006?
	inc	r3
	sjmp	L017006?
L017008?:
;	.\cmon51.c:385: if(*slist) return x;//Found one!
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	jz	L017010?
	mov	dpl,r5
;	.\cmon51.c:386: return 0xff; //What if a sfr is located at 0xff?
	ret
L017010?:
	mov	dpl,#0xFF
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'breakorstep'
;------------------------------------------------------------
;n                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:389: void breakorstep (void)
;	-----------------------------------------
;	 function breakorstep
;	-----------------------------------------
_breakorstep:
;	.\cmon51.c:393: gotbreak=0;
	mov	dptr,#_gotbreak
	clr	a
	movx	@dptr,a
;	.\cmon51.c:394: breakpoint=0;
	clr	_breakpoint
;	.\cmon51.c:396: if(go_pending==0x55)
	mov	dptr,#_go_pending
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x55,L018002?
;	.\cmon51.c:398: go_pending=0xaa;
	mov	dptr,#_go_pending
	mov	a,#0xAA
	movx	@dptr,a
;	.\cmon51.c:399: step_start=PC_save; //Next instruction to be executed
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_step_start
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	.\cmon51.c:400: gotbreak=0; //If changes to 1, the single step function worked!
	mov	dptr,#_gotbreak
	clr	a
	movx	@dptr,a
;	.\cmon51.c:401: gostep=1;
	mov	dptr,#_gostep
	mov	a,#0x01
	movx	@dptr,a
;	.\cmon51.c:402: dostep();
	lcall	_dostep
L018002?:
;	.\cmon51.c:404: go_pending=0xaa;	
	mov	dptr,#_go_pending
	mov	a,#0xAA
	movx	@dptr,a
;	.\cmon51.c:406: if (trace_type)
	mov	dptr,#_trace_type
	movx	a,@dptr
	mov	r2,a
	jnz	L018043?
	ljmp	L018017?
L018043?:
;	.\cmon51.c:408: if(trace_type==1) //Run in trace mode until a breapoint is hit
	mov	dptr,#_trace_type
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x01,L018006?
;	.\cmon51.c:410: for (n=0; n<4; n++)
	mov	r2,#0x00
L018021?:
	cjne	r2,#0x04,L018046?
L018046?:
	jnc	L018006?
;	.\cmon51.c:412: if(br[n]==PC_save)
	mov	a,r2
	add	a,r2
	add	a,#_br
	mov	dpl,a
	clr	a
	addc	a,#(_br >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	a,r3
	cjne	a,ar5,L018023?
	mov	a,r4
	cjne	a,ar6,L018023?
;	.\cmon51.c:414: breakpoint=1;
	setb	_breakpoint
L018023?:
;	.\cmon51.c:410: for (n=0; n<4; n++)
	inc	r2
	sjmp	L018021?
L018006?:
;	.\cmon51.c:418: if ((break_address!=PC_save))
	mov	dptr,#_break_address
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	a,r2
	cjne	a,ar4,L018050?
	mov	a,r3
	cjne	a,ar5,L018050?
	sjmp	L018017?
L018050?:
;	.\cmon51.c:420: if (trace_type>=2)
	mov	dptr,#_trace_type
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x02,L018051?
L018051?:
	jc	L018008?
;	.\cmon51.c:422: discnt=1;
	mov	_discnt,#0x01
	clr	a
	mov	(_discnt + 1),a
;	.\cmon51.c:423: unassemble(step_start); //The executed assembly instruction...
	mov	dptr,#_step_start
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	lcall	_unassemble
L018008?:
;	.\cmon51.c:425: if((JRXRDY==0)&&(breakpoint==0))
	jb	_JRXRDY,L018017?
	jb	_breakpoint,L018017?
;	.\cmon51.c:427: if(trace_type==3) disp_regs();
	mov	dptr,#_trace_type
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x03,L018010?
	lcall	_disp_regs
L018010?:
;	.\cmon51.c:428: step_start=PC_save;
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_step_start
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	.\cmon51.c:429: dostep();
	lcall	_dostep
L018017?:
;	.\cmon51.c:433: if((trace_type>=2) && (RI==0))
	mov	dptr,#_trace_type
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x02,L018057?
L018057?:
	jc	L018019?
	jb	_RI,L018019?
;	.\cmon51.c:435: discnt=1;
	mov	_discnt,#0x01
	clr	a
	mov	(_discnt + 1),a
;	.\cmon51.c:436: unassemble(step_start); //The executed assembly instruction...
	mov	dptr,#_step_start
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	lcall	_unassemble
L018019?:
;	.\cmon51.c:439: disp_regs();
	ljmp	_disp_regs
;------------------------------------------------------------
;Allocation info for local variables in function 'do_cmd'
;------------------------------------------------------------
;i                         Allocated with name '_do_cmd_i_1_150'
;j                         Allocated with name '_do_cmd_j_1_150'
;n                         Allocated with name '_do_cmd_n_1_150'
;p                         Allocated to registers r4 r5 
;q                         Allocated with name '_do_cmd_q_1_150'
;c                         Allocated to registers r6 
;d                         Allocated to registers r2 
;x                         Allocated to registers r7 
;y                         Allocated with name '_do_cmd_y_1_150'
;cmd                       Allocated with name '_do_cmd_cmd_1_150'
;sloc0                     Allocated with name '_do_cmd_sloc0_1_0'
;------------------------------------------------------------
;	.\cmon51.c:442: void do_cmd (void)
;	-----------------------------------------
;	 function do_cmd
;	-----------------------------------------
_do_cmd:
;	.\cmon51.c:450: append_txbuff=0;
	clr	_append_txbuff
;	.\cmon51.c:452: if (gotbreak!=1) //Power-on reset
	mov	dptr,#_gotbreak
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x01,L019320?
	sjmp	L019002?
L019320?:
;	.\cmon51.c:454: txcount=0;
	mov	dptr,#_txcount
	clr	a
	movx	@dptr,a
;	.\cmon51.c:455: putsp(BANNER);
	mov	dptr,#__str_3
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:456: SP_save=7; //Default user stack location
	mov	dptr,#_SP_save
	mov	a,#0x07
	movx	@dptr,a
;	.\cmon51.c:457: LEDRA_save=0xff;
	mov	dptr,#_LEDRA_save
	mov	a,#0xFF
	movx	@dptr,a
;	.\cmon51.c:458: LEDRB_save=0xff;
	mov	dptr,#_LEDRB_save
	mov	a,#0xFF
	movx	@dptr,a
;	.\cmon51.c:459: restorePC();
	lcall	_restorePC
;	.\cmon51.c:460: cmd=0;
	mov	_do_cmd_cmd_1_150,#0x00
	sjmp	L019220?
L019002?:
;	.\cmon51.c:462: else breakorstep(); //Got here from the beak/step interrupt
	lcall	_breakorstep
;	.\cmon51.c:464: while(1)
L019220?:
;	.\cmon51.c:466: fillmem(buff, BUFFSIZE, 0);;
	mov	_fillmem_PARM_2,#0x20
	clr	a
	mov	(_fillmem_PARM_2 + 1),a
	mov	_fillmem_PARM_3,#0x00
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_fillmem
;	.\cmon51.c:467: getsn();
	lcall	_getsn
;	.\cmon51.c:468: cleanbuff();
	lcall	_cleanbuff
;	.\cmon51.c:469: break_address=0;
	mov	dptr,#_break_address
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	.\cmon51.c:470: trace_type=0;
	mov	dptr,#_trace_type
	clr	a
	movx	@dptr,a
;	.\cmon51.c:473: cursor=0;
	mov	_cursor,#0x00
;	.\cmon51.c:474: getwordn();   //skip the command name
	lcall	_getwordn
;	.\cmon51.c:475: n=getwordn(); //n is the first parameter/number
	lcall	_getwordn
	mov	_do_cmd_n_1_150,dpl
	mov	(_do_cmd_n_1_150 + 1),dph
;	.\cmon51.c:476: p=getwordn(); //p is the second parameter/number
	lcall	_getwordn
	mov	r4,dpl
	mov	r5,dph
;	.\cmon51.c:477: q=getwordn(); //q is the third parameter/number
	push	ar4
	push	ar5
	lcall	_getwordn
	mov	_do_cmd_q_1_150,dpl
	mov	(_do_cmd_q_1_150 + 1),dph
	pop	ar5
	pop	ar4
;	.\cmon51.c:478: i=n&0xfff0;
	mov	a,#0xF0
	anl	a,_do_cmd_n_1_150
	mov	_do_cmd_i_1_150,a
	mov	(_do_cmd_i_1_150 + 1),(_do_cmd_n_1_150 + 1)
;	.\cmon51.c:479: j=(p+15)&0xfff0;
	mov	a,#0x0F
	add	a,r4
	mov	r6,a
	clr	a
	addc	a,r5
	mov	r7,a
	mov	a,#0xF0
	anl	a,r6
	mov	_do_cmd_j_1_150,a
	mov	(_do_cmd_j_1_150 + 1),r7
;	.\cmon51.c:480: c=n; // Sometimes for the first parameter we need an unsigned char
	mov	r6,_do_cmd_n_1_150
;	.\cmon51.c:481: p_bit=(p==0?0:1);
	mov	a,r4
	orl	a,r5
	add	a,#0xff
	mov	_do_cmd_p_bit_1_150,c
;	.\cmon51.c:483: cmd=nlist(cmdlst)&0x7f;
	mov	dptr,#_cmdlst
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	lcall	_nlist
	mov	a,dpl
	pop	ar6
	pop	ar5
	pop	ar4
	anl	a,#0x7F
	mov	_do_cmd_cmd_1_150,a
;	.\cmon51.c:485: switch(cmd)
	mov	a,_do_cmd_cmd_1_150
	mov	r7,a
	add	a,#0xff - 0x2E
	jnc	L019321?
	ljmp	L019156?
L019321?:
	mov	a,r7
L019324?:
	add	a,#(L019322?-3-L019324?)
	movc	a,@a+pc
	push	acc
	mov	a,r7
L019325?:
	add	a,#(L019323?-3-L019325?)
	movc	a,@a+pc
	push	acc
	ret
L019322?:
	db	L019005?
	db	L019006?
	db	L019007?
	db	L019008?
	db	L019009?
	db	L019010?
	db	L019011?
	db	L019012?
	db	L019013?
	db	L019014?
	db	L019017?
	db	L019023?
	db	L019024?
	db	L019025?
	db	L019026?
	db	L019027?
	db	L019031?
	db	L019019?
	db	L019035?
	db	L019036?
	db	L019037?
	db	L019038?
	db	L019039?
	db	L019040?
	db	L019041?
	db	L019042?
	db	L019018?
	db	L019022?
	db	L019046?
	db	L019049?
	db	L019050?
	db	L019051?
	db	L019055?
	db	L019056?
	db	L019057?
	db	L019156?
	db	L019058?
	db	L019088?
	db	L019156?
	db	L019095?
	db	L019096?
	db	L019140?
	db	L019156?
	db	L019147?
	db	L019015?
	db	L019016?
	db	L019004?
L019323?:
	db	L019005?>>8
	db	L019006?>>8
	db	L019007?>>8
	db	L019008?>>8
	db	L019009?>>8
	db	L019010?>>8
	db	L019011?>>8
	db	L019012?>>8
	db	L019013?>>8
	db	L019014?>>8
	db	L019017?>>8
	db	L019023?>>8
	db	L019024?>>8
	db	L019025?>>8
	db	L019026?>>8
	db	L019027?>>8
	db	L019031?>>8
	db	L019019?>>8
	db	L019035?>>8
	db	L019036?>>8
	db	L019037?>>8
	db	L019038?>>8
	db	L019039?>>8
	db	L019040?>>8
	db	L019041?>>8
	db	L019042?>>8
	db	L019018?>>8
	db	L019022?>>8
	db	L019046?>>8
	db	L019049?>>8
	db	L019050?>>8
	db	L019051?>>8
	db	L019055?>>8
	db	L019056?>>8
	db	L019057?>>8
	db	L019156?>>8
	db	L019058?>>8
	db	L019088?>>8
	db	L019156?>>8
	db	L019095?>>8
	db	L019096?>>8
	db	L019140?>>8
	db	L019156?>>8
	db	L019147?>>8
	db	L019015?>>8
	db	L019016?>>8
	db	L019004?>>8
;	.\cmon51.c:487: case ID_nothing:
L019004?:
;	.\cmon51.c:488: break;
	ljmp	L019220?
;	.\cmon51.c:490: case ID_display_data:
L019005?:
;	.\cmon51.c:491: dispmem(iram_save, 0, 'D');
	clr	a
	mov	_dispmem_PARM_2,a
	mov	(_dispmem_PARM_2 + 1),a
	mov	_dispmem_PARM_3,#0x44
	mov	dptr,#_iram_save
	mov	b,#0x00
	lcall	_dispmem
;	.\cmon51.c:492: break;
	ljmp	L019220?
;	.\cmon51.c:494: case ID_modify_data:
L019006?:
;	.\cmon51.c:495: modifymem(&iram_save[n&0x7f], 'D');
	mov	a,#0x7F
	anl	a,_do_cmd_n_1_150
	mov	r2,#0x00
	add	a,#_iram_save
	mov	r7,a
	mov	a,r2
	addc	a,#(_iram_save >> 8)
	mov	r2,a
	mov	r3,#0x00
	mov	_modifymem_PARM_2,#0x44
	mov	dpl,r7
	mov	dph,r2
	mov	b,r3
	lcall	_modifymem
;	.\cmon51.c:496: break;
	ljmp	L019220?
;	.\cmon51.c:498: case ID_fill_data:
L019007?:
;	.\cmon51.c:499: fillmem(&iram_save[n&0x7f], (p>0x80)?0x80:p, (unsigned char) q);
	mov	a,#0x7F
	anl	a,_do_cmd_n_1_150
	mov	r3,#0x00
	add	a,#_iram_save
	mov	r2,a
	mov	a,r3
	addc	a,#(_iram_save >> 8)
	mov	r3,a
	mov	r7,#0x00
	clr	c
	mov	a,#0x80
	subb	a,r4
	clr	a
	subb	a,r5
	jnc	L019232?
	mov	_do_cmd_sloc0_1_0,#0x80
	clr	a
	mov	(_do_cmd_sloc0_1_0 + 1),a
	sjmp	L019233?
L019232?:
	mov	_do_cmd_sloc0_1_0,r4
	mov	(_do_cmd_sloc0_1_0 + 1),r5
L019233?:
	mov	_fillmem_PARM_3,_do_cmd_q_1_150
	mov	_fillmem_PARM_2,_do_cmd_sloc0_1_0
	mov	(_fillmem_PARM_2 + 1),(_do_cmd_sloc0_1_0 + 1)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_fillmem
;	.\cmon51.c:500: break;
	ljmp	L019220?
;	.\cmon51.c:502: case ID_display_idata:
L019008?:
;	.\cmon51.c:503: dispmem((unsigned char data *)(0x80), 0, 'I');
	clr	a
	mov	_dispmem_PARM_2,a
	mov	(_dispmem_PARM_2 + 1),a
	mov	_dispmem_PARM_3,#0x49
	mov	dptr,#0x4080
	mov	b,#0x00
	lcall	_dispmem
;	.\cmon51.c:504: break;
	ljmp	L019220?
;	.\cmon51.c:506: case ID_modify_idata:
L019009?:
;	.\cmon51.c:507: modifymem((unsigned char data *)((n&0x7f)|0x80), 'I');
	mov	a,#0x7F
	anl	a,_do_cmd_n_1_150
	mov	r2,a
	orl	ar2,#0x80
	mov	r3,#0x00
	mov	r7,#0x40
	mov	_modifymem_PARM_2,#0x49
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_modifymem
;	.\cmon51.c:508: break;
	ljmp	L019220?
;	.\cmon51.c:510: case ID_fill_idata:
L019010?:
;	.\cmon51.c:511: fillmem((unsigned char data *)((n&0x7f)|0x80), p>0x80?0x80:p, (unsigned char) q);
	mov	a,#0x7F
	anl	a,_do_cmd_n_1_150
	mov	r2,a
	orl	ar2,#0x80
	mov	r3,#0x00
	mov	r7,#0x40
	clr	c
	mov	a,#0x80
	subb	a,r4
	clr	a
	subb	a,r5
	jnc	L019234?
	mov	_do_cmd_sloc0_1_0,#0x80
	clr	a
	mov	(_do_cmd_sloc0_1_0 + 1),a
	sjmp	L019235?
L019234?:
	mov	_do_cmd_sloc0_1_0,r4
	mov	(_do_cmd_sloc0_1_0 + 1),r5
L019235?:
	mov	_fillmem_PARM_3,_do_cmd_q_1_150
	mov	_fillmem_PARM_2,_do_cmd_sloc0_1_0
	mov	(_fillmem_PARM_2 + 1),(_do_cmd_sloc0_1_0 + 1)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_fillmem
;	.\cmon51.c:512: break;
	ljmp	L019220?
;	.\cmon51.c:514: case ID_display_xdata:
L019011?:
;	.\cmon51.c:515: dispmem((unsigned char xdata *)i, j, 'X');
	mov	r2,_do_cmd_i_1_150
	mov	r3,(_do_cmd_i_1_150 + 1)
	mov	r7,#0x00
	mov	_dispmem_PARM_2,_do_cmd_j_1_150
	mov	(_dispmem_PARM_2 + 1),(_do_cmd_j_1_150 + 1)
	mov	_dispmem_PARM_3,#0x58
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_dispmem
;	.\cmon51.c:516: break;
	ljmp	L019220?
;	.\cmon51.c:518: case ID_modify_xdata:
L019012?:
;	.\cmon51.c:519: modifymem((unsigned char xdata *)n, 'X');
	mov	r2,_do_cmd_n_1_150
	mov	r3,(_do_cmd_n_1_150 + 1)
	mov	r7,#0x00
	mov	_modifymem_PARM_2,#0x58
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_modifymem
;	.\cmon51.c:520: break;
	ljmp	L019220?
;	.\cmon51.c:522: case ID_fill_xdata:
L019013?:
;	.\cmon51.c:523: fillmem((unsigned char xdata *)n, p, (unsigned char)q);
	mov	r2,_do_cmd_n_1_150
	mov	r3,(_do_cmd_n_1_150 + 1)
	mov	r7,#0x00
	mov	_fillmem_PARM_3,_do_cmd_q_1_150
	mov	_fillmem_PARM_2,r4
	mov	(_fillmem_PARM_2 + 1),r5
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_fillmem
;	.\cmon51.c:524: break;
	ljmp	L019220?
;	.\cmon51.c:526: case ID_display_code:
L019014?:
;	.\cmon51.c:527: dispmem((unsigned char code *)i, j, 'C');
	mov	r2,_do_cmd_i_1_150
	mov	r3,(_do_cmd_i_1_150 + 1)
	mov	r7,#0x80
	mov	_dispmem_PARM_2,_do_cmd_j_1_150
	mov	(_dispmem_PARM_2 + 1),(_do_cmd_j_1_150 + 1)
	mov	_dispmem_PARM_3,#0x43
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_dispmem
;	.\cmon51.c:528: break;
	ljmp	L019220?
;	.\cmon51.c:530: case ID_modify_code:
L019015?:
;	.\cmon51.c:531: XRAMUSEDAS=0x01; // 32k RAM accessed as xdata
	mov	_XRAMUSEDAS,#0x01
;	.\cmon51.c:532: modifymem((unsigned char xdata *)n, 'C');
	mov	r2,_do_cmd_n_1_150
	mov	r3,(_do_cmd_n_1_150 + 1)
	mov	r7,#0x00
	mov	_modifymem_PARM_2,#0x43
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_modifymem
;	.\cmon51.c:533: XRAMUSEDAS=0x00; // 32k RAM accessed as code
	mov	_XRAMUSEDAS,#0x00
;	.\cmon51.c:534: break;
	ljmp	L019220?
;	.\cmon51.c:536: case ID_fill_code:
L019016?:
;	.\cmon51.c:537: XRAMUSEDAS=0x01; // 32k RAM accessed as xdata
	mov	_XRAMUSEDAS,#0x01
;	.\cmon51.c:538: fillmem((unsigned char xdata *)n, p, (unsigned char)q);
	mov	r2,_do_cmd_n_1_150
	mov	r3,(_do_cmd_n_1_150 + 1)
	mov	r7,#0x00
	mov	_fillmem_PARM_3,_do_cmd_q_1_150
	mov	_fillmem_PARM_2,r4
	mov	(_fillmem_PARM_2 + 1),r5
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_fillmem
;	.\cmon51.c:539: XRAMUSEDAS=0x00; // 32k RAM accessed as code
	mov	_XRAMUSEDAS,#0x00
;	.\cmon51.c:540: break;
	ljmp	L019220?
;	.\cmon51.c:542: case ID_unassemble:
L019017?:
;	.\cmon51.c:543: discnt=p;
	mov	_discnt,r4
	mov	(_discnt + 1),r5
;	.\cmon51.c:544: append_txbuff=1;
	setb	_append_txbuff
;	.\cmon51.c:545: unassemble(n);
	mov	dpl,_do_cmd_n_1_150
	mov	dph,(_do_cmd_n_1_150 + 1)
	lcall	_unassemble
;	.\cmon51.c:546: append_txbuff=0;
	clr	_append_txbuff
;	.\cmon51.c:547: add_nlcursor_txbuff();
	lcall	_add_nlcursor_txbuff
;	.\cmon51.c:548: flush_txbuff();
	lcall	_flush_txbuff
;	.\cmon51.c:549: break;
	ljmp	L019220?
;	.\cmon51.c:551: case ID_trace_reg:
L019018?:
;	.\cmon51.c:552: trace_type++;
	mov	dptr,#_trace_type
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
;	.\cmon51.c:554: case ID_trace:
L019019?:
;	.\cmon51.c:555: trace_type++;
	mov	dptr,#_trace_type
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
;	.\cmon51.c:556: if(n==0) break;
	mov	a,_do_cmd_n_1_150
	orl	a,(_do_cmd_n_1_150 + 1)
	jnz	L019328?
	ljmp	L019220?
L019328?:
;	.\cmon51.c:557: break_address=n;
	mov	dptr,#_break_address
	mov	a,_do_cmd_n_1_150
	movx	@dptr,a
	inc	dptr
	mov	a,(_do_cmd_n_1_150 + 1)
	movx	@dptr,a
;	.\cmon51.c:558: n=0;
	clr	a
	mov	_do_cmd_n_1_150,a
	mov	(_do_cmd_n_1_150 + 1),a
;	.\cmon51.c:560: case ID_go_breaks:
L019022?:
;	.\cmon51.c:561: trace_type++;
	mov	dptr,#_trace_type
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
;	.\cmon51.c:562: step_start=(n==0)?PC_save:n; //Next instruction to be executed
	mov	a,_do_cmd_n_1_150
	orl	a,(_do_cmd_n_1_150 + 1)
	cjne	a,#0x01,L019329?
L019329?:
	clr	a
	rlc	a
	mov	r2,a
	jz	L019236?
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	sjmp	L019237?
L019236?:
	mov	r2,_do_cmd_n_1_150
	mov	r3,(_do_cmd_n_1_150 + 1)
L019237?:
	mov	dptr,#_step_start
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	.\cmon51.c:563: gotbreak=0; //If changes to 1, the single step function worked!
	mov	dptr,#_gotbreak
;	.\cmon51.c:564: gostep=0;
	clr	a
	movx	@dptr,a
	mov	dptr,#_gostep
	movx	@dptr,a
;	.\cmon51.c:565: dostep();
	lcall	_dostep
;	.\cmon51.c:567: case ID_go:
L019023?:
;	.\cmon51.c:568: go_pending=0x55;
	mov	dptr,#_go_pending
	mov	a,#0x55
	movx	@dptr,a
;	.\cmon51.c:569: case ID_step:
L019024?:
;	.\cmon51.c:570: step_start=(n==0)?PC_save:n; //Next instruction to be executed
	mov	a,_do_cmd_n_1_150
	orl	a,(_do_cmd_n_1_150 + 1)
	cjne	a,#0x01,L019331?
L019331?:
	clr	a
	rlc	a
	mov	r2,a
	jz	L019238?
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	sjmp	L019239?
L019238?:
	mov	r2,_do_cmd_n_1_150
	mov	r3,(_do_cmd_n_1_150 + 1)
L019239?:
	mov	dptr,#_step_start
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	.\cmon51.c:571: gotbreak=0; //If changes to 1, the single step function worked!
	mov	dptr,#_gotbreak
;	.\cmon51.c:572: gostep=0;
	clr	a
	movx	@dptr,a
	mov	dptr,#_gostep
	movx	@dptr,a
;	.\cmon51.c:573: dostep();
	lcall	_dostep
;	.\cmon51.c:574: break;
	ljmp	L019220?
;	.\cmon51.c:576: case ID_registers:
L019025?:
;	.\cmon51.c:577: disp_regs();
	lcall	_disp_regs
;	.\cmon51.c:578: break;
	ljmp	L019220?
;	.\cmon51.c:580: case ID_load:
L019026?:
;	.\cmon51.c:582: break;
	ljmp	L019220?
;	.\cmon51.c:584: case ID_reg_dptr:
L019027?:
;	.\cmon51.c:585: if(buff_haseq)
	jnb	_buff_haseq,L019029?
;	.\cmon51.c:587: DPL_save=c;
	mov	dptr,#_DPL_save
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
;	.\cmon51.c:588: DPH_save=highof(n);
	mov	r2,(_do_cmd_n_1_150 + 1)
	mov	r3,#0x00
	mov	dptr,#_DPH_save
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	.\cmon51.c:589: outcursor();
	lcall	_outcursor
	ljmp	L019220?
L019029?:
;	.\cmon51.c:591: else outwordnl((DPH_save*0x100)+DPL_save);
	mov	dptr,#_DPH_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	(_do_cmd_sloc0_1_0 + 1),r2
	mov	_do_cmd_sloc0_1_0,#0x00
	mov	dptr,#_DPL_save
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	mov	a,r7
	add	a,_do_cmd_sloc0_1_0
	mov	dpl,a
	mov	a,r2
	addc	a,(_do_cmd_sloc0_1_0 + 1)
	mov	dph,a
	lcall	_outwordnl
;	.\cmon51.c:592: break;
	ljmp	L019220?
;	.\cmon51.c:594: case ID_reg_pc:
L019031?:
;	.\cmon51.c:595: if(buff_haseq)
	jnb	_buff_haseq,L019033?
;	.\cmon51.c:597: PC_save=n;
	mov	dptr,#_PC_save
	mov	a,_do_cmd_n_1_150
	movx	@dptr,a
	inc	dptr
	mov	a,(_do_cmd_n_1_150 + 1)
	movx	@dptr,a
;	.\cmon51.c:598: outcursor();
	lcall	_outcursor
	ljmp	L019220?
L019033?:
;	.\cmon51.c:600: else outwordnl(PC_save);
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	lcall	_outwordnl
;	.\cmon51.c:601: break;
	ljmp	L019220?
;	.\cmon51.c:603: case ID_reg_r0:
L019035?:
;	.\cmon51.c:604: case ID_reg_r1:
L019036?:
;	.\cmon51.c:605: case ID_reg_r2:
L019037?:
;	.\cmon51.c:606: case ID_reg_r3:
L019038?:
;	.\cmon51.c:607: case ID_reg_r4:
L019039?:
;	.\cmon51.c:608: case ID_reg_r5:
L019040?:
;	.\cmon51.c:609: case ID_reg_r6:
L019041?:
;	.\cmon51.c:610: case ID_reg_r7:
L019042?:
;	.\cmon51.c:611: d=(PSW_save&0x18)+buff[1]-'0';
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r2,a
	anl	ar2,#0x18
	mov	a,(_buff + 0x0001)
	add	a,r2
	add	a,#0xd0
	mov	r2,a
;	.\cmon51.c:612: if(buff_haseq)
	jnb	_buff_haseq,L019044?
;	.\cmon51.c:614: iram_save[d]=c;
	mov	a,r2
	add	a,#_iram_save
	mov	dpl,a
	clr	a
	addc	a,#(_iram_save >> 8)
	mov	dph,a
	mov	a,r6
	movx	@dptr,a
;	.\cmon51.c:615: outcursor();
	lcall	_outcursor
	ljmp	L019220?
L019044?:
;	.\cmon51.c:619: outbytenl(iram_save[d]);
	mov	a,r2
	add	a,#_iram_save
	mov	dpl,a
	clr	a
	addc	a,#(_iram_save >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	dpl,a
	lcall	_outbytenl
;	.\cmon51.c:621: break;
	ljmp	L019220?
;	.\cmon51.c:623: case ID_brl:
L019046?:
;	.\cmon51.c:625: get_txbuff();
	lcall	_get_txbuff
;	.\cmon51.c:626: BPC=0x40;
	mov	_BPC,#0x40
;	.\cmon51.c:627: for(n=0; n<0x8000; n++)
	clr	a
	mov	_do_cmd_n_1_150,a
	mov	(_do_cmd_n_1_150 + 1),a
L019222?:
	mov	a,#0x100 - 0x80
	add	a,(_do_cmd_n_1_150 + 1)
	jnc	L019336?
	ljmp	L019225?
L019336?:
;	.\cmon51.c:629: BPAH=n/0x100;
	mov	r3,(_do_cmd_n_1_150 + 1)
	mov	_BPAH,r3
;	.\cmon51.c:630: BPAL=n%0x100;
	mov	r3,_do_cmd_n_1_150
	mov	r7,#0x00
	mov	_BPAL,r3
;	.\cmon51.c:633: _endasm; //We need to clock-in the value before reading it
	
	     nop
	     
;	.\cmon51.c:634: if(BPS&0x01)
	mov	a,_BPS
	jnb	acc.0,L019224?
;	.\cmon51.c:636: add_wordnl_txbuff(n);
	mov	dpl,_do_cmd_n_1_150
	mov	dph,(_do_cmd_n_1_150 + 1)
	lcall	_add_wordnl_txbuff
L019224?:
;	.\cmon51.c:627: for(n=0; n<0x8000; n++)
	inc	_do_cmd_n_1_150
	clr	a
	cjne	a,_do_cmd_n_1_150,L019338?
	inc	(_do_cmd_n_1_150 + 1)
L019338?:
	ljmp	L019222?
L019225?:
;	.\cmon51.c:639: BPC=0x00;
	mov	_BPC,#0x00
;	.\cmon51.c:641: BPAL=0xff;
	mov	_BPAL,#0xFF
;	.\cmon51.c:642: BPAH=0xff;
	mov	_BPAH,#0xFF
;	.\cmon51.c:643: add_cursor_txbuff();
	lcall	_add_cursor_txbuff
;	.\cmon51.c:644: flush_txbuff();
	lcall	_flush_txbuff
;	.\cmon51.c:645: break;
	ljmp	L019220?
;	.\cmon51.c:647: case ID_brc:
L019049?:
;	.\cmon51.c:649: BPC=0x02;
	mov	_BPC,#0x02
;	.\cmon51.c:650: for(n=0; n<0x8000; n++)
	clr	a
	mov	_do_cmd_n_1_150,a
	mov	(_do_cmd_n_1_150 + 1),a
L019226?:
	mov	a,#0x100 - 0x80
	add	a,(_do_cmd_n_1_150 + 1)
	jc	L019229?
;	.\cmon51.c:652: BPAH=n/0x100;
	mov	r3,(_do_cmd_n_1_150 + 1)
	mov	_BPAH,r3
;	.\cmon51.c:653: BPAL=n%0x100;
	mov	r3,_do_cmd_n_1_150
	mov	r7,#0x00
	mov	_BPAL,r3
;	.\cmon51.c:650: for(n=0; n<0x8000; n++)
	inc	_do_cmd_n_1_150
	clr	a
	cjne	a,_do_cmd_n_1_150,L019226?
	inc	(_do_cmd_n_1_150 + 1)
	sjmp	L019226?
L019229?:
;	.\cmon51.c:655: BPAL=0xff;
	mov	_BPAL,#0xFF
;	.\cmon51.c:656: BPC=0x00;
	mov	_BPC,#0x00
;	.\cmon51.c:658: BPAL=0xff;
	mov	_BPAL,#0xFF
;	.\cmon51.c:659: BPAH=0xff;
	mov	_BPAH,#0xFF
;	.\cmon51.c:660: outcursor();
	lcall	_outcursor
;	.\cmon51.c:661: break;
	ljmp	L019220?
;	.\cmon51.c:663: case ID_br2:
L019050?:
;	.\cmon51.c:664: case ID_br3:
L019051?:
;	.\cmon51.c:665: d=buff[2]-'0';
	mov	a,(_buff + 0x0002)
	add	a,#0xd0
	mov	r2,a
;	.\cmon51.c:666: if(buff_haseq) br[d]=n;
	jnb	_buff_haseq,L019053?
	mov	a,r2
	add	a,r2
	mov	r3,a
	add	a,#_br
	mov	dpl,a
	clr	a
	addc	a,#(_br >> 8)
	mov	dph,a
	mov	a,_do_cmd_n_1_150
	movx	@dptr,a
	inc	dptr
	mov	a,(_do_cmd_n_1_150 + 1)
	movx	@dptr,a
	ljmp	L019220?
L019053?:
;	.\cmon51.c:667: else outwordnl(br[d]);
	mov	a,r2
	add	a,r2
	add	a,#_br
	mov	dpl,a
	clr	a
	addc	a,#(_br >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dpl,r3
	mov	dph,r7
	lcall	_outwordnl
;	.\cmon51.c:668: break;
	ljmp	L019220?
;	.\cmon51.c:670: case ID_broff:
L019055?:
;	.\cmon51.c:672: BPAL=n%0x100;
	mov	r3,_do_cmd_n_1_150
	mov	_BPAL,r3
;	.\cmon51.c:673: BPAH=n/0x100;
	mov	r3,(_do_cmd_n_1_150 + 1)
	mov	_BPAH,r3
;	.\cmon51.c:675: BPC=0x00;
	mov	_BPC,#0x00
;	.\cmon51.c:676: BPC=0x02;
	mov	_BPC,#0x02
;	.\cmon51.c:677: BPC=0x00;
	mov	_BPC,#0x00
;	.\cmon51.c:679: BPAL=0xff;
	mov	_BPAL,#0xFF
;	.\cmon51.c:680: BPAH=0xff;
	mov	_BPAH,#0xFF
;	.\cmon51.c:681: outcursor();
	lcall	_outcursor
;	.\cmon51.c:682: break;
	ljmp	L019220?
;	.\cmon51.c:684: case ID_bron:
L019056?:
;	.\cmon51.c:686: BPAL=n%0x100;
	mov	r3,_do_cmd_n_1_150
	mov	_BPAL,r3
;	.\cmon51.c:687: BPAH=n/0x100;
	mov	r3,(_do_cmd_n_1_150 + 1)
	mov	_BPAH,r3
;	.\cmon51.c:689: BPC=0x01;
	mov	_BPC,#0x01
;	.\cmon51.c:690: BPC=0x03;
	mov	_BPC,#0x03
;	.\cmon51.c:691: BPC=0x01;
	mov	_BPC,#0x01
;	.\cmon51.c:693: BPAL=0xff;
	mov	_BPAL,#0xFF
;	.\cmon51.c:694: BPAH=0xff;
	mov	_BPAH,#0xFF
;	.\cmon51.c:695: outcursor();
	lcall	_outcursor
;	.\cmon51.c:696: break;
	ljmp	L019220?
;	.\cmon51.c:698: case ID_pcr:  //Restore the PC
L019057?:
;	.\cmon51.c:699: restorePC();
	lcall	_restorePC
;	.\cmon51.c:700: outcursor();
	lcall	_outcursor
;	.\cmon51.c:701: break;
	ljmp	L019220?
;	.\cmon51.c:703: case ID_LEDRA:
L019058?:
;	.\cmon51.c:704: if(buff_haseq)
	jnb	_buff_haseq,L019086?
;	.\cmon51.c:706: if(buff_hasdot)
	jnb	_buff_hasdot,L019083?
;	.\cmon51.c:708: if     (c==0) LEDRA_0=p_bit;
	mov	a,r6
	jnz	L019080?
	mov	c,_do_cmd_p_bit_1_150
	mov	_LEDRA_0,c
	sjmp	L019084?
L019080?:
;	.\cmon51.c:709: else if(c==1) LEDRA_1=p_bit;
	cjne	r6,#0x01,L019077?
	mov	c,_do_cmd_p_bit_1_150
	mov	_LEDRA_1,c
	sjmp	L019084?
L019077?:
;	.\cmon51.c:710: else if(c==2) LEDRA_2=p_bit;
	cjne	r6,#0x02,L019074?
	mov	c,_do_cmd_p_bit_1_150
	mov	_LEDRA_2,c
	sjmp	L019084?
L019074?:
;	.\cmon51.c:711: else if(c==3) LEDRA_3=p_bit;
	cjne	r6,#0x03,L019071?
	mov	c,_do_cmd_p_bit_1_150
	mov	_LEDRA_3,c
	sjmp	L019084?
L019071?:
;	.\cmon51.c:712: else if(c==4) LEDRA_4=p_bit;
	cjne	r6,#0x04,L019068?
	mov	c,_do_cmd_p_bit_1_150
	mov	_LEDRA_4,c
	sjmp	L019084?
L019068?:
;	.\cmon51.c:713: else if(c==5) LEDRA_5=p_bit;
	cjne	r6,#0x05,L019065?
	mov	c,_do_cmd_p_bit_1_150
	mov	_LEDRA_5,c
	sjmp	L019084?
L019065?:
;	.\cmon51.c:714: else if(c==6) LEDRA_6=p_bit;
	cjne	r6,#0x06,L019062?
	mov	c,_do_cmd_p_bit_1_150
	mov	_LEDRA_6,c
	sjmp	L019084?
L019062?:
;	.\cmon51.c:715: else if(c==7) LEDRA_7=p_bit;
	cjne	r6,#0x07,L019084?
	mov	c,_do_cmd_p_bit_1_150
	mov	_LEDRA_7,c
	sjmp	L019084?
L019083?:
;	.\cmon51.c:719: LEDRA=c;
	mov	_LEDRA,r6
L019084?:
;	.\cmon51.c:721: outcursor();
	lcall	_outcursor
	ljmp	L019220?
L019086?:
;	.\cmon51.c:723: else putsp(cnr);
	mov	dptr,#_cnr
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:724: break;
	ljmp	L019220?
;	.\cmon51.c:726: case ID_LEDRB:
L019088?:
;	.\cmon51.c:727: if(buff_haseq)
	jnb	_buff_haseq,L019093?
;	.\cmon51.c:729: if(buff_hasdot)
	jnb	_buff_hasdot,L019090?
;	.\cmon51.c:731: putsp(nba);
	mov	dptr,#_nba
	mov	b,#0x80
	lcall	_putsp
	ljmp	L019220?
L019090?:
;	.\cmon51.c:735: LEDRB=c;
	mov	_LEDRB,r6
;	.\cmon51.c:736: outcursor();
	lcall	_outcursor
	ljmp	L019220?
L019093?:
;	.\cmon51.c:739: else putsp(cnr);
	mov	dptr,#_cnr
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:740: break;
	ljmp	L019220?
;	.\cmon51.c:742: case ID_KEY:
L019095?:
;	.\cmon51.c:743: case ID_SWA:
L019096?:
;	.\cmon51.c:744: if(buff_haseq==0)
	jnb	_buff_haseq,L019361?
	ljmp	L019138?
L019361?:
;	.\cmon51.c:746: if(buff_hasdot)
	jb	_buff_hasdot,L019362?
	ljmp	L019135?
L019362?:
;	.\cmon51.c:748: if(cmd==ID_SWA)
	mov	a,#0x28
	cjne	a,_do_cmd_cmd_1_150,L019132?
;	.\cmon51.c:750: if     (c==0) p_bit=SWA_0;
	mov	a,r6
	jnz	L019118?
	mov	c,_SWA_0
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019118?:
;	.\cmon51.c:751: else if(c==1) p_bit=SWA_1;
	cjne	r6,#0x01,L019115?
	mov	c,_SWA_1
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019115?:
;	.\cmon51.c:752: else if(c==2) p_bit=SWA_2;
	cjne	r6,#0x02,L019112?
	mov	c,_SWA_2
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019112?:
;	.\cmon51.c:753: else if(c==3) p_bit=SWA_3;
	cjne	r6,#0x03,L019109?
	mov	c,_SWA_3
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019109?:
;	.\cmon51.c:754: else if(c==4) p_bit=SWA_4;
	cjne	r6,#0x04,L019106?
	mov	c,_SWA_4
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019106?:
;	.\cmon51.c:755: else if(c==5) p_bit=SWA_5;
	cjne	r6,#0x05,L019103?
	mov	c,_SWA_5
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019103?:
;	.\cmon51.c:756: else if(c==6) p_bit=SWA_6;
	cjne	r6,#0x06,L019100?
	mov	c,_SWA_6
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019100?:
;	.\cmon51.c:757: else if(c==7) p_bit=SWA_7;
	cjne	r6,#0x07,L019133?
	mov	c,_SWA_7
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019132?:
;	.\cmon51.c:761: if     (c==0) p_bit=KEY_0;
	mov	a,r6
	jnz	L019129?
	mov	c,_KEY_0
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019129?:
;	.\cmon51.c:762: else if(c==1) p_bit=KEY_1;
	cjne	r6,#0x01,L019126?
	mov	c,_KEY_1
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019126?:
;	.\cmon51.c:763: else if(c==2) p_bit=KEY_2;
	cjne	r6,#0x02,L019123?
	mov	c,_KEY_2
	mov	_do_cmd_p_bit_1_150,c
	sjmp	L019133?
L019123?:
;	.\cmon51.c:764: else if(c==3) p_bit=KEY_3;
	cjne	r6,#0x03,L019133?
	mov	c,_KEY_3
	mov	_do_cmd_p_bit_1_150,c
L019133?:
;	.\cmon51.c:766: putcnl(p_bit?'1':'0');
	jnb	_do_cmd_p_bit_1_150,L019240?
	mov	r3,#0x31
	sjmp	L019241?
L019240?:
	mov	r3,#0x30
L019241?:
	mov	dpl,r3
	lcall	_putcnl
	ljmp	L019220?
L019135?:
;	.\cmon51.c:770: outbytenl(cmd==ID_SWA?SWA:KEY);
	mov	a,#0x28
	cjne	a,_do_cmd_cmd_1_150,L019242?
	mov	r3,_SWA
	sjmp	L019243?
L019242?:
	mov	r3,_KEY
L019243?:
	mov	dpl,r3
	lcall	_outbytenl
	ljmp	L019220?
L019138?:
;	.\cmon51.c:773: else putsp(cnw);
	mov	dptr,#_cnw
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:774: break;
	ljmp	L019220?
;	.\cmon51.c:776: case ID_SWB:
L019140?:
;	.\cmon51.c:777: if(buff_haseq==0)
	jb	_buff_haseq,L019145?
;	.\cmon51.c:779: if(buff_hasdot)
	jnb	_buff_hasdot,L019142?
;	.\cmon51.c:781: putsp(nba);
	mov	dptr,#_nba
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:782: break;
	ljmp	L019220?
L019142?:
;	.\cmon51.c:786: outbytenl(SWB);
	mov	dpl,_SWB
	lcall	_outbytenl
	ljmp	L019220?
L019145?:
;	.\cmon51.c:789: else putsp(cnw);
	mov	dptr,#_cnw
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:790: break;
	ljmp	L019220?
;	.\cmon51.c:792: case ID_BANK:
L019147?:
;	.\cmon51.c:793: if(buff_haseq)
	jnb	_buff_haseq,L019154?
;	.\cmon51.c:795: PSW_save&=0b_1110_0111;
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r3,a
	anl	a,#0xE7
	movx	@dptr,a
;	.\cmon51.c:796: switch(c&3)
	mov	a,#0x03
	anl	a,r6
	mov  r3,a
	add	a,#0xff - 0x03
	jc	L019152?
	mov	a,r3
	add	a,r3
	add	a,r3
	mov	dptr,#L019394?
	jmp	@a+dptr
L019394?:
	ljmp	L019148?
	ljmp	L019149?
	ljmp	L019150?
	ljmp	L019151?
;	.\cmon51.c:798: case 0:
L019148?:
;	.\cmon51.c:799: break;
;	.\cmon51.c:800: case 1:
	sjmp	L019152?
L019149?:
;	.\cmon51.c:801: PSW_save|=0b_0000_1000;
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r3,a
	orl	a,#0x08
	movx	@dptr,a
;	.\cmon51.c:802: break;
;	.\cmon51.c:803: case 2:
	sjmp	L019152?
L019150?:
;	.\cmon51.c:804: PSW_save|=0b_0001_0000;
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r3,a
	orl	a,#0x10
	movx	@dptr,a
;	.\cmon51.c:805: break;
;	.\cmon51.c:806: case 3:
	sjmp	L019152?
L019151?:
;	.\cmon51.c:807: PSW_save|=0b_0001_1000;
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r3,a
	orl	a,#0x18
	movx	@dptr,a
;	.\cmon51.c:809: }
L019152?:
;	.\cmon51.c:810: outcursor();
	lcall	_outcursor
	ljmp	L019220?
L019154?:
;	.\cmon51.c:814: outbytenl((PSW_save/0x8)&0x3);
	mov	dptr,#_PSW_save
	movx	a,@dptr
	swap	a
	rl	a
	anl	a,#0x1f
	mov	r3,a
	mov	a,#0x03
	anl	a,r3
	mov	dpl,a
	lcall	_outbytenl
;	.\cmon51.c:816: break;
	ljmp	L019220?
;	.\cmon51.c:818: default:
L019156?:
;	.\cmon51.c:820: y=nlist(bitn); //Search for bit names first
	mov	dptr,#_bitn
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	lcall	_nlist
	mov	_do_cmd_y_1_150,dpl
	pop	ar6
	pop	ar5
	pop	ar4
;	.\cmon51.c:821: if (y!=0xff)
	mov	a,#0xFF
	cjne	a,_do_cmd_y_1_150,L019395?
	sjmp	L019160?
L019395?:
;	.\cmon51.c:823: x=y&0xf8;
	mov	a,#0xF8
	anl	a,_do_cmd_y_1_150
	mov	r7,a
;	.\cmon51.c:824: y=maskbit[y&0x7];
	mov	a,#0x07
	anl	a,_do_cmd_y_1_150
	mov	dptr,#_maskbit
	movc	a,@a+dptr
	mov	_do_cmd_y_1_150,a
	sjmp	L019161?
L019160?:
;	.\cmon51.c:828: x=nlist(sfrn); //Is not a bit, try a sfr
	mov	dptr,#_sfrn
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	lcall	_nlist
	mov	r7,dpl
	pop	ar6
	pop	ar5
	pop	ar4
;	.\cmon51.c:829: if(buff_hasdot)
	jnb	_buff_hasdot,L019161?
;	.\cmon51.c:831: y=maskbit[c&0x7];
	mov	a,#0x07
	anl	a,r6
	mov	dptr,#_maskbit
	movc	a,@a+dptr
	mov	_do_cmd_y_1_150,a
;	.\cmon51.c:832: c=p;
	mov	ar6,r4
L019161?:
;	.\cmon51.c:836: if(x!=0xff)
	cjne	r7,#0xFF,L019397?
	ljmp	L019216?
L019397?:
;	.\cmon51.c:839: /**/ if (x==0xd0) d=PSW_save;
	clr	a
	cjne	r7,#0xD0,L019398?
	inc	a
L019398?:
	mov	r4,a
	jz	L019181?
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r2,a
	sjmp	L019182?
L019181?:
;	.\cmon51.c:840: else if (x==0xe0) d=A_save;
	cjne	r7,#0xE0,L019178?
	mov	dptr,#_A_save
	movx	a,@dptr
	mov	r2,a
	sjmp	L019182?
L019178?:
;	.\cmon51.c:841: else if (x==0xf0) d=B_save;
	cjne	r7,#0xF0,L019175?
	mov	dptr,#_B_save
	movx	a,@dptr
	mov	r2,a
	sjmp	L019182?
L019175?:
;	.\cmon51.c:842: else if (x==0xa8) d=IE_save;
	cjne	r7,#0xA8,L019172?
	mov	dptr,#_IE_save
	movx	a,@dptr
	mov	r2,a
	sjmp	L019182?
L019172?:
;	.\cmon51.c:843: else if (x==0x81) d=SP_save;
	cjne	r7,#0x81,L019169?
	mov	dptr,#_SP_save
	movx	a,@dptr
	mov	r2,a
	sjmp	L019182?
L019169?:
;	.\cmon51.c:844: else if (x==0x82) d=DPL_save;
	cjne	r7,#0x82,L019166?
	mov	dptr,#_DPL_save
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	ar2,r5
	sjmp	L019182?
L019166?:
;	.\cmon51.c:845: else if (x==0x83) d=DPH_save;
	cjne	r7,#0x83,L019163?
	mov	dptr,#_DPH_save
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	ar2,r3
	sjmp	L019182?
L019163?:
;	.\cmon51.c:846: else d=read_sfr(x);
	mov	dpl,r7
	push	ar4
	push	ar6
	push	ar7
	lcall	_read_sfr
	mov	r2,dpl
	pop	ar7
	pop	ar6
	pop	ar4
L019182?:
;	.\cmon51.c:849: if(y!=0xff)
	mov	a,#0xFF
	cjne	a,_do_cmd_y_1_150,L019413?
	mov	a,#0x01
	sjmp	L019414?
L019413?:
	clr	a
L019414?:
	mov	r3,a
	jnz	L019187?
;	.\cmon51.c:851: if(c) c=d|y;
	mov	a,r6
	jz	L019184?
	mov	a,_do_cmd_y_1_150
	orl	a,r2
	mov	r6,a
	sjmp	L019187?
L019184?:
;	.\cmon51.c:852: else c=d&(~y);
	mov	a,_do_cmd_y_1_150
	cpl	a
	mov	r5,a
	anl	a,r2
	mov	r6,a
L019187?:
;	.\cmon51.c:856: if(buff_haseq)
	jnb	_buff_haseq,L019213?
;	.\cmon51.c:858: /**/ if (x==0xd0) PSW_save=c;
	mov	a,r4
	jz	L019207?
	mov	dptr,#_PSW_save
	mov	a,r6
	movx	@dptr,a
	sjmp	L019208?
L019207?:
;	.\cmon51.c:859: else if (x==0xe0) A_save=c;
	cjne	r7,#0xE0,L019204?
	mov	dptr,#_A_save
	mov	a,r6
	movx	@dptr,a
	sjmp	L019208?
L019204?:
;	.\cmon51.c:860: else if (x==0xf0) B_save=c;
	cjne	r7,#0xF0,L019201?
	mov	dptr,#_B_save
	mov	a,r6
	movx	@dptr,a
	sjmp	L019208?
L019201?:
;	.\cmon51.c:861: else if (x==0xa8) IE_save=c;
	cjne	r7,#0xA8,L019198?
	mov	dptr,#_IE_save
	mov	a,r6
	movx	@dptr,a
	sjmp	L019208?
L019198?:
;	.\cmon51.c:862: else if (x==0x81) SP_save=c;
	cjne	r7,#0x81,L019195?
	mov	dptr,#_SP_save
	mov	a,r6
	movx	@dptr,a
	sjmp	L019208?
L019195?:
;	.\cmon51.c:863: else if (x==0x82) DPL_save=c;
	cjne	r7,#0x82,L019192?
	mov	dptr,#_DPL_save
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	sjmp	L019208?
L019192?:
;	.\cmon51.c:864: else if (x==0x83) DPH_save=c;
	cjne	r7,#0x83,L019189?
	mov	dptr,#_DPH_save
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	sjmp	L019208?
L019189?:
;	.\cmon51.c:865: else write_sfr(x, c);
	mov	_write_sfr_PARM_2,r6
	mov	dpl,r7
	lcall	_write_sfr
L019208?:
;	.\cmon51.c:866: outcursor();
	lcall	_outcursor
	ljmp	L019220?
L019213?:
;	.\cmon51.c:870: if(y==0xff)
	mov	a,r3
	jz	L019210?
;	.\cmon51.c:871: outbytenl(d);
	mov	dpl,r2
	lcall	_outbytenl
	ljmp	L019220?
L019210?:
;	.\cmon51.c:874: putcnl((d&y)?'1':'0');
	mov	a,_do_cmd_y_1_150
	anl	a,r2
	jz	L019244?
	mov	r2,#0x31
	sjmp	L019245?
L019244?:
	mov	r2,#0x30
L019245?:
	mov	dpl,r2
	lcall	_putcnl
	ljmp	L019220?
L019216?:
;	.\cmon51.c:878: else putsp("What?\n> ");
	mov	dptr,#__str_4
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:880: }
	ljmp	L019220?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_cmdlst:
	db 0x80
	db 'D'
	db 0x81
	db 'MD'
	db 0x82
	db 'FD'
	db 0x83
	db 'I'
	db 0x84
	db 'MI'
	db 0x85
	db 'FI'
	db 0x86
	db 'X'
	db 0x87
	db 'MX'
	db 0x88
	db 'FX'
	db 0x89
	db 'C'
	db 0x8A
	db 'U'
	db 0x8B
	db 'G'
	db 0x8C
	db 'S'
	db 0x8D
	db 'R'
	db 0x8E
	db 'L'
	db 0x8F
	db 'DPTR'
	db 0x90
	db 'PC'
	db 0x91
	db 'T'
	db 0x92
	db 'R0'
	db 0x93
	db 'R1'
	db 0x94
	db 'R2'
	db 0x95
	db 'R3'
	db 0x96
	db 'R'
	db '4'
	db 0x97
	db 'R5'
	db 0x98
	db 'R6'
	db 0x99
	db 'R7'
	db 0x9A
	db 'TR'
	db 0x9B
	db 'GB'
	db 0x9C
	db 'BRL'
	db 0x9D
	db 'BRC'
	db 0x9E
	db 'BR2'
	db 0x9F
	db 'BR3'
	db 0xA0
	db 'BROFF'
	db 0xA1
	db 'BRON'
	db 0xA2
	db 'PCR'
	db 0xA3
	db 'LEDG'
	db 0xA4
	db 'LEDRA'
	db 0xA5
	db 'L'
	db 'EDRB'
	db 0xA6
	db 'LEDRC'
	db 0xA7
	db 'KEY'
	db 0xA8
	db 'SWA'
	db 0xA9
	db 'SWB'
	db 0xAA
	db 'SWC'
	db 0xAB
	db 'BANK'
	db 0xAC
	db 'MC'
	db 0xAD
	db 'FC'
	db 0xAE
	db 0xAF
	db 0x00
	db 0x00
_hexval:
	db '0123456789ABCDEF'
	db 0x00
_maskbit:
	db 0x01	; 1 
	db 0x02	; 2 
	db 0x04	; 4 
	db 0x08	; 8 
	db 0x10	; 16 
	db 0x20	; 32 
	db 0x40	; 64 
	db 0x80	; 128 	€
_nba:
	db 'Not bit-addressable!'
	db 0x0A
	db '> '
	db 0x00
_cnr:
	db 'Can'
	db 0x27
	db 't read!'
	db 0x0A
	db '> '
	db 0x00
_cnw:
	db 'Can'
	db 0x27
	db 't write!'
	db 0x0A
	db '> '
	db 0x00
__str_0:
	db '=  '
	db 0x00
__str_1:
	db ':  '
	db 0x00
__str_2:
	db '   '
	db 0x00
_regframe:
	db 'A =xx  B =xx  SP=xx  IE=xx  DPH=xx DPL=xx PSW=xx PC=xxxx'
	db 0x0D
	db 0x0A
	db 'R0'
	db '=xx  R1=xx  R2=xx  R3=xx  R4=xx  R5=xx  R6=xx  R7=xx  BANK=x'
	db 0x0D
	db 0x0A
	db 0x00
__str_3:
	db 0x0A
	db 0x0A
	db 'CMON51 V2.0'
	db 0x0A
	db 'CopyRight (c) 2005-2015 Jesus Calvino-Fraga'
	db 0x0A
	db 'Po'
	db 'rt: CV_8052 V1.0'
	db 0x0A
	db '> '
	db 0x00
__str_4:
	db 'What?'
	db 0x0A
	db '> '
	db 0x00

	CSEG

end
