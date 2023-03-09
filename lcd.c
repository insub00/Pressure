#include "hwdefine.h"

void LcdCommandWrite(unsigned char Data)
{
	Delay(200);
	LcdRsLow();
    LcdDataBus(Data);
		
	LcdEHigh();
	LcdELow();
	Delay(200);
}

void LcdDataWrite(unsigned char Data)
{
	Delay(50);
	LcdRsHigh();
	LcdDataBus(Data);

	LcdEHigh();
	LcdELow();
}

void LcdInit(void)
{
	Delay(5000);

	LcdRwLow();
    LcdELow();
	
	Delay(5000);
    LcdCommandWrite(FUNCSET);
	Delay(5000);
	LcdCommandWrite(DISPON);
	Delay(5000);
	LcdCommandWrite(ALLCLR);
	LcdCommandWrite(ENTMODE);

	Delay(5000);
}

void LineDecision(unsigned char x, unsigned char y)
{
	switch(y){
		case 0:
			LcdCommandWrite(LINE1 + x);
			break;
            
		case 1:
			LcdCommandWrite(LINE2 + x);
			break;                     
            
		case 2:
			LcdCommandWrite(LINE3 + x);
			break;
            
    	default:
		case 3:
			LcdCommandWrite(LINE4 + x);
			break;				
	}
}

void LcdString(unsigned char *str)
{
	while(*str)
    {
		LcdDataWrite(*str);
        str++;
    }
}

void Lcdprintf(unsigned char x, unsigned char y, flash char *form,...)
{
	unsigned char buff[100];
	va_list argptr;
	va_start(argptr,form);
	vsprintf(buff,form,argptr);
	
	LineDecision(x,y);	//위치지정
	LcdString(buff);
    
	va_end(argptr);    
}

void LcdClear(void)
{
	LcdCommandWrite(ALLCLR);
}
