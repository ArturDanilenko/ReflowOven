;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Fri Jun 08 20:21:16 2018
;--------------------------------------------------------
$name CV_Boot_SPI
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
	public _Write_XRAM_PARM_2
	public _seven_seg
	public _hexval
	public _dummy_switch
	public _main
	public _Manual_Load
	public _OutWord
	public _OutByte
	public _str2hex
	public _loadintelhex
	public _Load_Ram_Fast_and_Run_Debugger
	public _Load_Ram_Fast_and_Run
	public _Copy_Flash_to_RAM
	public _FlashBuff
	public _FlashByte
	public _Read_XRAM
	public _Write_XRAM
	public _EraseSector
	public _In_Byte_Flash
	public _getbyte
	public _chartohex
	public _sends
	public _getchare
	public _inituart
	public _Check_WIP
	public _DoSPI
	public _de2_8052_crt0
	public _getchar_echo
	public _buff
	public _FlashBuff_PARM_3
	public _FlashBuff_PARM_2
	public _FlashByte_PARM_2
	public _putchar
	public _getchar
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
_MY_MOSI        BIT 0xdf
_MY_MISO        BIT 0xdf
_MY_SCLK        BIT 0xde
_MY_CE          BIT 0xdd
_ASMI_ACC_GRANTED BIT 0xdc
_ASMI_ACC_REQUEST BIT 0xde
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_getbyte_j_1_83:
	ds 1
_FlashByte_PARM_2:
	ds 1
_FlashBuff_PARM_2:
	ds 3
_FlashBuff_PARM_3:
	ds 1
_loadintelhex_address_1_103:
	ds 2
_loadintelhex_j_1_103:
	ds 1
_loadintelhex_size_1_103:
	ds 1
_loadintelhex_type_1_103:
	ds 1
_loadintelhex_checksum_1_103:
	ds 1
_loadintelhex_n_1_103:
	ds 1
_loadintelhex_echo_1_103:
	ds 1
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_Write_XRAM_PARM_2:
	ds 1
	rseg	R_OSEG
	rseg	R_OSEG
_str2hex_sloc0_1_0:
	ds 2
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
_buff:
	ds 64
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_getchar_echo:
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
	CSEG at 0xf000
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
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:44: bit getchar_echo=0;
	clr	_getchar_echo
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
;Allocation info for local variables in function 'DoSPI'
;------------------------------------------------------------
;value                     Allocated to registers 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:68: unsigned char DoSPI (unsigned char value)
;	-----------------------------------------
;	 function DoSPI
;	-----------------------------------------
_DoSPI:
	using	0
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:96: _endasm;
	
	  mov a, dpl
	  clr _MY_SCLK
	
	  SPIBIT MAC
      ; Send/Receive bit %0
	   rlc a
	   mov _MY_MOSI, c
	   setb _MY_SCLK
	   mov c, _MY_MISO
	   clr _MY_SCLK
	   mov acc.0, c
	  ENDMAC
	
	  SPIBIT(7)
	  SPIBIT(6)
	  SPIBIT(5)
	  SPIBIT(4)
	  SPIBIT(3)
	  SPIBIT(2)
	  SPIBIT(1)
	  SPIBIT(0)
	
	  mov dpl, a
	  ret
	 
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:98: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Check_WIP'
;------------------------------------------------------------
;status                    Allocated to registers 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:101: void Check_WIP (void)
;	-----------------------------------------
;	 function Check_WIP
;	-----------------------------------------
_Check_WIP:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:105: MY_CE=0;
	clr	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:106: DoSPI(READ_STATUS);
	mov	dpl,#0x05
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:107: do {
L004001?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:108: status=DoSPI(0x55);
	mov	dpl,#0x55
	lcall	_DoSPI
	mov	a,dpl
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:109: } while (status&0b0000_0001); // Check the Write in Progress bit
	jb	acc.0,L004001?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:110: MY_CE=1;
	setb	_MY_CE
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'inituart'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:113: void inituart (void)
;	-----------------------------------------
;	 function inituart
;	-----------------------------------------
_inituart:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:115: RCAP2H=HIGH(TIMER_2_RELOAD);
	mov	_RCAP2H,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:116: RCAP2L=LOW(TIMER_2_RELOAD);
	mov	_RCAP2L,#0xF7
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:117: T2CON=0x34; // #00110100B
	mov	_T2CON,#0x34
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:118: SCON=0x52; // Serial port in mode 1, ren, txrdy, rxempty
	mov	_SCON,#0x52
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'putchar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:121: void putchar (char c)
;	-----------------------------------------
;	 function putchar
;	-----------------------------------------
_putchar:
	mov	r2,dpl
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:123: if (c=='\n')
	cjne	r2,#0x0A,L006006?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:125: while (!TI);
L006001?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:126: TI=0;
	jbc	_TI,L006017?
	sjmp	L006001?
L006017?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:127: SBUF='\r';
	mov	_SBUF,#0x0D
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:129: while (!TI);
L006006?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:130: TI=0;
	jbc	_TI,L006018?
	sjmp	L006006?
L006018?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:131: SBUF=c;
	mov	_SBUF,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getchar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:134: char getchar (void)
;	-----------------------------------------
;	 function getchar
;	-----------------------------------------
_getchar:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:138: while (!RI);
L007001?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:139: RI=0;
	jbc	_RI,L007011?
	sjmp	L007001?
