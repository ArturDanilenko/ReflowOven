;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (May  5 2015) (MSVC)
; This file was generated Wed Oct 21 09:02:15 2015
;--------------------------------------------------------
$name d51
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
	public _mnemtbl
	public _mnem
	public _addword
	public _addstr
	public _addbyte
	public _discnt
	public _cur
	public _unassemble
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
_cur:
	ds 1
_discnt:
	ds 2
_unassemble_j_1_39:
	ds 2
_unassemble_nb_1_39:
	ds 1
_unassemble_ptr_1_39:
	ds 3
_unassemble_absadd_1_39:
	ds 2
_unassemble_pcounter_1_39:
	ds 2
_unassemble_sloc0_1_0:
	ds 1
_unassemble_sloc1_1_0:
	ds 1
_unassemble_sloc2_1_0:
	ds 1
_unassemble_sloc3_1_0:
	ds 3
_unassemble_sloc4_1_0:
	ds 3
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
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
_unassemble_bitncheck_1_39:
	DBIT	1
_unassemble_opcode0x85_1_39:
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
;Allocation info for local variables in function 'addbyte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	.\d51.c:36: void addbyte (unsigned char x)
;	-----------------------------------------
;	 function addbyte
;	-----------------------------------------
_addbyte:
	using	0
	mov	r2,dpl
;	.\d51.c:38: addchar(hexval[x/0x10]);
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	a,r2
	swap	a
	anl	a,#0x0f
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	@r0,a
;	.\d51.c:39: addchar(hexval[x&0xf]);
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	a,#0x0F
	anl	a,r2
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	@r0,a
;	.\d51.c:40: add_byte_txbuff(x);
	mov	dpl,r2
	lcall	_add_byte_txbuff
;	.\d51.c:41: add_char_txbuff(' ');
	mov	dpl,#0x20
	ljmp	_add_char_txbuff
;------------------------------------------------------------
;Allocation info for local variables in function 'addstr'
;------------------------------------------------------------
;x                         Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	.\d51.c:44: void addstr(unsigned char * x)
;	-----------------------------------------
;	 function addstr
;	-----------------------------------------
_addstr:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	.\d51.c:46: while ((*x!=0)&&(*x<0x80))
L003002?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	jz	L003005?
	cjne	r5,#0x80,L003012?
L003012?:
	jnc	L003005?
;	.\d51.c:48: addchar(*x);
	mov	r6,_cur
	inc	_cur
	mov	a,r6
	add	a,#_buff
	mov	r0,a
	mov	@r0,ar5
;	.\d51.c:49: x++;
	inc	r2
	cjne	r2,#0x00,L003002?
	inc	r3
	sjmp	L003002?
L003005?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'addword'
;------------------------------------------------------------
;x                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	.\d51.c:53: void addword (unsigned int x)
;	-----------------------------------------
;	 function addword
;	-----------------------------------------
_addword:
	mov	r2,dpl
	mov	r3,dph
;	.\d51.c:55: addchar(hexval[(x/0x1000)&0xf]);
	mov	r4,_cur
	inc	_cur
	mov	a,r4
	add	a,#_buff
	mov	r0,a
	mov	a,r3
	swap	a
	anl	a,#0x0f
	mov	r4,a
	anl	ar4,#0x0F
	mov	r5,#0x00
	mov	a,r4
	add	a,#_hexval
	mov	dpl,a
	mov	a,r5
	addc	a,#(_hexval >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	@r0,a
;	.\d51.c:56: addchar(hexval[(x/0x100)&0xf]);
	mov	r4,_cur
	inc	_cur
	mov	a,r4
	add	a,#_buff
	mov	r0,a
	mov	ar4,r3
	anl	ar4,#0x0F
	mov	r5,#0x00
	mov	a,r4
	add	a,#_hexval
	mov	dpl,a
	mov	a,r5
	addc	a,#(_hexval >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	@r0,a
;	.\d51.c:57: addchar(hexval[(x/0x10)&0xf]);
	mov	r4,_cur
	inc	_cur
	mov	a,r4
	add	a,#_buff
	mov	r0,a
	mov	ar4,r2
	mov	a,r3
	swap	a
	xch	a,r4
	swap	a
	anl	a,#0x0f
	xrl	a,r4
	xch	a,r4
	anl	a,#0x0f
	xch	a,r4
	xrl	a,r4
	xch	a,r4
	anl	ar4,#0x0F
	mov	r5,#0x00
	mov	a,r4
	add	a,#_hexval
	mov	dpl,a
	mov	a,r5
	addc	a,#(_hexval >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	@r0,a
;	.\d51.c:58: addchar(hexval[x&0xf]);
	mov	r4,_cur
	inc	_cur
	mov	a,r4
	add	a,#_buff
	mov	r0,a
	anl	ar2,#0x0F
	mov	r3,#0x00
	mov	a,r2
	add	a,#_hexval
	mov	dpl,a
	mov	a,r3
	addc	a,#(_hexval >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	@r0,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'unassemble'
