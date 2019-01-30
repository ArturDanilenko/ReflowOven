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

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <CV_8052.h>
#include "cmon51.h"
#include "proto.h"

volatile unsigned char xdata __at (0x8000) rxcount;
volatile unsigned char xdata __at (0x8001) rxbuff[254];
volatile unsigned char xdata __at (0x8100) txcount;
volatile unsigned char xdata __at (0x8101) txbuff[254];

//crt0 initializes all these variables to zero...
volatile xdata char iram_save[128];
volatile xdata unsigned int  br[4];
volatile xdata unsigned char A_save;
volatile xdata unsigned char PSW_save;
volatile xdata unsigned char B_save;
volatile xdata unsigned char IE_save;
volatile xdata unsigned int  DPL_save;
volatile xdata unsigned int  DPH_save;
volatile xdata unsigned char SP_save;
volatile xdata unsigned char LEDRA_save;
volatile xdata unsigned char LEDRB_save;
volatile xdata unsigned int  PC_save;
volatile xdata unsigned char gotbreak;
volatile xdata unsigned int  step_start;
volatile xdata unsigned char saved_jmp[3];
volatile xdata unsigned char saved_int[3];
volatile xdata unsigned char gostep;
volatile xdata unsigned int  break_address;
volatile xdata unsigned char trace_type;
volatile xdata unsigned char go_pending;

#define BUFFSIZE 0x20
char buff[BUFFSIZE];
unsigned char cursor;
const char hexval[]="0123456789ABCDEF";
const unsigned char maskbit[]={0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};

bit validbyte, keepediting, buff_haseq, buff_hasdot, breakpoint;

extern unsigned int discnt;
extern code unsigned char sfrn[];
extern code unsigned char bitn[];

const char nba[]="Not bit-addressable!\n> ";
const char cnr[]="Can't read!\n> ";
const char cnw[]="Can't write!\n> ";

extern volatile bit append_txbuff;
extern volatile unsigned int pos;

//Similar to puts() but without \n at the end
void putsp(unsigned char * x)
{
	unsigned int j;
	
	j=0;
	while(txcount!=0);
	while( ((*x)>0) && ((*x)<0x80) )
	{
		if(*x==(unsigned char)'\n') txbuff[j]='\r';
		txbuff[j]=*x;
		x++;
		j++;
	}
	txbuff[j]=0;
	txcount=(j<0x100)?j:0xff;
}

void clearline (void)
{
	unsigned char j;
	while(txcount!=0);
	txbuff[0]='\r';
	for(j=1; j<80; j++) txbuff[j]=' ';
	txbuff[j]='\r';
	txbuff[j+1]=0;
	txcount=j;
}

void getsn (void)
{
	unsigned char j;
	
	while(rxcount==0); // Wait for data to arrive
	for(j=0; j<rxcount; j++)
	{
		if(j<(BUFFSIZE-1))
		{
			buff[j]=rxbuff[j];
		}
		else
		{
			break;
		}
	}
	buff[j]=0;
	rxcount=0;
}

unsigned char chartohex(char c)
{
	unsigned char i;
	i=toupper(c)-'0';
	if(i>9) i-=7; //letter from A to F
	return i;
}

void outbytenl(unsigned char x)
{
	get_txbuff();
	add_byte_txbuff(x);
	add_nlcursor_txbuff();
	flush_txbuff();
}

void outcursor(void)
{
	get_txbuff();
	add_cursor_txbuff();
	flush_txbuff();
}

void outwordnl (unsigned int val)
{
	get_txbuff();
	add_word_txbuff(val);
	add_nlcursor_txbuff();
	flush_txbuff();
}

void putcnl(char c)
{
	get_txbuff();
	add_char_txbuff(c);
	add_nlcursor_txbuff();
	flush_txbuff();
}

//Fill a block of memory with a value
void fillmem(unsigned char * begin,  unsigned int len, unsigned char val)
{
	while(len)
	{
		*begin=val;
		begin++;
		len--;
	}
}

