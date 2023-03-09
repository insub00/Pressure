
#pragma used+
sfrb PINA=0;
sfrb DDRA=1;
sfrb PORTA=2;
sfrb PINB=3;
sfrb DDRB=4;
sfrb PORTB=5;
sfrb PINC=6;
sfrb DDRC=7;
sfrb PORTC=8;
sfrb PIND=9;
sfrb DDRD=0xa;
sfrb PORTD=0xb;
sfrb PINE=0xc;
sfrb DDRE=0xd;
sfrb PORTE=0xe;
sfrb PINF=0xf;
sfrb DDRF=0x10;
sfrb PORTF=0x11;
sfrb PING=0x12;
sfrb DDRG=0x13;
sfrb PORTG=0x14;
sfrb TIFR0=0x15;
sfrb TIFR1=0x16;
sfrb TIFR2=0x17;
sfrb TIFR3=0x18;
sfrb TIFR4=0x19;
sfrb TIFR5=0x1a;
sfrb PCIFR=0x1b;
sfrb EIFR=0x1c;
sfrb EIMSK=0x1d;
sfrb GPIOR0=0x1e;
sfrb EECR=0x1f;
sfrb EEDR=0x20;
sfrb EEARL=0x21;
sfrb EEARH=0x22;
sfrw EEAR=0X21;   
sfrb GTCCR=0x23;
sfrb TCCR0A=0x24;
sfrb TCCR0B=0x25;
sfrb TCNT0=0x26;
sfrb OCR0A=0x27;
sfrb OCR0B=0x28;
sfrb GPIOR1=0x2a;
sfrb GPIOR2=0x2b;
sfrb SPCR=0x2c;
sfrb SPSR=0x2d;
sfrb SPDR=0x2e;
sfrb ACSR=0x30;
sfrb OCDR=0x31;
sfrb SMCR=0x33;
sfrb MCUSR=0x34;
sfrb MCUCR=0x35;
sfrb SPMCSR=0x37;
sfrb RAMPZ=0x3b;
sfrb EIND=0x3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
#endasm

#pragma used+

signed char cmax(signed char a,signed char b);
int max(int a,int b);
long lmax(long a,long b);
float fmax(float a,float b);
signed char cmin(signed char a,signed char b);
int min(int a,int b);
long lmin(long a,long b);
float fmin(float a,float b);
signed char csign(signed char x);
signed char sign(int x);
signed char lsign(long x);
signed char fsign(float x);
unsigned char isqrt(unsigned int x);
unsigned int lsqrt(unsigned long x);
float sqrt(float x);
float floor(float x);
float ceil(float x);
float fmod(float x,float y);
float modf(float x,float *ipart);
float ldexp(float x,int expon);
float frexp(float x,int *expon);
float exp(float x);
float log(float x);
float log10(float x);
float pow(float x,float y);
float sin(float x);
float cos(float x);
float tan(float x);
float sinh(float x);
float cosh(float x);
float tanh(float x);
float asin(float x);
float acos(float x);
float atan(float x);
float atan2(float y,float x);

#pragma used-
#pragma library math.lib

typedef char *va_list;

#pragma used+

char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);

char *gets(char *str,unsigned int len);