;------------------------------------------------------------
;address                   Allocated to registers r2 r3 
;j                         Allocated with name '_unassemble_j_1_39'
;n                         Allocated to registers r2 
;nb                        Allocated with name '_unassemble_nb_1_39'
;opcode                    Allocated to registers r4 
;i                         Allocated to registers 
;ptr                       Allocated with name '_unassemble_ptr_1_39'
;absadd                    Allocated with name '_unassemble_absadd_1_39'
;pcounter                  Allocated with name '_unassemble_pcounter_1_39'
;bitnum                    Allocated to registers r6 
;sloc0                     Allocated with name '_unassemble_sloc0_1_0'
;sloc1                     Allocated with name '_unassemble_sloc1_1_0'
;sloc2                     Allocated with name '_unassemble_sloc2_1_0'
;sloc3                     Allocated with name '_unassemble_sloc3_1_0'
;sloc4                     Allocated with name '_unassemble_sloc4_1_0'
;------------------------------------------------------------
;	.\d51.c:63: void unassemble (unsigned int address)
;	-----------------------------------------
;	 function unassemble
;	-----------------------------------------
_unassemble:
	mov	r2,dpl
	mov	r3,dph
;	.\d51.c:73: get_txbuff();
	push	ar2
	push	ar3
	lcall	_get_txbuff
	pop	ar3
	pop	ar2
;	.\d51.c:75: pcounter=(unsigned char code *)address;
	mov	_unassemble_pcounter_1_39,r2
	mov	(_unassemble_pcounter_1_39 + 1),r3
;	.\d51.c:76: if(discnt==0) discnt=1;
	mov	a,_discnt
	orl	a,(_discnt + 1)
	jnz	L005107?
	mov	_discnt,#0x01
	clr	a
	mov	(_discnt + 1),a
;	.\d51.c:78: while(discnt--)
L005107?:
L005052?:
	mov	r4,_discnt
	mov	r5,(_discnt + 1)
	dec	_discnt
	mov	a,#0xff
	cjne	a,_discnt,L005113?
	dec	(_discnt + 1)
L005113?:
	mov	a,r4
	orl	a,r5
	jnz	L005114?
	ljmp	L005054?
L005114?:
;	.\d51.c:80: add_word_txbuff((int) pcounter);
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	lcall	_add_word_txbuff
;	.\d51.c:81: add_str_txbuff(": ");
	mov	dptr,#__str_0
	mov	b,#0x80
	lcall	_add_str_txbuff
;	.\d51.c:82: opcode=*pcounter;
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
;	.\d51.c:83: add_byte_txbuff(opcode);
	mov	r4,a
	mov	dpl,a
	push	ar4
	lcall	_add_byte_txbuff
;	.\d51.c:84: add_char_txbuff(' ');
	mov	dpl,#0x20
	lcall	_add_char_txbuff
	pop	ar4
;	.\d51.c:86: addchar('\t');
	mov	_cur,#0x01
	mov	_buff,#0x09
;	.\d51.c:87: opcode0x85=0;
	clr	_unassemble_opcode0x85_1_39
;	.\d51.c:92: for(j=0, n=0; (mnemtbl[j]!=0)&&(opcode!=n); j++)
	mov	r5,#0x00
	mov	r6,#0x00
	mov	r7,#0x00
L005056?:
	mov	a,r6
	add	a,#_mnemtbl
	mov	dpl,a
	mov	a,r7
	addc	a,#(_mnemtbl >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	jz	L005079?
	mov	a,r4
	cjne	a,ar5,L005116?
	sjmp	L005079?
L005116?:
;	.\d51.c:94: if(mnemtbl[j]=='\n') n++;
	cjne	r2,#0x0A,L005058?
	inc	r5
L005058?:
;	.\d51.c:92: for(j=0, n=0; (mnemtbl[j]!=0)&&(opcode!=n); j++)
	inc	r6
;	.\d51.c:100: while (mnemtbl[j]=='\n') j++; 
	cjne	r6,#0x00,L005056?
	inc	r7
	sjmp	L005056?
L005079?:
	mov	ar2,r6
	mov	ar3,r7
L005005?:
	mov	a,r2
	add	a,#_mnemtbl
	mov	dpl,a
	mov	a,r3
	addc	a,#(_mnemtbl >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r5,a
	cjne	r5,#0x0A,L005106?
	inc	r2
	cjne	r2,#0x00,L005005?
	inc	r3
	sjmp	L005005?
L005106?:
	clr	a
	cjne	r4,#0x85,L005122?
	inc	a
L005122?:
	mov	r5,a
	mov	a,#0x07
	anl	a,r4
	orl	a,#0x30
	mov	_unassemble_sloc2_1_0,a
	mov	a,#0x01
	anl	a,r4
	orl	a,#0x30
	mov	_unassemble_sloc1_1_0,a
	clr	a
	cjne	r4,#0x90,L005124?
	inc	a
