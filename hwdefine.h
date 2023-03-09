#include <mega2560.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <delay.h>

#pragma library With_setup.lib
#pragma library With_util.lib
#pragma library With_lcd.lib
#pragma library With_main.lib

 
#include "With_util.h"
#include "With_lcd.h"

#include "main.h"
#include "UserMain.h"

#ifndef __HWDEFINE__
#define __HWDEFINE__

#define DEBUG_MODE

#define MsgPrintf			Uartprintf0
#define MainComm            Uartprintf1

#ifdef DEBUG_MODE
    #define DebugComm			Uartprintf0
#else
    #define DebugComm			Nullprintf
#endif

#define CYL_X_IN_SENSOR		0x02	// SENSOR1
#define CYL_X_OUT_SENSOR	0x01	// SENSOR2
#define CYL_Y_DOWN_SENSOR	0x08	// SENSOR4
#define CYL_Y_UP_SENSOR		0x04	// SENSOR3

#define SAFE_SENSOR			0x10	// SENSOR5 default = 1
#define DOOR_SENSOR			0x20	// SENSOR6 default = 1

// 14.12.23 sis 복동 sol 구동 변경으로 인해 주석처리**********
//#define CYL_X_IN            Sol1On()
//#define CYL_X_OUT			Sol1Off()
//#define CYL_Y_DOWN			Sol2On()
//#define CYL_Y_UP			Sol2Off()

// 복동 
#define CYL_X_IN                        (Sol1On(), Sol2Off())
//#define CYL_X_OUT			(Sol1Off(), Sol2On())
#define CYL_X_OUT			(Sol2On(), Sol1Off())
//#define CYL_Y_DOWN			(Sol3On(), Sol4Off())
//#define CYL_Y_UP			(Sol3Off(), Sol4On())
#define CYL_Y_DOWN			(Sol3Off(), Sol4On())
#define CYL_Y_UP			(Sol3On(), Sol4Off())
// ************************************************************

#define KEY_MENU			0x02			
#define KEY_MODE			0x04
#define	KEY_ENTER			0x08
#define KEY_UP				0x10
#define KEY_DOWN			0x20
#define KEY_FN				0x40

#define EXT_KEY1			0x01
#define EXT_KEY2			0x02
#define EXT_KEY3			0x04
#define EXT_KEY4			0x08

#define SW_EMO				0x40

#define SW_START1			0x01
#define SW_START2			0x80

// *************************************************************
// Software Define
// *************************************************************
#define FILTERSIZE			10
#define RX_BUFFER_SIZE		300

// Queue
#define COMMAND_BUFFER_SIZE 50
#define QUEUE_SIZE      	256

extern volatile unsigned char QueueData[QUEUE_SIZE];
extern volatile unsigned int QueueFirst;
extern volatile unsigned int QueueLast;
extern volatile unsigned char CommCommandBuffer[];
extern volatile unsigned int CommCommandSize;

extern volatile unsigned char Key;
extern volatile unsigned char ExtKey;
extern volatile unsigned char Sensor;
extern volatile unsigned char Emo;

extern volatile unsigned char bBlink;

#define PRESSURE_TIME_MIN	0
#define PRESSURE_TIME_MAX	200

#define PRESSURE_MIN		0
#define PRESSURE_MAX		900
//#define PRESSURE_MAX_		300     //10kg
#define PRESSURE_MAX_		600     //5Kg

#define PRESSURE_LIMIT		50	// x.xx

#define ITV_MIN				0
#define ITV_MAX				900

#define SETUP_EXIT_TIME		100	// 10sec


//#define NULL		       	0
#define TRUE				1
#define FALSE				0

// Eeprom Position
#define EEPROM_SAVE_WIDTH	        2
#define INIT_POS		        0x3ff	// 1bytes
// data
//#define INIT_CODE						0x01	// Version
//#define INIT_CODE						0x02	// Version  // 교정모드
#define INIT_CODE						0x03	// Version  // 교정모드

// Stx(1byte) + Channel(4byte) + Command(1byte) + Data(1byte) + CheckSum(1byte) + Etx(1byte)
#define ASCII_STX      			0x02
#define ASCII_ETX  				0x03
#define ENTER					0x0D
#define ESC						0x1B


#define WRITE					0x00
#define READ					0x01

#ifndef RXB8
#define RXB8 1
#endif

#ifndef TXB8
#define TXB8 0
#endif

#ifndef UPE
#define UPE 2
#endif

#ifndef DOR
#define DOR 3
#endif

#ifndef FE
#define FE 4
#endif

#ifndef UDRE
#define UDRE 5
#endif

#ifndef TXC
#define TXC 6
#endif

#ifndef RXC
#define RXC 7
#endif

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)

// *************************************************************
// Hardware Define
// *************************************************************
#define SensorIn()		(~PINF & 0xFF)
#define KeyIn()			(~PINC & 0xFF)
#define ExtKeyIn()		(~PINL & 0x0F)
#define ModeIn()		((~PINE >> 2) & 0x03)
#define EmoIn()			(~PIND & 0x01)

#define Sol1On()		(PORTK |= 0x01)
#define Sol2On()		(PORTK |= 0x02)
#define Sol3On()		(PORTK |= 0x04)
#define Sol4On()		(PORTK |= 0x08)
#define Sol1Off()		(PORTK &= ~0x01)
#define Sol2Off()		(PORTK &= ~0x02)
#define Sol3Off()		(PORTK &= ~0x04)
#define Sol4Off()		(PORTK &= ~0x08)

#define Led1Off()		(PORTJ |= 0x01)		
#define Led2Off()		(PORTJ |= 0x02)		
#define LedComOff()		(PORTJ |= 0x04)		
#define LedPassOff()	(PORTJ |= 0x08)		
#define LedFailOff()	(PORTJ |= 0x10)		
#define BuzzerOn()		(PORTJ |= 0x20)		

#define Led1On()		(PORTJ &= ~0x01)		
#define Led2On()		(PORTJ &= ~0x02)		
#define LedComOn()		(PORTJ &= ~0x04)		
#define LedPassOn()		(PORTJ &= ~0x08)		
#define LedFailOn()		(PORTJ &= ~0x10)		
#define BuzzerOff()		(PORTJ &= ~0x20)

#define LcdDataBus(x)	(PORTH = x)
#define LcdEHigh()		(PORTA |= 0x20)		
#define LcdRwHigh()		(PORTA |= 0x40)		
#define LcdRsHigh()		(PORTA |= 0x80)		
#define LcdELow()		(PORTA &= ~0x20)		
#define LcdRwLow()		(PORTA &= ~0x40)		
#define LcdRsLow()		(PORTA &= ~0x80)

#define Sdi()			(PINA & 0x04)		
#define SckHigh()		(PORTA |= 0x08)		
#define SdoHigh()		(PORTA |= 0x10)		
#define Sync2High()		(PORTA |= 0x02)		
#define Sync1High()		(PORTA |= 0x01)		
#define SckLow()		(PORTA &= ~0x08)		
#define SdoLow()		(PORTA &= ~0x10)		
#define Sync2Low()		(PORTA &= ~0x02)		
#define Sync1Low()		(PORTA &= ~0x01)


#endif		
