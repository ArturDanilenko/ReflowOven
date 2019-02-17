#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MEMSIZE 0x10000
#define TRUE 1
#define FALSE 0

unsigned char FlashBuff[MEMSIZE];
int BuffLoaded=FALSE;

int hex2dec (char hex_digit)
{
   int j;
   j=toupper(hex_digit)-'0';
   if (j>9) j -= 7;
   return j;
}

unsigned char GetByte(char * buffer)
{
    return hex2dec(buffer[0])*0x10+hex2dec(buffer[1]);
}

unsigned short GetWord(char * buffer)
{
    return  hex2dec(buffer[0])*0x1000+
            hex2dec(buffer[1])*0x100+
            hex2dec(buffer[2])*0x10+
            hex2dec(buffer[3]);
}

void WriteHexFile (char * filename, int total)
{
    int j, k;
    unsigned char chk_sum;
    FILE * outfile;
    int tocomp;
    char buffer[1024];
    #define NUMBYTES 128

    if ( (outfile=fopen(filename, "w")) == NULL )
    {
        printf(buffer, "ERROR: Can't create hexadecimal outfile file `%s`.\n", filename);
        return;
    }
    tocomp=total/100;

    for (j=0; j<total; j++)
    {
        if(j%NUMBYTES==0)
        {
            if (j!=0) fprintf(outfile, "%02X\n", (unsigned char)(0x100-chk_sum));
            k=((total-j)>NUMBYTES) ? NUMBYTES : (total-j);
            fprintf(outfile,":%02X%04X00", k, j);
            chk_sum= (unsigned char) (k + (j%0x100) + (j/0x100));
        }
        fprintf(outfile,"%02X", (unsigned char) FlashBuff[j]);
        chk_sum += (unsigned char) FlashBuff[j];
    }
    fprintf(outfile,"%02X\n", (unsigned char)(0x100-chk_sum));
    fprintf(outfile,":00000001FF\n");
    fclose(outfile);
    printf("Saving completed (0x%04x bytes).\n", total);
}

long filesize(FILE *stream)
{
   long curpos, length;

   curpos = ftell(stream);
   fseek(stream, 0L, SEEK_END);
   length = ftell(stream);
   fseek(stream, curpos, SEEK_SET);
   return length;
}

int ReadBinFile(char * filename)
{
    FILE * filein;
    int numbytes, numread, j;
    char buff[1024];
    
    printf(buff, "Loading `%s`...\n", filename);
    
    if ( (filein=fopen(filename, "rb")) == NULL )
    {
       printf(buff, "Error: Can't open file `%s`.\n", filename);
       return 0;
    }
    numbytes=filesize(filein);
    if(numbytes>MEMSIZE) numbytes=MEMSIZE;
    for(j=0; j<MEMSIZE; j++) FlashBuff[j]=0xff;
    numread = fread (FlashBuff, 1, numbytes, filein);
    fclose(filein);
    
    printf(buff, "Bin load completed: 0x%04x bytes.\n", numbytes);

    BuffLoaded=TRUE;

    return numread;
}

int ReadHexFile(char * filename)
{
    char buffer[1024];
    FILE * filein;
    int j, numbytes;
    unsigned char linesize, recordtype, rchksum, value;
    unsigned short address;
    int MaxAddress=0;
    int chksum;
    int line_counter=0;
    int tocomp, barcount=0, numread=0;

    printf( "Loading `%s`...\n", filename);

    if ( (filein=fopen(filename, "r")) == NULL )
    {
       printf( "Error: Can't open file `%s`.\n", filename);
       return 0;
    }
    
    numbytes=filesize(filein);
    tocomp=numbytes/100;
    for(j=0; j<MEMSIZE; j++) FlashBuff[j]=0xff;

    while(fgets(buffer, sizeof(buffer), filein)!=NULL)
    {
        numread+=(strlen(buffer)+1);
        if(numread>(barcount*tocomp))
        {
            barcount++;
        }
        
        line_counter++;
        if(buffer[0]==':')
        {
            linesize = GetByte(&buffer[1]);
            address = GetWord(&buffer[3]);
            recordtype = GetByte(&buffer[7]);
            rchksum = GetByte(&buffer[9]+(linesize*2));
            chksum=linesize+(address/0x100)+(address%0x100)+recordtype+rchksum;

            if (recordtype==1) break; /*End of record*/

            for(j=0; j<linesize; j++)
            {
                value=GetByte(&buffer[9]+(j*2));
                chksum+=value;
                if((address+j)<MEMSIZE) FlashBuff[address+j]=value;
            }
            if(MaxAddress<(address+linesize-1)) MaxAddress=(address+linesize-1);

            if((chksum%0x100)!=0)
            {
                printf( "ERROR: Bad checksum in file at line %d\n", line_counter);
                return -1;
            }
        }
    }
    fclose(filein);
    printf("Hex load completed: 0x%04x bytes.\n", MaxAddress);

    BuffLoaded=TRUE;

    return MaxAddress;
}

int main(int argc, char **argv)
{
    int NumBytes, j;
    if(argc!=3)
    {
        printf("Usage: %s input output\n", argv[0]);
        return -1;
    }
    for(j=0; j<0x10000; j++) FlashBuff[j]=0xff;
    NumBytes=ReadHexFile(argv[1]);
    if(BuffLoaded)
    {
        WriteHexFile (argv[2], (NumBytes+128)&0xff80);
    }
    return 0;
}
