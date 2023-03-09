#include "hwdefine.h"
#include "With_util.h"

unsigned int TickCount = 0;

void Delay(unsigned int Count)
{
	unsigned int LimitCount = 0;
	
	for (LimitCount = 0; LimitCount < Count; LimitCount++);
}

void DelayMs(unsigned int Count)
{
	TickCount = 0;
	while(TickCount < Count);
}

char Asc2Hex(char asc)
{
	if((asc >= '0') && (asc <= '9'))	return (asc - '0');
 	else if((asc >= 'A') && (asc <= 'Z'))   return (asc - 'A' + 0x0a);
  	else if((asc >= 'a') && (asc <= 'z'))    return (asc - 'a' + 0x0a);
   	else return 0xff;
}       

char Hex2Asc(char hex)
{
	char da;
	da = hex & 0x0f;
 	if((da >= 0) && (da <= 9))    return  ('0' + da);
  	else    return  ('A' + da - 0x0a);
}

void swap(unsigned int *x, unsigned int *y)
{
	unsigned int Temp;
	
	Temp = *x;
	*x = *y;
	*y = Temp;
}

//  Promoto char to int <= 이 옵션은 항상 체크하지 말것(체크시 EEPROM 동작안됨)
//  char is unsigned

void SetEeprom(int Addr, unsigned char data)
{
	while(EECR & 0x02); 	// Poll EEWE
	EEAR = Addr;
	EEDR = data;
	EECR |= 0x04;  		// Set EEMWE
	EECR |= 0x02;  		// Set EEWE
}

void SetEeprom2(int Addr, int data)
{
	SetEeprom(Addr, data & 0xff);
	SetEeprom(Addr + 1, (data & 0xff00) >> 8);
}

void SetEeprom4(int Addr, unsigned long int data)
{
	SetEeprom(Addr, data & 0xff);
	SetEeprom(Addr + 1, (data & 0xff00) >> 8);
	SetEeprom(Addr + 2, (data & 0xff0000) >> 16);
	SetEeprom(Addr + 3, (data & 0xff000000) >> 24);
}

void SetNEeprom(int Addr, unsigned char *data, unsigned char Count)
{
	while(Count--) {
		SetEeprom(Addr++, *data++);
	}
}

void SetNEeprom_F(int Addr, const unsigned char *data, unsigned char Count)
{
	while(Count--) {
		SetEeprom(Addr++, *data++);
	}
}

unsigned char GetEeprom(int Addr)
{
	unsigned char data;

	while(EECR & 0x02);	// Poll EEWE
	EEAR = Addr;
	EECR |= 0x01;  		// Set EERE
	data = EEDR;   		// Get 1 Byte
	return data;
}

unsigned int GetEeprom2(int Addr)
{                      
	unsigned int data = 0;

	data = GetEeprom(Addr + 1);
	data = data << 8;
	data |= GetEeprom(Addr);
	return data;
}

unsigned long int GetEeprom4(int Addr)
{                      
	long data = 0;

	data = GetEeprom(Addr + 3);
	data = data << 8;
	data |= GetEeprom(Addr + 2);
	data = data << 8;
	data |= GetEeprom(Addr + 1);
	data = data << 8;
	data |= GetEeprom(Addr);
	return data;
}

void GetNEeprom(int Addr, unsigned char *data, unsigned char Count)
{
	while(Count--) {
		*data++ = GetEeprom(Addr++);
	}
}

void SerialTxChar(unsigned char TxCh, unsigned char Direction)
{
	if(Direction == 0)
	{
		// Waits until the Serial transmitter is ready
		while(!(UCSR0A & (1<<UDRE)));//udre
		 	UDR0 = TxCh;
		// Waits until the Transmit is finished
 		while(!(UCSR0A & (1<<TXC))); // WaitTxEndSIO
	}	
	else if(Direction == 1)
	{
		// Waits until the Serial transmitter is ready
		while(!(UCSR1A & (1<<UDRE)));//udre
 		 	UDR1 = TxCh;
 		// Waits until the Transmit is finished
 		while(!(UCSR1A & (1<<TXC)));//WaitTxEndCCN
	}    
	else if(Direction == 2)
	{
		// Waits until the Serial transmitter is ready
		while(!(UCSR2A & (1<<UDRE)));//udre
 		 	UDR2 = TxCh;
 		// Waits until the Transmit is finished
 		while(!(UCSR2A & (1<<TXC)));//WaitTxEndCCN
	}    
	else if(Direction == 3)
	{
		// Waits until the Serial transmitter is ready
		while(!(UCSR3A & (1<<UDRE)));//udre
 		 	UDR3 = TxCh;
 		// Waits until the Transmit is finished
 		while(!(UCSR3A & (1<<TXC)));//WaitTxEndCCN
	}    
	
}

