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

#define BANNER "\n\nCMON51 V2.0\nCopyRight (c) 2005-2015 Jesus Calvino-Fraga\n" \
                   "Port: CV_8052 V1.0\n> "

#define EQ(A,B) !strcmp((A),(B))
#define	lowof(x) (x%0x100)
#define highof(x) (x/0x100)

typedef enum cmd_is {
	ID_display_data,
	ID_modify_data,
	ID_fill_data,
	ID_display_idata,
	ID_modify_idata,
	ID_fill_idata,
	ID_display_xdata,
	ID_modify_xdata,
	ID_fill_xdata,
	ID_display_code,
	ID_unassemble,
	ID_go,
	ID_step,
	ID_registers,
	ID_load,
	ID_reg_dptr,
	ID_reg_pc,
	ID_trace,
	ID_reg_r0,
	ID_reg_r1,
	ID_reg_r2,
	ID_reg_r3,
	ID_reg_r4,
	ID_reg_r5,
	ID_reg_r6,
	ID_reg_r7,
	ID_trace_reg,
	ID_go_breaks,
	ID_brl,
	ID_brc,
	ID_br2,
	ID_br3,
	ID_broff,
	ID_bron,
	ID_pcr,
	ID_LEDG,
	ID_LEDRA,
	ID_LEDRB,
	ID_LEDRC,
	ID_KEY,
	ID_SWA,
	ID_SWB,
	ID_SWC,
	ID_BANK,
	ID_modify_code,
	ID_fill_code,
	ID_nothing,
	ID_invalid_cmd
};

code unsigned char cmdlst[] = 
"\200"    "D"
"\201"    "MD"
"\202"    "FD"
"\203"    "I"
"\204"    "MI"
"\205"    "FI"
"\206"    "X"
"\207"    "MX"
"\210"    "FX"
"\211"    "C"
"\212"    "U"
"\213"    "G"
"\214"    "S"
"\215"    "R"
"\216"    "L"
"\217"    "DPTR"
"\220"    "PC"
"\221"    "T"
"\222"    "R0"
"\223"    "R1"
"\224"    "R2"
"\225"    "R3"
"\226"    "R4"
"\227"    "R5"
"\230"    "R6"
"\231"    "R7"
"\232"    "TR"
"\233"    "GB"
"\234"    "BRL"
"\235"    "BRC"
"\236"    "BR2"
"\237"    "BR3"
"\240"    "BROFF"
"\241"    "BRON"
"\242"    "PCR"
"\243"    "LEDG"
"\244"    "LEDRA"
"\245"    "LEDRB"
"\246"    "LEDRC"
"\247"    "KEY"
"\250"    "SWA"
"\251"    "SWB"
"\252"    "SWC"
"\253"    "BANK"
"\254"    "MC"
"\255"    "FC"
"\256"    ""
"\257"    "\000"/*The end of the list*/
;