L007011?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:140: c=SBUF;
	mov	r2,_SBUF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:141: if (getchar_echo==1) putchar(c);
	jnb	_getchar_echo,L007005?
	mov	dpl,r2
	push	ar2
	lcall	_putchar
	pop	ar2
L007005?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:143: return c;
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getchare'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:146: char getchare (void)
;	-----------------------------------------
;	 function getchare
;	-----------------------------------------
_getchare:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:150: c=getchar();
	lcall	_getchar
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:151: putchar(c);
	mov  r2,dpl
	push	ar2
	lcall	_putchar
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:152: return c;
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'sends'
;------------------------------------------------------------
;c                         Allocated to registers r2 r3 r4 
;n                         Allocated to registers r6 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:155: void sends (unsigned char * c)
;	-----------------------------------------
;	 function sends
;	-----------------------------------------
_sends:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:158: while(n=*c)
L009001?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	mov	r6,a
	jz	L009004?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:160: putchar(n);
	mov	dpl,r6
	push	ar2
	push	ar3
	push	ar4
	lcall	_putchar
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:161: c++;
	inc	r2
	cjne	r2,#0x00,L009001?
	inc	r3
	sjmp	L009001?
L009004?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'chartohex'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:165: unsigned char chartohex(char c)
;	-----------------------------------------
;	 function chartohex
;	-----------------------------------------
_chartohex:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:167: if(c & 0x40) c+=9; //  a to f or A to F
	mov	a,dpl
	mov	r2,a
	jnb	acc.6,L010002?
	mov	a,#0x09
	add	a,r2
	mov	r2,a
L010002?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:168: return (c & 0xf);
	mov	a,#0x0F
	anl	a,r2
	mov	dpl,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getbyte'
;------------------------------------------------------------
;j                         Allocated with name '_getbyte_j_1_83'
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:172: unsigned char getbyte (void)
;	-----------------------------------------
;	 function getbyte
;	-----------------------------------------
_getbyte:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:176: j=chartohex(getchare())*0x10;
	lcall	_getchare
	lcall	_chartohex
	mov	a,dpl
	swap	a
	anl	a,#0xf0
	mov	_getbyte_j_1_83,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:177: j|=chartohex(getchare());
	lcall	_getchare
	lcall	_chartohex
	mov	a,dpl
	orl	_getbyte_j_1_83,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:179: return j;
	mov	dpl,_getbyte_j_1_83
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'In_Byte_Flash'
;------------------------------------------------------------
;address                   Allocated to registers r2 r3 
;j                         Allocated to registers 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:182: unsigned char In_Byte_Flash (unsigned int address)
;	-----------------------------------------
;	 function In_Byte_Flash
;	-----------------------------------------
_In_Byte_Flash:
	mov	r2,dpl
	mov	r3,dph
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:186: MY_CE=0;
	clr	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:187: DoSPI(READ_BYTES);
	mov	dpl,#0x03
	push	ar2
	push	ar3
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:188: DoSPI(FLASHSECTOR);
	mov	dpl,#0xF8
	lcall	_DoSPI
	pop	ar3
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:189: DoSPI(address/0x100);
	mov	ar4,r3
	mov	dpl,r4
	push	ar3
	lcall	_DoSPI
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:190: DoSPI(address%0x100);
	mov	dpl,r2
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:191: j=DoSPI(0x55);
	mov	dpl,#0x55
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:192: MY_CE=1;
	setb	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:194: return j;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'EraseSector'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:197: void EraseSector (void)
;	-----------------------------------------
;	 function EraseSector
;	-----------------------------------------
_EraseSector:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:199: MY_CE=0; DoSPI(WRITE_ENABLE); MY_CE=1;
	clr	_MY_CE
	mov	dpl,#0x06
	lcall	_DoSPI
	setb	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:201: MY_CE=0;
	clr	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:202: DoSPI(ERASE_SECTOR);
	mov	dpl,#0xD8
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:203: DoSPI(FLASHSECTOR);
	mov	dpl,#0xF8
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:204: DoSPI(0x00);
	mov	dpl,#0x00
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:205: DoSPI(0x00);
	mov	dpl,#0x00
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:206: MY_CE=1;
	setb	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:208: Check_WIP();
	ljmp	_Check_WIP
;------------------------------------------------------------
;Allocation info for local variables in function 'Write_XRAM'
;------------------------------------------------------------
;Value                     Allocated with name '_Write_XRAM_PARM_2'
;Address                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:211: void Write_XRAM (unsigned int Address, unsigned char Value)
;	-----------------------------------------
;	 function Write_XRAM
;	-----------------------------------------
_Write_XRAM:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:213: *((unsigned char xdata *) Address)=Value;
	mov	a,_Write_XRAM_PARM_2
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Read_XRAM'
;------------------------------------------------------------
;Address                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:216: unsigned char Read_XRAM (unsigned int Address)
;	-----------------------------------------
;	 function Read_XRAM
;	-----------------------------------------
_Read_XRAM:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:218: return *((unsigned char xdata *) Address);
	movx	a,@dptr
	mov	dpl,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'FlashByte'
