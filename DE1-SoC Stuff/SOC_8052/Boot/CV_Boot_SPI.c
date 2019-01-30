/*  CV-8052 bootloader using SPI configuration flash

	Copyright (C) 2009-2018  Jesus Calvino-Fraga, jesusc (at) ece.ubc.ca
	   
	This program is free software; you can redistribute it and/or modify it
	under the terms of the GNU General Public License as published by the
	Free Software Foundation; either version 2, or (at your option) any
	later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

//  ~C51~  --code-loc 0xf000

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <CV_8052.h>

#define MEMORY_KEY 0x7fff
#define PAGE_SIZE 64

#define EQ(A,B) !strcmp((A),(B))

#define FLASHSECTOR 0xf8  // This one seems available

code unsigned char hexval[] = "0123456789ABCDEF";

#define CLK 33333333L
#define BAUD 115200L
#define TIMER_2_RELOAD (0x10000L-(CLK/(32L*BAUD)))
#define LOW(X)  (X%0x100)
#define HIGH(X) (X/0x100)

#define MAXBUFF 64
idata unsigned char buff[MAXBUFF];
bit getchar_echo=0;

#define MY_POL   0
#define MY_PHA   0

#define WRITE_ENABLE     0b0000_0110  // Address:0 Dummy:0 Num:0 fMax: 25MHz
#define WRITE_DISABLE    0b0000_0100  // Address:0 Dummy:0 Num:0 fMax: 25MHz
#define READ_STATUS      0b0000_0101  // Address:0 Dummy:0 Num:1 to infinite fMax: 32MHz
#define READ_BYTES       0b0000_0011  // Address:3 Dummy:0 Num:1 to infinite fMax: 20MHz
#define READ_SILICON_ID  0b1010_1011  // Address:0 Dummy:3 Num:1 to infinite fMax: 32MHz
#define FAST_READ        0b0000_1011  // Address:3 Dummy:1 Num:1 to infinite fMax: 40MHz
#define WRITE_STATUS     0b0000_0001  // Address:0 Dummy:0 Num:1 fMax: 25MHz
#define WRITE_BYTES      0b0000_0010  // Address:3 Dummy:0 Num:1 to 256 fMax: 25MHz
#define ERASE_BULK       0b1100_0111  // Address:0 Dummy:0 Num:0 fMax: 25MHz
#define ERASE_SECTOR     0b1101_1000  // Address:3 Dummy:0 Num:0 fMax: 25MHz
#define READ_DEVICE_ID   0b1001_1111  // Address:0 Dummy:2 Num:1 to infinite fMax: 25MHz

__sbit __at (0xDF) MY_MOSI;
__sbit __at (0xDF) MY_MISO;
__sbit __at (0xDE) MY_SCLK;
__sbit __at (0xDD) MY_CE;
__sbit __at (0xDC) ASMI_ACC_GRANTED; // Set to '0' to be the SPI master
__sbit __at (0xDE) ASMI_ACC_REQUEST; // Somebody wants to be the master if '1'

unsigned char DoSPI (unsigned char value)
{
	value;
	_asm
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
	_endasm;

    return 0;
}

void Check_WIP (void)
{
	unsigned char status;
	
    MY_CE=0;
    DoSPI(READ_STATUS);
	do {
    	status=DoSPI(0x55);
    } while (status&0b0000_0001); // Check the Write in Progress bit
    MY_CE=1;
}

void inituart (void)
{
	RCAP2H=HIGH(TIMER_2_RELOAD);
	RCAP2L=LOW(TIMER_2_RELOAD);
	T2CON=0x34; // #00110100B
	SCON=0x52; // Serial port in mode 1, ren, txrdy, rxempty
}

void putchar (char c)
{
	if (c=='\n')
	{
		while (!TI);
		TI=0;
		SBUF='\r';
	}
	while (!TI);
	TI=0;
	SBUF=c;
}

char getchar (void)
{
	char c;
	
	while (!RI);
	RI=0;
	c=SBUF;
	if (getchar_echo==1) putchar(c);

	return c;
}

char getchare (void)
{
	char c;
	
	c=getchar();
	putchar(c);
	return c;
}

void sends (unsigned char * c)
{
	unsigned char n;
	while(n=*c)
	{
		putchar(n);
		c++;
	}
}

unsigned char chartohex(char c)
{
	if(c & 0x40) c+=9; //  a to f or A to F
	return (c & 0xf);
}

// Get a byte from the serial port without echo
unsigned char getbyte (void)
{
	volatile unsigned char j; // volatile variable eliminates some push/pop instrutions

	j=chartohex(getchare())*0x10;
	j|=chartohex(getchare());

	return j;
}

unsigned char In_Byte_Flash (unsigned int address)
{
	unsigned char j;
	
    MY_CE=0;
    DoSPI(READ_BYTES);
    DoSPI(FLASHSECTOR);
    DoSPI(address/0x100);
    DoSPI(address%0x100);
    j=DoSPI(0x55);
    MY_CE=1;
    
	return j;
}

void EraseSector (void)
{
    MY_CE=0; DoSPI(WRITE_ENABLE); MY_CE=1;
    
    MY_CE=0;
	DoSPI(ERASE_SECTOR);
    DoSPI(FLASHSECTOR);
    DoSPI(0x00);
    DoSPI(0x00);
    MY_CE=1;
    
    Check_WIP();
}

void Write_XRAM (unsigned int Address, unsigned char Value)
{
	*((unsigned char xdata *) Address)=Value;
}

unsigned char Read_XRAM (unsigned int Address)
{
	return *((unsigned char xdata *) Address);
}

void FlashByte (unsigned int address, unsigned char val)
{
    MY_CE=0; DoSPI(WRITE_ENABLE);  MY_CE=1;
    
    MY_CE=0;
	DoSPI(WRITE_BYTES);
    DoSPI(FLASHSECTOR);
    DoSPI(address/0x100);
    DoSPI(address%0x100);
    DoSPI(val);
    MY_CE=1;
  
    Check_WIP();
}

// It takes about the same time to flash a byte or a page of 256 bytes!
void FlashBuff (unsigned int address, unsigned char * buff, unsigned char numb)
{
	unsigned char j;
	
    MY_CE=0; DoSPI(WRITE_ENABLE);  MY_CE=1;
    MY_CE=0;
	DoSPI(WRITE_BYTES);
    DoSPI(FLASHSECTOR);
    DoSPI(address/0x100);
    DoSPI(address%0x100);
    for(j=0; j<numb; j++) DoSPI(buff[j]);
    MY_CE=1;

    Check_WIP();
}

void Copy_Flash_to_RAM (void)
{
	XRAMUSEDAS=0x01; // 32k RAM accessed as xdata
	
    MY_CE=0;
    DoSPI(READ_BYTES);
    DoSPI(FLASHSECTOR);
    DoSPI(0);
    DoSPI(0);
    
    // In Assembly for speed sake
    _asm
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
    _endasm;
    
    MY_CE=1;
}

void Load_Ram_Fast_and_Run (void)
{
	Copy_Flash_to_RAM();
	ASMI_ACC_GRANTED=1;  // Release the SPI bus
	T2CON=0;
	SCON=0;
	RCAP2H=0;
	RCAP2L=0;

	_asm
		mov _XRAMUSEDAS, #0 ; 32k RAM accessed as code
		; RAM is loaded with user code.  Run it.
		mov sp, #7
		ljmp 0x0000
	_endasm;
}

void Load_Ram_Fast_and_Run_Debugger (void)
{
	Copy_Flash_to_RAM();
	ASMI_ACC_GRANTED=1;  // Release the SPI bus
	T2CON=0;
	SCON=0;
	RCAP2H=0;
	RCAP2L=0;
	LEDRA=0xff;
	LEDRB=0xff;

	_asm
		mov _XRAMUSEDAS, #0 ; 32k RAM accessed as code
		mov sp, #7

		; RAM is loaded with user code.  Run the debugger now.
		ljmp 0xc000
	_endasm;
}

void loadintelhex (void)
{
	volatile unsigned int address;
	volatile unsigned char j, size, type, checksum, n;
	volatile char echo;
	unsigned char savedcs;

	while(1)
	{
		n=getchare();

		if(n==(unsigned char)':')
		{
			echo='.'; // If everything works ok, send a period...
			size=getbyte();
			checksum=size;
			
			address=getbyte();
			checksum+=address;
			address*=0x100;
			n=getbyte();
			checksum+=n;
			address+=n;
			
			type=getbyte();
			checksum+=type;

			for(j=0; j<size; j++)
			{
				n=getbyte();
				if(j<MAXBUFF) buff[j]=n; // Don't overrun the buffer
				checksum+=n;
			}
			
			savedcs=getbyte();
			checksum+=savedcs;
			if(size>MAXBUFF) checksum=1; // Force a checksum error
	
			if(checksum==0) switch(type)
			{
				case 4: // Erase command.
					EraseSector();
					LEDRA_1=1; // Flash erased
				break;

				case 0: // Write to flash command.
					FlashBuff(address, buff, j);

					//  One byte at a time with verify
					/* for(j=0; j<size; j++)
					{
						FlashByte(address, buff[j]);
						if (In_Byte_Flash(address)!=buff[j]) // Verify last write.
						{
							echo='!';
							LEDRA_0=1;
						}
						address++;
					}
					*/
				break;
				
				case 3: // Send ID number command.
					sends("DE1");
				break;
				
				case 1: // End record
					LEDRA_2=1; // Flash loaded
				break;
				
				default: // Unknown command;
					echo='?';
					LEDRA_2=1;
				break;
			}
			else
			{
				echo='X'; // Checksum error
				LEDRA_1=1;
			}
			putchar(echo);
		}
		else if(n==(unsigned char)'U')
		{
			LEDRA=0;
			LEDRB=0;
			LEDRA=1; // Bootloader running
		}
	}
}

