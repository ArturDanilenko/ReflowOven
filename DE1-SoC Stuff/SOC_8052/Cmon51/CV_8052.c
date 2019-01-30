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

//This file covers the specifics of the softcore DE1-8052 and DE2-8052 microcontrollers
//with separated XRAM and CODE memory

#include <CV_8052.h>
#include "proto.h"

//The step and break interrupt can be anywhere by setting the DEBUG_CALL_L and DEBUG_CALL_H sfrs

extern volatile xdata unsigned int  PC_save;
volatile unsigned int pos;
volatile bit append_txbuff=0;
extern const char hexval[];

extern volatile unsigned char xdata __at (0x8000) rxcount;
extern volatile unsigned char xdata __at (0x8001) rxbuff[254];
extern volatile unsigned char xdata __at (0x8100) txcount;
extern volatile unsigned char xdata __at (0x8101) txbuff[254];

//These are the Special Function Register names for the
//plain DE2_8052 microcontroller
code unsigned char sfrn[] =
    "\200" "P0"      \/*80*/
    "\201" "SP"      \/*81*/
    "\202" "DPL"     \/*82*/
    "\203" "DPH"     \/*83*/
    "\207" "PCON"    \/*87*/
    "\210" "TCON"    \/*88*/
    "\211" "TMOD"    \/*89*/
    "\212" "TL0"     \/*8A*/
    "\213" "TL1"     \/*8B*/
    "\214" "TH0"     \/*8C*/
    "\215" "TH1"     \/*8D*/
    "\216" "HEX4"    \/*8E*/
    "\217" "HEX5"    \/*8F*/
    "\220" "P1"      \/*90*/
    "\221" "HEX0"    \/*91*/
    "\222" "HEX1"    \/*92*/
    "\223" "HEX2"    \/*93*/
    "\224" "HEX3"    \/*94*/
    "\225" "LEDRB"   \/*95*/
    "\225" "SWB"     \/*95*/
    "\226" "HEX6"    \/*96*/
    "\227" "HEX7"    \/*97*/
    "\230" "SCON"    \/*98*/
    "\231" "SBUF"    \/*99*/
    "\232" "P0MOD"   \/*9A*/
    "\233" "P1MOD"   \/*9B*/
    "\234" "P2MOD"   \/*9C*/
    "\235" "P3MOD"   \/*9D*/
    "\240" "P2"      \/*A0*/
    "\250" "IE"      \/*A8*/
    "\260" "P3"      \/*B0*/
    "\270" "IP"      \/*B8*/
    "\310" "T2CON"   \/*C8*/
    "\311" "T2MOD"   \/*C9*/
    "\312" "RCAP2L"  \/*CA*/
    "\313" "RCAP2H"  \/*CB*/
    "\314" "TL2"     \/*CC*/
    "\315" "TH2"     \/*CD*/
    "\320" "PSW"     \/*D0*/
    "\330" "LCDCMD"  \/*D8*/
    "\331" "LCDDATA" \/*D9*/
    "\332" "LCDMOD"  \/*DA*/
    "\340" "ACC"     \/*E0*/
    "\340" "A"       \/*E0 for dissasembly "ACC" will be used instead */
	"\350" "LEDRA"   \/*E8*/
	"\350" "SWA"     \/*E8*/
    "\360" "B"       \/*F0*/
    "\370" "KEY"     \/*F8*/
    "\200" "\000" /*The end of the list*/
;

//These are the bit names...
code unsigned char bitn[] =
    "\210" "IT0"     \/*88*/ 
    "\211" "IE0"     \/*89*/ 
    "\212" "IT1"     \/*8A*/ 
    "\213" "IE1"     \/*8B*/ 
    "\214" "TR0"     \/*8C*/ 
    "\215" "TF0"     \/*8D*/ 
    "\216" "TR1"     \/*8E*/ 
    "\217" "TF1"     \/*8F*/ 
    "\230" "RI"      \/*98*/ 
    "\231" "TI"      \/*99*/ 
    "\232" "RB8"     \/*9A*/ 
    "\233" "TB8"     \/*9B*/ 
    "\234" "REN"     \/*9C*/ 
    "\250" "EX0"     \/*A8*/ 
    "\251" "ET0"     \/*A9*/ 
    "\252" "EX1"     \/*AA*/ 
    "\253" "ET1"     \/*AB*/ 
    "\254" "ES"      \/*AC*/ 
    "\255" "ET2"     \/*AD*/ 
    "\257" "EA"      \/*AF*/ 
    "\270" "PX0"     \/*B8*/ 
    "\271" "PT0"     \/*B9*/ 
    "\272" "PX1"     \/*BA*/ 
    "\273" "PT1"     \/*BB*/ 
    "\274" "PS"      \/*BC*/ 
    "\275" "PT2"     \/*BD*/ 
    "\320" "P"       \/*D0*/ 
    "\321" "F1"      \/*D1*/ 
    "\322" "OV"      \/*D2*/ 
    "\323" "RS0"     \/*D3*/ 
    "\324" "RS1"     \/*D4*/ 
    "\325" "F0"      \/*D5*/ 
    "\326" "AC"      \/*D6*/ 
    "\327" "CY"      \/*D7*/ 
    "\310" "CPRL2"   \/*C8*/ 
    "\311" "CT2"     \/*C9*/ 
    "\312" "TR2"     \/*CA*/ 
    "\313" "EXEN2"   \/*CB*/ 
    "\314" "TCLK"    \/*CC*/ 
    "\315" "RCLK"    \/*CD*/ 
    "\316" "EXF2"    \/*CE*/ 
    "\317" "TF2"     \/*CF*/ 
    "\330" "LCDRW"   \/*D8*/ 
    "\331" "LCDEN"   \/*D9*/ 
    "\332" "LCDRS"   \/*DA*/ 
    "\333" "LCDON"   \/*DB*/ 
    "\334" "LCDBLON" \/*DC*/ 
    "\377" "\000"/*The end of the list*/
