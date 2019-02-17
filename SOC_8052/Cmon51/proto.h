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

void putc (unsigned char c);
void unassemble (unsigned int address);
void dostep (void);
void loadintelhex (void);
void putnl (void);
void erasesector (unsigned int address);
void FlashByte (unsigned int address, unsigned char value);
void outbyte(unsigned char x);
void restorePC (void);
unsigned char read_sfr (unsigned char x);
void putsp(unsigned char * x);
unsigned char chartohex(char c);
void outbyte(unsigned char x);
void putnl(void);
void outword(unsigned int x);
unsigned char hitanykey(void);
unsigned char getbytene (void);
void do_cmd (void);
void write_sfr (unsigned char loc, unsigned char val);
void fillmem(unsigned char * begin,  unsigned int len, unsigned char val);

void get_txbuff (void);
void add_cursor_txbuff (void);
void add_nlcursor_txbuff(void);
void add_char_txbuff (char c);
void add_byte_txbuff (unsigned char c);
void add_word_txbuff (unsigned int w);
void add_wordnl_txbuff (unsigned int w);
void add_str_txbuff (unsigned char * s);
void flush_txbuff (void);
void update_txbuff (void);