unsigned int str2hex (char * s)
{
	unsigned int x=0;
	unsigned char i;
	while(*s)
	{
		if((*s>='0')&&(*s<='9')) i=*s-'0';
		else if ( (*s>='A') && (*s<='F') ) i=*s-'A'+10;
		else if ( (*s>='a') && (*s<='f') ) i=*s-'a'+10;
		else break;
		x=(x*0x10)+i;
		s++;
	}
	return x;
}

void OutByte (unsigned char x)
{
	putchar(hexval[x/0x10]);
	putchar(hexval[x%0x10]);
}

void OutWord (unsigned int x)
{
	OutByte(x/0x100);
	OutByte(x%0x100);
}

code unsigned char seven_seg[] = { 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8,
                                   0x80, 0x90, 0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E };

void Manual_Load (void)
{
	unsigned int add, j;
	unsigned char val, h_add, l_add;
	
	// Load RAM with the program in flash for manual edition
	Copy_Flash_to_RAM();

	LEDRA=0;
	LEDRB=0;
 	
	add=0;
	
	while(1)
	{
		// Display address
		h_add=add/0x100;
		l_add=add%0x100;
		HEX5=seven_seg[h_add/0x10];
		HEX4=seven_seg[h_add%0x10];
		HEX3=seven_seg[l_add/0x10];
		HEX2=seven_seg[l_add%0x10];
		// Display the data at the address above
		val=Read_XRAM(add);
		HEX1=seven_seg[val/0x10];
		HEX0=seven_seg[val%0x10];

		if(KEY_1==0)
		{
			while (KEY_1==0); // Wait for key release
			if((SWB&0x03)==0x01) // Reading address low
			{
				add&=0x7f00;
				add|=SWA;	
			}
			else if((SWB&0x03)==0x02) // Reading address high
			{
				add&=0x00ff;
				add|=(SWA*0x100);	
			}
			else if ((SWB&0x03)==0x00) // Reading data
			{
				val=SWA;
				Write_XRAM(add, val);
			}
			else if((SWB&0x03)==0x03) //Save RAM to flash
			{
				EraseSector();
				LEDRA_1=1;
				for(j=0; j<0x8000; j+=PAGE_SIZE)
				{
					FlashBuff(j, (unsigned char xdata *)j, PAGE_SIZE);
				}
				LEDRA_2=1;
			}
		}
		else if(KEY_3==0) // Increment address
		{
			while(KEY_3==0); // Wait for key release
			LEDRA_1=0;
			LEDRA_2=0;
			add++;
			if (add>0x7fff) add=0;
		}
		else if (KEY_2==0) // Decrement address
		{
			while(KEY_2==0); // Wait for key release
			LEDRA_1=0;
			LEDRA_2=0;
			add--;
			if (add>0x7fff) add=0x7fff;
		}
	}
}