L005124?:
	mov	r4,a
	mov	_unassemble_j_1_39,r2
	mov	(_unassemble_j_1_39 + 1),r3
L005064?:
;	.\d51.c:103: for(; mnemtbl[j]!='\n'; j++)
	mov	a,_unassemble_j_1_39
	add	a,#_mnemtbl
	mov	dpl,a
	mov	a,(_unassemble_j_1_39 + 1)
	addc	a,#(_mnemtbl >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	_unassemble_sloc0_1_0,a
	mov	a,#0x0A
	cjne	a,_unassemble_sloc0_1_0,L005126?
	ljmp	L005067?
L005126?:
;	.\d51.c:105: n=mnemtbl[j];
	mov	r2,_unassemble_sloc0_1_0
;	.\d51.c:107: bitncheck=0;
	clr	_unassemble_bitncheck_1_39
;	.\d51.c:109: if((n>=(unsigned char)'A')&&(n<=(unsigned char)'Z')) //Replace with string in table
	cjne	r2,#0x41,L005127?
L005127?:
	jc	L005049?
	mov	a,r2
	add	a,#0xff - 0x5A
	jc	L005049?
;	.\d51.c:110: addstr(mnem[n-'A']);
	mov	a,r2
	add	a,#0xbf
	add	a,acc
	mov	r3,a
	mov	dptr,#_mnem
	movc	a,@a+dptr
	xch	a,r3
	inc	dptr
	movc	a,@a+dptr
	mov	r6,a
	mov	r7,#0x80
	mov	dpl,r3
	mov	dph,r6
	mov	b,r7
	push	ar4
	push	ar5
	lcall	_addstr
	pop	ar5
	pop	ar4
	ljmp	L005066?
L005049?:
;	.\d51.c:111: else switch (n)
	cjne	r2,#0x21,L005130?
	sjmp	L005012?
L005130?:
	cjne	r2,#0x23,L005131?
	sjmp	L005008?
L005131?:
	cjne	r2,#0x25,L005132?
	sjmp	L005011?
L005132?:
	cjne	r2,#0x26,L005133?
	ljmp	L005042?
L005133?:
	cjne	r2,#0x2A,L005134?
	ljmp	L005044?
L005134?:
	cjne	r2,#0x2E,L005135?
	ljmp	L005041?
L005135?:
	cjne	r2,#0x3A,L005136?
	ljmp	L005043?
L005136?:
	cjne	r2,#0x3F,L005137?
	ljmp	L005045?
L005137?:
	ljmp	L005046?
;	.\d51.c:113: case '#': //Numeric constant (in hex)
L005008?:
;	.\d51.c:114: addchar('#');
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x23
;	.\d51.c:115: addbyte(*(++pcounter));
	inc	_unassemble_pcounter_1_39
	clr	a
	cjne	a,_unassemble_pcounter_1_39,L005138?
	inc	(_unassemble_pcounter_1_39 + 1)
L005138?:
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	push	ar4
	push	ar5
	lcall	_addbyte
	pop	ar5
	pop	ar4
;	.\d51.c:116: if(opcode==0x90) //"mov dptr,#1234" uses two bytes (Only exception)
	mov	a,r4
	jnz	L005139?
	ljmp	L005066?
L005139?:
;	.\d51.c:118: addbyte(*(++pcounter));
	inc	_unassemble_pcounter_1_39
	clr	a
	cjne	a,_unassemble_pcounter_1_39,L005140?
	inc	(_unassemble_pcounter_1_39 + 1)
L005140?:
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	push	ar4
	push	ar5
	lcall	_addbyte
	pop	ar5
	pop	ar4
;	.\d51.c:120: break;
	ljmp	L005066?
;	.\d51.c:122: case '%': //Direct bit addressing
L005011?:
;	.\d51.c:123: bitncheck=1;
	setb	_unassemble_bitncheck_1_39
;	.\d51.c:124: case '!': //Direct memory addressing including sfrs
L005012?:
;	.\d51.c:125: ptr=(bitncheck?bitn:sfrn); //Select the right table of names
	jnb	_unassemble_bitncheck_1_39,L005070?
	mov	r3,#_bitn
	mov	r7,#(_bitn >> 8)
	sjmp	L005071?
L005070?:
	mov	r3,#_sfrn
	mov	r7,#(_sfrn >> 8)
L005071?:
	mov	_unassemble_ptr_1_39,r3
	mov	(_unassemble_ptr_1_39 + 1),r7
	mov	(_unassemble_ptr_1_39 + 2),#0x80
;	.\d51.c:126: nb=*(++pcounter);					
	inc	_unassemble_pcounter_1_39
	clr	a
	cjne	a,_unassemble_pcounter_1_39,L005142?
	inc	(_unassemble_pcounter_1_39 + 1)
L005142?:
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	mov	_unassemble_nb_1_39,a
;	.\d51.c:128: bitnum=0;
	mov	r6,#0x00
