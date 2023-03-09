
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
#pragma library With_main.lib
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
void Dac7512Write(unsigned int Data);	
void Ltc1865Write(unsigned int Data);
unsigned int Ltc1865Read(unsigned int Ch);

extern void LcdInit(void);
extern void LcdCommandWrite(unsigned char Data);
extern void LcdDataWrite(unsigned char Data);
extern void LineDecision(unsigned char x, unsigned char y);
extern void Lcdprintf(unsigned char x, unsigned char y, flash char *form,...);
extern void LcdClear(void);

typedef enum{RUN_STOP = 0,  RUN_START_DELAY, RUN_JIG_IN, RUN_EXHAUST1, RUN_EXHAUST2, RUN_CYL_DOWN, RUN_PRESSURE_DELAY, RUN_CYL_UP, RUN_JIG_OUT, RUN_END} RUN_STEP_TYPE;
typedef enum{MODE1_NOMAL = 0,  MODE1_OCTA, MODE1_TAPE, MODE1_BATTERY, MODE1_ETC, MODE2_PRESSURE_SET, MODE2_PRESSURE_DELAY_SET} MODE1_STEP_TYPE;
typedef enum{HIDDEN1_STEP = 1, HIDDEN1_STEP_DELAY} HIDDEN1_STEP_TYPE;

extern unsigned long PressureTime; 	
extern unsigned long Pressure;		
extern unsigned int PressureStep;	
extern unsigned int PressureStepDelay;	
extern unsigned int sPressureStepDelay;	
extern unsigned long CalItvMin;	
extern unsigned long CalItvMax;	

extern unsigned char bReturn;		
extern unsigned char bReturnRun;		
extern unsigned char bReturnSensor;	
extern unsigned char bDebug;			
extern unsigned char bCalib;			
extern unsigned char bLongKey;			
extern unsigned char CalibStep;		
extern unsigned long CalibStepDelay;	
extern unsigned char TestMode;			
extern unsigned char bAgingMode;		
extern unsigned char bAgingEnd;		
extern unsigned char bAutoMode;   		
extern unsigned char bCylXIn;			
extern unsigned char bCylYDown;		
extern unsigned char bPressureFail;	
extern unsigned char bDoorSensorFail;
extern unsigned char bSafeSensorFail;
extern unsigned char bMenuDisplay;		
extern unsigned char bVarDisplay;		
extern unsigned char KeyRunCount;		
extern volatile unsigned char bRun; 	
extern unsigned char RunStep;			
extern unsigned long RunStepDelay;		
extern unsigned long RunStepTime;		
extern unsigned long mRunStepTime;		
extern unsigned char bRunAlarm;			
extern unsigned char Mode1Step;			
extern unsigned char sMode1Step;			
extern unsigned char HiddenStep;		
extern unsigned int SetupExitTime;		
extern unsigned int SetData;			
extern unsigned int Hidden1SetData;	
extern unsigned int BuzzerOnTime;
extern unsigned int BuzzerOffTime;
extern unsigned int BuzzerRepeatCount;
extern unsigned int BuzzerOnCount;
extern unsigned int BuzzerOffCount;
extern unsigned long ReadPressure;
extern unsigned int DownPressure;
extern volatile unsigned char bEmoState;
extern unsigned char bDownPressureEnd;
extern unsigned char bPressureReward;
void SetItv(unsigned int Data);
unsigned long GetItv(void);
void FirstReturn(void);
void HwInit(void);
void UserMain(void);
void HalfSecMain(void);

void CommSubroutine(void);
void RunSubroutine(void);
void KeySubroutine(void);
void DisplaySubroutine(void);
void PressureRewardSubroutine(void);
void StepPressureSubroutine(void);
void PressureCheckSubroutine(void);

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

unsigned int PressureStep = 6			;				
unsigned int PressureStepDelay = 1;								
unsigned int sPressureStepDelay = 1		;	
unsigned char bAutoMode = 2;   			
unsigned int DownPressure = 0;			
unsigned char bDownPressureEnd = 0;		
unsigned char bPressureReward = 0;		

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
static unsigned int TactTimeCheckIn = 0;
static unsigned int TactTimeCheckOut = 0;
static unsigned int TactTimeCheckDown = 0;
static unsigned int TactTimeCheckUp = 0;