//A very simple memory editor
void modifymem(unsigned char * ptr,  char loc)
{
	unsigned char j;
	
	get_txbuff();
	while(1)
	{
		add_char_txbuff(loc);
		add_char_txbuff(':');

    	if((loc=='D')||(loc=='I'))
    		add_byte_txbuff((unsigned char)ptr);
    	else
    		add_word_txbuff((unsigned int)ptr);

		add_str_txbuff("=  ");
		flush_txbuff();
		
		// Receive something and check if it is hex
		while(rxcount==0);
		if( (!isxdigit(rxbuff[0])) || (!isxdigit(rxbuff[1])) )
		{
			if (rxbuff[0]=='\'')
			{
				for(j=1; (rxbuff[j]!=0) && (rxbuff[j]!='\''); j++) (*ptr++)=rxbuff[j];
			}
			else if (toupper(rxbuff[0])!='S')
			{
				rxcount=0;
				break; // get out of while(1) loop
			}
			else ptr++;
		}
		else
		{
			for(j=0; j<rxcount; j+=3)
			{
				if( (isxdigit(rxbuff[j])) && (isxdigit(rxbuff[j+1])) )
				{
					(*ptr++)=chartohex(rxbuff[j])*0x10+chartohex(rxbuff[j+1]);
				}
			}
		}
		rxcount=0;
	}
	add_nlcursor_txbuff();
 	flush_txbuff();
}

//Display the content of memory
void dispmem(unsigned char * begin,  unsigned int len, char loc)
{
	unsigned int j;
	unsigned char n, i, k=0;

	get_txbuff();
		
	if(len==0) len=0x80;
	
	buff[16]=0;
	
	for(j=0; j<len; j++)
	{
		if(loc=='I')
		{
			n=*(idata unsigned char *)((unsigned char)begin+j);
		}
		else
		{
			n=begin[j];
		}
		i=j&0xf;
		
		if(i==0) 
		{
			add_char_txbuff(loc);  //A letter to indicate Data, Xram, Code, Idata
			add_char_txbuff(':');
        	if((loc=='D')||(loc=='I'))
        		add_byte_txbuff((unsigned char)begin+j);
        	else
        		add_word_txbuff((unsigned int)begin+j);
			add_str_txbuff(":  ");
		}
		add_byte_txbuff(n);
		add_char_txbuff(i==7?'-':' '); //A middle separator like the old good DOS debug

		if((n>0x20)&&(n<0x7f))
			buff[i]=n;
		else
			buff[i]='.';
		
		if(i==0xf)
		{
			add_str_txbuff("   ");
			add_str_txbuff(buff);
			add_char_txbuff('\r');
			add_char_txbuff('\n');
			update_txbuff();
		}
 	}
	add_nlcursor_txbuff();
 	flush_txbuff();
}

//Preproccess the terminal input buffer
void cleanbuff (void)
{
	unsigned char j, k;
	
	buff_haseq=0;
	buff_hasdot=0;
	
	//Uppercase the string and change spaces with zeros
	for(j=0; j<BUFFSIZE; j++)
	{
		buff[j]=toupper(buff[j]);
		if(isspace(buff[j])) buff[j]=0;
		if(buff[j]=='=')
		{
			buff[j]=0;
			buff_haseq=1;
		}
		else if((buff[j]=='.')||(buff[j]=='_'))
		{
			buff[j]=0;
			buff_hasdot=1;
		}
	}
	
	//Remove any leading and double zeros
	for(j=0, k=0; j<BUFFSIZE; j++)
	{
		buff[k]=buff[j];
		if( ((buff[j]!=0)||(buff[j+1]!=0)) && buff[0]!=0) k++;
	}
	for(; k<BUFFSIZE; k++) buff[k]=0;
}

//Get a word (two bytes) from the input buffer.
unsigned int getwordn(void)
{
	unsigned int word=0;
	
	for( ; buff[cursor]!=0; cursor++)
	{
		if(isxdigit(buff[cursor]))
			word=(word*0x10)+chartohex(buff[cursor]);
	}
	cursor++;
	return word;
}

