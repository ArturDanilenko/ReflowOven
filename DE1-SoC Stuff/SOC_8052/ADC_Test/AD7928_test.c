/***************************************************************************/
// ~C51~

#include <stdio.h>
#include<stdlib.h>
#include <CV_8052.h>

#define CLK 33333333L
#define BAUD 115200L
#define TIMER_2_RELOAD (0x10000L-(CLK/(32L*BAUD)))
#define TIMER_0_1ms (0x10000L-(CLK/(12L*1000L)))
#define LOW(X)  (X%0x100)
#define HIGH(X) (X/0x100)

// The bits used to access the SPI pins of the AD7928
__sbit __at (0xF8) AD7928_MISO; // Read only bit
__sbit __at (0xF9) AD7928_MOSI; // Write only bit
__sbit __at (0xFA) AD7928_SCLK; // Write only bit
__sbit __at (0xFB) AD7928_EN_N; // Write only bit

unsigned char _c51_external_startup(void)
{
	setbaud_timer2(TIMER_2_RELOAD);
	
	LEDRA=0x00;
	LEDRB=0x00;
	
	// Default state for SPI pins.
	AD7928_MOSI=0;
	AD7928_SCLK=1;
	AD7928_EN_N=1;

	return 0;
}

// Bit-bang communication with AD7928.  Check Figure 28 in datasheet (page 25).
unsigned int AD7928RW (unsigned int x)
{
	unsigned char i=16;
	AD7928_EN_N=0;
    do {
        AD7928_MOSI = x & 0x8000;
        AD7928_SCLK = 0;
        x <<= 1;
        if(AD7928_MISO) x += 1; 
        AD7928_SCLK = 1;
    } while(--i);
    AD7928_EN_N=1;
    return ((x>>1)&0xfff);
}

const unsigned char SevenSeg[]= {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};

void DisplayFloat (float v)
{
	char buff[6];
	sprintf(buff, "%5.3f", v);
	HEX3=SevenSeg[buff[0]-'0'];
	HEX2=SevenSeg[buff[2]-'0'];
	HEX1=SevenSeg[buff[3]-'0'];
	HEX0=SevenSeg[buff[4]-'0'];
}

void Wait1ms (void)
{
	TR0=0;
	TMOD=(TMOD &0xf0)|0x01; // Timer 0: GATE=0, C/T*=0, M1=0, M0=1: 16-bit timer
	TH0=HIGH(TIMER_0_1ms);
	TL0=LOW(TIMER_0_1ms);
	TF0=0;
	TR0=1;
	while(TF0==0);
	TR0=0;
}

void MyDelay (unsigned int msec)
{
	do {
		Wait1ms();
	} while (--msec);
}

void main(void)
{
	unsigned int val=0;
	float v;
	
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.

	printf("CV-8052 test program for the AD7928 in the DE1-SoC\r\n");
	
	while (1)
	{
	    // From table 7 of datasheet, page 15:
	    //     +--------------------- WRITE=1
	    //     |+-------------------- SEQ. 0 for standard operation.
	    //     ||  +----------------- Channel to read (000 for channel 0, 001 for channel 1, etc.)
	    //     ||  |   +------------- PM1, PM0 (11 for normal operation)
	    //     ||  |   | +----------- SHADOW. 0 for standard operation.
	    //     ||  |   | |  +-------- RANGE.  0 for 0V to Vref*2.  Vref in the DE1-SoC is 2.5V.
	    //     ||  |   | |  |+------- CODING. 1 for straight binary.
	    //     ||  ( ) ()|  ||
		val=0b_100_000_110_001_0000;
		
		val|=((SWA & 0b_111) << 10); // Select channel using the switches
		val=AD7928RW(val);
		v=(val*5.0)/4095.0;
		printf("val[%d]=0x%04x, V=%5.3f\r", SWA & 0b_111, val, v);
		DisplayFloat(v);
		HEX5=SevenSeg[SWA & 0b_111]; // Display the channel number
		MyDelay(500);
	}
}