#define LetterD 0xA1
#define LetterE 0x86
#define LetterB 0x83
#define LetterU 0xC1
#define LetterG 0xC2
#define LetterO 0b_1010_0011
#define LetterT 0b_1000_0111
#define Dash    0b_1011_1111

void main (void)
{
	unsigned char d;
	unsigned int j;
	
	ASMI_ACC_GRANTED=0;  // Acquire the SPI bus

	if( (KEY_1==1) && (KEY_2==1) && (KEY_3==1) ) Load_Ram_Fast_and_Run();

	if (KEY_3==0) // Run debugger?
	{
		HEX5=LetterD;
		HEX4=LetterE;
		HEX3=LetterB;
		HEX2=LetterU;
		HEX1=LetterG;
		HEX0=LetterG;
		
		// Wait for the activation keys release
		while(KEY_3==0);

		HEX0=0xff;
		HEX1=0xff;
		HEX2=0xff;
		HEX3=0xff;
		HEX4=0xff;
		HEX5=0xff;

		Load_Ram_Fast_and_Run_Debugger();
	}

	if (KEY_2==0) // Byte by Byte code loader
	{
		HEX5=Dash;
		HEX4=Dash;
		HEX3=Dash;
		HEX2=Dash;
		HEX1=Dash;
		HEX0=Dash;
		
		while(KEY_2==0);
		
		Manual_Load();
	}
	
	XRAMUSEDAS=1; // 32k RAM accessed as xdata

	HEX3=LetterB;
	HEX2=LetterO;
	HEX1=LetterO;
	HEX0=LetterT;
	
	while(KEY_1==0); // Wait for key release
	
	LEDRA=1;// Bootloader running
	LEDRB=0;
 
	HEX0=0xff;
	HEX1=0xff;
	HEX2=0xff;
	HEX3=0xff;
	HEX4=0xff;
	HEX5=0xff;

	inituart();
	
	// Set the memory key to zero.  If it is changed using the memory editor,
	// then copy whatever is in xram to flash.
	Write_XRAM(MEMORY_KEY, 0x00);
	
	//Determine which mode is being used for communication
	while(1)
	{
		if (RI==1)
		{
			d=SBUF;
			RI=0;
			if(d==(unsigned char)'U') break;
			TI=0; // Echo what was received
			SBUF=d;
		}
		
		if(Read_XRAM(MEMORY_KEY)!=0x00)
		{
			LEDRA_1=0;
			LEDRA_2=0;
			Write_XRAM(MEMORY_KEY, 0x00);
			EraseSector();
			LEDRA_1=1;
			for(j=0; j<0x8000; j+=PAGE_SIZE)
			{
				FlashBuff(j, (unsigned char xdata *)j, PAGE_SIZE);
			}
			LEDRA_2=1;
		}
	}

	loadintelhex();
}

void dummy_switch(void) __naked
{
	_asm
		CSEG at 0xFFE0
		mov _XRAMUSEDAS, #0x00 ; 32k RAM accessed as code
		nop
		ret
		
		CSEG at 0xffE8
		mov _XRAMUSEDAS, #0x01 ; 32k RAM accessed as xdata
		nop
		ret
	_endasm;
}
