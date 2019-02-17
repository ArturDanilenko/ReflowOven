/*
**  spiflash.C - SPI flash access using bitbang SPI
*/

//  ~C51~  

#include<stdio.h>
#include<stdlib.h>
#include <DE2_8052.h>

#define CLK 33333333L
#define BAUD 115200L
#define TIMER_2_RELOAD (0x10000L-(CLK/(32L*BAUD)))
#define LOW(X)  (X%0x100)
#define HIGH(X) (X/0x100)

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

unsigned char DoSPI_OLD (unsigned char value)
{
    unsigned char mask=0x80, result=0;

    MY_MISO=1; // Make MY_MISO pin input
    MY_SCLK=MY_POL;
    while (mask)
    {
        MY_MOSI=(value & mask)?1:0;
        MY_SCLK=!(MY_POL ^ MY_PHA);
        if (MY_MISO) result|=mask;
        MY_SCLK=(MY_POL ^ MY_PHA);
        mask/=2;
    }
    MY_SCLK=MY_POL;
    return result;
}

unsigned char DoSPI (unsigned char value)
{
	value;
	_asm
		mov a, dpl
		clr _MY_SCLK
		
		SPIBIT MAC
			rlc a
			mov _MY_MOSI, c
			setb _MY_SCLK
			mov c, _MY_MISO
			clr _MY_SCLK
			mov acc.0, c
		ENDMAC
		
		SPIBIT()
		SPIBIT()
		SPIBIT()
		SPIBIT()
		SPIBIT()
		SPIBIT()
		SPIBIT()
		SPIBIT()
	
		mov dpl, a
		ret
	_endasm;

    return 0;
}

void Display_Sector (unsigned char sector, unsigned int num)
{
	unsigned int j;
	unsigned char val;
	
	printf("%03d: ", sector);
    // Read some bytes and display them
    MY_CE=0;
    DoSPI(READ_BYTES);
    DoSPI(sector); //Some sector should have something
    DoSPI(0x00);
    DoSPI(0x00);
    for(j=0; j<num; j++)
    {
    	val=DoSPI(0x55);
    	printf("%02x ", val);
    }
    MY_CE=1;
    printf("\n");
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

void Erase_Sector (unsigned char sector)
{
    MY_CE=0;
	DoSPI(WRITE_ENABLE);
    MY_CE=1;
    
    MY_CE=0;
	DoSPI(ERASE_SECTOR);
    DoSPI(sector);
    DoSPI(0x00);
    DoSPI(0x00);
    MY_CE=1;
    
    Check_WIP();
}

void main (void)
{
	unsigned char Silicon_ID, sector;
	unsigned int j;
	
	LEDRA=0;
	LEDRB=0;
	LEDRC=0;
	LEDG=0;
	
	ASMI_ACC_GRANTED=0;  // Take over the SPI bus
	
	RCAP2H=HIGH(TIMER_2_RELOAD);
	RCAP2L=LOW(TIMER_2_RELOAD);
	T2CON=0b00110100;
	SCON=0x52; // Serial port in mode 1, ren, txrdy, rxempty

	printf("S25FL064P Test Program\n");

	// Read silicon ID
    MY_CE=0;
    DoSPI(READ_SILICON_ID);
    DoSPI(0x55);
    DoSPI(0x55);
    DoSPI(0x55);
    Silicon_ID=DoSPI(0x55);
    MY_CE=1;
    printf("Silicon ID: %02x\n", Silicon_ID);
    
    for(sector=25; sector<32; sector++)
    {
    	Display_Sector(sector, 16);
    }
    
    sector=30;
    
    printf("Erase Sector Command\n");
    Erase_Sector(sector);
  
	Display_Sector(sector, 16);

    MY_CE=0; DoSPI(WRITE_ENABLE);  MY_CE=1;
    printf("Write Bytes Command\n");
    MY_CE=0;
	DoSPI(WRITE_BYTES);
    DoSPI(sector);
    DoSPI(0x00);
    DoSPI(0x00);
    for(j=0; j<256; j++) DoSPI(j);
    MY_CE=1;
  
    Check_WIP();

	Display_Sector(sector, 16);
    printf("Test ended.\n");
    
    ASMI_ACC_GRANTED=1; // Release the SPI bus
}