;------------------------------------------------------------
;val                       Allocated with name '_FlashByte_PARM_2'
;address                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:221: void FlashByte (unsigned int address, unsigned char val)
;	-----------------------------------------
;	 function FlashByte
;	-----------------------------------------
_FlashByte:
	mov	r2,dpl
	mov	r3,dph
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:223: MY_CE=0; DoSPI(WRITE_ENABLE);  MY_CE=1;
	clr	_MY_CE
	mov	dpl,#0x06
	push	ar2
	push	ar3
	lcall	_DoSPI
	setb	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:225: MY_CE=0;
	clr	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:226: DoSPI(WRITE_BYTES);
	mov	dpl,#0x02
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:227: DoSPI(FLASHSECTOR);
	mov	dpl,#0xF8
	lcall	_DoSPI
	pop	ar3
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:228: DoSPI(address/0x100);
	mov	ar4,r3
	mov	dpl,r4
	push	ar3
	lcall	_DoSPI
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:229: DoSPI(address%0x100);
	mov	dpl,r2
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:230: DoSPI(val);
	mov	dpl,_FlashByte_PARM_2
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:231: MY_CE=1;
	setb	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:233: Check_WIP();
	ljmp	_Check_WIP
;------------------------------------------------------------
;Allocation info for local variables in function 'FlashBuff'
;------------------------------------------------------------
;buff                      Allocated with name '_FlashBuff_PARM_2'
;numb                      Allocated with name '_FlashBuff_PARM_3'
;address                   Allocated to registers r2 r3 
;j                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:237: void FlashBuff (unsigned int address, unsigned char * buff, unsigned char numb)
;	-----------------------------------------
;	 function FlashBuff
;	-----------------------------------------
_FlashBuff:
	mov	r2,dpl
	mov	r3,dph
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:241: MY_CE=0; DoSPI(WRITE_ENABLE);  MY_CE=1;
	clr	_MY_CE
	mov	dpl,#0x06
	push	ar2
	push	ar3
	lcall	_DoSPI
	setb	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:242: MY_CE=0;
	clr	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:243: DoSPI(WRITE_BYTES);
	mov	dpl,#0x02
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:244: DoSPI(FLASHSECTOR);
	mov	dpl,#0xF8
	lcall	_DoSPI
	pop	ar3
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:245: DoSPI(address/0x100);
	mov	ar4,r3
	mov	dpl,r4
	push	ar3
	lcall	_DoSPI
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:246: DoSPI(address%0x100);
	mov	dpl,r2
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:247: for(j=0; j<numb; j++) DoSPI(buff[j]);
	mov	r2,#0x00
L017001?:
	clr	c
	mov	a,r2
	subb	a,_FlashBuff_PARM_3
	jnc	L017004?
	mov	a,r2
	add	a,_FlashBuff_PARM_2
	mov	r3,a
	clr	a
	addc	a,(_FlashBuff_PARM_2 + 1)
	mov	r4,a
	mov	r5,(_FlashBuff_PARM_2 + 2)
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	lcall	__gptrget
	mov	dpl,a
	push	ar2
	lcall	_DoSPI
	pop	ar2
	inc	r2
	sjmp	L017001?
L017004?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:248: MY_CE=1;
	setb	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:250: Check_WIP();
	ljmp	_Check_WIP