if (bRun)
{
if (bEmoState == 1 || bReturnSensor == 1)		
{
SetItv(0);
bRunAlarm |= 0x04;

}else {

if (RunStep == RUN_STOP) SetItv(200);

if ((bEmoState == 2) || bReturnSensor == 2)	
{
SetItv(200     );
bRunAlarm |= 0x08;
}

if (((bEmoState == 2) || bReturnSensor == 2) && RunStep <= RUN_PRESSURE_DELAY)	
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
RunStepDelay = 10;	
bVarDisplay = 1;
break;

case RUN_START_DELAY:
RunStep = RUN_JIG_IN;
(((*(unsigned char *) 0x108) |= 0x01), ((*(unsigned char *) 0x108) &= ~0x02));
bVarDisplay = 1;
break;

case RUN_JIG_IN:
if (Sensor & 0x02	)
{
if (bAutoMode == 2)
{
SetItv(100);
RunStep = RUN_EXHAUST1;
}else {
SetItv(Pressure);
RunStep = RUN_CYL_DOWN;   
bDownPressureEnd = 1;

}
(((*(unsigned char *) 0x108) &= ~0x04), ((*(unsigned char *) 0x108) |= 0x08));
bVarDisplay = 1;

RunStepDelay = 100;
}
break;

case RUN_EXHAUST1:
SetItv(20);

RunStep = RUN_CYL_DOWN;
RunStepDelay = 100;		
break;

case RUN_CYL_DOWN:
if (Sensor & 0x08	)
{

if (bDownPressureEnd == 1)
{
RunStep = RUN_PRESSURE_DELAY;
RunStepDelay = PressureTime * 10;
bPressureReward = 1;
}
bVarDisplay = 1;
}
break;

case RUN_PRESSURE_DELAY:
RunStep = RUN_CYL_UP;
bDownPressureEnd = 0;    

if (bRunAlarm == 0x01) RunStepDelay = 100; 	
else RunStepDelay = 10;

SetItv(200);

(((*(unsigned char *) 0x108) |= 0x04), ((*(unsigned char *) 0x108) &= ~0x08));  

if (bPressureFail) SetBuzzer(1, 2);
else SetBuzzer(0, 0);

RunStepDelay = 30;
bVarDisplay = 1;
break;

case RUN_CYL_UP:

{
if (bReturnSensor == 2 || (bEmoState == 2))
{
RunStep = RUN_JIG_OUT;
RunStepDelay = 10;
(((*(unsigned char *) 0x108) |= 0x02), ((*(unsigned char *) 0x108) &= ~0x01));
bVarDisplay = 1;
}else {
if (bDoorSensorFail == 0 && bSafeSensorFail == 0)
{
RunStep = RUN_JIG_OUT;
RunStepDelay = 10;
(((*(unsigned char *) 0x108) |= 0x02), ((*(unsigned char *) 0x108) &= ~0x01));
bVarDisplay = 1;
}
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
bPressureFail = 0; 
bRunAlarm = 0;
DownPressure = 0;
if (bRunAlarm) SetBuzzer(1, 1);
else SetBuzzer(0, 1);

if (bReturnSensor || (bEmoState == 2))
{
bReturnSensor = 0;
bEmoState = 0;

CalItvMin = GetEeprom2(10);
CalItvMax = GetEeprom4(12);  

SetItv(Pressure);

}

if (bAgingEnd) bRun = 0;
else if (!bAgingEnd && bAgingMode) bRun = 1;		
else bRun = 0;

RunStep = RUN_STOP;
bMenuDisplay = 1;
bVarDisplay = 1;
break;
}
}
}
}else {
RunStep = RUN_STOP;
RunStepDelay = 0;
RunStepTime = 0;
bDownPressureEnd = 0;

if (bAutoMode)	
{
bCylXIn = 0;
bCylYDown = 0;
(((*(unsigned char *) 0x108) |= 0x02), ((*(unsigned char *) 0x108) &= ~0x01));
(((*(unsigned char *) 0x108) |= 0x04), ((*(unsigned char *) 0x108) &= ~0x08));
} else{
if (bCylXIn) 	
{
if ((Sensor & 0x02	) != 0x02	) 
{
TactTimeCheckOut = 0;
mRunStepTime = TactTimeCheckIn++;
if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
}
} else {	
if ((Sensor & 0x01	) != 0x01	) 
{
TactTimeCheckIn = 0;
mRunStepTime = TactTimeCheckOut++;
if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
}
} 
if (bCylYDown){	
if ((Sensor & 0x08	) != 0x08	) 
{
TactTimeCheckUp = 0;
mRunStepTime = TactTimeCheckDown++;
if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
}
} else{	
if ((Sensor & 0x04	) != 0x04	) 
{
TactTimeCheckDown = 0;
mRunStepTime = TactTimeCheckUp++;
if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
} 
}  
}
}
}

