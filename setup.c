/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
� Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 2014-10-02
Author  : 
Company : 
Comments: 


Chip type               : ATmega2560
Program type            : Application
AVR Core Clock frequency: 7.372800 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 2048
*****************************************************/

#include "hwdefine.h"

volatile unsigned char QueueData[QUEUE_SIZE];
volatile unsigned int QueueFirst = 0;
volatile unsigned int QueueLast = 0;
volatile unsigned char CommCommandBuffer[COMMAND_BUFFER_SIZE];
volatile unsigned int CommCommandSize = 0;

// USART0 Receiver interrupt service routine
interrupt [USART0_RXC] void usart0_rx_isr(void)
{
char status,data;
status=UCSR0A;
data=UDR0;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	{
	QueueData[QueueLast] = data;
	if (++QueueLast >= QUEUE_SIZE) QueueLast = 0;
	}
}

// USART1 Receiver interrupt service routine
interrupt [USART1_RXC] void usart1_rx_isr(void)
{
char status,data;
status=UCSR1A;
data=UDR1;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	{

	}
}

// Standard Input/Output functions
#include <stdio.h>

volatile unsigned char bMainStart = 0;
volatile unsigned char bHalfMainStart = 0;
volatile unsigned int IntCount = 0;
volatile unsigned char bBlink = 0;

volatile unsigned char Key = 0;
volatile unsigned char ExtKey = 0;
volatile unsigned char Sensor = 0;
volatile unsigned char Emo = 0;

volatile unsigned char NewKey = 0;
volatile unsigned char NewExtKey = 0;
volatile unsigned char NewSensor = 0;
volatile unsigned char NewEmo = 0;
volatile unsigned char OldKey = 0;
volatile unsigned char OldExtKey = 0;
volatile unsigned char OldSensor = 0;
volatile unsigned char OldEmo = 0;


// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
	// Reinitialize Timer 0 value
	TCNT0=0x8E;
	// Place your code here
    
    TickCount++;
	// 1ms Routine

	if (++IntCount >= 500)
    {
    	bHalfMainStart = 1;
        IntCount = 0;
    }

    if ((IntCount % 10) == 0)	// 10ms
    {
		NewKey = KeyIn();
		if(NewKey == OldKey) Key = NewKey;
		OldKey = NewKey;

		NewSensor = SensorIn();
		if(NewSensor == OldSensor) Sensor = NewSensor;
		OldSensor = NewSensor;

		NewExtKey = ExtKeyIn();
		if(NewExtKey == OldExtKey) ExtKey = NewExtKey;
		OldExtKey = NewExtKey;

		NewEmo = EmoIn();
		if(NewEmo == OldEmo) 
		{
			Emo = NewEmo;
			if (Emo) bEmoState = 1;
		}else {
				if (!bRun && bEmoState == 1) bEmoState = 0;	// Run중에만 동작
				//else if (bEmoState == 1) bEmoState = 2;
		}
		OldEmo = NewEmo;

    	bMainStart = 1;
	}
}

// Declare your global variables here