void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void snprintf(char *str, unsigned int size, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
void vsnprintf (char *str, unsigned int size, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);

#pragma used-

#pragma library stdio.lib

#pragma used+

unsigned char cabs(signed char x);
unsigned int abs(int x);
unsigned long labs(long x);
float fabs(float x);
int atoi(char *str);
long int atol(char *str);
float atof(char *str);
void itoa(int n,char *str);
void ltoa(long int n,char *str);
void ftoa(float n,unsigned char decimals,char *str);
void ftoe(float n,unsigned char decimals,char *str);
void srand(int seed);
int rand(void);
void *malloc(unsigned int size);
void *calloc(unsigned int num, unsigned int size);
void *realloc(void *ptr, unsigned int size); 
void free(void *ptr);

#pragma used-
#pragma library stdlib.lib

#pragma used+

char *strcat(char *str1,char *str2);
char *strcatf(char *str1,char flash *str2);
char *strchr(char *str,char c);
signed char strcmp(char *str1,char *str2);
signed char strcmpf(char *str1,char flash *str2);
char *strcpy(char *dest,char *src);
char *strcpyf(char *dest,char flash *src);
unsigned int strlenf(char flash *str);
char *strncat(char *str1,char *str2,unsigned char n);
char *strncatf(char *str1,char flash *str2,unsigned char n);
signed char strncmp(char *str1,char *str2,unsigned char n);
signed char strncmpf(char *str1,char flash *str2,unsigned char n);
char *strncpy(char *dest,char *src,unsigned char n);
char *strncpyf(char *dest,char flash *src,unsigned char n);
char *strpbrk(char *str,char *set);
char *strpbrkf(char *str,char flash *set);
char *strrchr(char *str,char c);
char *strrpbrk(char *str,char *set);
char *strrpbrkf(char *str,char flash *set);
char *strstr(char *str1,char *str2);
char *strstrf(char *str1,char flash *str2);
char *strtok(char *str1,char flash *str2);

unsigned int strlen(char *str);
void *memccpy(void *dest,void *src,char c,unsigned n);
void *memchr(void *buf,unsigned char c,unsigned n);
signed char memcmp(void *buf1,void *buf2,unsigned n);
signed char memcmpf(void *buf1,void flash *buf2,unsigned n);
void *memcpy(void *dest,void *src,unsigned n);
void *memcpyf(void *dest,void flash *src,unsigned n);
void *memmove(void *dest,void *src,unsigned n);
void *memset(void *buf,unsigned char c,unsigned n);
unsigned int strcspn(char *str,char *set);
unsigned int strcspnf(char *str,char flash *set);
int strpos(char *str,char c);
int strrpos(char *str,char c);
unsigned int strspn(char *str,char *set);
unsigned int strspnf(char *str,char flash *set);

#pragma used-
#pragma library string.lib

#pragma used+

void delay_us(unsigned int n);
void delay_ms(unsigned int n);

#pragma used-

#pragma library With_setup.lib
#pragma library With_util.lib
#pragma library With_lcd.lib
extern unsigned int TickCount;
void Delay(unsigned int Count);
void DelayMs(unsigned int Count);;
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
void Dac7512Write(unsigned int Data);	
void Ltc1865Write(unsigned int Data);
unsigned int Ltc1865Read(unsigned int Ch);

extern void LcdInit(void);
extern void LcdCommandWrite(unsigned char Data);
extern void LcdDataWrite(unsigned char Data);
extern void LineDecision(unsigned char x, unsigned char y);
extern void Lcdprintf(unsigned char x, unsigned char y, flash char *form,...);
extern void LcdClear(void);
void CommSubroutine(void);
void HwInit(void);
void UserMain(void);
void HalfSecMain(void);

extern volatile unsigned char QueueData[256];
extern volatile unsigned int QueueFirst;
extern volatile unsigned int QueueLast;
extern volatile unsigned char CommCommandBuffer[];
extern volatile unsigned int CommCommandSize;
extern volatile unsigned char Key;
extern volatile unsigned char ExtKey;
extern volatile unsigned char Sensor;
extern volatile unsigned char Emo;
extern volatile unsigned char bBlink;

unsigned long PressureTime = 50; 	
unsigned long Pressure = 300;		

unsigned long CalItvMin = 11490;	
unsigned long CalItvMax = 60400;	

unsigned char bDebug = 0;			
unsigned char bCalib = 0;			
unsigned char bLongKey = 0;			
unsigned char CalibStep = 0;		
unsigned long CalibStepDelay = 0;	
unsigned char TestMode = 0;			

unsigned char bAutoMode = 1;   		
unsigned char bCylXIn = 0;			
unsigned char bCylYDown = 0;		
unsigned char bPressureFail = 0;	
unsigned char bDoorSensorFail = 0;
unsigned char bSafeSensorFail = 0;

unsigned char bMenuDisplay = 1;		
unsigned char bVarDisplay = 1;		

unsigned char KeyRunCount = 0;		

unsigned char bRun = 0; 			
unsigned char RunStep = 0;			
unsigned long RunStepDelay = 0;		
unsigned long RunStepTime = 0;		
unsigned char bRunAlarm = 0;		

unsigned char SetupStep = 0;		
unsigned int SetupExitTime = 0;		
unsigned int SetData = 0;			

unsigned int BuzzerOnTime = 0;
unsigned int BuzzerOffTime = 0;
unsigned int BuzzerRepeatCount = 0;
unsigned int BuzzerOnCount = 0;
unsigned int BuzzerOffCount = 0;

unsigned long ReadPressure = 0;

typedef enum{ RUN_STOP = 0,  RUN_START_DELAY, RUN_JIG_IN, RUN_CYL_DOWN, RUN_PRESSURE_DELAY, RUN_CYL_UP, RUN_JIG_OUT, RUN_END} RUN_STEP_TYPE;

void SetBuzzer(unsigned char Mode, unsigned char Repeat);

void SetItv(unsigned int Data)
{	
unsigned long Result = 0;

Result = (Data - 0);
Result *= 4095;
Result /= (900 - 0);
Dac7512Write(Result);	
}

unsigned long GetItv(void)
{
unsigned long Result = 0;

Result = Ltc1865Read(0);

if (Result < CalItvMin) Result = CalItvMin;
if (Result > CalItvMax) Result = CalItvMax;

Result -= CalItvMin;

Result *= (900 - 0);
Result /= (CalItvMax - CalItvMin);

Result += 0;    

return Result;
}

void HwInit(void)
{  
((*(unsigned char *) 0x105) |= 0x01)		;
((*(unsigned char *) 0x105) |= 0x02)		;
((*(unsigned char *) 0x105) |= 0x04)		;
((*(unsigned char *) 0x105) |= 0x08)		;
((*(unsigned char *) 0x105) |= 0x10)		;

bMenuDisplay = 1;
bVarDisplay = 1;

if (GetEeprom2(0x3ff	) != 0x01	)
{
SetEeprom2(0, PressureTime);
SetEeprom2(2, Pressure);

SetEeprom2(10, CalItvMin);
SetEeprom2(12, CalItvMax);

SetEeprom2(0x3ff	, 0x01	);
}else { 
PressureTime = GetEeprom2(0);
Pressure = GetEeprom2(2);

CalItvMin = GetEeprom2(10);
CalItvMax = GetEeprom2(12);
}

Uartprintf0("\n\r");
Uartprintf0("******************************\n\r");
Uartprintf0("*          WINDOW PRESSURE   *\n\r");
Uartprintf0("*               Bestpro      *\n\r");
Uartprintf0("*            2014/10/02      *\n\r");
Uartprintf0("******************************\n\r");
Uartprintf0("01");
Uartprintf0("Prompt:> ");

LcdInit();      
SetItv(Pressure);
GetItv();
SetBuzzer(0, 1);

TestMode = 0; 
}

void CommSubroutine(void)
{
unsigned int tQueueLast = QueueLast;        

if (QueueFirst != tQueueLast)
{
while(QueueFirst != tQueueLast)
{
CommCommandBuffer[CommCommandSize++] = QueueData[QueueFirst++];        
if (CommCommandSize >= 50) CommCommandSize = 0;
if (QueueFirst >= 256) QueueFirst = 0;

if ((CommCommandBuffer[CommCommandSize - 1] == '\n') || (CommCommandBuffer[CommCommandSize - 1] == '\r'))    
{
CommCommandBuffer[CommCommandSize] = 0;                                                                                                                       
if (CommCommandSize != 1)        
{

switch(CommCommandSize - 1)
{
case 3:
case 1:
CommCommandBuffer[0] = 'H';
CommCommandBuffer[1] = 'E';
CommCommandBuffer[2] = 'L';
CommCommandBuffer[3] = 'P';
case 4:
if (strncmpf((char *)CommCommandBuffer, "HELP", 4) == 0)
{

Uartprintf0("\n\r");
Uartprintf0("  Command List\n\r");

Uartprintf0("  HELP       :   Help Meassage\n\r");
Uartprintf0("  TEST       :   TEST Command\n\r");
Uartprintf0("  DEBUG      :   DEBUG Command\n\r");
Uartprintf0("  VER?       :   Version Command\n\r");
}
else if (strncmpf((char *)CommCommandBuffer, "TEST", 4) == 0)
{
TestMode = Asc2Hex(CommCommandBuffer[4]);
if(TestMode) Uartprintf0("Test Mode %d\n\r", TestMode);
else Uartprintf0("Test Mode Disable\n\r");
}
break;
case 5:
if (strncmpf((char *)CommCommandBuffer, "DEBUG", 5) == 0)
{
bDebug = !bDebug;
if (bDebug)
{
Uartprintf0("Debug Mode Enable\n\r");
}
else
{
Uartprintf0("Debug Mode Disable\n\r");
}
}
break;
default:
Uartprintf0("Command ?\n");
break;
}
}
CommCommandSize = 0;
}
}
}

}

void SetBuzzer(unsigned char Mode, unsigned char Repeat)
{
switch(Mode)
{
case 0:
BuzzerOnTime = 10;
BuzzerOffTime = 10;
break;
case 1:    
BuzzerOnTime = 50;
BuzzerOffTime = 10;
break;
}                          
BuzzerOnCount = BuzzerOnTime;
BuzzerOffCount = BuzzerOffTime;
BuzzerRepeatCount = Repeat;
}

void RunSubroutine(void)	
{
if (bRun)
{
if (Emo && RunStep <= RUN_PRESSURE_DELAY)
{
RunStepDelay = 0;
RunStep = RUN_PRESSURE_DELAY;
bRunAlarm |= 0x01;
}

if (RunStepDelay)
{
RunStepDelay--;
RunStepTime++;
if ((RunStepDelay % 10) == 0) bVarDisplay = 1;
}else {	
if (RunStep == RUN_PRESSURE_DELAY && bPressureFail) bRunAlarm |= 0x02;

RunStepTime = 0;
switch(RunStep)
{
case RUN_STOP:
RunStep = RUN_START_DELAY;
RunStepDelay = 100;	
bVarDisplay = 1;
break;

case RUN_START_DELAY:
RunStep = RUN_JIG_IN;
((*(unsigned char *) 0x108) |= 0x01);
bVarDisplay = 1;
break;

case RUN_JIG_IN:
if (Sensor & 0x02	)
{
RunStep = RUN_CYL_DOWN;
((*(unsigned char *) 0x108) |= 0x02);
bVarDisplay = 1;
}
break;

case RUN_CYL_DOWN:
if (Sensor & 0x08	)
{
RunStep = RUN_PRESSURE_DELAY;
RunStepDelay = PressureTime * 10; 
bVarDisplay = 1;
}
break;

case RUN_PRESSURE_DELAY:
RunStep = RUN_CYL_UP;
RunStepDelay = 10;  
((*(unsigned char *) 0x108) &= ~0x02);
bVarDisplay = 1;
break;

case RUN_CYL_UP:
if (Sensor & 0x04	)
{
if (bDoorSensorFail == 0 && bSafeSensorFail == 0)
{
RunStep = RUN_JIG_OUT;
RunStepDelay = 10;
((*(unsigned char *) 0x108) &= ~0x01);
bVarDisplay = 1;
}
}
break;

case RUN_JIG_OUT:
if (Sensor & 0x01	)
{
RunStep = RUN_END;
RunStepDelay = 10;
bVarDisplay = 1;
}
break;

case RUN_END:
if (bRunAlarm) SetBuzzer(1, 1);
else SetBuzzer(0, 1);

bRun = 0;
RunStep = RUN_STOP;
bMenuDisplay = 1;  
bVarDisplay = 1;
break;
}
}    
}else {
RunStep = RUN_STOP;
RunStepDelay = 0;
RunStepTime = 0;

if (bAutoMode)
{        
bCylXIn = 0;
bCylYDown = 0;
((*(unsigned char *) 0x108) &= ~0x01);
((*(unsigned char *) 0x108) &= ~0x02);
}
}
}

void DisplaySubroutine(void)	
{

if (bMenuDisplay)
{
LcdClear();
switch(SetupStep)
{
case 0:	
if (TestMode)
{

}else {
Lcdprintf(0, 0, "WINDOW PRESS BASE:");
Lcdprintf(18, 0, "01");
Lcdprintf(0, 2, "Status:");
if (bRun) Lcdprintf(7, 2, "RUN  TIM:");
else Lcdprintf(7, 2, "STOP TIM:");

if (bAutoMode)
{
Lcdprintf(0, 1, "AUTO:");
}else {
Lcdprintf(0, 1, "MAN :");
}
Lcdprintf(5, 1, "%2d.%dsec %d.%02dkgf", PressureTime / 10, PressureTime % 10, Pressure / 100, Pressure % 100);
}
{LcdCommandWrite(0x0C    );};
break;

case 1:	
Lcdprintf(0, 0, "       SETUP");
Lcdprintf(0, 1, " PRESSURE :      kgf");
Lcdprintf(0, 2, " LIMIT (%d ~ %d)", 0, 900);
{LcdCommandWrite(0x0F    );};
break;

case 2:	
Lcdprintf(0, 0, "       SETUP");
Lcdprintf(0, 1, " TIME     :      sec");
Lcdprintf(0, 2, " LIMIT (%d ~ %d)", 0, 200);
{LcdCommandWrite(0x0F    );};
break;

}

bMenuDisplay = 0;
bVarDisplay = 1;
}    

if (bVarDisplay)
{
switch(SetupStep)
{
case 0:	
if (TestMode)
{
Lcdprintf(0, 0, "Ky=%02X,EK=%02X,Ss=%02X", Key, ExtKey, Sensor);
Lcdprintf(0, 1, "Run=%d,Step=%2d,Dly=%2d", bRun, RunStep, RunStepDelay);
Lcdprintf(0, 2, "SetupStep = %d", SetupStep);
Lcdprintf(0, 3, "CH0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
}else {
Lcdprintf(13, 3, "%d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
Lcdprintf(16, 2, "%2d.%d", (RunStepTime / 10) / 10, (RunStepTime / 10) % 10);
if (bRun)
{
switch(RunStep)
{
case RUN_STOP:
Lcdprintf(0, 3, "STOP       ");
break;

case RUN_START_DELAY:
Lcdprintf(0, 3, "START DELAY");
break;

case RUN_JIG_IN:
Lcdprintf(0, 3, "JIG IN     ");
break;

case RUN_CYL_DOWN:
Lcdprintf(0, 3, "CYL DOWN   ");
break;

case RUN_PRESSURE_DELAY:
Lcdprintf(0, 3, "PRESSURE   ");
break;

case RUN_CYL_UP:
Lcdprintf(0, 3, "CYL UP     ");
break;

case RUN_JIG_OUT:
Lcdprintf(0, 3, "JIG OUT    ");
break;

case RUN_END:
Lcdprintf(0, 3, "END        ");
break;

}
}else {
if (Emo)
{
if (bBlink)
{
Lcdprintf(0, 3, "EMERGENCY!!!");
}else {
Lcdprintf(0, 3, "            ");
}
}else if (bAutoMode && bSafeSensorFail) {
if (bBlink)
{
Lcdprintf(0, 3, "SAFE SENSOR!");
}else {
Lcdprintf(0, 3, "            ");
}
}else if (bAutoMode && bDoorSensorFail) {
if (bBlink)
{
Lcdprintf(0, 3, "DOOR SENSOR!");
}else {
Lcdprintf(0, 3, "            ");
}
}else if (bAutoMode && bPressureFail) {
if (bBlink)
{
Lcdprintf(0, 3, "PRESSURE AL!");
}else {
Lcdprintf(0, 3, "            ");
}
}else if (bAutoMode) {
Lcdprintf(0, 3, "READY       ");
}else {
Lcdprintf(0, 3, "CYL : ");
if (bCylXIn) Lcdprintf(6, 3, "IN -");
else Lcdprintf(6, 3, "OUT-");

if (bCylYDown) Lcdprintf(10, 3, "DO");
else Lcdprintf(10, 3, "UP");
}
}            

}
break;

case 1:	
Lcdprintf(12, 1, "%d.%02d", SetData / 100, SetData % 100);
LineDecision(15, 1);
break;

case 2:	
Lcdprintf(12, 1, "%2d.%d", SetData / 10, SetData % 10);
LineDecision(15, 1);
break;

}
bVarDisplay = 0;
}

if (bPressureFail)
{
if (!bRun)
{
((*(unsigned char *) 0x105) |= 0x08)		;
((*(unsigned char *) 0x105) &= ~0x10)		;
}
}else {          
if (bRunAlarm) {
if (bBlink)
{
((*(unsigned char *) 0x105) |= 0x08)		;
((*(unsigned char *) 0x105) &= ~0x10)		;
}else {
((*(unsigned char *) 0x105) |= 0x08)		;
((*(unsigned char *) 0x105) |= 0x10)		;
}
}else {
((*(unsigned char *) 0x105) |= 0x10)		;
((*(unsigned char *) 0x105) &= ~0x08)		;
}
}

if (bRun)
{
if (bBlink)
{
((*(unsigned char *) 0x105) &= ~0x04)		;
}else {
((*(unsigned char *) 0x105) |= 0x04)		;
}
}else {
if (bLongKey) ((*(unsigned char *) 0x105) |= 0x04)		;
else ((*(unsigned char *) 0x105) &= ~0x04)		;
}
}  	

void KeySubroutine(void)	
{
static unsigned char KeyDownCount = 0;
static unsigned char PrevDownKey = 0;

if (Key)	
{
PrevDownKey = Key;
if (++KeyDownCount >= 200) KeyDownCount--;

if (KeyDownCount > 10)	
{
bLongKey = 1;
switch(Key)
{
case 0x10:
switch(SetupStep)
{       
case 0:
break;
case 1:	
if (KeyDownCount > 30) {
SetData += 10;
if (SetData > 900) SetData = 900;
}else {
if (++SetData > 900) SetData--;
}
bVarDisplay = 1;
break;
case 2:	
if (KeyDownCount > 30) {
SetData += 10;
if (SetData > 200) SetData = 200;
}else { 
if (++SetData > 200) SetData--;
}
bVarDisplay = 1;
break;
}
break;

case 0x20:        
switch(SetupStep)
{       
case 0:
break;
case 1:
if (KeyDownCount > 30) {
if (SetData > 0 + 10) SetData -= 10;
else SetData = 0; 
}else {
if (SetData > 0) SetData--;
}
bVarDisplay = 1;
break;
case 2:	
if (KeyDownCount > 30) {
if (SetData > 0 + 10) SetData -= 10;
else SetData = 0; 
}else {
if (SetData > 0) SetData--;
}
bVarDisplay = 1;
break;
}
break;
}
}else {
if (Key == (0x01 | 0x80))
{
if (bAutoMode && !bRun)
{
if (bDoorSensorFail == 0 && bSafeSensorFail == 0 && !Emo && !bPressureFail)
{    
SetupStep = 0;
bRun = 1;
bRunAlarm = 0;
bMenuDisplay = 1;
bVarDisplay = 1;
}else {
SetBuzzer(1, 1);
bVarDisplay = 1;                        
}
}
}
}
}else {	
if (PrevDownKey)
{
SetupExitTime = 100	;
if (KeyDownCount < 10)	
{
switch(PrevDownKey)
{
case 0x02			:	
if (SetupStep)
{			
if (++SetupStep > 2) SetupStep = 1;

if (SetupStep == 1) SetData = Pressure;
else if (SetupStep == 2) SetData = PressureTime;

bMenuDisplay = 1;
SetBuzzer(0, 0);
}
break;
case 0x04:	
break;

case 0x08:
switch(SetupStep)
{
case 1:
Pressure = SetData;
SetEeprom2(2, Pressure);
SetItv(Pressure);

SetupStep = 2;
SetData = PressureTime;
bMenuDisplay = 1;
SetBuzzer(0, 0);
break;
case 2:
PressureTime = SetData;
SetEeprom2(0, PressureTime);

SetupStep = 1;
SetData = Pressure;
bMenuDisplay = 1;                            
SetBuzzer(0, 0);
break;
}                
break;

case 0x10:
switch(SetupStep)
{       
case 0:
if (!bAutoMode)
{
bCylYDown = !bCylYDown;
if (bCylYDown) ((*(unsigned char *) 0x108) |= 0x02);
else ((*(unsigned char *) 0x108) &= ~0x02);
bVarDisplay = 1;
}
break;
case 1:
if (++SetData > 900) SetData--;
bVarDisplay = 1;
break;
case 2:	
if (++SetData > 200) SetData--;
bVarDisplay = 1;
break;
}
SetBuzzer(0, 0);
break;

case 0x20:
switch(SetupStep)
{       
case 0:
if (!bAutoMode && !bCylYDown)
{
bCylXIn = !bCylXIn;
if (bCylXIn) ((*(unsigned char *) 0x108) |= 0x01);
else ((*(unsigned char *) 0x108) &= ~0x01);
bVarDisplay = 1;
}
break;
case 1:
if (SetData > 0) SetData--;
bVarDisplay = 1;
break;
case 2:	
if (SetData > 0) SetData--;
bVarDisplay = 1;
break;
}
SetBuzzer(0, 0);
break;
case 0x40:
break;

}
}else {	
switch(PrevDownKey)
{
case 0x02			:	
if (SetupStep) 
{
SetupStep = 0;
}else {
SetupStep = 1;
}
SetData = Pressure;
bMenuDisplay = 1;
SetBuzzer(0, 1);
break;

case 0x04:	
if (!bRun && SetupStep == 0)
{
bAutoMode = !bAutoMode;
bMenuDisplay = 1;
}
SetBuzzer(0, 1);
break;
case 0x08:
break;
case 0x10:
break;
case 0x20:
break;
case 0x40:
if (TestMode)
{
bCalib = 1;
CalibStep = 0;
CalibStepDelay = 100;
SetBuzzer(1, 0);
}
break;

case 0x10 | 0x20:
TestMode = !TestMode;
bMenuDisplay = 1;                    
SetBuzzer(1, 0);
break;                

}
}
}else {
if (SetupExitTime && SetupStep)
{
SetupExitTime--;
if (SetupExitTime == 0)
{
SetupStep = 0;
bMenuDisplay = 1;
SetBuzzer(0, 1);
}
}        
}
bLongKey = 0;
KeyDownCount = 0;
PrevDownKey = 0;
}
}

void BuzzerSubroutine(void)
{
if (BuzzerOnCount)
{
BuzzerOnCount--;
((*(unsigned char *) 0x105) |= 0x20)		;
}else if (BuzzerOffCount) {
BuzzerOffCount--;
((*(unsigned char *) 0x105) &= ~0x20);
}else if (BuzzerRepeatCount) {
BuzzerRepeatCount--;
BuzzerOnCount = BuzzerOnTime;
BuzzerOffCount = BuzzerOffTime;    
}else if (Emo) {	
if (bBlink)
{
((*(unsigned char *) 0x105) |= 0x20)		;
}else {
((*(unsigned char *) 0x105) &= ~0x20);
}
}else {
((*(unsigned char *) 0x105) &= ~0x20);
}
}

void CalibSubroutine(void)
{
if (bCalib)
{
if (CalibStepDelay) {
CalibStepDelay--;
}else {
switch(CalibStep)
{
case 0:
CalibStep++;
SetItv(0);	
CalibStepDelay = 1500;
SetBuzzer(0, 0);
break;

case 1:
CalibStep++;
CalItvMin = Ltc1865Read(0);
SetEeprom2(10, CalItvMin);

SetItv(900);	
CalibStepDelay = 500;
SetBuzzer(0, 0);
break;                

case 2:
CalibStep++;
CalItvMax = Ltc1865Read(0);
SetEeprom2(12, CalItvMax);

SetItv(Pressure);	
CalibStepDelay = 0;
bCalib = 0;
SetBuzzer(1, 0);
break;
}
}
}
}

void UserMain(void)	
{
RunSubroutine();
DisplaySubroutine();
BuzzerSubroutine();
CalibSubroutine();

if (KeyRunCount++ >= 10)	
{
KeySubroutine();
KeyRunCount = 0;

ReadPressure = GetItv();
if (abs(Pressure - ReadPressure) > 50	) bPressureFail = 1;
else bPressureFail = 0;

if (Sensor & 0x20	) bDoorSensorFail = 0;
else bDoorSensorFail = 1;

if (Sensor & 0x10	) bSafeSensorFail = 0;
else bSafeSensorFail = 1;

bVarDisplay = 1;
}
}

void HalfSecMain(void)
{
unsigned int Count;

if (bBlink)
{
((*(unsigned char *) 0x105) &= ~0x01)		;
}else {
((*(unsigned char *) 0x105) |= 0x01)		;
}

if (bDebug)
{
Uartprintf0("Run = %d, Step = %2d, Delay = %3d\n\r", bRun, RunStep, RunStepDelay);
Uartprintf0("Key = 0x%02X, ExtKey = 0x%02X, Sensor = 0x%02X, Emp = %d\n\r", Key, ExtKey, Sensor, Emo);
Uartprintf0("SetupStep = %d\n\r", SetupStep);
Uartprintf0("CH0 = %ld(0x%04X)\n\r", Ltc1865Read(0), Ltc1865Read(0));
}

}