void Sputs(char *Str, unsigned char device)
{
	while(*Str != '\0') {
		SerialTxChar(*Str, device); 
  		Str++;
    	}
}

void NSputs(char *Str, unsigned char Count, unsigned char device)
{
	while(Count--) {
		SerialTxChar(*Str, device); 
  		Str++;
    	}
}

void Uartprintf0(flash char *form, ...)
{
	char buff[100];

	va_list argptr;
	va_start(argptr,form);
	vsprintf(buff,form,argptr);
	
	Sputs(buff, 0);


	va_end(argptr);
}   

void Uartprintf1(flash char *form, ...)
{
	char buff[100];

	va_list argptr;
	va_start(argptr,form);
	vsprintf(buff,form,argptr);
	
	Sputs(buff, 1);

	va_end(argptr);
}   

void Uartprintf2(flash char *form, ...)
{
	char buff[100];

	va_list argptr;
	va_start(argptr,form);
	vsprintf(buff,form,argptr);
	
	Sputs(buff, 2);

	va_end(argptr);
}   

void Uartprintf3(flash char *form, ...)
{
	char buff[100];

	va_list argptr;
	va_start(argptr,form);
	vsprintf(buff,form,argptr);
	
	Sputs(buff, 3);

	va_end(argptr);
}   

void Nullprintf(flash char *form, ...)
{
	//
}   

char StrCmp(unsigned char *Buffer, flash char *Command)
{
	unsigned char Count = 0;
    char Result = 0;
    
    while((Buffer[Count] != '\n') && (Buffer[Count] != '\r') && (Buffer[Count] != ' '))
    {    
//		DebugComm("%d, Buffer=%02x, Command=%02x\n\r", Count, Buffer[Count], Command[Count]);
		if (Buffer[Count] != Command[Count]) return 0;
        Result = 1;
        Count++;    	
    }

	return Result;
}
 
void Dac7512Write(unsigned int Data) 	// 0~4095
{
	int Count = 0;

	Sync1Low();
	Sync1High();
	Sync1Low();
    
    for (Count = 0; Count < 16; Count++)
    {
    	if (Data & (0x8000 >> Count))
        {
			SdoHigh();
        }else {
			SdoLow();        
        }
        SckLow();
        SckHigh();
        SckLow();
    }
    
	Sync1High();
}

void Ltc1865Write(unsigned int Data)
{
	int Count = 0;

	Sync2Low();
	Sync2High();
	Sync2Low();
    
    for (Count = 0; Count < 16; Count++)
    {
    	if (Data & (0x8000 >> Count))
        {
			SdoHigh();
        }else {
			SdoLow();        
        }
        SckLow();
        SckHigh();
        SckLow();
    }
    
	Sync2High();
}

unsigned int Ltc1865Read(unsigned int Ch)
{
	unsigned int Result = 0;
	unsigned int Data = 0;
	int Count = 0;

	Sync2Low();
	Sync2High();
	Sync2Low();

	if (Ch) Data = 0xC000;
    else Data = 0x8000;
        
    for (Count = 0; Count < 16; Count++)
    {
    	Result <<= 1;
        
       	if (Data & (0x8000 >> Count))
        {
			SdoHigh();
        }else {
			SdoLow();        
        }

       	if (Sdi())
        {
			Result |= 1;
        }else {
			Result |= 0;
        }

        SckLow();
        SckHigh();
        SckLow();
    }
    
	Sync2High();
    
    return Result;
}