;	.\d51.c:132: if(opcode==0x85)
	mov	a,r5
	jz	L005017?
;	.\d51.c:134: if(opcode0x85==0)
	jb	_unassemble_opcode0x85_1_39,L005014?
;	.\d51.c:136: n=*(pcounter+1);
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r2,a
;	.\d51.c:137: opcode0x85=1;
	setb	_unassemble_opcode0x85_1_39
	sjmp	L005019?
L005014?:
;	.\d51.c:141: n=*(pcounter-1);
	mov	a,_unassemble_pcounter_1_39
	add	a,#0xff
	mov	dpl,a
	mov	a,(_unassemble_pcounter_1_39 + 1)
	addc	a,#0xff
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r2,a
;	.\d51.c:142: opcode0x85=0;
	clr	_unassemble_opcode0x85_1_39
	sjmp	L005019?
L005017?:
;	.\d51.c:147: n=nb;	
	mov	r2,_unassemble_nb_1_39
;	.\d51.c:150: checkagain:
L005019?:
;	.\d51.c:151: if(n>0x7f)  //Search for sfr or bit names
	mov	a,r2
	add	a,#0xff - 0x7F
	jc	L005145?
	ljmp	L005039?
L005145?:
;	.\d51.c:195: }
	mov	_unassemble_sloc3_1_0,_unassemble_ptr_1_39
	mov	(_unassemble_sloc3_1_0 + 1),(_unassemble_ptr_1_39 + 1)
	mov	(_unassemble_sloc3_1_0 + 2),(_unassemble_ptr_1_39 + 2)
L005024?:
;	.\d51.c:153: for(; *ptr; ptr++)
	mov	dpl,_unassemble_sloc3_1_0
	mov	dph,(_unassemble_sloc3_1_0 + 1)
	mov	b,(_unassemble_sloc3_1_0 + 2)
	lcall	__gptrget
	mov	r7,a
	jnz	L005146?
	ljmp	L005027?
L005146?:
;	.\d51.c:155: if(*ptr==n)
	mov	a,r7
	cjne	a,ar2,L005147?
	sjmp	L005148?
L005147?:
	ljmp	L005026?
L005148?:
;	.\d51.c:157: add_byte_txbuff(nb);
	mov	dpl,_unassemble_nb_1_39
	push	ar2
	push	ar4
	push	ar5
	push	ar6
	lcall	_add_byte_txbuff
;	.\d51.c:158: add_char_txbuff(' ');
	mov	dpl,#0x20
	lcall	_add_char_txbuff
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar2
;	.\d51.c:159: for(ptr++; *ptr<0x80; ptr++) addchar(*ptr);
	inc	_unassemble_ptr_1_39
	clr	a
	cjne	a,_unassemble_ptr_1_39,L005149?
	inc	(_unassemble_ptr_1_39 + 1)
L005149?:
	mov	_unassemble_sloc4_1_0,_unassemble_ptr_1_39
	mov	(_unassemble_sloc4_1_0 + 1),(_unassemble_ptr_1_39 + 1)
	mov	(_unassemble_sloc4_1_0 + 2),(_unassemble_ptr_1_39 + 2)
L005060?:
	mov	dpl,_unassemble_sloc4_1_0
	mov	dph,(_unassemble_sloc4_1_0 + 1)
	mov	b,(_unassemble_sloc4_1_0 + 2)
	lcall	__gptrget
	mov	r7,a
	cjne	r7,#0x80,L005150?
L005150?:
	jnc	L005110?
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	@r0,ar7
	inc	_unassemble_sloc4_1_0
	clr	a
	cjne	a,_unassemble_sloc4_1_0,L005060?
	inc	(_unassemble_sloc4_1_0 + 1)
	sjmp	L005060?
L005110?:
	mov	_unassemble_ptr_1_39,_unassemble_sloc4_1_0
	mov	(_unassemble_ptr_1_39 + 1),(_unassemble_sloc4_1_0 + 1)
	mov	(_unassemble_ptr_1_39 + 2),(_unassemble_sloc4_1_0 + 2)
;	.\d51.c:160: if(bitnum>0)
	clr	c
	clr	a
	xrl	a,#0x80
	mov	b,r6
	xrl	b,#0x80
	subb	a,b
	jnc	L005027?
;	.\d51.c:162: addchar('.');
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x2E
;	.\d51.c:163: addchar(bitnum);
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	@r0,ar6
;	.\d51.c:165: break;
	sjmp	L005027?
L005026?:
;	.\d51.c:153: for(; *ptr; ptr++)
	inc	_unassemble_sloc3_1_0
	clr	a
	cjne	a,_unassemble_sloc3_1_0,L005154?
	inc	(_unassemble_sloc3_1_0 + 1)