;------------------------------------------------------------
;Allocation info for local variables in function 'Copy_Flash_to_RAM'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:253: void Copy_Flash_to_RAM (void)
;	-----------------------------------------
;	 function Copy_Flash_to_RAM
;	-----------------------------------------
_Copy_Flash_to_RAM:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:255: XRAMUSEDAS=0x01; // 32k RAM accessed as xdata
	mov	_XRAMUSEDAS,#0x01
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:257: MY_CE=0;
	clr	_MY_CE
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:258: DoSPI(READ_BYTES);
	mov	dpl,#0x03
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:259: DoSPI(FLASHSECTOR);
	mov	dpl,#0xF8
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:260: DoSPI(0);
	mov	dpl,#0x00
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:261: DoSPI(0);
	mov	dpl,#0x00
	lcall	_DoSPI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:313: _endasm;
	
	     mov dptr, #0
	 load_next_byte:
     ; Bit 7
	  clr _MY_SCLK
	  mov c, _MY_MISO
	  setb _MY_SCLK
	  rlc a
     ; Bit 6
	  clr _MY_SCLK
	  mov c, _MY_MISO
	  setb _MY_SCLK
	  rlc a
     ; Bit 5
	  clr _MY_SCLK
	  mov c, _MY_MISO
	  setb _MY_SCLK
	  rlc a
     ; Bit 4
	  clr _MY_SCLK
	  mov c, _MY_MISO
	  setb _MY_SCLK
	  rlc a
     ; Bit 3
	  clr _MY_SCLK
	  mov c, _MY_MISO
	  setb _MY_SCLK
	  rlc a
     ; Bit 2
	  clr _MY_SCLK
	  mov c, _MY_MISO
	  setb _MY_SCLK
	  rlc a
     ; Bit 1
	  clr _MY_SCLK
	  mov c, _MY_MISO
	  setb _MY_SCLK
	  rlc a
     ; Bit 0
	  clr _MY_SCLK
	  mov c, _MY_MISO
	  setb _MY_SCLK
	  rlc a
  ; Move to xram
	  movx @dptr, a
	  inc dptr
  ; Check for number of bytes
	  mov a, dph
	  jnb acc.7, load_next_byte
	    
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:315: MY_CE=1;
	setb	_MY_CE
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Load_Ram_Fast_and_Run'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:318: void Load_Ram_Fast_and_Run (void)
;	-----------------------------------------
;	 function Load_Ram_Fast_and_Run
;	-----------------------------------------
_Load_Ram_Fast_and_Run:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:320: Copy_Flash_to_RAM();
	lcall	_Copy_Flash_to_RAM
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:321: ASMI_ACC_GRANTED=1;  // Release the SPI bus
	setb	_ASMI_ACC_GRANTED
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:322: T2CON=0;
	mov	_T2CON,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:323: SCON=0;
	mov	_SCON,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:324: RCAP2H=0;
	mov	_RCAP2H,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:325: RCAP2L=0;
	mov	_RCAP2L,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:332: _endasm;
	
	  mov _XRAMUSEDAS, #0 ; 32k RAM accessed as code
  ; RAM is loaded with user code. Run it.
	  mov sp, #7
	  ljmp 0x0000
	 
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Load_Ram_Fast_and_Run_Debugger'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:335: void Load_Ram_Fast_and_Run_Debugger (void)
;	-----------------------------------------
;	 function Load_Ram_Fast_and_Run_Debugger
;	-----------------------------------------
_Load_Ram_Fast_and_Run_Debugger:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:337: Copy_Flash_to_RAM();
	lcall	_Copy_Flash_to_RAM
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:338: ASMI_ACC_GRANTED=1;  // Release the SPI bus
	setb	_ASMI_ACC_GRANTED
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:339: T2CON=0;
	mov	_T2CON,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:340: SCON=0;
	mov	_SCON,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:341: RCAP2H=0;
	mov	_RCAP2H,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:342: RCAP2L=0;
	mov	_RCAP2L,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:343: LEDRA=0xff;
	mov	_LEDRA,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:344: LEDRB=0xff;
	mov	_LEDRB,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:352: _endasm;
	
	  mov _XRAMUSEDAS, #0 ; 32k RAM accessed as code
	  mov sp, #7
	
  ; RAM is loaded with user code. Run the debugger now.
	  ljmp 0xc000
	 
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'loadintelhex'
;------------------------------------------------------------
;address                   Allocated with name '_loadintelhex_address_1_103'
;j                         Allocated with name '_loadintelhex_j_1_103'
;size                      Allocated with name '_loadintelhex_size_1_103'
;type                      Allocated with name '_loadintelhex_type_1_103'
;checksum                  Allocated with name '_loadintelhex_checksum_1_103'
;n                         Allocated with name '_loadintelhex_n_1_103'
;echo                      Allocated with name '_loadintelhex_echo_1_103'
;savedcs                   Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:355: void loadintelhex (void)
;	-----------------------------------------
;	 function loadintelhex
;	-----------------------------------------
_loadintelhex:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:362: while(1)
L021020?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:364: n=getchare();
	lcall	_getchare
	mov	_loadintelhex_n_1_103,dpl
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:366: if(n==(unsigned char)':')
	mov	a,#0x3A
	cjne	a,_loadintelhex_n_1_103,L021040?
	sjmp	L021041?
L021040?:
	ljmp	L021017?
L021041?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:368: echo='.'; // If everything works ok, send a period...
	mov	_loadintelhex_echo_1_103,#0x2E
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:369: size=getbyte();
	lcall	_getbyte
	mov	_loadintelhex_size_1_103,dpl
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:370: checksum=size;
	mov	_loadintelhex_checksum_1_103,_loadintelhex_size_1_103
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:372: address=getbyte();
	lcall	_getbyte
	mov	r2,dpl
	mov	_loadintelhex_address_1_103,r2
	mov	(_loadintelhex_address_1_103 + 1),#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:373: checksum+=address;
	mov	r2,_loadintelhex_address_1_103
	mov	a,r2
	add	a,_loadintelhex_checksum_1_103
	mov	_loadintelhex_checksum_1_103,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:374: address*=0x100;
	mov	(_loadintelhex_address_1_103 + 1),_loadintelhex_address_1_103
	mov	_loadintelhex_address_1_103,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:375: n=getbyte();
	lcall	_getbyte
	mov	_loadintelhex_n_1_103,dpl
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:376: checksum+=n;
	mov	a,_loadintelhex_n_1_103
	add	a,_loadintelhex_checksum_1_103
	mov	_loadintelhex_checksum_1_103,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:377: address+=n;
	mov	r2,_loadintelhex_n_1_103
	mov	r3,#0x00
	mov	a,r2
	add	a,_loadintelhex_address_1_103
	mov	_loadintelhex_address_1_103,a
	mov	a,r3
	addc	a,(_loadintelhex_address_1_103 + 1)
	mov	(_loadintelhex_address_1_103 + 1),a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:379: type=getbyte();
	lcall	_getbyte
	mov	_loadintelhex_type_1_103,dpl
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:380: checksum+=type;
	mov	a,_loadintelhex_type_1_103
	add	a,_loadintelhex_checksum_1_103
	mov	_loadintelhex_checksum_1_103,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:382: for(j=0; j<size; j++)
	mov	_loadintelhex_j_1_103,#0x00
L021022?:
	clr	c
	mov	a,_loadintelhex_j_1_103
	subb	a,_loadintelhex_size_1_103
	jnc	L021025?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:384: n=getbyte();
	lcall	_getbyte
	mov	_loadintelhex_n_1_103,dpl
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:385: if(j<MAXBUFF) buff[j]=n; // Don't overrun the buffer
	mov	a,#0x100 - 0x40
	add	a,_loadintelhex_j_1_103
	jc	L021002?
	mov	a,_loadintelhex_j_1_103
	add	a,#_buff
	mov	r0,a
	mov	@r0,_loadintelhex_n_1_103