void add_byte_buff(unsigned char val, unsigned char loc)
{
	txbuff[loc]=  hexval[val/0x10];
	txbuff[loc+1]=hexval[val&0x0f];
}

const char regframe[]=
//0         1         2         3         4         5         6       
//0123456789012345678901234567890123456789012345678901234567890123456789
 "A =xx  B =xx  SP=xx  IE=xx  DPH=xx DPL=xx PSW=xx PC=xxxx\r\n"
//5 6         7         8         9         1         0       
//89012345678901234567890123456789012345678901234567890123456789
 "R0=xx  R1=xx  R2=xx  R3=xx  R4=xx  R5=xx  R6=xx  R7=xx  BANK=x\r\n";

void disp_regs(void)
{
	unsigned char j, bank;
	
	get_txbuff();
	add_str_txbuff(regframe);

	add_byte_buff(A_save,   3);
	add_byte_buff(B_save,   10);
	add_byte_buff(SP_save,  17);
	add_byte_buff(IE_save,  24);
	add_byte_buff(DPH_save, 32);
	add_byte_buff(DPL_save, 39);
	add_byte_buff(PSW_save, 46);
	add_byte_buff((PC_save/0x100), 52);
	add_byte_buff((PC_save%0x100), 54);
	
	bank=(PSW_save/0x8)&0x3;
	for(j=0; j<8; j++)
	{
		add_byte_buff(iram_save[j+bank*8], 58+3+(7*j));
	}
	txbuff[58+61]=('0'+bank);

	append_txbuff=1;
	discnt=1;
	unassemble(PC_save); //The next assembly instruction...
	append_txbuff=0;
	add_nlcursor_txbuff();
	flush_txbuff();
}

unsigned char nlist (unsigned char * slist)
{
	unsigned char x=0xff, q;
	
	while(*slist)
	{
		if((*slist)>0x7f)
		{
			x=*(slist++);
			for(q=0; (*slist<=0x7f) && (*slist==(unsigned char)buff[q]) ; q++) slist++;
			if((*slist>0x7f)&&(buff[q]==0)) break;
		}
		slist++;
	}
	if(*slist) return x;//Found one!
	return 0xff; //What if a sfr is located at 0xff?
}

void breakorstep (void)
{
	unsigned char n;
	
	gotbreak=0;
	breakpoint=0;
	
	if(go_pending==0x55)
	{
		go_pending=0xaa;
    	step_start=PC_save; //Next instruction to be executed
    	gotbreak=0; //If changes to 1, the single step function worked!
    	gostep=1;
    	dostep();
	}
	go_pending=0xaa;	
	
	if (trace_type)
	{
		if(trace_type==1) //Run in trace mode until a breapoint is hit
		{
    		for (n=0; n<4; n++)
    		{
    			if(br[n]==PC_save)
    			{
    				breakpoint=1;
    			}
    		}
		}
		if ((break_address!=PC_save))
		{
	    	if (trace_type>=2)
	    	{
				discnt=1;
	    		unassemble(step_start); //The executed assembly instruction...
	    	}
	    	if((JRXRDY==0)&&(breakpoint==0))
	    	{
		    	if(trace_type==3) disp_regs();
		    	step_start=PC_save;
	        	dostep();
	        }
        }
	}
	if((trace_type>=2) && (RI==0))
	{
    	discnt=1;
    	unassemble(step_start); //The executed assembly instruction...
	}

	disp_regs();
}