L005154?:
	mov	_unassemble_ptr_1_39,_unassemble_sloc3_1_0
	mov	(_unassemble_ptr_1_39 + 1),(_unassemble_sloc3_1_0 + 1)
	mov	(_unassemble_ptr_1_39 + 2),(_unassemble_sloc3_1_0 + 2)
	ljmp	L005024?
L005027?:
;	.\d51.c:168: if(*ptr==0)
	mov	dpl,_unassemble_ptr_1_39
	mov	dph,(_unassemble_ptr_1_39 + 1)
	mov	b,(_unassemble_ptr_1_39 + 2)
	lcall	__gptrget
	jz	L005155?
	ljmp	L005066?
L005155?:
;	.\d51.c:170: if(bitnum>0) n|=(bitnum&7);
	clr	c
	clr	a
	xrl	a,#0x80
	mov	b,r6
	xrl	b,#0x80
	subb	a,b
	jnc	L005029?
	mov	a,#0x07
	anl	a,r6
	orl	ar2,a
L005029?:
;	.\d51.c:171: if(bitncheck)
;	.\d51.c:174: bitncheck=0;
	jbc	_unassemble_bitncheck_1_39,L005157?
	sjmp	L005034?
L005157?:
;	.\d51.c:175: bitnum=(n&7)|'0';
	mov	a,#0x07
	anl	a,r2
	orl	a,#0x30
	mov	r6,a
;	.\d51.c:176: n&=0xf8;
	anl	ar2,#0xF8
;	.\d51.c:177: ptr=sfrn;
	mov	_unassemble_ptr_1_39,#_sfrn
	mov	(_unassemble_ptr_1_39 + 1),#(_sfrn >> 8)
	mov	(_unassemble_ptr_1_39 + 2),#0x80
;	.\d51.c:178: goto checkagain;
	ljmp	L005019?
L005034?:
;	.\d51.c:182: if(opcode==0x85)
	mov	a,r5
	jz	L005031?
;	.\d51.c:184: addchar(hexval[n/0x10]);
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	a,r2
	swap	a
	anl	a,#0x0f
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	@r0,a
;	.\d51.c:185: addchar(hexval[n&0x0f]);
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	a,#0x0F
	anl	a,r2
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	@r0,a
;	.\d51.c:186: add_byte_txbuff(nb);
	mov	dpl,_unassemble_nb_1_39
	push	ar4
	push	ar5
	lcall	_add_byte_txbuff
;	.\d51.c:187: add_char_txbuff(' ');
	mov	dpl,#0x20
	lcall	_add_char_txbuff
	pop	ar5
	pop	ar4
	ljmp	L005066?
L005031?:
;	.\d51.c:191: addbyte(n);
	mov	dpl,r2
	push	ar4
	push	ar5
	lcall	_addbyte
	pop	ar5
	pop	ar4
	ljmp	L005066?
L005039?:
;	.\d51.c:196: else addbyte(n); //Not an sfr name print the number
	mov	dpl,r2
	push	ar4
	push	ar5
	lcall	_addbyte
	pop	ar5
	pop	ar4
;	.\d51.c:197: break;
	ljmp	L005066?
;	.\d51.c:199: case '.': //8 bit relative address
L005041?:
;	.\d51.c:200: pcounter++;
	push	ar4
	inc	_unassemble_pcounter_1_39
	clr	a
	cjne	a,_unassemble_pcounter_1_39,L005159?
	inc	(_unassemble_pcounter_1_39 + 1)
L005159?:
;	.\d51.c:201: absadd=(unsigned int)pcounter+(char)*pcounter+1;
	mov	r3,_unassemble_pcounter_1_39
	mov	r6,(_unassemble_pcounter_1_39 + 1)
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	mov	r7,a
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	a,r7
	add	a,r3
	mov	r3,a
	mov	a,r4
	addc	a,r6
	mov	r6,a
	mov	a,#0x01
	add	a,r3
	mov	_unassemble_absadd_1_39,a
	clr	a
	addc	a,r6
	mov	(_unassemble_absadd_1_39 + 1),a
;	.\d51.c:202: addword(absadd);
	mov	dpl,_unassemble_absadd_1_39
	mov	dph,(_unassemble_absadd_1_39 + 1)
	push	ar4
	push	ar5
	lcall	_addword
;	.\d51.c:203: add_byte_txbuff(*pcounter);
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_add_byte_txbuff
;	.\d51.c:204: add_char_txbuff(' ');
	mov	dpl,#0x20
	lcall	_add_char_txbuff
	pop	ar5
	pop	ar4
;	.\d51.c:205: break;
	pop	ar4
	ljmp	L005066?
;	.\d51.c:207: case '&': //11 bit paged address
L005042?:
;	.\d51.c:208: n=(*pcounter/0x20)|((((unsigned int)pcounter+2)/0x100)&0xf8);
	push	ar4
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	swap	a
	rr	a
	anl	a,#0x07
	mov	r3,a
	mov	r6,_unassemble_pcounter_1_39
	mov	r7,(_unassemble_pcounter_1_39 + 1)
	mov	a,#0x02
	add	a,r6
	clr	a
	addc	a,r7
	mov	r6,a
	anl	ar6,#0xF8
	clr	a
	mov	r7,a
	mov	r4,a
	mov	a,r3
	orl	ar6,a
	mov	a,r4
	orl	ar7,a
	mov	ar2,r6