L021002?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:386: checksum+=n;
	mov	a,_loadintelhex_n_1_103
	add	a,_loadintelhex_checksum_1_103
	mov	_loadintelhex_checksum_1_103,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:382: for(j=0; j<size; j++)
	inc	_loadintelhex_j_1_103
	sjmp	L021022?
L021025?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:389: savedcs=getbyte();
	lcall	_getbyte
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:390: checksum+=savedcs;
	mov	a,dpl
	mov	r2,a
	add	a,_loadintelhex_checksum_1_103
	mov	_loadintelhex_checksum_1_103,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:391: if(size>MAXBUFF) checksum=1; // Force a checksum error
	mov	a,_loadintelhex_size_1_103
	add	a,#0xff - 0x40
	jnc	L021004?
	mov	_loadintelhex_checksum_1_103,#0x01
L021004?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:393: if(checksum==0) switch(type)
	mov	a,_loadintelhex_checksum_1_103
	jnz	L021012?
	mov	r2,_loadintelhex_type_1_103
	cjne	r2,#0x00,L021046?
	sjmp	L021006?
L021046?:
	cjne	r2,#0x01,L021047?
	sjmp	L021008?
L021047?:
	cjne	r2,#0x03,L021048?
	sjmp	L021007?
L021048?:
	cjne	r2,#0x04,L021009?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:396: EraseSector();
	lcall	_EraseSector
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:397: LEDRA_1=1; // Flash erased
	setb	_LEDRA_1
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:398: break;
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:400: case 0: // Write to flash command.
	sjmp	L021013?
L021006?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:401: FlashBuff(address, buff, j);
	mov	_FlashBuff_PARM_2,#_buff
	mov	(_FlashBuff_PARM_2 + 1),#0x00
	mov	(_FlashBuff_PARM_2 + 2),#0x40
	mov	_FlashBuff_PARM_3,_loadintelhex_j_1_103
	mov	dpl,_loadintelhex_address_1_103
	mov	dph,(_loadintelhex_address_1_103 + 1)
	lcall	_FlashBuff
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:415: break;
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:417: case 3: // Send ID number command.
	sjmp	L021013?
L021007?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:418: sends("DE1");
	mov	dptr,#__str_0
	mov	b,#0x80
	lcall	_sends
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:419: break;
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:421: case 1: // End record
	sjmp	L021013?
L021008?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:422: LEDRA_2=1; // Flash loaded
	setb	_LEDRA_2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:423: break;
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:425: default: // Unknown command;
	sjmp	L021013?
L021009?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:426: echo='?';
	mov	_loadintelhex_echo_1_103,#0x3F
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:427: LEDRA_2=1;
	setb	_LEDRA_2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:429: }
	sjmp	L021013?
L021012?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:432: echo='X'; // Checksum error
	mov	_loadintelhex_echo_1_103,#0x58
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:433: LEDRA_1=1;
	setb	_LEDRA_1
L021013?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:435: putchar(echo);
	mov	dpl,_loadintelhex_echo_1_103
	lcall	_putchar
	ljmp	L021020?
L021017?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:437: else if(n==(unsigned char)'U')
	mov	a,#0x55
	cjne	a,_loadintelhex_n_1_103,L021051?
	sjmp	L021052?
L021051?:
	ljmp	L021020?
L021052?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:439: LEDRA=0;
	mov	_LEDRA,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:440: LEDRB=0;
	mov	_LEDRB,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:441: LEDRA=1; // Bootloader running
	mov	_LEDRA,#0x01
	ljmp	L021020?
;------------------------------------------------------------
;Allocation info for local variables in function 'str2hex'
;------------------------------------------------------------
;s                         Allocated to registers r2 r3 r4 
;x                         Allocated to registers r5 r6 
;i                         Allocated to registers r7 
;sloc0                     Allocated with name '_str2hex_sloc0_1_0'
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:446: unsigned int str2hex (char * s)
;	-----------------------------------------
;	 function str2hex
;	-----------------------------------------
_str2hex:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:448: unsigned int x=0;
	mov	r5,#0x00
	mov	r6,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:450: while(*s)
L022013?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r7,a
	jnz	L022027?
	ljmp	L022015?
L022027?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:452: if((*s>='0')&&(*s<='9')) i=*s-'0';
	clr	c
	mov	a,r7
	xrl	a,#0x80
	subb	a,#0xb0
	jc	L022010?
	mov	a,#(0x39 ^ 0x80)
	mov	b,r7
	xrl	b,#0x80
	subb	a,b
	jc	L022010?
	mov	a,r7
	add	a,#0xd0
	mov	r7,a
	sjmp	L022011?
L022010?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:453: else if ( (*s>='A') && (*s<='F') ) i=*s-'A'+10;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r0,a
	clr	c
	xrl	a,#0x80
	subb	a,#0xc1
	jc	L022006?
	mov	a,#(0x46 ^ 0x80)
	mov	b,r0
	xrl	b,#0x80
	subb	a,b
	jc	L022006?
	mov	a,#0xC9
	add	a,r0
	mov	r7,a
	sjmp	L022011?