void main(void)
{
// Declare your local variables here

// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Input/Output Ports initialization
// Port A initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=In Func1=Out Func0=Out 
// State7=1 State6=1 State5=1 State4=1 State3=0 State2=1 State1=1 State0=1 
PORTA=0xF7;
DDRA=0xFB;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=P State6=P State5=P State4=P State3=P State2=P State1=P State0=P 
PORTB=0xFF;
DDRB=0x00;

// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=P State6=P State5=P State4=P State3=P State2=P State1=P State0=P 
PORTC=0xFF;
DDRC=0x00;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=Out Func2=In Func1=In Func0=In 
// State7=P State6=P State5=P State4=P State3=1 State2=P State1=P State0=P 
PORTD=0xFF;
DDRD=0x08;

// Port E initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=In 
// State7=P State6=P State5=P State4=P State3=P State2=P State1=1 State0=P 
PORTE=0xFF;
DDRE=0x02;

// Port F initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=P State6=P State5=P State4=P State3=P State2=P State1=P State0=P 
PORTF=0xFF;
DDRF=0x00;

// Port G initialization
// Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State5=P State4=P State3=P State2=P State1=P State0=P 
PORTG=0x3F;
DDRG=0x00;

// Port H initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=1 State6=1 State5=1 State4=1 State3=1 State2=1 State1=1 State0=1 
PORTH=0xFF;
DDRH=0xFF;

// Port J initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTJ=0x00;
DDRJ=0xFF;

// Port K initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTK=0x00;
DDRK=0xFF;

// Port L initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=P State6=P State5=P State4=P State3=P State2=P State1=P State0=P 
PORTL=0xFF;
DDRL=0x00;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 115.200 kHz
// Mode: Normal top=0xFF
// OC0A output: Disconnected
// OC0B output: Disconnected
TCCR0A=0x00;
TCCR0B=0x03;
TCNT0=0x8E;
OCR0A=0x00;
OCR0B=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Discon.
// OC1B output: Discon.
// OC1C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
OCR1CH=0x00;
OCR1CL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2A output: Disconnected
// OC2B output: Disconnected
ASSR=0x00;
TCCR2A=0x00;
TCCR2B=0x00;
TCNT2=0x00;
OCR2A=0x00;
OCR2B=0x00;

// Timer/Counter 3 initialization
// Clock source: System Clock
// Clock value: Timer3 Stopped
// Mode: Normal top=0xFFFF
// OC3A output: Discon.
// OC3B output: Discon.
// OC3C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer3 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR3A=0x00;
TCCR3B=0x00;
TCNT3H=0x00;
TCNT3L=0x00;
ICR3H=0x00;
ICR3L=0x00;
OCR3AH=0x00;
OCR3AL=0x00;
OCR3BH=0x00;
OCR3BL=0x00;
OCR3CH=0x00;
OCR3CL=0x00;

// Timer/Counter 4 initialization
// Clock source: System Clock
// Clock value: Timer4 Stopped
// Mode: Normal top=0xFFFF
// OC4A output: Discon.
// OC4B output: Discon.
// OC4C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer4 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR4A=0x00;
TCCR4B=0x00;
TCNT4H=0x00;
TCNT4L=0x00;
ICR4H=0x00;
ICR4L=0x00;
OCR4AH=0x00;
OCR4AL=0x00;
OCR4BH=0x00;
OCR4BL=0x00;
OCR4CH=0x00;
OCR4CL=0x00;

// Timer/Counter 5 initialization
// Clock source: System Clock
// Clock value: Timer5 Stopped
// Mode: Normal top=0xFFFF
// OC5A output: Discon.
// OC5B output: Discon.
// OC5C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer5 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR5A=0x00;
TCCR5B=0x00;
TCNT5H=0x00;
TCNT5L=0x00;
ICR5H=0x00;
ICR5L=0x00;
OCR5AH=0x00;
OCR5AL=0x00;
OCR5BH=0x00;
OCR5BL=0x00;
OCR5CH=0x00;
OCR5CL=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: Off
// INT5: Off
// INT6: Off
// INT7: Off
EICRA=0x00;
EICRB=0x00;
EIMSK=0x00;
// PCINT0 interrupt: Off
// PCINT1 interrupt: Off
// PCINT2 interrupt: Off
// PCINT3 interrupt: Off
// PCINT4 interrupt: Off
// PCINT5 interrupt: Off
// PCINT6 interrupt: Off
// PCINT7 interrupt: Off
// PCINT8 interrupt: Off
// PCINT9 interrupt: Off
// PCINT10 interrupt: Off
// PCINT11 interrupt: Off
// PCINT12 interrupt: Off
// PCINT13 interrupt: Off
// PCINT14 interrupt: Off
// PCINT15 interrupt: Off
// PCINT16 interrupt: Off
// PCINT17 interrupt: Off
// PCINT18 interrupt: Off
// PCINT19 interrupt: Off
// PCINT20 interrupt: Off
// PCINT21 interrupt: Off
// PCINT22 interrupt: Off
// PCINT23 interrupt: Off
PCMSK0=0x00;
PCMSK1=0x00;
PCMSK2=0x00;
PCICR=0x00;

// Timer/Counter 0 Interrupt(s) initialization
TIMSK0=0x01;

// Timer/Counter 1 Interrupt(s) initialization
TIMSK1=0x00;

// Timer/Counter 2 Interrupt(s) initialization
TIMSK2=0x00;

// Timer/Counter 3 Interrupt(s) initialization
TIMSK3=0x00;

// Timer/Counter 4 Interrupt(s) initialization
TIMSK4=0x00;

// Timer/Counter 5 Interrupt(s) initialization
TIMSK5=0x00;

// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: On
// USART0 Mode: Asynchronous
// USART0 Baud Rate: 115200
UCSR0A=0x00;
UCSR0B=0x98;
UCSR0C=0x06;
UBRR0H=0x00;
UBRR0L=0x03;

// USART1 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART1 Receiver: On
// USART1 Transmitter: On
// USART1 Mode: Asynchronous
// USART1 Baud Rate: 115200
UCSR1A=0x00;
UCSR1B=0x98;
UCSR1C=0x06;
UBRR1H=0x00;
UBRR1L=0x03;

// USART2 initialization
// USART2 disabled
UCSR2B=0x00;

// USART3 initialization
// USART3 disabled
UCSR3B=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
ADCSRB=0x00;
DIDR1=0x00;

// ADC initialization
// ADC disabled
ADCSRA=0x00;

// SPI initialization
// SPI disabled
SPCR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;

// Alphanumeric LCD initialization
// Connections specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTA Bit 7
// RD - PORTA Bit 6
// EN - PORTA Bit 5
// D4 - PORTH Bit 4
// D5 - PORTH Bit 5
// D6 - PORTH Bit 6
// D7 - PORTH Bit 7
// Characters/line: 24
//lcd_init(24);

// Global enable interrupts
#asm("sei")

    HwInit();

    while (1)
    {
        // Place your code here
        CommSubroutine();
        
		if (bMainStart)	// 10ms Routine
		{
			bMainStart = 0;

            UserMain();
		}

		if (bHalfMainStart)	// 500ms Routine
		{
			bHalfMainStart = 0;
			bBlink = !bBlink;

            HalfSecMain();
        }
    }
}