;	.\d51.c:209: pcounter++;
	inc	_unassemble_pcounter_1_39
	clr	a
	cjne	a,_unassemble_pcounter_1_39,L005160?
	inc	(_unassemble_pcounter_1_39 + 1)
L005160?:
;	.\d51.c:210: absadd=(n*0x100)+(*pcounter);
	mov	ar3,r2
	mov	ar4,r3
	mov	r3,#0x00
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	mov	r7,#0x00
	add	a,r3
	mov	_unassemble_absadd_1_39,a
	mov	a,r7
	addc	a,r4
	mov	(_unassemble_absadd_1_39 + 1),a
;	.\d51.c:211: addword(absadd);
	mov	dpl,_unassemble_absadd_1_39
	mov	dph,(_unassemble_absadd_1_39 + 1)
	push	ar4
	push	ar5
	lcall	_addword
;	.\d51.c:212: add_byte_txbuff(*pcounter);
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_add_byte_txbuff
;	.\d51.c:213: add_char_txbuff(' ');
	mov	dpl,#0x20
	lcall	_add_char_txbuff
	pop	ar5
	pop	ar4
;	.\d51.c:214: break;
	pop	ar4
	ljmp	L005066?
;	.\d51.c:216: case ':': // 16 bit absolute address
L005043?:
;	.\d51.c:217: absadd=*(++pcounter)*0x100;
	inc	_unassemble_pcounter_1_39
	clr	a
	cjne	a,_unassemble_pcounter_1_39,L005161?
	inc	(_unassemble_pcounter_1_39 + 1)
L005161?:
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	mov	r3,a
	inc	dptr
	mov	_unassemble_pcounter_1_39,dpl
	mov	(_unassemble_pcounter_1_39 + 1),dph
	mov	ar6,r3
	mov	(_unassemble_absadd_1_39 + 1),r6
	mov	_unassemble_absadd_1_39,#0x00
;	.\d51.c:218: add_byte_txbuff(*pcounter);
	mov	dpl,r3
	push	ar4
	push	ar5
	lcall	_add_byte_txbuff
;	.\d51.c:219: add_char_txbuff(' ');
	mov	dpl,#0x20
	lcall	_add_char_txbuff
;	.\d51.c:220: add_byte_txbuff(*(++pcounter));
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	mov	dpl,a
	lcall	_add_byte_txbuff
;	.\d51.c:221: add_char_txbuff(' ');
	mov	dpl,#0x20
	lcall	_add_char_txbuff
;	.\d51.c:222: absadd+=*pcounter;
	mov	dpl,_unassemble_pcounter_1_39
	mov	dph,(_unassemble_pcounter_1_39 + 1)
	clr	a
	movc	a,@a+dptr
	mov	r6,#0x00
	add	a,_unassemble_absadd_1_39
	mov	_unassemble_absadd_1_39,a
	mov	a,r6
	addc	a,(_unassemble_absadd_1_39 + 1)
	mov	(_unassemble_absadd_1_39 + 1),a
;	.\d51.c:223: addword(absadd);
	mov	dpl,_unassemble_absadd_1_39
	mov	dph,(_unassemble_absadd_1_39 + 1)
	lcall	_addword
	pop	ar5
	pop	ar4
;	.\d51.c:224: break;
;	.\d51.c:226: case '*': //@r0 or @r1
	sjmp	L005066?
L005044?:
;	.\d51.c:227: addstr("@r");
	mov	dptr,#__str_1
	mov	b,#0x80
	push	ar4
	push	ar5
	lcall	_addstr
	pop	ar5
	pop	ar4
;	.\d51.c:228: addchar((opcode&0x1)|'0');
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	@r0,_unassemble_sloc1_1_0
;	.\d51.c:229: break;
;	.\d51.c:231: case '?': //r0 to r7
	sjmp	L005066?
L005045?:
;	.\d51.c:232: addchar('r');
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x72
;	.\d51.c:233: addchar((opcode&0x7)|'0');
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	@r0,_unassemble_sloc2_1_0
;	.\d51.c:234: break;
;	.\d51.c:236: default:
	sjmp	L005066?
L005046?:
;	.\d51.c:237: addchar(n);
	mov	r3,_cur
	inc	_cur
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	@r0,ar2
;	.\d51.c:239: }
L005066?:
;	.\d51.c:103: for(; mnemtbl[j]!='\n'; j++)
	inc	_unassemble_j_1_39
	clr	a
	cjne	a,_unassemble_j_1_39,L005162?
	inc	(_unassemble_j_1_39 + 1)
L005162?:
	ljmp	L005064?