L022006?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:454: else if ( (*s>='a') && (*s<='f') ) i=*s-'a'+10;
	clr	c
	mov	a,r0
	xrl	a,#0x80
	subb	a,#0xe1
	jc	L022015?
	mov	a,#(0x66 ^ 0x80)
	mov	b,r0
	xrl	b,#0x80
	subb	a,b
	jc	L022015?
	mov	a,#0xA9
	add	a,r0
	mov	r7,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:455: else break;
L022011?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:456: x=(x*0x10)+i;
	mov	_str2hex_sloc0_1_0,r5
	mov	a,r6
	swap	a
	anl	a,#0xf0
	xch	a,_str2hex_sloc0_1_0
	swap	a
	xch	a,_str2hex_sloc0_1_0
	xrl	a,_str2hex_sloc0_1_0
	xch	a,_str2hex_sloc0_1_0
	anl	a,#0xf0
	xch	a,_str2hex_sloc0_1_0
	xrl	a,_str2hex_sloc0_1_0
	mov	(_str2hex_sloc0_1_0 + 1),a
	mov	r0,#0x00
	mov	a,r7
	add	a,_str2hex_sloc0_1_0
	mov	r5,a
	mov	a,r0
	addc	a,(_str2hex_sloc0_1_0 + 1)
	mov	r6,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:457: s++;
	inc	r2
	cjne	r2,#0x00,L022034?
	inc	r3
L022034?:
	ljmp	L022013?
L022015?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:459: return x;
	mov	dpl,r5
	mov	dph,r6
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'OutByte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:462: void OutByte (unsigned char x)
;	-----------------------------------------
;	 function OutByte
;	-----------------------------------------
_OutByte:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:464: putchar(hexval[x/0x10]);
	mov	a,dpl
	mov	r2,a
	swap	a
	anl	a,#0x0f
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	dpl,a
	push	ar2
	lcall	_putchar
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:465: putchar(hexval[x%0x10]);
	mov	a,#0x0F
	anl	a,r2
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	dpl,a
	ljmp	_putchar
;------------------------------------------------------------
;Allocation info for local variables in function 'OutWord'
;------------------------------------------------------------
;x                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:468: void OutWord (unsigned int x)
;	-----------------------------------------
;	 function OutWord
;	-----------------------------------------
_OutWord:
	mov	r2,dpl
	mov	r3,dph
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:470: OutByte(x/0x100);
	mov	ar4,r3
	mov	dpl,r4
	push	ar2
	push	ar3
	lcall	_OutByte
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:471: OutByte(x%0x100);
	mov	dpl,r2
	ljmp	_OutByte
;------------------------------------------------------------
;Allocation info for local variables in function 'Manual_Load'
;------------------------------------------------------------
;add                       Allocated to registers r2 r3 
;j                         Allocated to registers r4 r5 
;val                       Allocated to registers r4 
;h_add                     Allocated to registers r4 
;l_add                     Allocated to registers r5 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:477: void Manual_Load (void)
;	-----------------------------------------
;	 function Manual_Load
;	-----------------------------------------
_Manual_Load:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:483: Copy_Flash_to_RAM();
	lcall	_Copy_Flash_to_RAM
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:485: LEDRA=0;
	mov	_LEDRA,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:486: LEDRB=0;
	mov	_LEDRB,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:488: add=0;
	mov	r2,#0x00
	mov	r3,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:490: while(1)
L025034?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:493: h_add=add/0x100;
	mov	ar4,r3
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:494: l_add=add%0x100;
	mov	ar5,r2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:495: HEX5=seven_seg[h_add/0x10];
	mov	a,r4
	swap	a
	anl	a,#0x0f
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX5,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:496: HEX4=seven_seg[h_add%0x10];
	mov	a,#0x0F
	anl	a,r4
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX4,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:497: HEX3=seven_seg[l_add/0x10];
	mov	a,r5
	swap	a
	anl	a,#0x0f
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX3,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:498: HEX2=seven_seg[l_add%0x10];
	mov	a,#0x0F
	anl	a,r5
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX2,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:500: val=Read_XRAM(add);
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	_Read_XRAM
	mov	r4,dpl
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:501: HEX1=seven_seg[val/0x10];
	mov	a,r4
	swap	a
	anl	a,#0x0f
	mov	r5,a
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX1,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:502: HEX0=seven_seg[val%0x10];
	mov	a,#0x0F
	anl	a,r4
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX0,a
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:504: if(KEY_1==0)
	jnb	_KEY_1,L025058?
	ljmp	L025031?
L025058?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:506: while (KEY_1==0); // Wait for key release
L025001?:
	jnb	_KEY_1,L025001?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:507: if((SWB&0x03)==0x01) // Reading address low
	mov	a,#0x03
	anl	a,_SWB
	mov	r4,a
	cjne	r4,#0x01,L025013?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:509: add&=0x7f00;
	mov	r2,#0x00
	anl	ar3,#0x7F
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:510: add|=SWA;	
	mov	r4,_SWA
	mov	r5,#0x00
	mov	a,r4
	orl	ar2,a
	mov	a,r5
	orl	ar3,a
	ljmp	L025034?
L025013?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:512: else if((SWB&0x03)==0x02) // Reading address high
	mov	a,#0x03
	anl	a,_SWB
	mov	r4,a
	cjne	r4,#0x02,L025010?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:514: add&=0x00ff;
	mov	r3,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:515: add|=(SWA*0x100);	
	mov	r4,_SWA
	mov	ar5,r4
	clr	a
	mov	r4,a
	orl	ar2,a
	mov	a,r5
	orl	ar3,a
	ljmp	L025034?
