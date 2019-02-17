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

// The bits used to access the SPI pins of the LTC2308
__sbit __at (0xF8) LTC2308_MISO; // Read only bit
__sbit __at (0xF9) LTC2308_MOSI; // Write only bit
__sbit __at (0xFA) LTC2308_SCLK; // Write only bit
__sbit __at (0xFB) LTC2308_EN_N; // Write only bit

unsigned char _c51_external_startup(void)
{
	setbaud_timer2(TIMER_2_RELOAD);
	
	LEDRA=0x00;
	LEDRB=0x00;
	
	// Default state for SPI pins.
	LTC2308_MOSI=0;
	LTC2308_SCLK=0;
	LTC2308_EN_N=1;

	return 0;
}

// Bit-bang communication with LTC2308.  Check Figure 8 in datasheet (page 17).
// Warning: we are reading the previously converted value!
unsigned int LTC2308RW (unsigned int x)
{
	unsigned char i=12;
	LTC2308_EN_N=0;
    do {
        LTC2308_MOSI = x & 0x800;
        LTC2308_SCLK = 1;
        x <<= 1;
        if(LTC2308_MISO) x += 1; 
        LTC2308_SCLK = 0;
    } while(--i);
    LTC2308_EN_N=1; // Start conversion for next reading
    return (x&0xfff);
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

	printf("CV-8052 test program for the LTC2308 in the DE1-SoC\r\n");
	
	while (1)
	{
	    // From page 10 of datasheet:
	    //     +--------------------- S/D=1 for single ended conversion
	    //     |+-------------------- O/S odd channel select
	    //     ||+------------------- S1
	    //     |||+------------------ S0
	    //     ||||+----------------- UNI=1 for unipolar output mode
	    //     |||||+---------------- SLP=0 for NAP mode
	    //     ||||||
	    //     ||||||
		val=0b_100010_000000;
		
		// Channel selection is a bit confusing.
		// So better follow table 1 in page 10.
		switch (SWA & 0b_111) // Select channel using the switches
		{
			case 0: val|=0b_0_000_00000000; break;
			case 1: val|=0b_0_100_00000000; break;
			case 2: val|=0b_0_001_00000000; break;
			case 3: val|=0b_0_101_00000000; break;
			case 4: val|=0b_0_010_00000000; break;
			case 5: val|=0b_0_110_00000000; break;
			case 6: val|=0b_0_011_00000000; break;
			case 7: val|=0b_0_111_00000000; break;
		}
		val=LTC2308RW(val);
		v=val/1000.0; // faster version of v=(val*4.096)/4096.0;
		printf("val[%d]=0x%04x, V=%5.3f\r", SWA & 0b_111, val, v);
		DisplayFloat(v);
		HEX5=SevenSeg[SWA & 0b_111]; // Display the channel number
		MyDelay(500);
	}
}