;

void main (void)
{
	_asm
		ljmp _do_cmd
	_endasm; //All the work is done in cmon51.c
}

unsigned char _c51_external_startup(void)
{
	// Set the vector for the debug callback function
	_asm
		mov	_DEBUG_CALL_L,#(_step_and_break)
		mov	_DEBUG_CALL_H,#(_step_and_break >> 8)
		;lcall _R_DINIT_start ; Initialize data/idata variables
	_endasm;
	
	return 0;
}

char getchar(void)
{
	volatile unsigned char c, j;

	while(rxcount==0); // Wait for data to arrive
	c=rxbuff[0];
	for(j=1; rxbuff[j]!=0; j++) rxbuff[j-1]=rxbuff[j];
	rxbuff[j-1]=0;
	rxcount--;
	
	return c;
}

void putc (unsigned char c)
{
	while(txcount!=0);
	txbuff[0]=c;
	txbuff[1]=0;
	txcount=2;	
}

void putnl (void)
{
	while(txcount!=0);
	txbuff[0]='\r';
	txbuff[1]='\n';
	txbuff[2]=0;
	txcount=3;	
}

void get_txbuff (void)
{
	if(append_txbuff==1) return;
	while(txcount!=0);
	pos=0;
}

void add_nlcursor_txbuff (void)
{
	txbuff[pos++]='\r';
	txbuff[pos++]='\n';
	txbuff[pos++]='>';
	txbuff[pos++]=' ';
}

void add_char_txbuff (char c)
{
	txbuff[pos++]=c;
}

void add_cursor_txbuff (void)
{
	txbuff[pos++]='>';
	txbuff[pos++]=' ';
}

void add_byte_txbuff (unsigned char c)
{
	txbuff[pos++]=hexval[c/0x10];
	txbuff[pos++]=hexval[c&0x0f];
}

void add_word_txbuff (unsigned int w)
{
	add_byte_txbuff(w/0x100);
	add_byte_txbuff(w%0x100);
}

void add_wordnl_txbuff (unsigned int w)
{
	add_byte_txbuff(w/0x100);
	add_byte_txbuff(w%0x100);
	add_char_txbuff('\r');
	add_char_txbuff('\n');
}


void add_str_txbuff (unsigned char * s)
{
	while(*s!=0)
	{
		txbuff[pos++]=*s;
		s++;
	}
}

void flush_txbuff (void)
{
	if(append_txbuff==1) return;
	if(pos>0)
	{
		txbuff[pos++]=0;
		txcount=(pos<0x100)?pos:0xff;
		pos=0;
		while(txcount!=0);
	}
}

void update_txbuff (void)
{
	bit saved_append_txbuff;
	
	if(pos>8191) 
	{
		saved_append_txbuff=append_txbuff;
		append_txbuff=0;
		flush_txbuff();
		append_txbuff=saved_append_txbuff;
	}
}

unsigned char read_sfr (unsigned char loc)
{
	REP_VALUE=loc; // Byte to replace with
    _asm
		mov	_REP_ADD_L,#(_asm_read_sfr+4)
		mov	_REP_ADD_H,#((_asm_read_sfr+4) >> 8)
		orl _XRAMUSEDAS, #00000010B ; Enable byte replacement at the given address
	_asm_read_sfr:
		read_sfr_0xff data 0xff ; To avoid warning
    	nop ; Account for delay
    	nop
    	nop
		mov dpl, read_sfr_0xff
		anl _XRAMUSEDAS, #not(00000010B) ; Disable byte replacement at the given address
		ret
    _endasm;

	return 0; //Dummy return. DPL has the value
}

void write_sfr (unsigned char loc, unsigned char val)
{
	REP_VALUE=loc;
	DPL= val;
    _asm
		mov	_REP_ADD_L,#(_asm_write_sfr+5)
		mov	_REP_ADD_H,#((_asm_write_sfr+5) >> 8)
		orl _XRAMUSEDAS, #00000010B
    _asm_write_sfr:
    	nop
    	nop
    	nop
		mov 0xff, dpl
		anl _XRAMUSEDAS, #not(00000010B)
		ret
    _endasm;
}

void restorePC (void)
{
	PC_save=0;
}