L025010?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:517: else if ((SWB&0x03)==0x00) // Reading data
	mov	a,_SWB
	anl	a,#0x03
	jnz	L025007?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:519: val=SWA;
	mov	_Write_XRAM_PARM_2,_SWA
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:520: Write_XRAM(add, val);
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	_Write_XRAM
	pop	ar3
	pop	ar2
	ljmp	L025034?
L025007?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:522: else if((SWB&0x03)==0x03) //Save RAM to flash
	mov	a,#0x03
	anl	a,_SWB
	mov	r4,a
	cjne	r4,#0x03,L025066?
	sjmp	L025067?
L025066?:
	ljmp	L025034?
L025067?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:524: EraseSector();
	push	ar2
	push	ar3
	lcall	_EraseSector
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:525: LEDRA_1=1;
	setb	_LEDRA_1
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:526: for(j=0; j<0x8000; j+=PAGE_SIZE)
	mov	r4,#0x00
	mov	r5,#0x00
L025036?:
	mov	a,#0x100 - 0x80
	add	a,r5
	jc	L025039?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:528: FlashBuff(j, (unsigned char xdata *)j, PAGE_SIZE);
	mov	ar6,r4
	mov	ar7,r5
	mov	_FlashBuff_PARM_2,r6
	mov	(_FlashBuff_PARM_2 + 1),r7
	mov	(_FlashBuff_PARM_2 + 2),#0x00
	mov	_FlashBuff_PARM_3,#0x40
	mov	dpl,r4
	mov	dph,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_FlashBuff
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:526: for(j=0; j<0x8000; j+=PAGE_SIZE)
	mov	a,#0x40
	add	a,r4
	mov	r4,a
	clr	a
	addc	a,r5
	mov	r5,a
	sjmp	L025036?
L025039?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:530: LEDRA_2=1;
	setb	_LEDRA_2
	ljmp	L025034?
L025031?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:533: else if(KEY_3==0) // Increment address
	jb	_KEY_3,L025028?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:535: while(KEY_3==0); // Wait for key release
L025015?:
	jnb	_KEY_3,L025015?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:536: LEDRA_1=0;
	clr	_LEDRA_1
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:537: LEDRA_2=0;
	clr	_LEDRA_2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:538: add++;
	inc	r2
	cjne	r2,#0x00,L025071?
	inc	r3
L025071?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:539: if (add>0x7fff) add=0;
	clr	c
	mov	a,#0xFF
	subb	a,r2
	mov	a,#0x7F
	subb	a,r3
	jc	L025072?
	ljmp	L025034?
L025072?:
	mov	r2,#0x00
	mov	r3,#0x00
	ljmp	L025034?
L025028?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:541: else if (KEY_2==0) // Decrement address
	jnb	_KEY_2,L025073?
	ljmp	L025034?
L025073?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:543: while(KEY_2==0); // Wait for key release
L025020?:
	jnb	_KEY_2,L025020?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:544: LEDRA_1=0;
	clr	_LEDRA_1
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:545: LEDRA_2=0;
	clr	_LEDRA_2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:546: add--;
	dec	r2
	cjne	r2,#0xff,L025075?
	dec	r3
L025075?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:547: if (add>0x7fff) add=0x7fff;
	clr	c
	mov	a,#0xFF
	subb	a,r2
	mov	a,#0x7F
	subb	a,r3
	jc	L025076?
	ljmp	L025034?
L025076?:
	mov	r2,#0xFF
	mov	r3,#0x7F
	ljmp	L025034?
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;d                         Allocated to registers r2 
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:561: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:566: ASMI_ACC_GRANTED=0;  // Acquire the SPI bus
	clr	_ASMI_ACC_GRANTED
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:568: if( (KEY_1==1) && (KEY_2==1) && (KEY_3==1) ) Load_Ram_Fast_and_Run();
	jnb	_KEY_1,L026002?
	jnb	_KEY_2,L026002?
	jnb	_KEY_3,L026002?
	lcall	_Load_Ram_Fast_and_Run
L026002?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:570: if (KEY_3==0) // Run debugger?
	jb	_KEY_3,L026009?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:572: HEX5=LetterD;
	mov	_HEX5,#0xA1
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:573: HEX4=LetterE;
	mov	_HEX4,#0x86
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:574: HEX3=LetterB;
	mov	_HEX3,#0x83
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:575: HEX2=LetterU;
	mov	_HEX2,#0xC1
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:576: HEX1=LetterG;
	mov	_HEX1,#0xC2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:577: HEX0=LetterG;
	mov	_HEX0,#0xC2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:580: while(KEY_3==0);
L026005?:
	jnb	_KEY_3,L026005?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:582: HEX0=0xff;
	mov	_HEX0,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:583: HEX1=0xff;
	mov	_HEX1,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:584: HEX2=0xff;
	mov	_HEX2,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:585: HEX3=0xff;
	mov	_HEX3,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:586: HEX4=0xff;
	mov	_HEX4,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:587: HEX5=0xff;
	mov	_HEX5,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:589: Load_Ram_Fast_and_Run_Debugger();
	lcall	_Load_Ram_Fast_and_Run_Debugger