L005067?:
;	.\d51.c:241: addchar('\r');
	mov	r2,_cur
	inc	_cur
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x0D
;	.\d51.c:242: addchar('\n');
	mov	r2,_cur
	inc	_cur
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x0A
;	.\d51.c:243: addchar(0);
	mov	r2,_cur
	inc	_cur
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x00
;	.\d51.c:244: add_str_txbuff(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_add_str_txbuff
;	.\d51.c:245: pcounter++; //points to next opcode
	inc	_unassemble_pcounter_1_39
	clr	a
	cjne	a,_unassemble_pcounter_1_39,L005163?
	inc	(_unassemble_pcounter_1_39 + 1)
L005163?:
;	.\d51.c:247: update_txbuff();
	lcall	_update_txbuff
	ljmp	L005052?
L005054?:
;	.\d51.c:249: flush_txbuff();
	ljmp	_flush_txbuff
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_mnem:
	db _str_2,(_str_2 >> 8)
	db _str_3,(_str_3 >> 8)
	db _str_4,(_str_4 >> 8)
	db _str_5,(_str_5 >> 8)
	db _str_6,(_str_6 >> 8)
	db _str_7,(_str_7 >> 8)
	db _str_8,(_str_8 >> 8)
	db _str_9,(_str_9 >> 8)
	db _str_10,(_str_10 >> 8)
	db _str_11,(_str_11 >> 8)
	db _str_12,(_str_12 >> 8)
	db _str_13,(_str_13 >> 8)
	db _str_14,(_str_14 >> 8)
	db _str_15,(_str_15 >> 8)
	db _str_16,(_str_16 >> 8)
	db _str_17,(_str_17 >> 8)
_mnemtbl:
	db 'nop'
	db 0x0A
	db 'H&'
	db 0x0A
	db 'ljmp'
	db 0x09
	db ':'
	db 0x0A
	db 'rr'
	db 0x09
	db 'a'
	db 0x0A
	db 'Ba'
	db 0x0A
	db 'B!'
	db 0x0A
	db 0x0A
	db 'B*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'B?'
	db 0x0A
	db 'jbc'
	db 0x09
	db '%,.'
	db 0x0A
	db 'D&'
	db 0x0A
	db 'lcall'
	db 0x09
	db ':'
	db 0x0A
	db 'rr'
	db 'c a'
	db 0x0A
	db 'Ca'
	db 0x0A
	db 'C!'
	db 0x0A
	db 0x0A
	db 'C*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'C?'
	db 0x0A
	db 'jb'
	db 0x09
	db '%,.'
	db 0x0A
	db 'H&'
	db 0x0A
	db 'ret'
	db 0x0A
	db 'rl'
	db 0x09
	db 'a'
	db 0x0A
	db 'E#'
	db 0x0A
	db 'E!'
	db 0x0A
	db 0x0A
	db 'E*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'E?'
	db 0x0A
	db 'jnb'
	db 0x09
	db '%,.'
	db 0x0A
	db 'D&'
	db 0x0A
	db 'reti'
	db 0x0A
	db 'rlc'
	db 0x09
	db 'a'
	db 0x0A
	db 'F#'
	db 0x0A
	db 'F!'
	db 0x0A
	db 0x0A
	db 'F*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'F?'
	db 0x0A
	db 'jc'
	db 0x09
	db '.'
	db 0x0A
	db 'H&'
	db 0x0A
	db 'orl'
	db 0x09
	db '!,a'
	db 0x0A
	db 'orl'
	db 0x09
	db '!,#'
	db 0x0A
	db 'G#'
	db 0x0A
	db 'G!'
	db 0x0A
	db 0x0A
	db 'G*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'G?'
	db 0x0A
	db 'jnc'
	db 0x09
	db '.'
	db 0x0A
	db 'D&'
	db 0x0A
	db 'anl'
	db 0x09
	db '!,a'
	db 0x0A
	db 'anl'
	db 0x09
	db '!,#'
	db 0x0A
	db 'I#'
	db 0x0A
	db 'I!'
	db 0x0A
	db 0x0A
	db 'I*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'I?'
	db 0x0A
	db 'jz'
	db 0x09
	db '.'
	db 0x0A
	db 'H&'
	db 0x0A
	db 'xrl'
	db 0x09
	db '!,a'
	db 0x0A
	db 'xrl'
	db 0x09
	db '!,#'
	db 0x0A
	db 'J#'
	db 0x0A
	db 'J!'
	db 0x0A
	db 0x0A
	db 'J*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'J?'
	db 0x0A
	db 'jn'
	db 'z'
	db 0x09
	db '.'
	db 0x0A
	db 'D&'
	db 0x0A
	db 'orl'
	db 0x09
	db 'c,%'
	db 0x0A
	db 'jmp'
	db 0x09
	db '@a+P'
	db 0x0A
	db 'Aa,#'
	db 0x0A
	db 'A!,#'
	db 0x0A
	db 0x0A
	db 'A*,#'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'A?,#'
	db 0x0A
	db 'sjmp'
	db 0x09
	db '.'
	db 0x0A
	db 'H'
	db '&'
	db 0x0A
	db 'anl c,%'
	db 0x0A
	db 'movc'
	db 0x09
	db 'a,@a+pc'
	db 0x0A
	db 'div'
	db 0x09
	db 'ab'
	db 0x0A
	db 'A!,!'
	db 0x0A
	db 0x0A
	db 'A!,*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'A!,?'
	db 0x0A
	db 'AP,#'
	db 0x0A
	db 'D&'
	db 0x0A
	db 'A%,c'
	db 0x0A
	db 'movc'
	db 0x09
	db 'a,@a+P'
	db 0x0A
	db 'K#'
	db 0x0A
	db 'K!'
	db 0x0A
	db 0x0A
	db 'K*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'K?'
	db 0x0A
	db 'orl'
	db 0x09
	db 'c,/.'
	db 0x0A
	db 'H&'
	db 0x0A
	db 'Ac,%'
	db 0x0A
	db 'BP'
	db 0x0A
	db 'mu'
	db 'l'
	db 0x09
	db 'ab'
	db 0x0A
	db 'db'
	db 0x09
	db 'a5'
	db 0x0A
	db 0x0A
	db 'A*,!'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'A?,!'
	db 0x0A
	db 'anl'
	db 0x09
	db 'c,/.'
	db 0x0A
	db 'D&'
	db 0x0A
	db 'cpl'
	db 0x09
	db '%'
	db 0x0A
	db 'cpl'
	db 0x09
	db 'c'
	db 0x0A
	db 'La,# .'
	db 0x0A
	db 'La,! .'
	db 0x0A
	db 0x0A
	db 'L*,# .'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'L?,# .'
	db 0x0A
	db 'push'
	db 0x09
	db '!'
	db 0x0A
	db 'H&'
	db 0x0A
	db 'clr'
	db 0x09
	db '%'
	db 0x0A
	db 'clr'
	db 0x09
	db 'c'
	db 0x0A
	db 'swap'
	db 0x09
	db 'a'
	db 0x0A
	db 'M!'
	db 0x0A
	db 0x0A
	db 'M*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'M?'
	db 0x0A
	db 'pop'
	db 0x09
	db '!'
	db 0x0A
	db 'D&'
	db 0x0A
	db 'setb'
	db 0x09
	db '%'
	db 0x0A
	db 'setb'
	db 0x09
	db 'c'
	db 0x0A
	db 'da'
	db 0x09
	db 'a'
	db 0x0A
	db 'N! .'
	db 0x0A
	db 0x0A
	db 'xchd'
	db 0x09
	db 'a,*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'N?,.'
	db 0x0A
	db 'Oa,@P'
	db 0x0A
	db 'H&'
	db 0x0A
	db 0x0A
	db 'Oa,*'
	db 0x0A
	db 'clr'
	db 0x09
	db 'a'
	db 0x0A
	db 'Aa,!'
	db 0x0A
	db 0x0A
	db 'Aa,*'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'Aa,?'
	db 0x0A
	db 'O@P,a'
	db 0x0A
	db 'D&'
	db 0x0A
	db 0x0A
	db 'O*,a'
	db 0x0A
	db 'cpl'
	db 0x09
	db 'a'
	db 0x0A
	db 'A!,a'
	db 0x0A
	db 0x0A
	db 'A*,a'
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 0x0A
	db 'A?,a'
	db 0x0A
	db 0x00
__str_0:
	db ': '
	db 0x00
__str_1:
	db '@r'
	db 0x00
_str_2:
	db 'mov'
	db 0x09
	db 0x00
_str_3:
	db 'inc'
	db 0x09
	db 0x00
_str_4:
	db 'dec'
	db 0x09
	db 0x00
_str_5:
	db 'acall'
	db 0x09
	db 0x00
_str_6:
	db 'add'
	db 0x09
	db 'a,'
	db 0x00
_str_7:
	db 'addc'
	db 0x09
	db 'a,'
	db 0x00
_str_8:
	db 'orl'
	db 0x09
	db 'a,'
	db 0x00
_str_9:
	db 'ajmp'
	db 0x09
	db 0x00
_str_10:
	db 'anl'
	db 0x09
	db 'a,'
	db 0x00
_str_11:
	db 'xrl'
	db 0x09
	db 'a,'
	db 0x00
_str_12:
	db 'subb'
	db 0x09
	db 'a,'
	db 0x00
_str_13:
	db 'cjne'
	db 0x09
	db 0x00
_str_14:
	db 'xch'
	db 0x09
	db 'a,'
	db 0x00
_str_15:
	db 'djnz'
	db 0x09
	db 0x00
_str_16:
	db 'movx'
	db 0x09
	db 0x00
_str_17:
	db 'dptr'
	db 0x00

	CSEG

end
