#ifndef UTIL_HEADER
#define UTIL_HEADER

extern unsigned int TickCount;

void Delay(unsigned int Count);
void DelayMs(unsigned int Count);
char Asc2Hex(char asc);
char Hex2Asc(char hex);
void swap(unsigned int *x, unsigned int *y);

void SetEeprom(int Addr, unsigned char data);
void SetEeprom2(int Addr, int data);
void SetEeprom4(int Addr, unsigned long int data);
void SetNEeprom(int Addr, unsigned char *data, unsigned char Count);
void SetNEeprom_F(int Addr, const unsigned char *data, unsigned char Count);
unsigned char GetEeprom(int Addr);
unsigned int GetEeprom2(int Addr);
unsigned long int GetEeprom4(int Addr);
void GetNEeprom(int Addr, unsigned char *data, unsigned char Count);
void SerialTxChar(unsigned char TxCh, unsigned char Direction);
void Sputs(char *Str, unsigned char device);
void NSputs(char *Str, unsigned char Count, unsigned char device);
void Uartprintf0(flash char *form, ...);
void Uartprintf1(flash char *form, ...);
void Uartprintf2(flash char *form, ...);
void Uartprintf3(flash char *form, ...);

void Nullprintf(flash char *form, ...);

char StrCmp(unsigned char *Buffer, flash char *Command);

void Dac7512Write(unsigned int Data);	// 0 ~ 4095
void Ltc1865Write(unsigned int Data);
unsigned int Ltc1865Read(unsigned int Ch);

#endif