L026009?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:592: if (KEY_2==0) // Byte by Byte code loader
	jb	_KEY_2,L026014?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:594: HEX5=Dash;
	mov	_HEX5,#0xBF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:595: HEX4=Dash;
	mov	_HEX4,#0xBF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:596: HEX3=Dash;
	mov	_HEX3,#0xBF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:597: HEX2=Dash;
	mov	_HEX2,#0xBF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:598: HEX1=Dash;
	mov	_HEX1,#0xBF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:599: HEX0=Dash;
	mov	_HEX0,#0xBF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:601: while(KEY_2==0);
L026010?:
	jnb	_KEY_2,L026010?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:603: Manual_Load();
	lcall	_Manual_Load
L026014?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:606: XRAMUSEDAS=1; // 32k RAM accessed as xdata
	mov	_XRAMUSEDAS,#0x01
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:608: HEX3=LetterB;
	mov	_HEX3,#0x83
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:609: HEX2=LetterO;
	mov	_HEX2,#0xA3
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:610: HEX1=LetterO;
	mov	_HEX1,#0xA3
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:611: HEX0=LetterT;
	mov	_HEX0,#0x87
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:613: while(KEY_1==0); // Wait for key release
L026015?:
	jnb	_KEY_1,L026015?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:615: LEDRA=1;// Bootloader running
	mov	_LEDRA,#0x01
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:616: LEDRB=0;
	mov	_LEDRB,#0x00
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:618: HEX0=0xff;
	mov	_HEX0,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:619: HEX1=0xff;
	mov	_HEX1,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:620: HEX2=0xff;
	mov	_HEX2,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:621: HEX3=0xff;
	mov	_HEX3,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:622: HEX4=0xff;
	mov	_HEX4,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:623: HEX5=0xff;
	mov	_HEX5,#0xFF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:625: inituart();
	lcall	_inituart
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:629: Write_XRAM(MEMORY_KEY, 0x00);
	mov	_Write_XRAM_PARM_2,#0x00
	mov	dptr,#0x7FFF
	lcall	_Write_XRAM
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:632: while(1)
L026025?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:634: if (RI==1)
	jnb	_RI,L026021?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:636: d=SBUF;
	mov	r2,_SBUF
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:637: RI=0;
	clr	_RI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:638: if(d==(unsigned char)'U') break;
	cjne	r2,#0x55,L026060?
	sjmp	L026026?
L026060?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:639: TI=0; // Echo what was received
	clr	_TI
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:640: SBUF=d;
	mov	_SBUF,r2
L026021?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:643: if(Read_XRAM(MEMORY_KEY)!=0x00)
	mov	dptr,#0x7FFF
	lcall	_Read_XRAM
	mov	a,dpl
	jz	L026025?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:645: LEDRA_1=0;
	clr	_LEDRA_1
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:646: LEDRA_2=0;
	clr	_LEDRA_2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:647: Write_XRAM(MEMORY_KEY, 0x00);
	mov	_Write_XRAM_PARM_2,#0x00
	mov	dptr,#0x7FFF
	lcall	_Write_XRAM
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:648: EraseSector();
	lcall	_EraseSector
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:649: LEDRA_1=1;
	setb	_LEDRA_1
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:650: for(j=0; j<0x8000; j+=PAGE_SIZE)
	mov	r2,#0x00
	mov	r3,#0x00
L026027?:
	mov	a,#0x100 - 0x80
	add	a,r3
	jc	L026030?
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:652: FlashBuff(j, (unsigned char xdata *)j, PAGE_SIZE);
	mov	ar4,r2
	mov	ar5,r3
	mov	_FlashBuff_PARM_2,r4
	mov	(_FlashBuff_PARM_2 + 1),r5
	mov	(_FlashBuff_PARM_2 + 2),#0x00
	mov	_FlashBuff_PARM_3,#0x40
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	_FlashBuff
	pop	ar3
	pop	ar2
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:650: for(j=0; j<0x8000; j+=PAGE_SIZE)
	mov	a,#0x40
	add	a,r2
	mov	r2,a
	clr	a
	addc	a,r3
	mov	r3,a
	sjmp	L026027?
L026030?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:654: LEDRA_2=1;
	setb	_LEDRA_2
	sjmp	L026025?
L026026?:
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:658: loadintelhex();
	ljmp	_loadintelhex
;------------------------------------------------------------
;Allocation info for local variables in function 'dummy_switch'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:661: void dummy_switch(void) __naked
;	-----------------------------------------
;	 function dummy_switch
;	-----------------------------------------
_dummy_switch:
;	naked function: no prologue.
;	C:\Source\SOC_8052\Boot\CV_Boot_SPI.c:673: _endasm;
	
	  CSEG at 0xFFE0
	  mov _XRAMUSEDAS, #0x00 ; 32k RAM accessed as code
	  nop
	  ret
	
	  CSEG at 0xffE8
	  mov _XRAMUSEDAS, #0x01 ; 32k RAM accessed as xdata
	  nop
	  ret
	 
;	naked function: no epilogue.
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_hexval:
	db '0123456789ABCDEF'
	db 0x00
__str_0:
	db 'DE1'
	db 0x00
_seven_seg:
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
	db 0x88	; 136 
	db 0x83	; 131 
	db 0xc6	; 198 
	db 0xa1	; 161 	¡
	db 0x86	; 134 	†
	db 0x8e	; 142 	Ž

	CSEG

end