void do_cmd (void)
{
    unsigned int i, j;
    unsigned int n, p, q;
    unsigned char c, d, x, y;
	volatile unsigned char cmd;
	bit p_bit;
	
	append_txbuff=0;

	if (gotbreak!=1) //Power-on reset
	{
		txcount=0;
	    putsp(BANNER);
		SP_save=7; //Default user stack location
		LEDRA_save=0xff;
		LEDRB_save=0xff;
		restorePC();
		cmd=0;
    }
    else breakorstep(); //Got here from the beak/step interrupt
       
	while(1)
    {
        fillmem(buff, BUFFSIZE, 0);;
        getsn();
        cleanbuff();
        break_address=0;
        trace_type=0;
        
        //Some commands require these values, so in order to save some space:
        cursor=0;
        getwordn();   //skip the command name
        n=getwordn(); //n is the first parameter/number
        p=getwordn(); //p is the second parameter/number
        q=getwordn(); //q is the third parameter/number
        i=n&0xfff0;
        j=(p+15)&0xfff0;
        c=n; // Sometimes for the first parameter we need an unsigned char
        p_bit=(p==0?0:1);
        
	    cmd=nlist(cmdlst)&0x7f;

	    switch(cmd)
	    {
	    	case ID_nothing:
	    		break;
	    		
	    	case ID_display_data:
	    		dispmem(iram_save, 0, 'D');
	    		break;
	    		
			case ID_modify_data:
	        	modifymem(&iram_save[n&0x7f], 'D');
	        	break;
	        	
	        case ID_fill_data:
				fillmem(&iram_save[n&0x7f], (p>0x80)?0x80:p, (unsigned char) q);
	        	break;
	        	
	        case ID_display_idata:
	        	dispmem((unsigned char data *)(0x80), 0, 'I');
	        	break;
	        	
	        case ID_modify_idata:
	        	modifymem((unsigned char data *)((n&0x7f)|0x80), 'I');
	        	break;
	        	
	        case ID_fill_idata:
				fillmem((unsigned char data *)((n&0x7f)|0x80), p>0x80?0x80:p, (unsigned char) q);
	        	break;
	        	
	        case ID_display_xdata:
	        	dispmem((unsigned char xdata *)i, j, 'X');
	        	break;
	        	
	        case ID_modify_xdata:
	        	modifymem((unsigned char xdata *)n, 'X');
	        	break;
	        	
	        case ID_fill_xdata:
				fillmem((unsigned char xdata *)n, p, (unsigned char)q);
	        	break;
	        	
	        case ID_display_code:
	        	dispmem((unsigned char code *)i, j, 'C');
	        	break;
	        
	        case ID_modify_code:
	        	XRAMUSEDAS=0x01; // 32k RAM accessed as xdata
	        	modifymem((unsigned char xdata *)n, 'C');
	        	XRAMUSEDAS=0x00; // 32k RAM accessed as code
	        	break;

	        case ID_fill_code:
	        	XRAMUSEDAS=0x01; // 32k RAM accessed as xdata
				fillmem((unsigned char xdata *)n, p, (unsigned char)q);
	        	XRAMUSEDAS=0x00; // 32k RAM accessed as code
	        	break;
	        	
	        case ID_unassemble:
	        	discnt=p;
	        	append_txbuff=1;
				unassemble(n);
				append_txbuff=0;
				add_nlcursor_txbuff();
				flush_txbuff();
	        	break;

	        case ID_trace_reg:
	        	trace_type++;
	        	
	        case ID_trace:
	        	trace_type++;
	        	if(n==0) break;
	        	break_address=n;
 	        	n=0;
 	        			
			case ID_go_breaks:
	        	trace_type++;
	        	step_start=(n==0)?PC_save:n; //Next instruction to be executed
	        	gotbreak=0; //If changes to 1, the single step function worked!
	        	gostep=0;
	        	dostep();
 	        	       
	        case ID_go:
	        	go_pending=0x55;
	        case ID_step:
	        	step_start=(n==0)?PC_save:n; //Next instruction to be executed
	        	gotbreak=0; //If changes to 1, the single step function worked!
	        	gostep=0;
	        	dostep();
	        	break;

	        case ID_registers:
		        disp_regs();
	        	break;
	        	
	        case ID_load:
	        	//loadintelhex();
	        	break;
	        	
	        case ID_reg_dptr:
	        	if(buff_haseq)
	        	{
	        		DPL_save=c;
	        		DPH_save=highof(n);
					outcursor();
	        	}
	        	else outwordnl((DPH_save*0x100)+DPL_save);
	        	break;
			
	        case ID_reg_pc:
	        	if(buff_haseq)
	        	{
	        		PC_save=n;
					outcursor();
	        	}
	        	else outwordnl(PC_save);
	        	break;
	        	
	        case ID_reg_r0:
	        case ID_reg_r1:
	        case ID_reg_r2:
	        case ID_reg_r3:
	        case ID_reg_r4:
	        case ID_reg_r5:
	        case ID_reg_r6:
	        case ID_reg_r7:
	        	d=(PSW_save&0x18)+buff[1]-'0';
	        	if(buff_haseq)
	        	{
					iram_save[d]=c;
					outcursor();
	        	}
	        	else
	        	{
	        		outbytenl(iram_save[d]);
	        	}
	        	break;
	        	
	        case ID_brl:
				// List all breakpoints
				get_txbuff();
				BPC=0x40;
				for(n=0; n<0x8000; n++)
				{
					BPAH=n/0x100;
					BPAL=n%0x100;
					_asm
					nop
					_endasm; //We need to clock-in the value before reading it
					if(BPS&0x01)
					{
						add_wordnl_txbuff(n);
					}
				}
				BPC=0x00;
				// Very important: set BPA to an unused memory address
				BPAL=0xff;
				BPAH=0xff;
				add_cursor_txbuff();
				flush_txbuff();
				break;
			
			case ID_brc:
				// Disable all breakpoints
				BPC=0x02;
				for(n=0; n<0x8000; n++)
				{
					BPAH=n/0x100;
					BPAL=n%0x100;
				}
				BPAL=0xff;
				BPC=0x00;
				// Very important: set BPA to an unused memory address
				BPAL=0xff;
				BPAH=0xff;
				outcursor();
				break;
			
			case ID_br2:
	        case ID_br3:
	        	d=buff[2]-'0';
	        	if(buff_haseq) br[d]=n;
	        	else outwordnl(br[d]);
	        	break;
	        	
	        case ID_broff:
				// Select the write address
				BPAL=n%0x100;
				BPAH=n/0x100;
				// Disable breakpoint at that address
				BPC=0x00;
				BPC=0x02;
				BPC=0x00;
				// Very important: set BPA to an unused memory address
				BPAL=0xff;
				BPAH=0xff;
				outcursor();
			  	break;
	        	
	        case ID_bron:
				// Select the write address
				BPAL=n%0x100;
				BPAH=n/0x100;
				// Enable breakpoint at that address
				BPC=0x01;
				BPC=0x03;
				BPC=0x01;
				// Very important: set BPA to an unused memory address
				BPAL=0xff;
				BPAH=0xff;
				outcursor();
	        	break;

	        case ID_pcr:  //Restore the PC
	        	restorePC();
				outcursor();
	        	break;
	        	
	        case ID_LEDRA:
	        	if(buff_haseq)
	        	{
	        		if(buff_hasdot)
	        		{
	        			if     (c==0) LEDRA_0=p_bit;
	        			else if(c==1) LEDRA_1=p_bit;
	        			else if(c==2) LEDRA_2=p_bit;
	        			else if(c==3) LEDRA_3=p_bit;
	        			else if(c==4) LEDRA_4=p_bit;
	        			else if(c==5) LEDRA_5=p_bit;
	        			else if(c==6) LEDRA_6=p_bit;
	        			else if(c==7) LEDRA_7=p_bit;
	        		}
	        		else
	        		{
	        			LEDRA=c;
	        		}
					outcursor();
	        	}
	        	else putsp(cnr);
	        break;
	        
	        case ID_LEDRB:
	        	if(buff_haseq)
	        	{
	        		if(buff_hasdot)
	        		{
	        			putsp(nba);
	        		}
	        		else
	        		{
	        			LEDRB=c;
						outcursor();
	        		}
	        	}
	        	else putsp(cnr);
	        break;

		    case ID_KEY:
	        case ID_SWA:
	        	if(buff_haseq==0)
	        	{
	        		if(buff_hasdot)
	        		{
	        			if(cmd==ID_SWA)
	        			{
		       				if     (c==0) p_bit=SWA_0;
		       				else if(c==1) p_bit=SWA_1;
		       				else if(c==2) p_bit=SWA_2;
		       				else if(c==3) p_bit=SWA_3;
		       				else if(c==4) p_bit=SWA_4;
		       				else if(c==5) p_bit=SWA_5;
		       				else if(c==6) p_bit=SWA_6;
		       				else if(c==7) p_bit=SWA_7;
	       				}
	       				else
	       				{
	       				    if     (c==0) p_bit=KEY_0;
	        				else if(c==1) p_bit=KEY_1;
	        				else if(c==2) p_bit=KEY_2;
	        				else if(c==3) p_bit=KEY_3;
	        			}
	       				putcnl(p_bit?'1':'0');
	        		}
	        		else
	        		{
	        			outbytenl(cmd==ID_SWA?SWA:KEY);
	        		}
	        	}
	        	else putsp(cnw);
	        break;

	        case ID_SWB:
	           	if(buff_haseq==0)
	        	{
	        		if(buff_hasdot)
	        		{
						putsp(nba);
						break;
	        		}
	        		else
	        		{
	        			outbytenl(SWB);
	        		}
	        	}
	        	else putsp(cnw);
	        break;

	        case ID_BANK:
	        	if(buff_haseq)
	        	{
	        		PSW_save&=0b_1110_0111;
	        		switch(c&3)
	        		{
	        			case 0:
	        			break;
	        			case 1:
	        				PSW_save|=0b_0000_1000;
	        			break;
	        			case 2:
	        				PSW_save|=0b_0001_0000;
	        			break;
	        			case 3:
	        				PSW_save|=0b_0001_1000;
	        			break;
	        		}
	        		outcursor();
				}
	        	else
	        	{
	        		outbytenl((PSW_save/0x8)&0x3);
	        	}
	        break;
	        
	        default:
		        //Search the table of sfr and bit names for predefined values
	        	y=nlist(bitn); //Search for bit names first
	        	if (y!=0xff)
	        	{
	        		x=y&0xf8;
	        		y=maskbit[y&0x7];
	        	}
	        	else
	        	{
	        		x=nlist(sfrn); //Is not a bit, try a sfr
	        	   	if(buff_hasdot)
	        		{
	        			y=maskbit[c&0x7];
	        			c=p;
	        		}
	        	}

	        	if(x!=0xff)
	        	{
	    			//Some registers are used by the monitor
					/**/ if (x==0xd0) d=PSW_save;
	        		else if (x==0xe0) d=A_save;
	        		else if (x==0xf0) d=B_save;
	        		else if (x==0xa8) d=IE_save;
	        		else if (x==0x81) d=SP_save;
	        		else if (x==0x82) d=DPL_save;
	        		else if (x==0x83) d=DPH_save;
	        		else d=read_sfr(x);
	        		
	        		//In case of bits use 'y' as the mask
	        		if(y!=0xff)
	        		{
	        			if(c) c=d|y;
	        			else c=d&(~y);
	        		}
	        		
	        		//Perform the actual read or write operation
	        		if(buff_haseq)
	        		{
	        			/**/ if (x==0xd0) PSW_save=c;
	        			else if (x==0xe0) A_save=c;
	        			else if (x==0xf0) B_save=c;
	        			else if (x==0xa8) IE_save=c;
	        			else if (x==0x81) SP_save=c;
	        			else if (x==0x82) DPL_save=c;
	        			else if (x==0x83) DPH_save=c;
	        			else write_sfr(x, c);
	        			outcursor();
	        		}
	        		else
	        		{
		     			if(y==0xff)
		     				outbytenl(d);
		     			else
		     			{
		     				putcnl((d&y)?'1':'0');
		     			}
		     		}
	        	}
			    else putsp("What?\n> ");
	        break;
		}
	}
}