void DisplaySubroutine(void)	
{

if (bMenuDisplay)
{
LcdClear();
switch(Mode1Step)
{
case MODE1_NOMAL:	
if (TestMode)
{

}else if (HiddenStep){

}else {

switch (sMode1Step)
{
case MODE1_OCTA:

Lcdprintf(13, 0, "MODE : OCTA      V");
break;
case MODE1_TAPE:

Lcdprintf(13, 0, "MODE : TAPE      V");
break;
case MODE1_BATTERY:

Lcdprintf(13, 0, "MODE : BATT      V");
break;
case MODE1_ETC:

Lcdprintf(13, 0, "MODE : ETC       V");
break;
}
Lcdprintf(18, 0, "06"	);
Lcdprintf(0, 2, "Status:");
if (bRun) Lcdprintf(7, 2, "RUN  TIM:");
else Lcdprintf(7, 2, "STOP TIM:");

if (bAutoMode == 1)							
{
Lcdprintf(0, 1, "AUTO:");
}else if (bAutoMode == 2){					
Lcdprintf(0, 1, "EDGE:");
}else {
Lcdprintf(0, 1, "MAN :");				
}
if (bAgingMode) Lcdprintf(0, 1, "AGING:");	

Lcdprintf(5, 1, "%2d.%dsec %d.%02dkgf", PressureTime / 10, PressureTime % 10, Pressure / 100, Pressure % 100);
}
{LcdCommandWrite(0x0C    );};
break;

case MODE2_PRESSURE_SET:	
Lcdprintf(0, 0, "       SETUP");
Lcdprintf(0, 1, " PRESSURE :      kgf");
Lcdprintf(0, 2, " LIMIT (%d ~ %d)", 0, 600     );
{LcdCommandWrite(0x0F    );};
break;

case MODE2_PRESSURE_DELAY_SET:	
Lcdprintf(0, 0, "       SETUP");
Lcdprintf(0, 1, " TIME     :      sec");
Lcdprintf(0, 2, " LIMIT (%d ~ %d)", 0, 200);
{LcdCommandWrite(0x0F    );};
break;

case MODE1_OCTA:	
Lcdprintf(0, 0, "       OCTA");
Lcdprintf(0, 1, " PRESSURE :      kgf");
Lcdprintf(0, 2, " TIME     :      sec");
Lcdprintf(12, 1, "%d.%02d", 550			 / 100, 550			 % 100);
Lcdprintf(12, 2, "%2d.%d", 117			 / 10, 117			 % 10);

break;

case MODE1_TAPE:	
Lcdprintf(0, 0, "       TAPE");
Lcdprintf(0, 1, " PRESSURE :      kgf");
Lcdprintf(0, 2, " TIME     :      sec");
Lcdprintf(12, 1, "%d.%02d", 300			 / 100, 300			 % 100);
Lcdprintf(12, 2, "%2d.%d", 46			 / 10, 46			 % 10);

break;

case MODE1_BATTERY:	
Lcdprintf(0, 0, "       BATT");
Lcdprintf(0, 1, " PRESSURE :      kgf");
Lcdprintf(0, 2, " TIME     :      sec");
Lcdprintf(12, 1, "%d.%02d", 550			 / 100, 550			 % 100);
Lcdprintf(12, 2, "%2d.%d", 117			 / 10, 117			 % 10);

break;

case MODE1_ETC:	
Lcdprintf(0, 0, "       ETC");
Lcdprintf(0, 1, " PRESSURE :      kgf");
Lcdprintf(0, 2, " TIME     :      sec");
Lcdprintf(12, 1, "%d.%02d", Pressure / 100, Pressure % 100);
Lcdprintf(12, 2, "%2d.%d", PressureTime / 10, PressureTime % 10);

break;
}

switch(HiddenStep)
{
case HIDDEN1_STEP:	
Lcdprintf(0, 0, "   PRESSURE-STEP");
Lcdprintf(0, 1, " STEP     :     STEP");
Lcdprintf(0, 2, " LIMIT (%d ~ %d)", 2		, 10		);
{LcdCommandWrite(0x0F    );};
break;

case HIDDEN1_STEP_DELAY:	
Lcdprintf(0, 0, "     STEP-TIME");
Lcdprintf(0, 1, " DELAY    :      sec");
Lcdprintf(0, 2, " LIMIT (%d ~ %d)", 1		, 10		);
{LcdCommandWrite(0x0F    );};
break;
}

bMenuDisplay = 0;
bVarDisplay = 1;
}

if (bVarDisplay)
{
switch(Mode1Step)
{
case MODE1_NOMAL:	
if (TestMode)
{
ReadPressure = GetItv();
Lcdprintf(0, 0, "Ky=%02X,EK=%02X,Ss=%02X", Key, ExtKey, Sensor);
Lcdprintf(0, 1, "Run=%d,Step=%2d,Dly=%2d", bRun, RunStep, RunStepDelay);
Lcdprintf(0, 2, "Mode1Step = %d", Mode1Step);

Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
}else if (bCalib) {
switch(CalibStep)
{
case 0:

case 1:

break;

case 10:    
Lcdprintf(0, 0, "ITV 4mA Calib Mode!!");
Lcdprintf(0, 1, "Set VR10            ");
Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
break;
case 11:    
Lcdprintf(0, 0, "ITV 20mA Calib Mode!");
Lcdprintf(0, 1, "Set VR11            ");
Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
break;

case 12:    
Lcdprintf(0, 0, "ITV 1V Calib Mode! ");
Lcdprintf(0, 1, "Set Volt 1V  :%ld", CalItvMin);
Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
break;
case 13:    
Lcdprintf(0, 0, "ITV 5V Calib Mode! ");
Lcdprintf(0, 1, "Set Volt 5V  :%ld", CalItvMax);
Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
break;

}            
}else if (HiddenStep) {

}
else {
ReadPressure = GetItv();

Lcdprintf(13, 3, "%d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
if (bAutoMode) Lcdprintf(16, 2, "%2d.%d", (RunStepTime / 10) / 10, (RunStepTime / 10) % 10);
else Lcdprintf(16, 2, "%2d.%d", (mRunStepTime / 10) / 10, (mRunStepTime / 10) % 10);
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

case RUN_EXHAUST1:
Lcdprintf(0, 3, "CYL D1     ");
break;

case RUN_EXHAUST2:
Lcdprintf(0, 3, "CYL D2     ");
break;

case RUN_CYL_DOWN:
Lcdprintf(0, 3, "CYL DOWN   ");
break;

case RUN_PRESSURE_DELAY:
Lcdprintf(0, 3, "PRESSURE");
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
if ((bEmoState == 1) || (bEmoState == 2))
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
Lcdprintf(0, 3, "READY        ");
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

case MODE2_PRESSURE_SET:	
Lcdprintf(12, 1, "%d.%02d", SetData / 100, SetData % 100);
LineDecision(15, 1);
break;

case MODE2_PRESSURE_DELAY_SET:	
Lcdprintf(12, 1, "%2d.%d", SetData / 10, SetData % 10);
LineDecision(15, 1);
break;
}

switch(HiddenStep)
{
case HIDDEN1_STEP:	
Lcdprintf(13, 1, "%02d", Hidden1SetData);
LineDecision(14, 1);
break;

case HIDDEN1_STEP_DELAY:	
Lcdprintf(12, 1, "%2d.%d", Hidden1SetData / 10, Hidden1SetData % 10);
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
((*(unsigned char *) 0x105) |= 0x08)		;
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

if (RunStep == RUN_PRESSURE_DELAY) 
{
if (!bPressureFail && !bRunAlarm)
{        
if (bBlink)
{
((*(unsigned char *) 0x105) &= ~0x08)		;
((*(unsigned char *) 0x105) |= 0x10)		;  
} else{
((*(unsigned char *) 0x105) |= 0x08)		;
((*(unsigned char *) 0x105) |= 0x10)		; 
}
}else { 
if (bBlink)
{  
((*(unsigned char *) 0x105) |= 0x08)		;
((*(unsigned char *) 0x105) &= ~0x10)		;
} else {
((*(unsigned char *) 0x105) |= 0x08)		;
((*(unsigned char *) 0x105) |= 0x10)		;
}
}
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
switch(Mode1Step)
{
case MODE1_NOMAL:
break;
case MODE2_PRESSURE_SET:	
if (KeyDownCount > 30) {
SetData += 10;
if (SetData > 600     ) SetData = 600     ;
}else {
if (++SetData > 600     ) SetData--;
}
bVarDisplay = 1;
break;
case MODE2_PRESSURE_DELAY_SET:	
if (KeyDownCount > 30) {
SetData += 10;
if (SetData > 200) SetData = 200;
}else {
if (++SetData > 200) SetData--;
}
bVarDisplay = 1;
break;
}

switch(HiddenStep)
{
case HIDDEN1_STEP:				
if (KeyDownCount > 30) {
Hidden1SetData += 10;
if (Hidden1SetData > 10		) Hidden1SetData = 10		;
}else {
if (++Hidden1SetData > 10		) Hidden1SetData--;
}
bVarDisplay = 1;
break;
case HIDDEN1_STEP_DELAY:		
if (KeyDownCount > 30) {
Hidden1SetData += 10;
if (Hidden1SetData > 10		) Hidden1SetData = 10		;
}else {
if (++Hidden1SetData > 10		) Hidden1SetData--;
}
bVarDisplay = 1;
break;
}
break;

case 0x20:
switch(Mode1Step)
{
case MODE1_NOMAL:
break;
case MODE2_PRESSURE_SET:
if (KeyDownCount > 30) {
if (SetData > 0 + 10) SetData -= 10;
else SetData = 0;
}else {
if (SetData > 0) SetData--;
}
bVarDisplay = 1;
break;
case MODE2_PRESSURE_DELAY_SET:	
if (KeyDownCount > 30) {
if (SetData > 0 + 10) SetData -= 10;
else SetData = 0;
}else {
if (SetData > 0) SetData--;
}
bVarDisplay = 1;
break;
}

switch(HiddenStep)
{
case HIDDEN1_STEP:				
if (KeyDownCount > 30) {
if (Hidden1SetData > 2		 + 10) Hidden1SetData -= 10;
else Hidden1SetData = 2		;
}else {
if (Hidden1SetData > 2		) Hidden1SetData--;
}
bVarDisplay = 1;
break;
case HIDDEN1_STEP_DELAY:		
if (KeyDownCount > 30) {
if (Hidden1SetData > 1		 + 10) Hidden1SetData -= 10;
else Hidden1SetData = 1		;
}else {
if (Hidden1SetData > 1		) Hidden1SetData--;
}
bVarDisplay = 1;
break;
}
break;
}

if (Key == (0x01 | 0x80))
{
if (bAgingMode)
{
KeyDownCount = 0;
SetBuzzer(1, 2);
if (!bRun)	
{
bAgingEnd = 0;
if (!bAgingEnd)
{
if (bDoorSensorFail == 0 && bSafeSensorFail == 0 && !Emo && !bPressureFail)
{
Mode1Step = 0;
bRun = 1;
bRunAlarm = 0;
bMenuDisplay = 1;
bVarDisplay = 1;
}else {
SetBuzzer(1, 1);
bVarDisplay = 1;
}
}
}else {
bAgingEnd = 1;
if (bAgingEnd)
{

bRunAlarm = 0;
bMenuDisplay = 1;
bVarDisplay = 1;

}
}
}
}

}else {
if (Key == (0x01 | 0x80))
{
if (bReturnSensor == 1 || bEmoState == 1)
{
bReturnSensor = 2;
bEmoState = 2;
}else if (!bAgingMode && bAutoMode && !bRun)
{
bAgingMode = 0;
if (bDoorSensorFail == 0 && bSafeSensorFail == 0 && !Emo && !bPressureFail)
{
Mode1Step = 0;
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

break;
case 0x04:	
break;

case 0x08:
if (HiddenStep)
{
switch(HiddenStep)
{
case HIDDEN1_STEP:				
PressureStep = Hidden1SetData;
SetEeprom2(16, PressureStep);

HiddenStep = HIDDEN1_STEP_DELAY;
Hidden1SetData = sPressureStepDelay;
bMenuDisplay = 1;
SetBuzzer(0, 0);
break;
case HIDDEN1_STEP_DELAY:		
sPressureStepDelay = Hidden1SetData;
SetEeprom2(18, sPressureStepDelay);

HiddenStep = HIDDEN1_STEP;
Hidden1SetData = PressureStep;
bMenuDisplay = 1;
SetBuzzer(0, 0);
break;
}
} else if (Mode1Step >= MODE1_OCTA && Mode1Step <= MODE1_ETC){ 	

sMode1Step = Mode1Step;
SetEeprom2(6, Mode1Step);
switch (Mode1Step)
{
case MODE1_OCTA:
Pressure = 550			;
PressureTime = 117			;
break;
case MODE1_TAPE:
Pressure = 300			;
PressureTime = 46			;
break;
case MODE1_BATTERY:
Pressure = 550			;
PressureTime = 117			;
break;
case MODE1_ETC:
Pressure = GetEeprom2(2);
PressureTime = GetEeprom2(0);
break;
}

Mode1Step = MODE2_PRESSURE_SET;	
SetData = Pressure;
SetEeprom2(2, Pressure);
SetItv(Pressure);
bMenuDisplay = 1;
SetBuzzer(0, 0);
} else{				
switch(Mode1Step)
{
case MODE2_PRESSURE_SET:	
Pressure = SetData;
SetEeprom2(2, Pressure);
SetItv(Pressure);

Mode1Step = MODE2_PRESSURE_DELAY_SET;
SetData = PressureTime;
bMenuDisplay = 1;
SetBuzzer(0, 0);
break;
case MODE2_PRESSURE_DELAY_SET:	
PressureTime = SetData;
SetEeprom2(0, PressureTime);

Mode1Step = MODE2_PRESSURE_SET;
SetData = Pressure;
bMenuDisplay = 1;
SetBuzzer(0, 0);
break;
}
}

if (bCalib && CalibStep >= 10){
switch(CalibStep)
{
case 12:
CalItvMin = Ltc1865Read(0);
SetEeprom2(10, CalItvMin);
break;

case 13:
CalItvMax = (unsigned long)((unsigned long)Ltc1865Read(0) * 1);     
SetEeprom4(12, CalItvMax);
break;
}
SetBuzzer(0, 0);
}
break;

case 0x10:
if (!HiddenStep)
{
switch(Mode1Step)
{
case MODE1_NOMAL:
if (!bAutoMode)	
{
SetItv(200);     
if (Sensor & 0x02	 || Sensor & 0x01	)
{
bCylYDown = !bCylYDown;
if (bCylYDown) (((*(unsigned char *) 0x108) &= ~0x04), ((*(unsigned char *) 0x108) |= 0x08));
else (((*(unsigned char *) 0x108) |= 0x04), ((*(unsigned char *) 0x108) &= ~0x08));
}
bVarDisplay = 1;
}
break;
case MODE1_OCTA:
case MODE1_TAPE:
case MODE1_BATTERY:
case MODE1_ETC:
if (++Mode1Step >= 5) Mode1Step = 4;	
bMenuDisplay = 1;
break;
case MODE2_PRESSURE_SET:
if (++SetData > 600     ) SetData--;
bVarDisplay = 1;
break;
case MODE2_PRESSURE_DELAY_SET:	
if (++SetData > 200) SetData--;
bVarDisplay = 1;
break;
}
} else{
switch(HiddenStep)
{
case HIDDEN1_STEP:				
if (++Hidden1SetData > 10		) Hidden1SetData--;
bVarDisplay = 1;
break;
case HIDDEN1_STEP_DELAY:		
if (++Hidden1SetData > 10		) Hidden1SetData--;
bVarDisplay = 1;
break;
}
}
SetBuzzer(0, 0);
break;

case 0x20:
if (!HiddenStep)
{
switch(Mode1Step)
{
case MODE1_NOMAL:
if (!bAutoMode && !bCylYDown)
{
SetItv(200);     
if (Sensor & 0x04	)
{
bCylXIn = !bCylXIn;
if (bCylXIn) (((*(unsigned char *) 0x108) |= 0x01), ((*(unsigned char *) 0x108) &= ~0x02));
else (((*(unsigned char *) 0x108) |= 0x02), ((*(unsigned char *) 0x108) &= ~0x01));
}
bVarDisplay = 1;
}
break;
case MODE1_OCTA:
case MODE1_TAPE:
case MODE1_BATTERY:
case MODE1_ETC:
if (--Mode1Step <= 0) Mode1Step = 1;	
bMenuDisplay = 1;
break;
case MODE2_PRESSURE_SET:
if (SetData > 0) SetData--;
bVarDisplay = 1;
break;
case MODE2_PRESSURE_DELAY_SET:	
if (SetData > 0) SetData--;
bVarDisplay = 1;
break;
}
} else{					
switch(HiddenStep)
{
case HIDDEN1_STEP:				
if (Hidden1SetData > 2		) Hidden1SetData--;
bVarDisplay = 1;
break;
case HIDDEN1_STEP_DELAY:		
if (Hidden1SetData > 1		) Hidden1SetData--;
bVarDisplay = 1;
break;
}
}
SetBuzzer(0, 0);
break;
case 0x40:
if (bCalib && CalibStep >= 10)
{
if (++CalibStep >= 12) CalibStep = 10;
}
SetBuzzer(0, 0);
bMenuDisplay = 1;
break;

}
}else {	
switch(PrevDownKey)
{
case 0x02			:	
if (!HiddenStep)	
{
if (Mode1Step)
{
Mode1Step = 0;
}else {
Mode1Step = 1;
}
SetData = Pressure;
bMenuDisplay = 1;
SetBuzzer(0, 1);
}
break;

case 0x04:	
if (!bRun && Mode1Step == 0 && !HiddenStep)
{
if (++bAutoMode >= 3) bAutoMode = 0;
if (bAutoMode == 1) bAutoMode = 2;		
bMenuDisplay = 1;
bAgingMode = 0;
SetEeprom2(4, bAutoMode);
if (bAutoMode) mRunStepTime = 0;
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
case 0x40 | 0x08:
if (!bRun && Mode1Step == 0)
{
bAgingMode = !bAgingMode;
bMenuDisplay = 1;

}
SetBuzzer(0, 1);
break;

case 0x10 | 0x20:
TestMode = !TestMode;
bCalib = 0; 
bMenuDisplay = 1;
SetBuzzer(1, 0);
break;   

case 0x40 | 0x02			: 
bCalib = !bCalib;
bMenuDisplay = 1;

if (bCalib)
{
CalibStep = 10;
}else {
SetItv(Pressure);
}
SetBuzzer(1, 0);
break;

case 0x40 | 0x04:	
if (!bRun && Mode1Step == 0)	
{
HiddenStep = !HiddenStep;
Hidden1SetData = PressureStep;
bMenuDisplay = 1;
SetBuzzer(0, 1);
}
break;  
}
}
}else {
if (SetupExitTime && Mode1Step)
{
SetupExitTime--;
if (SetupExitTime == 0)
{
Mode1Step = 0;
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

void StepPressureSubroutine(void)
{
unsigned int DownPressureStep = Pressure / PressureStep;

if (RunStep == RUN_CYL_DOWN && !bEmoState && !bReturnSensor && !bDownPressureEnd)
{
if (Sensor & 0x08	)
{
if (PressureStepDelay)
{
PressureStepDelay--;
} else{
if (DownPressure <= Pressure)
{
DownPressure += DownPressureStep;
if (DownPressure >= Pressure) DownPressure = Pressure;

SetItv(DownPressure);

if (DownPressure >= Pressure)
{
bDownPressureEnd = 1;
DownPressure = 0;
}
PressureStepDelay = sPressureStepDelay;
}
}
}
}
}

void PressureRewardSubroutine(void)
{
unsigned long GetPressure;

if (bPressureReward && RunStepTime >= 50)	
{
GetPressure = GetItv();
if ((Pressure - GetPressure) > 0) SetItv(Pressure + abs(Pressure - GetPressure));	
else if ((Pressure - GetPressure) < 0) SetItv(Pressure - abs(Pressure - GetPressure));	

bPressureReward = 0;
}
}

void PressureCheckSubroutine(void)
{
unsigned long GetPressure;

if (bAutoMode == 2  && (RunStep == RUN_PRESSURE_DELAY) && !bRunAlarm)
{
GetPressure = GetItv();
if (RunStepTime >= 100)	
{
if (abs(Pressure - GetPressure) > 50	) bPressureFail = 1;

}
}
}

