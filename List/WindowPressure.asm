
;CodeVisionAVR C Compiler V2.03.4 Standard
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega2560
;Program type           : Application
;Clock frequency        : 7.372800 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : float, width, precision
;(s)scanf features      : long, width
;External RAM size      : 0
;Data Stack size        : 2048 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : No
;global const stored in FLASH  : Yes
;8 bit enums            : No
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega2560
	#pragma AVRPART MEMORY PROG_FLASH 262144
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 8192
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x200

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x74
	.EQU XMCRB=0x75
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	LDI  R23,BYTE4(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+@1,R0
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0x00

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  _usart0_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart1_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

;GPIOR0 INITIALIZATION
	.EQU  __GPIOR0_INIT=0x00

;DATA STACK END MARKER INITIALIZATION
__DSTACK_END:
	.DB  'D','S','T','A','C','K','E','N','D',0

;HARDWARE STACK END MARKER INITIALIZATION
__HSTACK_END:
	.DB  'H','S','T','A','C','K','E','N','D',0

_0x3:
	.DB  0x6
_0x4:
	.DB  0x1
_0x5:
	.DB  0x1
_0x6:
	.DB  0x2
_0x0:
	.DB  0x48,0x45,0x4C,0x50,0x0,0xA,0xD,0x0
	.DB  0x20,0x20,0x43,0x6F,0x6D,0x6D,0x61,0x6E
	.DB  0x64,0x20,0x4C,0x69,0x73,0x74,0xA,0xD
	.DB  0x0,0x20,0x20,0x48,0x45,0x4C,0x50,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x3A,0x20
	.DB  0x20,0x20,0x48,0x65,0x6C,0x70,0x20,0x4D
	.DB  0x65,0x61,0x73,0x73,0x61,0x67,0x65,0xA
	.DB  0xD,0x0,0x20,0x20,0x54,0x45,0x53,0x54
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x3A
	.DB  0x20,0x20,0x20,0x54,0x45,0x53,0x54,0x20
	.DB  0x43,0x6F,0x6D,0x6D,0x61,0x6E,0x64,0xA
	.DB  0xD,0x0,0x20,0x20,0x44,0x45,0x42,0x55
	.DB  0x47,0x20,0x20,0x20,0x20,0x20,0x20,0x3A
	.DB  0x20,0x20,0x20,0x44,0x45,0x42,0x55,0x47
	.DB  0x20,0x43,0x6F,0x6D,0x6D,0x61,0x6E,0x64
	.DB  0xA,0xD,0x0,0x20,0x20,0x56,0x45,0x52
	.DB  0x3F,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x3A,0x20,0x20,0x20,0x56,0x65,0x72,0x73
	.DB  0x69,0x6F,0x6E,0x20,0x43,0x6F,0x6D,0x6D
	.DB  0x61,0x6E,0x64,0xA,0xD,0x0,0x54,0x45
	.DB  0x53,0x54,0x0,0x54,0x65,0x73,0x74,0x20
	.DB  0x4D,0x6F,0x64,0x65,0x20,0x25,0x64,0xA
	.DB  0xD,0x0,0x54,0x65,0x73,0x74,0x20,0x4D
	.DB  0x6F,0x64,0x65,0x20,0x44,0x69,0x73,0x61
	.DB  0x62,0x6C,0x65,0xA,0xD,0x0,0x44,0x45
	.DB  0x42,0x55,0x47,0x0,0x44,0x65,0x62,0x75
	.DB  0x67,0x20,0x4D,0x6F,0x64,0x65,0x20,0x45
	.DB  0x6E,0x61,0x62,0x6C,0x65,0xA,0xD,0x0
	.DB  0x44,0x65,0x62,0x75,0x67,0x20,0x4D,0x6F
	.DB  0x64,0x65,0x20,0x44,0x69,0x73,0x61,0x62
	.DB  0x6C,0x65,0xA,0xD,0x0,0x43,0x6F,0x6D
	.DB  0x6D,0x61,0x6E,0x64,0x20,0x3F,0xA,0x0
	.DB  0x4D,0x4F,0x44,0x45,0x20,0x3A,0x20,0x4F
	.DB  0x43,0x54,0x41,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x56,0x0,0x4D,0x4F,0x44,0x45,0x20
	.DB  0x3A,0x20,0x54,0x41,0x50,0x45,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x56,0x0,0x4D,0x4F
	.DB  0x44,0x45,0x20,0x3A,0x20,0x42,0x41,0x54
	.DB  0x54,0x20,0x20,0x20,0x20,0x20,0x20,0x56
	.DB  0x0,0x4D,0x4F,0x44,0x45,0x20,0x3A,0x20
	.DB  0x45,0x54,0x43,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x56,0x0,0x30,0x36,0x0,0x53
	.DB  0x74,0x61,0x74,0x75,0x73,0x3A,0x0,0x52
	.DB  0x55,0x4E,0x20,0x20,0x54,0x49,0x4D,0x3A
	.DB  0x0,0x53,0x54,0x4F,0x50,0x20,0x54,0x49
	.DB  0x4D,0x3A,0x0,0x41,0x55,0x54,0x4F,0x3A
	.DB  0x0,0x45,0x44,0x47,0x45,0x3A,0x0,0x4D
	.DB  0x41,0x4E,0x20,0x3A,0x0,0x41,0x47,0x49
	.DB  0x4E,0x47,0x3A,0x0,0x25,0x32,0x64,0x2E
	.DB  0x25,0x64,0x73,0x65,0x63,0x20,0x25,0x64
	.DB  0x2E,0x25,0x30,0x32,0x64,0x6B,0x67,0x66
	.DB  0x0,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x53,0x45,0x54,0x55,0x50,0x0,0x20,0x50
	.DB  0x52,0x45,0x53,0x53,0x55,0x52,0x45,0x20
	.DB  0x3A,0x20,0x20,0x20,0x20,0x20,0x20,0x6B
	.DB  0x67,0x66,0x0,0x20,0x4C,0x49,0x4D,0x49
	.DB  0x54,0x20,0x28,0x25,0x64,0x20,0x7E,0x20
	.DB  0x25,0x64,0x29,0x0,0x20,0x54,0x49,0x4D
	.DB  0x45,0x20,0x20,0x20,0x20,0x20,0x3A,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x73,0x65,0x63
	.DB  0x0,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x4F,0x43,0x54,0x41,0x0,0x25,0x64,0x2E
	.DB  0x25,0x30,0x32,0x64,0x0,0x25,0x32,0x64
	.DB  0x2E,0x25,0x64,0x0,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x54,0x41,0x50,0x45,0x0
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x42
	.DB  0x41,0x54,0x54,0x0,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x45,0x54,0x43,0x0,0x20
	.DB  0x20,0x20,0x50,0x52,0x45,0x53,0x53,0x55
	.DB  0x52,0x45,0x2D,0x53,0x54,0x45,0x50,0x0
	.DB  0x20,0x53,0x54,0x45,0x50,0x20,0x20,0x20
	.DB  0x20,0x20,0x3A,0x20,0x20,0x20,0x20,0x20
	.DB  0x53,0x54,0x45,0x50,0x0,0x20,0x20,0x20
	.DB  0x20,0x20,0x53,0x54,0x45,0x50,0x2D,0x54
	.DB  0x49,0x4D,0x45,0x0,0x20,0x44,0x45,0x4C
	.DB  0x41,0x59,0x20,0x20,0x20,0x20,0x3A,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x73,0x65,0x63
	.DB  0x0,0x4B,0x79,0x3D,0x25,0x30,0x32,0x58
	.DB  0x2C,0x45,0x4B,0x3D,0x25,0x30,0x32,0x58
	.DB  0x2C,0x53,0x73,0x3D,0x25,0x30,0x32,0x58
	.DB  0x0,0x52,0x75,0x6E,0x3D,0x25,0x64,0x2C
	.DB  0x53,0x74,0x65,0x70,0x3D,0x25,0x32,0x64
	.DB  0x2C,0x44,0x6C,0x79,0x3D,0x25,0x32,0x64
	.DB  0x0,0x4D,0x6F,0x64,0x65,0x31,0x53,0x74
	.DB  0x65,0x70,0x20,0x3D,0x20,0x25,0x64,0x0
	.DB  0x43,0x48,0x30,0x20,0x3D,0x20,0x25,0x64
	.DB  0x2E,0x25,0x30,0x32,0x64,0x6B,0x67,0x66
	.DB  0x0,0x49,0x54,0x56,0x20,0x34,0x6D,0x41
	.DB  0x20,0x43,0x61,0x6C,0x69,0x62,0x20,0x4D
	.DB  0x6F,0x64,0x65,0x21,0x21,0x0,0x53,0x65
	.DB  0x74,0x20,0x56,0x52,0x31,0x30,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x0,0x41,0x44,0x30,0x20,0x3D
	.DB  0x20,0x25,0x6C,0x64,0x28,0x30,0x78,0x25
	.DB  0x30,0x34,0x58,0x29,0x0,0x49,0x54,0x56
	.DB  0x20,0x32,0x30,0x6D,0x41,0x20,0x43,0x61
	.DB  0x6C,0x69,0x62,0x20,0x4D,0x6F,0x64,0x65
	.DB  0x21,0x0,0x53,0x65,0x74,0x20,0x56,0x52
	.DB  0x31,0x31,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x0,0x49
	.DB  0x54,0x56,0x20,0x31,0x56,0x20,0x43,0x61
	.DB  0x6C,0x69,0x62,0x20,0x4D,0x6F,0x64,0x65
	.DB  0x21,0x20,0x0,0x53,0x65,0x74,0x20,0x56
	.DB  0x6F,0x6C,0x74,0x20,0x31,0x56,0x20,0x20
	.DB  0x3A,0x25,0x6C,0x64,0x0,0x49,0x54,0x56
	.DB  0x20,0x35,0x56,0x20,0x43,0x61,0x6C,0x69
	.DB  0x62,0x20,0x4D,0x6F,0x64,0x65,0x21,0x20
	.DB  0x0,0x53,0x65,0x74,0x20,0x56,0x6F,0x6C
	.DB  0x74,0x20,0x35,0x56,0x20,0x20,0x3A,0x25
	.DB  0x6C,0x64,0x0,0x53,0x54,0x4F,0x50,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x0,0x53
	.DB  0x54,0x41,0x52,0x54,0x20,0x44,0x45,0x4C
	.DB  0x41,0x59,0x0,0x4A,0x49,0x47,0x20,0x49
	.DB  0x4E,0x20,0x20,0x20,0x20,0x20,0x0,0x43
	.DB  0x59,0x4C,0x20,0x44,0x31,0x20,0x20,0x20
	.DB  0x20,0x20,0x0,0x43,0x59,0x4C,0x20,0x44
	.DB  0x32,0x20,0x20,0x20,0x20,0x20,0x0,0x43
	.DB  0x59,0x4C,0x20,0x44,0x4F,0x57,0x4E,0x20
	.DB  0x20,0x20,0x0,0x50,0x52,0x45,0x53,0x53
	.DB  0x55,0x52,0x45,0x0,0x43,0x59,0x4C,0x20
	.DB  0x55,0x50,0x20,0x20,0x20,0x20,0x20,0x0
	.DB  0x4A,0x49,0x47,0x20,0x4F,0x55,0x54,0x20
	.DB  0x20,0x20,0x20,0x0,0x45,0x4E,0x44,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x0
	.DB  0x45,0x4D,0x45,0x52,0x47,0x45,0x4E,0x43
	.DB  0x59,0x21,0x21,0x21,0x0,0x53,0x41,0x46
	.DB  0x45,0x20,0x53,0x45,0x4E,0x53,0x4F,0x52
	.DB  0x21,0x0,0x44,0x4F,0x4F,0x52,0x20,0x53
	.DB  0x45,0x4E,0x53,0x4F,0x52,0x21,0x0,0x50
	.DB  0x52,0x45,0x53,0x53,0x55,0x52,0x45,0x20
	.DB  0x41,0x4C,0x21,0x0,0x52,0x45,0x41,0x44
	.DB  0x59,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x0,0x43,0x59,0x4C,0x20,0x3A,0x20
	.DB  0x0,0x49,0x4E,0x20,0x2D,0x0,0x4F,0x55
	.DB  0x54,0x2D,0x0,0x44,0x4F,0x0
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0
_0x204005F:
	.DB  0x1
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0
_0x20E0003:
	.DB  0x32
_0x20E0004:
	.DB  0x2C,0x1
_0x20E0005:
	.DB  0xE2,0x2C
_0x20E0006:
	.DB  0xF0,0xEB
_0x20E0007:
	.DB  0x1
_0x20E0008:
	.DB  0x1
_0x20E0009:
	.DB  0x1
_0x20E000A:
	.DB  0x4
_0x20E0000:
	.DB  0x57,0x49,0x4E,0x44,0x4F,0x57,0x20,0x50
	.DB  0x52,0x45,0x53,0x53,0x20,0x42,0x41,0x53
	.DB  0x45,0x3A,0x0,0x30,0x36,0x0,0x57,0x49
	.DB  0x54,0x48,0x53,0x59,0x53,0x54,0x45,0x4D
	.DB  0x0,0x49,0x4E,0x49,0x54,0x49,0x41,0x4C
	.DB  0x49,0x5A,0x45,0x2E,0x2E,0x0,0xA,0xD
	.DB  0x0,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A
	.DB  0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A
	.DB  0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A
	.DB  0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0xA
	.DB  0xD,0x0,0x2A,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x57,0x49,0x4E
	.DB  0x44,0x4F,0x57,0x20,0x50,0x52,0x45,0x53
	.DB  0x53,0x55,0x52,0x45,0x20,0x20,0x20,0x2A
	.DB  0xA,0xD,0x0,0x2A,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x42,0x65,0x73,0x74,0x70
	.DB  0x72,0x6F,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x2A,0xA,0xD,0x0,0x2A,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x32,0x30,0x31,0x34,0x2F,0x31,0x30
	.DB  0x2F,0x30,0x32,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x2A,0xA,0xD,0x0,0x50,0x72,0x6F
	.DB  0x6D,0x70,0x74,0x3A,0x3E,0x20,0x0,0x52
	.DB  0x75,0x6E,0x20,0x3D,0x20,0x25,0x64,0x2C
	.DB  0x20,0x53,0x74,0x65,0x70,0x20,0x3D,0x20
	.DB  0x25,0x32,0x64,0x2C,0x20,0x44,0x65,0x6C
	.DB  0x61,0x79,0x20,0x3D,0x20,0x25,0x33,0x64
	.DB  0xA,0xD,0x0,0x4B,0x65,0x79,0x20,0x3D
	.DB  0x20,0x30,0x78,0x25,0x30,0x32,0x58,0x2C
	.DB  0x20,0x45,0x78,0x74,0x4B,0x65,0x79,0x20
	.DB  0x3D,0x20,0x30,0x78,0x25,0x30,0x32,0x58
	.DB  0x2C,0x20,0x53,0x65,0x6E,0x73,0x6F,0x72
	.DB  0x20,0x3D,0x20,0x30,0x78,0x25,0x30,0x32
	.DB  0x58,0x2C,0x20,0x45,0x6D,0x70,0x20,0x3D
	.DB  0x20,0x25,0x64,0xA,0xD,0x0,0x4D,0x6F
	.DB  0x64,0x65,0x31,0x53,0x74,0x65,0x70,0x20
	.DB  0x3D,0x20,0x25,0x64,0xA,0xD,0x0,0x43
	.DB  0x48,0x30,0x20,0x3D,0x20,0x25,0x6C,0x64
	.DB  0x28,0x30,0x78,0x25,0x30,0x34,0x58,0x29
	.DB  0xA,0xD,0x0

__GLOBAL_INI_TBL:
	.DW  0x09
	.DW  0x200
	.DW  __DSTACK_END*2

	.DW  0x09
	.DW  0x00
	.DW  __HSTACK_END*2

	.DW  0x01
	.DW  _PressureStep
	.DW  _0x3*2

	.DW  0x01
	.DW  _PressureStepDelay
	.DW  _0x4*2

	.DW  0x01
	.DW  _sPressureStepDelay
	.DW  _0x5*2

	.DW  0x01
	.DW  _bAutoMode
	.DW  _0x6*2

	.DW  0x01
	.DW  __seed_G102
	.DW  _0x204005F*2

	.DW  0x01
	.DW  _PressureTime
	.DW  _0x20E0003*2

	.DW  0x02
	.DW  _Pressure
	.DW  _0x20E0004*2

	.DW  0x02
	.DW  _CalItvMin
	.DW  _0x20E0005*2

	.DW  0x02
	.DW  _CalItvMax
	.DW  _0x20E0006*2

	.DW  0x01
	.DW  _bDebug
	.DW  _0x20E0007*2

	.DW  0x01
	.DW  _bMenuDisplay
	.DW  _0x20E0008*2

	.DW  0x01
	.DW  _bVarDisplay
	.DW  _0x20E0009*2

	.DW  0x01
	.DW  _sMode1Step
	.DW  _0x20E000A*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRA,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x2000)
	LDI  R25,HIGH(0x2000)
	LDI  R26,LOW(0x200)
	LDI  R27,HIGH(0x200)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  EIND,R24

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x21FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x21FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0xA00)
	LDI  R29,HIGH(0xA00)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xA00

	.CSEG
;#include "hwdefine.h"
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
;
;unsigned int PressureStep = PRESSURE_STEP_DEFAULT;				// ITV 설정 압력 Step	// Default

	.DSEG
;unsigned int PressureStepDelay = 1;								// setp별 압착 딜레이
;unsigned int sPressureStepDelay = PRESSURE_STEP_DELAY_DEFAULT;	// setp별 압착 딜레이	// Default
;unsigned char bAutoMode = 2;   			// 자동/수동 상태
;unsigned int DownPressure = 0;			// 압력 Step 동작시 압력값
;unsigned char bDownPressureEnd = 0;		// 압력 Step 완료
;unsigned char bPressureReward = 0;		// 압력 보상
;
;void CommSubroutine(void)
; 0000 000C {

	.CSEG
_CommSubroutine:
; 0000 000D     unsigned int tQueueLast = QueueLast;        //루틴 수행중 QueueLast 값이 바뀔수 있으므로 수신확인되면 QueueLast Count 값을 Buffer(tQueueLast)에 저장
; 0000 000E 
; 0000 000F     if (QueueFirst != tQueueLast)
	ST   -Y,R17
	ST   -Y,R16
;	tQueueLast -> R16,R17
	__GETWRMN 16,17,0,_QueueLast
	CALL SUBOPT_0x0
	BRNE PC+3
	JMP _0x7
; 0000 0010     {
; 0000 0011         while(QueueFirst != tQueueLast)
_0x8:
	CALL SUBOPT_0x0
	BRNE PC+3
	JMP _0xA
; 0000 0012         {
; 0000 0013             CommCommandBuffer[CommCommandSize++] = QueueData[QueueFirst++];        //CommCommandBuffer에 수신 Data를 하나씩 저장
	LDI  R26,LOW(_CommCommandSize)
	LDI  R27,HIGH(_CommCommandSize)
	CALL SUBOPT_0x1
	SUBI R30,LOW(-_CommCommandBuffer)
	SBCI R31,HIGH(-_CommCommandBuffer)
	MOVW R0,R30
	LDI  R26,LOW(_QueueFirst)
	LDI  R27,HIGH(_QueueFirst)
	CALL SUBOPT_0x1
	SUBI R30,LOW(-_QueueData)
	SBCI R31,HIGH(-_QueueData)
	LD   R30,Z
	MOVW R26,R0
	ST   X,R30
; 0000 0014             if (CommCommandSize >= COMMAND_BUFFER_SIZE) CommCommandSize = 0;
	LDS  R26,_CommCommandSize
	LDS  R27,_CommCommandSize+1
	SBIW R26,50
	BRSH PC+3
	JMP _0xB
	CALL SUBOPT_0x2
; 0000 0015             if (QueueFirst >= QUEUE_SIZE) QueueFirst = 0;
_0xB:
	LDS  R26,_QueueFirst
	LDS  R27,_QueueFirst+1
	CPI  R26,LOW(0x100)
	LDI  R30,HIGH(0x100)
	CPC  R27,R30
	BRSH PC+3
	JMP _0xC
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _QueueFirst,R30
	STS  _QueueFirst+1,R31
; 0000 0016 
; 0000 0017 			if ((CommCommandBuffer[CommCommandSize - 1] == '\n') || (CommCommandBuffer[CommCommandSize - 1] == '\r'))    //데이터 마지막에 '\n','r'에 입력이 되면 수신 완료
_0xC:
	CALL SUBOPT_0x3
	CPI  R30,LOW(0xA)
	BRNE PC+3
	JMP _0xE
	CALL SUBOPT_0x3
	CPI  R30,LOW(0xD)
	BRNE PC+3
	JMP _0xE
	RJMP _0xD
_0xE:
; 0000 0018 			{
; 0000 0019                 CommCommandBuffer[CommCommandSize] = 0;                                                                                                                       //CommCommandSize - 1 은 수신 시작시 QueueFirst Count를 증가 시키고 시작했기때문에 마지막 Data를 읽으려면 1Byte전 Data를 읽어야 한다.
	LDS  R30,_CommCommandSize
	LDS  R31,_CommCommandSize+1
	SUBI R30,LOW(-_CommCommandBuffer)
	SBCI R31,HIGH(-_CommCommandBuffer)
	LDI  R26,LOW(0)
	STD  Z+0,R26
; 0000 001A 				if (CommCommandSize != 1)        //CommCommandSize를 위에서 증가 시켰기 때문에 0은 읽을 수 없고, 'n','r'이 1Byte를 차지하므로 CommandSize가 1일 경우에는 Data가 없다고 판단. 1보다 클때부터 Data를 살핀다.
	LDS  R26,_CommCommandSize
	LDS  R27,_CommCommandSize+1
	SBIW R26,1
	BRNE PC+3
	JMP _0x10
; 0000 001B 				{
; 0000 001C //                    MainComm("CMD[%d][%d]-%s\n", QueueFirst, tQueueLast, CommCommandBuffer);
; 0000 001D 
; 0000 001E 					switch(CommCommandSize - 1)
	LDS  R30,_CommCommandSize
	LDS  R31,_CommCommandSize+1
	SBIW R30,1
; 0000 001F 					{
; 0000 0020                         case 3:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x14
; 0000 0021                         case 1:
	RJMP _0x15
_0x14:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x16
_0x15:
; 0000 0022                             CommCommandBuffer[0] = 'H';
	LDI  R30,LOW(72)
	STS  _CommCommandBuffer,R30
; 0000 0023                             CommCommandBuffer[1] = 'E';
	LDI  R30,LOW(69)
	__PUTB1MN _CommCommandBuffer,1
; 0000 0024                             CommCommandBuffer[2] = 'L';
	LDI  R30,LOW(76)
	__PUTB1MN _CommCommandBuffer,2
; 0000 0025                             CommCommandBuffer[3] = 'P';
	LDI  R30,LOW(80)
	__PUTB1MN _CommCommandBuffer,3
; 0000 0026 						case 4:
	RJMP _0x17
_0x16:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x18
_0x17:
; 0000 0027                             if (strncmpf((char *)CommCommandBuffer, "HELP", 4) == 0)
	CALL SUBOPT_0x4
	__POINTW1FN _0x0,0
	CALL SUBOPT_0x5
	BREQ PC+3
	JMP _0x19
; 0000 0028 							{
; 0000 0029 
; 0000 002A                                 DebugComm("\n\r");
	__POINTW1FN _0x0,5
	CALL SUBOPT_0x6
; 0000 002B                                 DebugComm("  Command List\n\r");
	__POINTW1FN _0x0,8
	CALL SUBOPT_0x6
; 0000 002C 
; 0000 002D                                 DebugComm("  HELP       :   Help Meassage\n\r");
	__POINTW1FN _0x0,25
	CALL SUBOPT_0x6
; 0000 002E                                 DebugComm("  TEST       :   TEST Command\n\r");
	__POINTW1FN _0x0,58
	CALL SUBOPT_0x6
; 0000 002F                                 DebugComm("  DEBUG      :   DEBUG Command\n\r");
	__POINTW1FN _0x0,90
	CALL SUBOPT_0x6
; 0000 0030                                 DebugComm("  VER?       :   Version Command\n\r");
	__POINTW1FN _0x0,123
	CALL SUBOPT_0x6
; 0000 0031                             }
; 0000 0032 							else if (strncmpf((char *)CommCommandBuffer, "TEST", 4) == 0)
	RJMP _0x1A
_0x19:
	CALL SUBOPT_0x4
	__POINTW1FN _0x0,158
	CALL SUBOPT_0x5
	BREQ PC+3
	JMP _0x1B
; 0000 0033                             {
; 0000 0034                                 TestMode = Asc2Hex(CommCommandBuffer[4]);
	__GETB1MN _CommCommandBuffer,4
	ST   -Y,R30
	CALL _Asc2Hex
	STS  _TestMode,R30
; 0000 0035                                 if(TestMode) DebugComm("Test Mode %d\n\r", TestMode);
	CPI  R30,0
	BRNE PC+3
	JMP _0x1C
	__POINTW1FN _0x0,163
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_TestMode
	CALL SUBOPT_0x7
	LDI  R24,4
	CALL _Uartprintf0
	ADIW R28,6
; 0000 0036                                 else DebugComm("Test Mode Disable\n\r");
	RJMP _0x1D
_0x1C:
	__POINTW1FN _0x0,178
	CALL SUBOPT_0x6
; 0000 0037                             }
_0x1D:
; 0000 0038                             break;
_0x1B:
_0x1A:
	RJMP _0x13
; 0000 0039                         case 5:
_0x18:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x22
; 0000 003A                             if (strncmpf((char *)CommCommandBuffer, "DEBUG", 5) == 0)
	CALL SUBOPT_0x4
	__POINTW1FN _0x0,198
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(5)
	ST   -Y,R30
	CALL _strncmpf
	CPI  R30,0
	BREQ PC+3
	JMP _0x1F
; 0000 003B                             {
; 0000 003C                             	bDebug = !bDebug;
	LDS  R30,_bDebug
	CALL __LNEGB1
	STS  _bDebug,R30
; 0000 003D                                 if (bDebug)
	CPI  R30,0
	BRNE PC+3
	JMP _0x20
; 0000 003E                                 {
; 0000 003F                                     DebugComm("Debug Mode Enable\n\r");
	__POINTW1FN _0x0,204
	CALL SUBOPT_0x6
; 0000 0040                                 }
; 0000 0041                                 else
	RJMP _0x21
_0x20:
; 0000 0042                                 {
; 0000 0043                                     DebugComm("Debug Mode Disable\n\r");
	__POINTW1FN _0x0,224
	CALL SUBOPT_0x6
; 0000 0044 								}
_0x21:
; 0000 0045                             }
; 0000 0046                             break;
_0x1F:
	RJMP _0x13
; 0000 0047                        	default:
_0x22:
; 0000 0048 							#ifdef DEBUG_MODE
; 0000 0049                            	DebugComm("Command ?\n");
	__POINTW1FN _0x0,245
	CALL SUBOPT_0x6
; 0000 004A                             #else
; 0000 004B                             MainComm("ER1:%s\n", CommCommandBuffer);
; 0000 004C                             #endif
; 0000 004D 	                        break;
; 0000 004E     	           	}
_0x13:
; 0000 004F         	    }
; 0000 0050            	    CommCommandSize = 0;
_0x10:
	CALL SUBOPT_0x2
; 0000 0051 			}
; 0000 0052 		}
_0xD:
	RJMP _0x8
_0xA:
; 0000 0053 	}
; 0000 0054 
; 0000 0055 }
_0x7:
	LD   R16,Y+
	LD   R17,Y+
	RET
;
;void SetBuzzer(unsigned char Mode, unsigned char Repeat)
; 0000 0058 {
_SetBuzzer:
; 0000 0059 	switch(Mode)
;	Mode -> Y+1
;	Repeat -> Y+0
	LDD  R30,Y+1
; 0000 005A     {
; 0000 005B 		case 0:
	CPI  R30,0
	BREQ PC+3
	JMP _0x26
; 0000 005C         	BuzzerOnTime = 10;
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL SUBOPT_0x8
; 0000 005D             BuzzerOffTime = 10;
; 0000 005E             break;
	RJMP _0x25
; 0000 005F         case 1:
_0x26:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x25
; 0000 0060         	BuzzerOnTime = 50;
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	CALL SUBOPT_0x8
; 0000 0061             BuzzerOffTime = 10;
; 0000 0062             break;
; 0000 0063     }
_0x25:
; 0000 0064     BuzzerOnCount = BuzzerOnTime;
	CALL SUBOPT_0x9
; 0000 0065     BuzzerOffCount = BuzzerOffTime;
; 0000 0066     BuzzerRepeatCount = Repeat;
	LD   R30,Y
	LDI  R31,0
	STS  _BuzzerRepeatCount,R30
	STS  _BuzzerRepeatCount+1,R31
; 0000 0067 }
	ADIW R28,2
	RET
;
;void RunSubroutine(void)	// 10ms
; 0000 006A {
_RunSubroutine:
; 0000 006B 	static unsigned int TactTimeCheckIn = 0;
; 0000 006C 	static unsigned int TactTimeCheckOut = 0;
; 0000 006D 	static unsigned int TactTimeCheckDown = 0;
; 0000 006E 	static unsigned int TactTimeCheckUp = 0;
; 0000 006F 
; 0000 0070     if (bRun)
	LDS  R30,_bRun
	CPI  R30,0
	BRNE PC+3
	JMP _0x28
; 0000 0071     {
; 0000 0072 		if (bEmoState == 1 || bReturnSensor == 1)		// Emo 누른 상태, 인전 센서
	LDS  R26,_bEmoState
	CPI  R26,LOW(0x1)
	BRNE PC+3
	JMP _0x2A
	LDS  R26,_bReturnSensor
	CPI  R26,LOW(0x1)
	BRNE PC+3
	JMP _0x2A
	RJMP _0x29
_0x2A:
; 0000 0073 		{
; 0000 0074 			SetItv(PRESSURE_STOP);
	CALL SUBOPT_0xA
	CALL _SetItv
; 0000 0075 			bRunAlarm |= 0x04;
	LDS  R30,_bRunAlarm
	ORI  R30,4
	STS  _bRunAlarm,R30
; 0000 0076 
; 0000 0077 		}else {
	RJMP _0x2C
_0x29:
; 0000 0078 
; 0000 0079 			if (RunStep == RUN_STOP) SetItv(PRESSURE_NOMAL);
	LDS  R30,_RunStep
	CPI  R30,0
	BREQ PC+3
	JMP _0x2D
	CALL SUBOPT_0xB
; 0000 007A 
; 0000 007B 			// **************************************************************************************************************************************************
; 0000 007C 			if ((bEmoState == 2) || bReturnSensor == 2)	// Run중 센서 & Emo 받으면
_0x2D:
	LDS  R26,_bEmoState
	CPI  R26,LOW(0x2)
	BRNE PC+3
	JMP _0x2F
	LDS  R26,_bReturnSensor
	CPI  R26,LOW(0x2)
	BRNE PC+3
	JMP _0x2F
	RJMP _0x2E
_0x2F:
; 0000 007D 			{
; 0000 007E 				SetItv(PRESSURE_RETURN);
	CALL SUBOPT_0xB
; 0000 007F 				bRunAlarm |= 0x08;
	LDS  R30,_bRunAlarm
	ORI  R30,8
	STS  _bRunAlarm,R30
; 0000 0080 			}
; 0000 0081 
; 0000 0082 			if (((bEmoState == 2) || bReturnSensor == 2) && RunStep <= RUN_PRESSURE_DELAY)	// Emo 입력시 Y축 올리는 단계로 점프하여 실린더 초기상태로 원복시킴
_0x2E:
	LDS  R26,_bEmoState
	CPI  R26,LOW(0x2)
	BRNE PC+3
	JMP _0x32
	LDS  R26,_bReturnSensor
	CPI  R26,LOW(0x2)
	BRNE PC+3
	JMP _0x32
	RJMP _0x34
_0x32:
	LDS  R26,_RunStep
	CPI  R26,LOW(0x7)
	BRLO PC+3
	JMP _0x34
	RJMP _0x35
_0x34:
	RJMP _0x31
_0x35:
; 0000 0083 			{
; 0000 0084 				RunStepDelay = 0;
	CALL SUBOPT_0xC
	CALL SUBOPT_0xD
; 0000 0085 				RunStep = RUN_PRESSURE_DELAY;
	LDI  R30,LOW(6)
	STS  _RunStep,R30
; 0000 0086 				bRunAlarm |= 0x01;
	LDS  R30,_bRunAlarm
	ORI  R30,1
	STS  _bRunAlarm,R30
; 0000 0087 			}
; 0000 0088 			// **************************************************************************************************************************************************
; 0000 0089 
; 0000 008A 			if (RunStepDelay)
_0x31:
	CALL SUBOPT_0xE
	CALL __CPD10
	BRNE PC+3
	JMP _0x36
; 0000 008B 			{
; 0000 008C 				RunStepDelay--;
	LDI  R26,LOW(_RunStepDelay)
	LDI  R27,HIGH(_RunStepDelay)
	CALL SUBOPT_0xF
; 0000 008D 				RunStepTime++;										// RunStepDelay 사용시 시간 카운터로 사용됨.
	LDI  R26,LOW(_RunStepTime)
	LDI  R27,HIGH(_RunStepTime)
	CALL __GETD1P_INC
	__SUBD1N -1
	CALL __PUTDP1_DEC
; 0000 008E 				if ((RunStepDelay % 10) == 0) bVarDisplay = 1;		// 100ms에 한번씩 상태 LCD에 출력
	LDS  R26,_RunStepDelay
	LDS  R27,_RunStepDelay+1
	LDS  R24,_RunStepDelay+2
	LDS  R25,_RunStepDelay+3
	CALL SUBOPT_0x10
	CALL SUBOPT_0x11
	BREQ PC+3
	JMP _0x37
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 008F 			}else {													// RunStepDelay 0일때만 실행
_0x37:
	RJMP _0x38
_0x36:
; 0000 0090 				if (RunStep == RUN_PRESSURE_DELAY && bPressureFail) bRunAlarm |= 0x02;
	LDS  R26,_RunStep
	CPI  R26,LOW(0x6)
	BREQ PC+3
	JMP _0x3A
	LDS  R30,_bPressureFail
	CPI  R30,0
	BRNE PC+3
	JMP _0x3A
	RJMP _0x3B
_0x3A:
	RJMP _0x39
_0x3B:
	LDS  R30,_bRunAlarm
	ORI  R30,2
	STS  _bRunAlarm,R30
; 0000 0091 
; 0000 0092 				RunStepTime = 0;
_0x39:
	CALL SUBOPT_0x12
; 0000 0093 				switch(RunStep)
	LDS  R30,_RunStep
; 0000 0094 				{
; 0000 0095 				case RUN_STOP:
	CPI  R30,0
	BREQ PC+3
	JMP _0x3F
; 0000 0096 					RunStep = RUN_START_DELAY;
	LDI  R30,LOW(1)
	CALL SUBOPT_0x13
; 0000 0097 					RunStepDelay = 10;	// 100ms delay (2014.10.15_이원욱D 초기 빨리 진입하게 변경요청)
; 0000 0098 					bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0099 					break;
	RJMP _0x3E
; 0000 009A 
; 0000 009B 				case RUN_START_DELAY:
_0x3F:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x40
; 0000 009C 					RunStep = RUN_JIG_IN;
	LDI  R30,LOW(2)
	STS  _RunStep,R30
; 0000 009D 					CYL_X_IN;
	CALL SUBOPT_0x14
; 0000 009E 					bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 009F 					break;
	RJMP _0x3E
; 0000 00A0 
; 0000 00A1 				case RUN_JIG_IN:
_0x40:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x41
; 0000 00A2 					if (Sensor & CYL_X_IN_SENSOR)
	LDS  R30,_Sensor
	ANDI R30,LOW(0x2)
	BRNE PC+3
	JMP _0x42
; 0000 00A3 					{
; 0000 00A4                         if (bAutoMode == 2)
	LDS  R26,_bAutoMode
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x43
; 0000 00A5                         {
; 0000 00A6     						SetItv(PRESSURE_Y_DOWN);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL SUBOPT_0x15
; 0000 00A7 						    RunStep = RUN_EXHAUST1;
	LDI  R30,LOW(3)
	STS  _RunStep,R30
; 0000 00A8                         }else {
	RJMP _0x44
_0x43:
; 0000 00A9     						SetItv(Pressure);
	CALL SUBOPT_0x16
; 0000 00AA 						    RunStep = RUN_CYL_DOWN;
	LDI  R30,LOW(5)
	STS  _RunStep,R30
; 0000 00AB                             bDownPressureEnd = 1;
	LDI  R30,LOW(1)
	STS  _bDownPressureEnd,R30
; 0000 00AC 
; 0000 00AD                         }
_0x44:
; 0000 00AE 						CYL_Y_DOWN;
	CALL SUBOPT_0x17
; 0000 00AF 						bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 00B0 
; 0000 00B1 						RunStepDelay = 100;
	CALL SUBOPT_0x18
; 0000 00B2 					}
; 0000 00B3 					break;
_0x42:
	RJMP _0x3E
; 0000 00B4 
; 0000 00B5 				case RUN_EXHAUST1:
_0x41:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x45
; 0000 00B6 					SetItv(PRESSURE_EXHAUST2);
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	CALL SUBOPT_0x15
; 0000 00B7 
; 0000 00B8 					RunStep = RUN_CYL_DOWN;
	LDI  R30,LOW(5)
	STS  _RunStep,R30
; 0000 00B9 					RunStepDelay = 100;		// 1sec
	CALL SUBOPT_0x18
; 0000 00BA 					break;
	RJMP _0x3E
; 0000 00BB 
; 0000 00BC 				case RUN_CYL_DOWN:
_0x45:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x46
; 0000 00BD 					if (Sensor & CYL_Y_DOWN_SENSOR)
	LDS  R30,_Sensor
	ANDI R30,LOW(0x8)
	BRNE PC+3
	JMP _0x47
; 0000 00BE 					{
; 0000 00BF 						//PressureTime = GetEeprom2(0);
; 0000 00C0 						//Pressure = GetEeprom2(2);
; 0000 00C1 
; 0000 00C2 						if (bDownPressureEnd == 1)
	LDS  R26,_bDownPressureEnd
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x48
; 0000 00C3 						{
; 0000 00C4 							RunStep = RUN_PRESSURE_DELAY;
	LDI  R30,LOW(6)
	STS  _RunStep,R30
; 0000 00C5 							RunStepDelay = PressureTime * 10;
	CALL SUBOPT_0x19
	CALL __MULD12U
	CALL SUBOPT_0xD
; 0000 00C6 							bPressureReward = 1;
	LDI  R30,LOW(1)
	STS  _bPressureReward,R30
; 0000 00C7 						}
; 0000 00C8 						bVarDisplay = 1;
_0x48:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 00C9 					}
; 0000 00CA 					break;
_0x47:
	RJMP _0x3E
; 0000 00CB 
; 0000 00CC 				case RUN_PRESSURE_DELAY:
_0x46:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0x49
; 0000 00CD 					RunStep = RUN_CYL_UP;
	LDI  R30,LOW(7)
	STS  _RunStep,R30
; 0000 00CE 					bDownPressureEnd = 0;
	LDI  R30,LOW(0)
	STS  _bDownPressureEnd,R30
; 0000 00CF 
; 0000 00D0                     if (bRunAlarm == 0x01) RunStepDelay = 100; 	// 14.10.14
	LDS  R26,_bRunAlarm
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x4A
	CALL SUBOPT_0x18
; 0000 00D1 				    else RunStepDelay = 10;
	RJMP _0x4B
_0x4A:
	CALL SUBOPT_0x10
	CALL SUBOPT_0xD
; 0000 00D2 
; 0000 00D3 					SetItv(PRESSURE_NOMAL);
_0x4B:
	CALL SUBOPT_0xB
; 0000 00D4 
; 0000 00D5 					CYL_Y_UP;
	CALL SUBOPT_0x1A
; 0000 00D6 
; 0000 00D7                     if (bPressureFail) SetBuzzer(1, 2);
	LDS  R30,_bPressureFail
	CPI  R30,0
	BRNE PC+3
	JMP _0x4C
	CALL SUBOPT_0x1B
; 0000 00D8                     else SetBuzzer(0, 0);
	RJMP _0x4D
_0x4C:
	CALL SUBOPT_0x1C
	CALL _SetBuzzer
; 0000 00D9 
; 0000 00DA                     RunStepDelay = 30;
_0x4D:
	__GETD1N 0x1E
	CALL SUBOPT_0xD
; 0000 00DB 					bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 00DC 					break;
	RJMP _0x3E
; 0000 00DD 
; 0000 00DE 				case RUN_CYL_UP:
_0x49:
	CPI  R30,LOW(0x7)
	BREQ PC+3
	JMP _0x4E
; 0000 00DF 					//if (Sensor & CYL_Y_UP_SENSOR)	// TactTime 축소로 센서 받기전 X축 Out적용으로 주석처리
; 0000 00E0 					{
; 0000 00E1 						if (bReturnSensor == 2 || (bEmoState == 2))
	LDS  R26,_bReturnSensor
	CPI  R26,LOW(0x2)
	BRNE PC+3
	JMP _0x50
	LDS  R26,_bEmoState
	CPI  R26,LOW(0x2)
	BRNE PC+3
	JMP _0x50
	RJMP _0x4F
_0x50:
; 0000 00E2 						{
; 0000 00E3 							RunStep = RUN_JIG_OUT;
	LDI  R30,LOW(8)
	CALL SUBOPT_0x13
; 0000 00E4 							RunStepDelay = 10;
; 0000 00E5 							CYL_X_OUT;
	CALL SUBOPT_0x1D
; 0000 00E6 							bVarDisplay = 1;
; 0000 00E7 						}else {
	RJMP _0x52
_0x4F:
; 0000 00E8 							if (bDoorSensorFail == 0 && bSafeSensorFail == 0)
	LDS  R26,_bDoorSensorFail
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x54
	LDS  R26,_bSafeSensorFail
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x54
	RJMP _0x55
_0x54:
	RJMP _0x53
_0x55:
; 0000 00E9 							{
; 0000 00EA 								RunStep = RUN_JIG_OUT;
	LDI  R30,LOW(8)
	CALL SUBOPT_0x13
; 0000 00EB 								RunStepDelay = 10;
; 0000 00EC 								CYL_X_OUT;
	CALL SUBOPT_0x1D
; 0000 00ED 								bVarDisplay = 1;
; 0000 00EE 							}
; 0000 00EF 						}
_0x53:
_0x52:
; 0000 00F0 					}
; 0000 00F1 					break;
	RJMP _0x3E
; 0000 00F2 
; 0000 00F3 				case RUN_JIG_OUT:
_0x4E:
	CPI  R30,LOW(0x8)
	BREQ PC+3
	JMP _0x56
; 0000 00F4 					if (Sensor & CYL_X_OUT_SENSOR)
	LDS  R30,_Sensor
	ANDI R30,LOW(0x1)
	BRNE PC+3
	JMP _0x57
; 0000 00F5 					{
; 0000 00F6 						RunStep = RUN_END;
	LDI  R30,LOW(9)
	CALL SUBOPT_0x13
; 0000 00F7 						RunStepDelay = 10;
; 0000 00F8 						bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 00F9 					}
; 0000 00FA 					break;
_0x57:
	RJMP _0x3E
; 0000 00FB 
; 0000 00FC 				case RUN_END:
_0x56:
	CPI  R30,LOW(0x9)
	BREQ PC+3
	JMP _0x3E
; 0000 00FD                     bPressureFail = 0;
	LDI  R30,LOW(0)
	STS  _bPressureFail,R30
; 0000 00FE                     bRunAlarm = 0;
	STS  _bRunAlarm,R30
; 0000 00FF 					DownPressure = 0;
	CALL SUBOPT_0x1E
; 0000 0100 					if (bRunAlarm) SetBuzzer(1, 1);
	LDS  R30,_bRunAlarm
	CPI  R30,0
	BRNE PC+3
	JMP _0x59
	CALL SUBOPT_0x1F
; 0000 0101 					else SetBuzzer(0, 1);
	RJMP _0x5A
_0x59:
	CALL SUBOPT_0x20
	CALL _SetBuzzer
; 0000 0102 
; 0000 0103 					if (bReturnSensor || (bEmoState == 2))
_0x5A:
	LDS  R30,_bReturnSensor
	CPI  R30,0
	BREQ PC+3
	JMP _0x5C
	LDS  R26,_bEmoState
	CPI  R26,LOW(0x2)
	BRNE PC+3
	JMP _0x5C
	RJMP _0x5B
_0x5C:
; 0000 0104 					{
; 0000 0105 						bReturnSensor = 0;
	LDI  R30,LOW(0)
	STS  _bReturnSensor,R30
; 0000 0106 						bEmoState = 0;
	STS  _bEmoState,R30
; 0000 0107 						//PressureTime = GetEeprom2(0);
; 0000 0108 						//Pressure = GetEeprom2(2);
; 0000 0109 
; 0000 010A 						CalItvMin = GetEeprom2(10);
	CALL SUBOPT_0x21
	CALL SUBOPT_0x22
	CALL SUBOPT_0x23
; 0000 010B                         CalItvMax = GetEeprom4(12);
	CALL SUBOPT_0x24
	CALL SUBOPT_0x25
; 0000 010C 
; 0000 010D 						SetItv(Pressure);
	CALL SUBOPT_0x16
; 0000 010E 						//GetItv();
; 0000 010F 					}
; 0000 0110 					//bReturnRun = 0;
; 0000 0111 					if (bAgingEnd) bRun = 0;
_0x5B:
	LDS  R30,_bAgingEnd
	CPI  R30,0
	BRNE PC+3
	JMP _0x5E
	LDI  R30,LOW(0)
	STS  _bRun,R30
; 0000 0112             	    else if (!bAgingEnd && bAgingMode) bRun = 1;		// Aging Mode시 반복되게 bRun 플래그 ON
	RJMP _0x5F
_0x5E:
	LDS  R30,_bAgingEnd
	CPI  R30,0
	BREQ PC+3
	JMP _0x61
	LDS  R30,_bAgingMode
	CPI  R30,0
	BRNE PC+3
	JMP _0x61
	RJMP _0x62
_0x61:
	RJMP _0x60
_0x62:
	LDI  R30,LOW(1)
	STS  _bRun,R30
; 0000 0113 				    else bRun = 0;
	RJMP _0x63
_0x60:
	LDI  R30,LOW(0)
	STS  _bRun,R30
; 0000 0114 
; 0000 0115 					RunStep = RUN_STOP;
_0x63:
_0x5F:
	LDI  R30,LOW(0)
	STS  _RunStep,R30
; 0000 0116 					bMenuDisplay = 1;
	CALL SUBOPT_0x26
; 0000 0117 					bVarDisplay = 1;
; 0000 0118 					break;
; 0000 0119 				}
_0x3E:
; 0000 011A 			}
_0x38:
; 0000 011B 		}
_0x2C:
; 0000 011C     }else {
	RJMP _0x64
_0x28:
; 0000 011D 		RunStep = RUN_STOP;
	LDI  R30,LOW(0)
	STS  _RunStep,R30
; 0000 011E 		RunStepDelay = 0;
	CALL SUBOPT_0xC
	CALL SUBOPT_0xD
; 0000 011F         RunStepTime = 0;
	CALL SUBOPT_0x12
; 0000 0120 		bDownPressureEnd = 0;
	LDI  R30,LOW(0)
	STS  _bDownPressureEnd,R30
; 0000 0121 
; 0000 0122 		if (bAutoMode)	// AutoMode & EdgeMode
	LDS  R30,_bAutoMode
	CPI  R30,0
	BRNE PC+3
	JMP _0x65
; 0000 0123         {
; 0000 0124             bCylXIn = 0;
	LDI  R30,LOW(0)
	STS  _bCylXIn,R30
; 0000 0125             bCylYDown = 0;
	STS  _bCylYDown,R30
; 0000 0126         	CYL_X_OUT;
	CALL SUBOPT_0x27
; 0000 0127         	CYL_Y_UP;
	CALL SUBOPT_0x1A
; 0000 0128         } else{
	RJMP _0x66
_0x65:
; 0000 0129 			if (bCylXIn) 	// X IN
	LDS  R30,_bCylXIn
	CPI  R30,0
	BRNE PC+3
	JMP _0x67
; 0000 012A 			{
; 0000 012B 				if ((Sensor & CYL_X_IN_SENSOR) != CYL_X_IN_SENSOR)
	LDS  R30,_Sensor
	ANDI R30,LOW(0x2)
	CPI  R30,LOW(0x2)
	BRNE PC+3
	JMP _0x68
; 0000 012C 				{
; 0000 012D 					TactTimeCheckOut = 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _TactTimeCheckOut_S0000002,R30
	STS  _TactTimeCheckOut_S0000002+1,R31
; 0000 012E 					mRunStepTime = TactTimeCheckIn++;
	LDI  R26,LOW(_TactTimeCheckIn_S0000002)
	LDI  R27,HIGH(_TactTimeCheckIn_S0000002)
	CALL SUBOPT_0x1
	CALL SUBOPT_0x28
; 0000 012F 					if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
	BREQ PC+3
	JMP _0x69
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0130 				}
_0x69:
; 0000 0131 			} else {	// X OUT
_0x68:
	RJMP _0x6A
_0x67:
; 0000 0132 				if ((Sensor & CYL_X_OUT_SENSOR) != CYL_X_OUT_SENSOR)
	LDS  R30,_Sensor
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE PC+3
	JMP _0x6B
; 0000 0133 				{
; 0000 0134 					TactTimeCheckIn = 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _TactTimeCheckIn_S0000002,R30
	STS  _TactTimeCheckIn_S0000002+1,R31
; 0000 0135 					mRunStepTime = TactTimeCheckOut++;
	LDI  R26,LOW(_TactTimeCheckOut_S0000002)
	LDI  R27,HIGH(_TactTimeCheckOut_S0000002)
	CALL SUBOPT_0x1
	CALL SUBOPT_0x28
; 0000 0136 					if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
	BREQ PC+3
	JMP _0x6C
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0137 				}
_0x6C:
; 0000 0138 			}
_0x6B:
_0x6A:
; 0000 0139 			if (bCylYDown){	// Y Down
	LDS  R30,_bCylYDown
	CPI  R30,0
	BRNE PC+3
	JMP _0x6D
; 0000 013A  				if ((Sensor & CYL_Y_DOWN_SENSOR) != CYL_Y_DOWN_SENSOR)
	LDS  R30,_Sensor
	ANDI R30,LOW(0x8)
	CPI  R30,LOW(0x8)
	BRNE PC+3
	JMP _0x6E
; 0000 013B 				{
; 0000 013C 					TactTimeCheckUp = 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _TactTimeCheckUp_S0000002,R30
	STS  _TactTimeCheckUp_S0000002+1,R31
; 0000 013D 					mRunStepTime = TactTimeCheckDown++;
	LDI  R26,LOW(_TactTimeCheckDown_S0000002)
	LDI  R27,HIGH(_TactTimeCheckDown_S0000002)
	CALL SUBOPT_0x1
	CALL SUBOPT_0x28
; 0000 013E 					if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
	BREQ PC+3
	JMP _0x6F
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 013F 				}
_0x6F:
; 0000 0140 			} else{	// Y Up
_0x6E:
	RJMP _0x70
_0x6D:
; 0000 0141  				if ((Sensor & CYL_Y_UP_SENSOR) != CYL_Y_UP_SENSOR)
	LDS  R30,_Sensor
	ANDI R30,LOW(0x4)
	CPI  R30,LOW(0x4)
	BRNE PC+3
	JMP _0x71
; 0000 0142 				{
; 0000 0143 					TactTimeCheckDown = 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _TactTimeCheckDown_S0000002,R30
	STS  _TactTimeCheckDown_S0000002+1,R31
; 0000 0144 					mRunStepTime = TactTimeCheckUp++;
	LDI  R26,LOW(_TactTimeCheckUp_S0000002)
	LDI  R27,HIGH(_TactTimeCheckUp_S0000002)
	CALL SUBOPT_0x1
	CALL SUBOPT_0x28
; 0000 0145 					if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
	BREQ PC+3
	JMP _0x72
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0146 				}
_0x72:
; 0000 0147 			}
_0x71:
_0x70:
; 0000 0148 		}
_0x66:
; 0000 0149     }
_0x64:
; 0000 014A }
	RET
;
;void DisplaySubroutine(void)	// 10ms
; 0000 014D {
_DisplaySubroutine:
; 0000 014E 	// LCD
; 0000 014F 	if (bMenuDisplay)
	LDS  R30,_bMenuDisplay
	CPI  R30,0
	BRNE PC+3
	JMP _0x73
; 0000 0150     {
; 0000 0151 		LcdClear();
	CALL _LcdClear
; 0000 0152        	switch(Mode1Step)
	LDS  R30,_Mode1Step
; 0000 0153 		{
; 0000 0154         case MODE1_NOMAL:	// NORMAL
	CPI  R30,0
	BREQ PC+3
	JMP _0x77
; 0000 0155           	if (TestMode)
	LDS  R30,_TestMode
	CPI  R30,0
	BRNE PC+3
	JMP _0x78
; 0000 0156             {
; 0000 0157 
; 0000 0158         	}else if (HiddenStep){
	RJMP _0x79
_0x78:
	LDS  R30,_HiddenStep
	CPI  R30,0
	BRNE PC+3
	JMP _0x7A
; 0000 0159 
; 0000 015A 			}else {
	RJMP _0x7B
_0x7A:
; 0000 015B 		    	//Lcdprintf(0, 0, "WINDOW PRESS BASE:");
; 0000 015C 		    	//Lcdprintf(0, 0, "WINDOW PRESS ");
; 0000 015D 				switch (sMode1Step)
	LDS  R30,_sMode1Step
; 0000 015E 				{
; 0000 015F 				case MODE1_OCTA:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x7F
; 0000 0160 					//Lcdprintf(13, 0, "WINDOW PRESS OCTA:");
; 0000 0161 					Lcdprintf(13, 0, "MODE : OCTA      V");
	CALL SUBOPT_0x29
	__POINTW1FN _0x0,256
	CALL SUBOPT_0x2A
; 0000 0162 					break;
	RJMP _0x7E
; 0000 0163 				case MODE1_TAPE:
_0x7F:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x80
; 0000 0164 					//Lcdprintf(13, 0, "WINDOW PRESS TAPE:");
; 0000 0165 					Lcdprintf(13, 0, "MODE : TAPE      V");
	CALL SUBOPT_0x29
	__POINTW1FN _0x0,275
	CALL SUBOPT_0x2A
; 0000 0166 					break;
	RJMP _0x7E
; 0000 0167 				case MODE1_BATTERY:
_0x80:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x81
; 0000 0168 					//Lcdprintf(13, 0, "WINDOW PRESS BATT:");
; 0000 0169 					Lcdprintf(13, 0, "MODE : BATT      V");
	CALL SUBOPT_0x29
	__POINTW1FN _0x0,294
	CALL SUBOPT_0x2A
; 0000 016A 					break;
	RJMP _0x7E
; 0000 016B 				case MODE1_ETC:
_0x81:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x7E
; 0000 016C 					//Lcdprintf(13, 0, "WINDOW PRESS  ETC:");
; 0000 016D 					Lcdprintf(13, 0, "MODE : ETC       V");
	CALL SUBOPT_0x29
	__POINTW1FN _0x0,313
	CALL SUBOPT_0x2A
; 0000 016E 					break;
; 0000 016F 				}
_0x7E:
; 0000 0170                 Lcdprintf(18, 0, VERSION);
	LDI  R30,LOW(18)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	__POINTW1FN _0x0,332
	CALL SUBOPT_0x2A
; 0000 0171                 Lcdprintf(0, 2, "Status:");
	CALL SUBOPT_0x2B
	__POINTW1FN _0x0,335
	CALL SUBOPT_0x2A
; 0000 0172                 if (bRun) Lcdprintf(7, 2, "RUN  TIM:");
	LDS  R30,_bRun
	CPI  R30,0
	BRNE PC+3
	JMP _0x83
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	__POINTW1FN _0x0,343
	CALL SUBOPT_0x2A
; 0000 0173                 else Lcdprintf(7, 2, "STOP TIM:");
	RJMP _0x84
_0x83:
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	__POINTW1FN _0x0,353
	CALL SUBOPT_0x2A
; 0000 0174 
; 0000 0175             	if (bAutoMode == 1)							// AutoMode
_0x84:
	LDS  R26,_bAutoMode
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x85
; 0000 0176                 {
; 0000 0177 					Lcdprintf(0, 1, "AUTO:");
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,363
	CALL SUBOPT_0x2A
; 0000 0178 				}else if (bAutoMode == 2){					// EdgeMode
	RJMP _0x86
_0x85:
	LDS  R26,_bAutoMode
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x87
; 0000 0179 					Lcdprintf(0, 1, "EDGE:");
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,369
	CALL SUBOPT_0x2A
; 0000 017A                 }else {
	RJMP _0x88
_0x87:
; 0000 017B 					Lcdprintf(0, 1, "MAN :");				// ManualMode
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,375
	CALL SUBOPT_0x2A
; 0000 017C                 }
_0x88:
_0x86:
; 0000 017D 				if (bAgingMode) Lcdprintf(0, 1, "AGING:");	// AgingMode
	LDS  R30,_bAgingMode
	CPI  R30,0
	BRNE PC+3
	JMP _0x89
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,381
	CALL SUBOPT_0x2A
; 0000 017E 
; 0000 017F                 Lcdprintf(5, 1, "%2d.%dsec %d.%02dkgf", PressureTime / 10, PressureTime % 10, Pressure / 100, Pressure % 100);
_0x89:
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	__POINTW1FN _0x0,388
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x19
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x19
	CALL SUBOPT_0x2D
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x2D
	LDI  R24,16
	CALL _Lcdprintf
	ADIW R28,20
; 0000 0180             }
_0x7B:
_0x79:
; 0000 0181             LcdCursorOff();
	CALL SUBOPT_0x2F
; 0000 0182             break;
	RJMP _0x76
; 0000 0183 
; 0000 0184         case MODE2_PRESSURE_SET:	// 압력
_0x77:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x8A
; 0000 0185 			Lcdprintf(0, 0, "       SETUP");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,409
	CALL SUBOPT_0x2A
; 0000 0186     		Lcdprintf(0, 1, " PRESSURE :      kgf");
	CALL SUBOPT_0x20
	CALL SUBOPT_0x30
; 0000 0187             Lcdprintf(0, 2, " LIMIT (%d ~ %d)", PRESSURE_MIN, PRESSURE_MAX_);
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x31
	__GETD1N 0x258
	CALL SUBOPT_0x32
; 0000 0188             LcdCursorOn();
; 0000 0189             break;
	RJMP _0x76
; 0000 018A 
; 0000 018B         case MODE2_PRESSURE_DELAY_SET:	// TIME
_0x8A:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0x8B
; 0000 018C 			Lcdprintf(0, 0, "       SETUP");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,409
	CALL SUBOPT_0x2A
; 0000 018D     		Lcdprintf(0, 1, " TIME     :      sec");
	CALL SUBOPT_0x20
	CALL SUBOPT_0x33
; 0000 018E             Lcdprintf(0, 2, " LIMIT (%d ~ %d)", PRESSURE_TIME_MIN, PRESSURE_TIME_MAX);
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x31
	__GETD1N 0xC8
	CALL SUBOPT_0x32
; 0000 018F             LcdCursorOn();
; 0000 0190             break;
	RJMP _0x76
; 0000 0191 
; 0000 0192 		case MODE1_OCTA:
_0x8B:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x8C
; 0000 0193 			Lcdprintf(0, 0, "       OCTA");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,481
	CALL SUBOPT_0x2A
; 0000 0194     		Lcdprintf(0, 1, " PRESSURE :      kgf");
	CALL SUBOPT_0x20
	CALL SUBOPT_0x30
; 0000 0195             Lcdprintf(0, 2, " TIME     :      sec");
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x33
; 0000 0196 			Lcdprintf(12, 1, "%d.%02d", OCTA_PRESSURE / 100, OCTA_PRESSURE % 100);
	CALL SUBOPT_0x34
	CALL SUBOPT_0x35
; 0000 0197 			Lcdprintf(12, 2, "%2d.%d", OCTA_PRESSURE_TIME / 10, OCTA_PRESSURE_TIME % 10);
; 0000 0198 //            LcdCursorOn();
; 0000 0199 			break;
	RJMP _0x76
; 0000 019A 
; 0000 019B 		case MODE1_TAPE:
_0x8C:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x8D
; 0000 019C 			Lcdprintf(0, 0, "       TAPE");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,508
	CALL SUBOPT_0x2A
; 0000 019D     		Lcdprintf(0, 1, " PRESSURE :      kgf");
	CALL SUBOPT_0x20
	CALL SUBOPT_0x30
; 0000 019E             Lcdprintf(0, 2, " TIME     :      sec");
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x33
; 0000 019F 			Lcdprintf(12, 1, "%d.%02d", TYPE_PRESSURE / 100, TYPE_PRESSURE % 100);
	CALL SUBOPT_0x34
	__GETD1N 0x3
	CALL __PUTPARD1
	CALL SUBOPT_0xC
	CALL SUBOPT_0x36
; 0000 01A0 			Lcdprintf(12, 2, "%2d.%d", TYPE_PRESSURE_TIME / 10, TYPE_PRESSURE_TIME % 10);
	CALL SUBOPT_0x37
	__GETD1N 0x4
	CALL __PUTPARD1
	__GETD1N 0x6
	CALL SUBOPT_0x36
; 0000 01A1 //            LcdCursorOn();
; 0000 01A2 			break;
	RJMP _0x76
; 0000 01A3 
; 0000 01A4 		case MODE1_BATTERY:
_0x8D:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x8E
; 0000 01A5 			Lcdprintf(0, 0, "       BATT");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,520
	CALL SUBOPT_0x2A
; 0000 01A6     		Lcdprintf(0, 1, " PRESSURE :      kgf");
	CALL SUBOPT_0x20
	CALL SUBOPT_0x30
; 0000 01A7             Lcdprintf(0, 2, " TIME     :      sec");
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x33
; 0000 01A8 			Lcdprintf(12, 1, "%d.%02d", BATTERY_PRESSURE / 100, BATTERY_PRESSURE % 100);
	CALL SUBOPT_0x34
	CALL SUBOPT_0x35
; 0000 01A9 			Lcdprintf(12, 2, "%2d.%d", BATTERY_PRESSURE_TIME / 10, BATTERY_PRESSURE_TIME % 10);
; 0000 01AA //            LcdCursorOn();
; 0000 01AB             break;
	RJMP _0x76
; 0000 01AC 
; 0000 01AD 		case MODE1_ETC:
_0x8E:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x76
; 0000 01AE 			Lcdprintf(0, 0, "       ETC");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,532
	CALL SUBOPT_0x2A
; 0000 01AF     		Lcdprintf(0, 1, " PRESSURE :      kgf");
	CALL SUBOPT_0x20
	CALL SUBOPT_0x30
; 0000 01B0             Lcdprintf(0, 2, " TIME     :      sec");
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x33
; 0000 01B1 			Lcdprintf(12, 1, "%d.%02d", Pressure / 100, Pressure % 100);
	CALL SUBOPT_0x34
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x2D
	CALL SUBOPT_0x38
; 0000 01B2 			Lcdprintf(12, 2, "%2d.%d", PressureTime / 10, PressureTime % 10);
	CALL SUBOPT_0x37
	CALL SUBOPT_0x19
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x19
	CALL SUBOPT_0x2D
	CALL SUBOPT_0x38
; 0000 01B3 //            LcdCursorOn();
; 0000 01B4             break;
; 0000 01B5         }
_0x76:
; 0000 01B6 
; 0000 01B7 		switch(HiddenStep)
	LDS  R30,_HiddenStep
; 0000 01B8 		{
; 0000 01B9 		case HIDDEN1_STEP:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x93
; 0000 01BA 			Lcdprintf(0, 0, "   PRESSURE-STEP");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,543
	CALL SUBOPT_0x2A
; 0000 01BB     		Lcdprintf(0, 1, " STEP     :     STEP");
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,560
	CALL SUBOPT_0x2A
; 0000 01BC             Lcdprintf(0, 2, " LIMIT (%d ~ %d)", PRESSURE_STEP_MIN, PRESSURE_STEP_MAX);
	CALL SUBOPT_0x2B
	__POINTW1FN _0x0,443
	ST   -Y,R31
	ST   -Y,R30
	__GETD1N 0x2
	CALL SUBOPT_0x39
; 0000 01BD             LcdCursorOn();
; 0000 01BE             break;
	RJMP _0x92
; 0000 01BF 
; 0000 01C0 		case HIDDEN1_STEP_DELAY:
_0x93:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x92
; 0000 01C1 			Lcdprintf(0, 0, "     STEP-TIME");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,581
	CALL SUBOPT_0x2A
; 0000 01C2     		Lcdprintf(0, 1, " DELAY    :      sec");
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,596
	CALL SUBOPT_0x2A
; 0000 01C3             Lcdprintf(0, 2, " LIMIT (%d ~ %d)", PRESSURE_STEP_DELAY_MIN, PRESSURE_STEP_DELAY_MAX);
	CALL SUBOPT_0x2B
	__POINTW1FN _0x0,443
	ST   -Y,R31
	ST   -Y,R30
	__GETD1N 0x1
	CALL SUBOPT_0x39
; 0000 01C4             LcdCursorOn();
; 0000 01C5             break;
; 0000 01C6 		}
_0x92:
; 0000 01C7 
; 0000 01C8 	    bMenuDisplay = 0;
	LDI  R30,LOW(0)
	STS  _bMenuDisplay,R30
; 0000 01C9         bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 01CA     }
; 0000 01CB 
; 0000 01CC     if (bVarDisplay)
_0x73:
	LDS  R30,_bVarDisplay
	CPI  R30,0
	BRNE PC+3
	JMP _0x95
; 0000 01CD     {
; 0000 01CE 		switch(Mode1Step)
	LDS  R30,_Mode1Step
; 0000 01CF 		{
; 0000 01D0 		case MODE1_NOMAL:	// NORMAL
	CPI  R30,0
	BREQ PC+3
	JMP _0x99
; 0000 01D1 			if (TestMode)
	LDS  R30,_TestMode
	CPI  R30,0
	BRNE PC+3
	JMP _0x9A
; 0000 01D2 			{
; 0000 01D3 				ReadPressure = GetItv();
	CALL SUBOPT_0x3A
; 0000 01D4 				Lcdprintf(0, 0, "Ky=%02X,EK=%02X,Ss=%02X", Key, ExtKey, Sensor);
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,617
	CALL SUBOPT_0x3B
	LDS  R30,_ExtKey
	CALL SUBOPT_0x7
	LDS  R30,_Sensor
	CALL SUBOPT_0x7
	LDI  R24,12
	CALL _Lcdprintf
	ADIW R28,16
; 0000 01D5 				Lcdprintf(0, 1, "Run=%d,Step=%2d,Dly=%2d", bRun, RunStep, RunStepDelay);
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,641
	CALL SUBOPT_0x3C
	LDS  R30,_RunStep
	CALL SUBOPT_0x7
	CALL SUBOPT_0xE
	CALL __PUTPARD1
	LDI  R24,12
	CALL _Lcdprintf
	ADIW R28,16
; 0000 01D6 				Lcdprintf(0, 2, "Mode1Step = %d", Mode1Step);
	CALL SUBOPT_0x2B
	__POINTW1FN _0x0,665
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x7
	CALL SUBOPT_0x3E
; 0000 01D7 				//Lcdprintf(0, 3, "CH0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
; 0000 01D8 				Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
	CALL SUBOPT_0x3F
	CALL SUBOPT_0x40
	CALL SUBOPT_0x38
; 0000 01D9 			}else if (bCalib) {
	RJMP _0x9B
_0x9A:
	LDS  R30,_bCalib
	CPI  R30,0
	BRNE PC+3
	JMP _0x9C
; 0000 01DA 				switch(CalibStep)
	LDS  R30,_CalibStep
; 0000 01DB 				{
; 0000 01DC 					case 0:
	CPI  R30,0
	BREQ PC+3
	JMP _0xA0
; 0000 01DD 
; 0000 01DE 					case 1:
	RJMP _0xA1
_0xA0:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0xA2
_0xA1:
; 0000 01DF 
; 0000 01E0 						break;
	RJMP _0x9F
; 0000 01E1 
; 0000 01E2 					case 10:    // ITV 0.05 Output  4mA  Set VR
_0xA2:
	CPI  R30,LOW(0xA)
	BREQ PC+3
	JMP _0xA3
; 0000 01E3 						Lcdprintf(0, 0, "ITV 4mA Calib Mode!!");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,697
	CALL SUBOPT_0x2A
; 0000 01E4 						Lcdprintf(0, 1, "Set VR10            ");
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,718
	CALL SUBOPT_0x2A
; 0000 01E5 						Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x41
	CALL SUBOPT_0x42
	CALL SUBOPT_0x43
	CALL SUBOPT_0x42
	CALL SUBOPT_0x36
; 0000 01E6 						Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
	CALL SUBOPT_0x3F
	CALL SUBOPT_0x40
	CALL SUBOPT_0x38
; 0000 01E7 						break;
	RJMP _0x9F
; 0000 01E8 					case 11:    // ITV 9.00 Output  20mA  Set VR
_0xA3:
	CPI  R30,LOW(0xB)
	BREQ PC+3
	JMP _0xA4
; 0000 01E9 						Lcdprintf(0, 0, "ITV 20mA Calib Mode!");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,757
	CALL SUBOPT_0x2A
; 0000 01EA 						Lcdprintf(0, 1, "Set VR11            ");
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,778
	CALL SUBOPT_0x2A
; 0000 01EB 						Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x41
	CALL SUBOPT_0x42
	CALL SUBOPT_0x43
	CALL SUBOPT_0x42
	CALL SUBOPT_0x36
; 0000 01EC 						Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
	CALL SUBOPT_0x3F
	CALL SUBOPT_0x40
	CALL SUBOPT_0x38
; 0000 01ED 						break;
	RJMP _0x9F
; 0000 01EE 
; 0000 01EF 					case 12:    // ITV INPUT CALIB
_0xA4:
	CPI  R30,LOW(0xC)
	BREQ PC+3
	JMP _0xA5
; 0000 01F0 						Lcdprintf(0, 0, "ITV 1V Calib Mode! ");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,799
	CALL SUBOPT_0x2A
; 0000 01F1 						Lcdprintf(0, 1, "Set Volt 1V  :%ld", CalItvMin);
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,819
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x44
	CALL SUBOPT_0x45
; 0000 01F2 						Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x41
	CALL SUBOPT_0x42
	CALL SUBOPT_0x43
	CALL SUBOPT_0x42
	CALL SUBOPT_0x36
; 0000 01F3 						Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
	CALL SUBOPT_0x3F
	CALL SUBOPT_0x40
	CALL SUBOPT_0x38
; 0000 01F4 						break;
	RJMP _0x9F
; 0000 01F5 					case 13:    // ITV INPUT CALIB
_0xA5:
	CPI  R30,LOW(0xD)
	BREQ PC+3
	JMP _0x9F
; 0000 01F6 						Lcdprintf(0, 0, "ITV 5V Calib Mode! ");
	CALL SUBOPT_0x1C
	__POINTW1FN _0x0,837
	CALL SUBOPT_0x2A
; 0000 01F7 						Lcdprintf(0, 1, "Set Volt 5V  :%ld", CalItvMax);
	CALL SUBOPT_0x20
	__POINTW1FN _0x0,857
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x46
	CALL SUBOPT_0x45
; 0000 01F8 						Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x41
	CALL SUBOPT_0x42
	CALL SUBOPT_0x43
	CALL SUBOPT_0x42
	CALL SUBOPT_0x36
; 0000 01F9 						Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
	CALL SUBOPT_0x3F
	CALL SUBOPT_0x40
	CALL SUBOPT_0x38
; 0000 01FA 						break;
; 0000 01FB 
; 0000 01FC 				}
_0x9F:
; 0000 01FD 			}else if (HiddenStep) {
	RJMP _0xA7
_0x9C:
	LDS  R30,_HiddenStep
	CPI  R30,0
	BRNE PC+3
	JMP _0xA8
; 0000 01FE 
; 0000 01FF 			}
; 0000 0200 			else {
	RJMP _0xA9
_0xA8:
; 0000 0201 				ReadPressure = GetItv();
	CALL SUBOPT_0x3A
; 0000 0202 				//Lcdprintf(13, 3, "%d.%02dkgf", Pressure / 100, Pressure % 100);
; 0000 0203 				Lcdprintf(13, 3, "%d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
	LDI  R30,LOW(13)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	__POINTW1FN _0x0,398
	ST   -Y,R31
	ST   -Y,R30
	LDS  R26,_ReadPressure
	LDS  R27,_ReadPressure+1
	LDS  R24,_ReadPressure+2
	LDS  R25,_ReadPressure+3
	__GETD1N 0x64
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x40
	CALL SUBOPT_0x38
; 0000 0204 				if (bAutoMode) Lcdprintf(16, 2, "%2d.%d", (RunStepTime / 10) / 10, (RunStepTime / 10) % 10);
	LDS  R30,_bAutoMode
	CPI  R30,0
	BRNE PC+3
	JMP _0xAA
	CALL SUBOPT_0x47
	CALL SUBOPT_0x48
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x48
	CALL SUBOPT_0x2D
	CALL SUBOPT_0x38
; 0000 0205 				else Lcdprintf(16, 2, "%2d.%d", (mRunStepTime / 10) / 10, (mRunStepTime / 10) % 10);
	RJMP _0xAB
_0xAA:
	CALL SUBOPT_0x47
	CALL SUBOPT_0x49
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x49
	CALL SUBOPT_0x2D
	CALL SUBOPT_0x38
; 0000 0206 				if (bRun)
_0xAB:
	LDS  R30,_bRun
	CPI  R30,0
	BRNE PC+3
	JMP _0xAC
; 0000 0207 				{
; 0000 0208 					switch(RunStep)
	LDS  R30,_RunStep
; 0000 0209 					{
; 0000 020A 					case RUN_STOP:
	CPI  R30,0
	BREQ PC+3
	JMP _0xB0
; 0000 020B 						Lcdprintf(0, 3, "STOP       ");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,875
	CALL SUBOPT_0x2A
; 0000 020C 						break;
	RJMP _0xAF
; 0000 020D 
; 0000 020E 					case RUN_START_DELAY:
_0xB0:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0xB1
; 0000 020F 						Lcdprintf(0, 3, "START DELAY");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,887
	CALL SUBOPT_0x2A
; 0000 0210 						break;
	RJMP _0xAF
; 0000 0211 
; 0000 0212 					case RUN_JIG_IN:
_0xB1:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0xB2
; 0000 0213 						Lcdprintf(0, 3, "JIG IN     ");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,899
	CALL SUBOPT_0x2A
; 0000 0214 						break;
	RJMP _0xAF
; 0000 0215 
; 0000 0216 					case RUN_EXHAUST1:
_0xB2:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0xB3
; 0000 0217 						Lcdprintf(0, 3, "CYL D1     ");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,911
	CALL SUBOPT_0x2A
; 0000 0218 						break;
	RJMP _0xAF
; 0000 0219 
; 0000 021A 					case RUN_EXHAUST2:
_0xB3:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0xB4
; 0000 021B 						Lcdprintf(0, 3, "CYL D2     ");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,923
	CALL SUBOPT_0x2A
; 0000 021C 						break;
	RJMP _0xAF
; 0000 021D 
; 0000 021E 					case RUN_CYL_DOWN:
_0xB4:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0xB5
; 0000 021F 						Lcdprintf(0, 3, "CYL DOWN   ");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,935
	CALL SUBOPT_0x2A
; 0000 0220 						break;
	RJMP _0xAF
; 0000 0221 
; 0000 0222 					case RUN_PRESSURE_DELAY:
_0xB5:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0xB6
; 0000 0223 						Lcdprintf(0, 3, "PRESSURE");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,947
	CALL SUBOPT_0x2A
; 0000 0224 						break;
	RJMP _0xAF
; 0000 0225 
; 0000 0226 					case RUN_CYL_UP:
_0xB6:
	CPI  R30,LOW(0x7)
	BREQ PC+3
	JMP _0xB7
; 0000 0227 						Lcdprintf(0, 3, "CYL UP     ");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,956
	CALL SUBOPT_0x2A
; 0000 0228 						break;
	RJMP _0xAF
; 0000 0229 
; 0000 022A 					case RUN_JIG_OUT:
_0xB7:
	CPI  R30,LOW(0x8)
	BREQ PC+3
	JMP _0xB8
; 0000 022B 						Lcdprintf(0, 3, "JIG OUT    ");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,968
	CALL SUBOPT_0x2A
; 0000 022C 						break;
	RJMP _0xAF
; 0000 022D 
; 0000 022E 					case RUN_END:
_0xB8:
	CPI  R30,LOW(0x9)
	BREQ PC+3
	JMP _0xAF
; 0000 022F 						Lcdprintf(0, 3, "END        ");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,980
	CALL SUBOPT_0x2A
; 0000 0230 						break;
; 0000 0231 
; 0000 0232 					}
_0xAF:
; 0000 0233 				}else {
	RJMP _0xBA
_0xAC:
; 0000 0234 					if ((bEmoState == 1) || (bEmoState == 2))
	LDS  R26,_bEmoState
	CPI  R26,LOW(0x1)
	BRNE PC+3
	JMP _0xBC
	LDS  R26,_bEmoState
	CPI  R26,LOW(0x2)
	BRNE PC+3
	JMP _0xBC
	RJMP _0xBB
_0xBC:
; 0000 0235 					{
; 0000 0236 						if (bBlink)
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0xBE
; 0000 0237 						{
; 0000 0238 							Lcdprintf(0, 3, "EMERGENCY!!!");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,992
	CALL SUBOPT_0x2A
; 0000 0239 							//Lcdprintf(0, 3, "EME%d", bEmoState);
; 0000 023A 						}else {
	RJMP _0xBF
_0xBE:
; 0000 023B 							Lcdprintf(0, 3, "            ");
	CALL SUBOPT_0x4A
	CALL SUBOPT_0x4B
; 0000 023C 						}
_0xBF:
; 0000 023D 					}else if (bAutoMode && bSafeSensorFail) {
	RJMP _0xC0
_0xBB:
	LDS  R30,_bAutoMode
	CPI  R30,0
	BRNE PC+3
	JMP _0xC2
	LDS  R30,_bSafeSensorFail
	CPI  R30,0
	BRNE PC+3
	JMP _0xC2
	RJMP _0xC3
_0xC2:
	RJMP _0xC1
_0xC3:
; 0000 023E 						if (bBlink)
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0xC4
; 0000 023F 						{
; 0000 0240 							Lcdprintf(0, 3, "SAFE SENSOR!");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,1005
	CALL SUBOPT_0x2A
; 0000 0241 						}else {
	RJMP _0xC5
_0xC4:
; 0000 0242 							Lcdprintf(0, 3, "            ");
	CALL SUBOPT_0x4A
	CALL SUBOPT_0x4B
; 0000 0243 						}
_0xC5:
; 0000 0244 					}else if (bAutoMode && bDoorSensorFail) {
	RJMP _0xC6
_0xC1:
	LDS  R30,_bAutoMode
	CPI  R30,0
	BRNE PC+3
	JMP _0xC8
	LDS  R30,_bDoorSensorFail
	CPI  R30,0
	BRNE PC+3
	JMP _0xC8
	RJMP _0xC9
_0xC8:
	RJMP _0xC7
_0xC9:
; 0000 0245 						if (bBlink)
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0xCA
; 0000 0246 						{
; 0000 0247 							Lcdprintf(0, 3, "DOOR SENSOR!");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,1018
	CALL SUBOPT_0x2A
; 0000 0248 						}else {
	RJMP _0xCB
_0xCA:
; 0000 0249 							Lcdprintf(0, 3, "            ");
	CALL SUBOPT_0x4A
	CALL SUBOPT_0x4B
; 0000 024A 						}
_0xCB:
; 0000 024B 					}else if (bAutoMode && bPressureFail) {
	RJMP _0xCC
_0xC7:
	LDS  R30,_bAutoMode
	CPI  R30,0
	BRNE PC+3
	JMP _0xCE
	LDS  R30,_bPressureFail
	CPI  R30,0
	BRNE PC+3
	JMP _0xCE
	RJMP _0xCF
_0xCE:
	RJMP _0xCD
_0xCF:
; 0000 024C 						if (bBlink)
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0xD0
; 0000 024D 						{
; 0000 024E 							Lcdprintf(0, 3, "PRESSURE AL!");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,1031
	CALL SUBOPT_0x2A
; 0000 024F 						}else {
	RJMP _0xD1
_0xD0:
; 0000 0250 							Lcdprintf(0, 3, "            ");
	CALL SUBOPT_0x4A
	CALL SUBOPT_0x4B
; 0000 0251 						}
_0xD1:
; 0000 0252 					}else if (bAutoMode) {
	RJMP _0xD2
_0xCD:
	LDS  R30,_bAutoMode
	CPI  R30,0
	BRNE PC+3
	JMP _0xD3
; 0000 0253 						Lcdprintf(0, 3, "READY        ");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,1044
	CALL SUBOPT_0x2A
; 0000 0254 					}else {
	RJMP _0xD4
_0xD3:
; 0000 0255 						Lcdprintf(0, 3, "CYL : ");
	CALL SUBOPT_0x4A
	__POINTW1FN _0x0,1058
	CALL SUBOPT_0x2A
; 0000 0256 						if (bCylXIn) Lcdprintf(6, 3, "IN -");
	LDS  R30,_bCylXIn
	CPI  R30,0
	BRNE PC+3
	JMP _0xD5
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	__POINTW1FN _0x0,1065
	CALL SUBOPT_0x2A
; 0000 0257 						else Lcdprintf(6, 3, "OUT-");
	RJMP _0xD6
_0xD5:
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	__POINTW1FN _0x0,1070
	CALL SUBOPT_0x2A
; 0000 0258 
; 0000 0259 						if (bCylYDown) Lcdprintf(10, 3, "DO");
_0xD6:
	LDS  R30,_bCylYDown
	CPI  R30,0
	BRNE PC+3
	JMP _0xD7
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	__POINTW1FN _0x0,1075
	CALL SUBOPT_0x2A
; 0000 025A 						else Lcdprintf(10, 3, "UP");
	RJMP _0xD8
_0xD7:
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	__POINTW1FN _0x0,419
	CALL SUBOPT_0x2A
; 0000 025B 					}
_0xD8:
_0xD4:
_0xD2:
_0xCC:
_0xC6:
_0xC0:
; 0000 025C 				}
_0xBA:
; 0000 025D 
; 0000 025E 			}
_0xA9:
_0xA7:
_0x9B:
; 0000 025F 			break;
	RJMP _0x98
; 0000 0260 
; 0000 0261 		case MODE2_PRESSURE_SET:	// 압력
_0x99:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0xD9
; 0000 0262 			Lcdprintf(12, 1, "%d.%02d", SetData / 100, SetData % 100);
	CALL SUBOPT_0x34
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x4D
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x4E
; 0000 0263 			LineDecision(15, 1);
	CALL SUBOPT_0x4F
; 0000 0264 			break;
	RJMP _0x98
; 0000 0265 
; 0000 0266 		case MODE2_PRESSURE_DELAY_SET:	// TIME
_0xD9:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0x98
; 0000 0267 			Lcdprintf(12, 1, "%2d.%d", SetData / 10, SetData % 10);
	CALL SUBOPT_0x50
	CALL SUBOPT_0x51
	CALL SUBOPT_0x4D
	CALL SUBOPT_0x51
	CALL SUBOPT_0x4E
; 0000 0268 			LineDecision(15, 1);
	CALL SUBOPT_0x4F
; 0000 0269 			break;
; 0000 026A 		}
_0x98:
; 0000 026B 
; 0000 026C 		switch(HiddenStep)
	LDS  R30,_HiddenStep
; 0000 026D 		{
; 0000 026E 		case HIDDEN1_STEP:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0xDE
; 0000 026F 			Lcdprintf(13, 1, "%02d", Hidden1SetData);
	LDI  R30,LOW(13)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	__POINTW1FN _0x0,496
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x52
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x45
; 0000 0270 			LineDecision(14, 1);
	LDI  R30,LOW(14)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _LineDecision
; 0000 0271             break;
	RJMP _0xDD
; 0000 0272 
; 0000 0273 		case HIDDEN1_STEP_DELAY:
_0xDE:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0xDD
; 0000 0274 			Lcdprintf(12, 1, "%2d.%d", Hidden1SetData / 10, Hidden1SetData % 10);
	CALL SUBOPT_0x50
	CALL SUBOPT_0x53
	CALL SUBOPT_0x4D
	CALL SUBOPT_0x53
	CALL SUBOPT_0x4E
; 0000 0275             LineDecision(15, 1);
	CALL SUBOPT_0x4F
; 0000 0276             break;
; 0000 0277 		}
_0xDD:
; 0000 0278     	bVarDisplay = 0;
	LDI  R30,LOW(0)
	STS  _bVarDisplay,R30
; 0000 0279     }
; 0000 027A 
; 0000 027B 
; 0000 027C 	// LED
; 0000 027D     if (bPressureFail)
_0x95:
	LDS  R30,_bPressureFail
	CPI  R30,0
	BRNE PC+3
	JMP _0xE0
; 0000 027E     {
; 0000 027F 		if (!bRun)
	LDS  R30,_bRun
	CPI  R30,0
	BREQ PC+3
	JMP _0xE1
; 0000 0280         {
; 0000 0281         	LedPassOff();
	CALL SUBOPT_0x54
; 0000 0282         	LedFailOn();
; 0000 0283         }
; 0000 0284     }else {
_0xE1:
	RJMP _0xE2
_0xE0:
; 0000 0285     	if (bRunAlarm) {
	LDS  R30,_bRunAlarm
	CPI  R30,0
	BRNE PC+3
	JMP _0xE3
; 0000 0286         	if (bBlink)
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0xE4
; 0000 0287             {
; 0000 0288 				LedPassOff();
	CALL SUBOPT_0x54
; 0000 0289        			LedFailOn();
; 0000 028A             }else {
	RJMP _0xE5
_0xE4:
; 0000 028B 				LedPassOff();
	CALL SUBOPT_0x55
; 0000 028C        			LedFailOff();
	CALL SUBOPT_0x56
; 0000 028D             }
_0xE5:
; 0000 028E         }else {
	RJMP _0xE6
_0xE3:
; 0000 028F 			LedFailOff();
	CALL SUBOPT_0x56
; 0000 0290         	LedPassOff();
	CALL SUBOPT_0x55
; 0000 0291         }
_0xE6:
; 0000 0292     }
_0xE2:
; 0000 0293 
; 0000 0294     if (bRun)
	LDS  R30,_bRun
	CPI  R30,0
	BRNE PC+3
	JMP _0xE7
; 0000 0295 	{
; 0000 0296        	if (bBlink)
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0xE8
; 0000 0297         {
; 0000 0298 	        LedComOn();
	LDS  R30,261
	ANDI R30,0xFB
	STS  261,R30
; 0000 0299         }else {
	RJMP _0xE9
_0xE8:
; 0000 029A 	        LedComOff();
	CALL SUBOPT_0x57
; 0000 029B         }
_0xE9:
; 0000 029C 
; 0000 029D         if (RunStep == RUN_PRESSURE_DELAY)
	LDS  R26,_RunStep
	CPI  R26,LOW(0x6)
	BREQ PC+3
	JMP _0xEA
; 0000 029E         {
; 0000 029F             if (!bPressureFail && !bRunAlarm)
	LDS  R30,_bPressureFail
	CPI  R30,0
	BREQ PC+3
	JMP _0xEC
	LDS  R30,_bRunAlarm
	CPI  R30,0
	BREQ PC+3
	JMP _0xEC
	RJMP _0xED
_0xEC:
	RJMP _0xEB
_0xED:
; 0000 02A0             {
; 0000 02A1                 if (bBlink)
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0xEE
; 0000 02A2                 {
; 0000 02A3                     LedPassOn();
	LDS  R30,261
	ANDI R30,0XF7
	STS  261,R30
; 0000 02A4        			    LedFailOff();
	CALL SUBOPT_0x56
; 0000 02A5                 } else{
	RJMP _0xEF
_0xEE:
; 0000 02A6                     LedPassOff();
	CALL SUBOPT_0x55
; 0000 02A7        			    LedFailOff();
	CALL SUBOPT_0x56
; 0000 02A8                 }
_0xEF:
; 0000 02A9             }else {
	RJMP _0xF0
_0xEB:
; 0000 02AA                 if (bBlink)
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0xF1
; 0000 02AB                 {
; 0000 02AC                     LedPassOff();
	CALL SUBOPT_0x54
; 0000 02AD        			    LedFailOn();
; 0000 02AE                 } else {
	RJMP _0xF2
_0xF1:
; 0000 02AF                     LedPassOff();
	CALL SUBOPT_0x55
; 0000 02B0        			    LedFailOff();
	CALL SUBOPT_0x56
; 0000 02B1                 }
_0xF2:
; 0000 02B2             }
_0xF0:
; 0000 02B3         }
; 0000 02B4     }else {
_0xEA:
	RJMP _0xF3
_0xE7:
; 0000 02B5     	if (bLongKey) LedComOff();
	LDS  R30,_bLongKey
	CPI  R30,0
	BRNE PC+3
	JMP _0xF4
	CALL SUBOPT_0x57
; 0000 02B6         else LedComOn();
	RJMP _0xF5
_0xF4:
	LDS  R30,261
	ANDI R30,0xFB
	STS  261,R30
; 0000 02B7     }
_0xF5:
_0xF3:
; 0000 02B8 }
	RET
;
;void KeySubroutine(void)	// 100ms
; 0000 02BB {
_KeySubroutine:
; 0000 02BC 	static unsigned char KeyDownCount = 0;
; 0000 02BD     static unsigned char PrevDownKey = 0;
; 0000 02BE 
; 0000 02BF     if (Key)	// 키 눌려진 상태
	LDS  R30,_Key
	CPI  R30,0
	BRNE PC+3
	JMP _0xF6
; 0000 02C0     {
; 0000 02C1 		PrevDownKey = Key;
	LDS  R30,_Key
	STS  _PrevDownKey_S0000004,R30
; 0000 02C2     	if (++KeyDownCount >= 200) KeyDownCount--;
	LDS  R26,_KeyDownCount_S0000004
	SUBI R26,-LOW(1)
	STS  _KeyDownCount_S0000004,R26
	CPI  R26,LOW(0xC8)
	BRSH PC+3
	JMP _0xF7
	LDS  R30,_KeyDownCount_S0000004
	SUBI R30,LOW(1)
	STS  _KeyDownCount_S0000004,R30
; 0000 02C3 
; 0000 02C4         if (KeyDownCount > 10)	//1sec 이상
_0xF7:
	LDS  R26,_KeyDownCount_S0000004
	CPI  R26,LOW(0xB)
	BRSH PC+3
	JMP _0xF8
; 0000 02C5         {
; 0000 02C6 			bLongKey = 1;
	LDI  R30,LOW(1)
	STS  _bLongKey,R30
; 0000 02C7         	switch(Key)
	LDS  R30,_Key
; 0000 02C8         	{
; 0000 02C9 				case KEY_UP:
	CPI  R30,LOW(0x10)
	BREQ PC+3
	JMP _0xFC
; 0000 02CA                 	switch(Mode1Step)
	LDS  R30,_Mode1Step
; 0000 02CB                     {
; 0000 02CC                     	case MODE1_NOMAL:
	CPI  R30,0
	BREQ PC+3
	JMP _0x100
; 0000 02CD                         	break;
	RJMP _0xFF
; 0000 02CE                         case MODE2_PRESSURE_SET:	// 압력 설정
_0x100:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x101
; 0000 02CF                         	if (KeyDownCount > 30) {
	LDS  R26,_KeyDownCount_S0000004
	CPI  R26,LOW(0x1F)
	BRSH PC+3
	JMP _0x102
; 0000 02D0                             	SetData += 10;
	CALL SUBOPT_0x58
; 0000 02D1                         		if (SetData > PRESSURE_MAX_) SetData = PRESSURE_MAX_;
	CPI  R26,LOW(0x259)
	LDI  R30,HIGH(0x259)
	CPC  R27,R30
	BRSH PC+3
	JMP _0x103
	LDI  R30,LOW(600)
	LDI  R31,HIGH(600)
	CALL SUBOPT_0x59
; 0000 02D2 							}else {
_0x103:
	RJMP _0x104
_0x102:
; 0000 02D3                         		if (++SetData > PRESSURE_MAX_) SetData--;
	CALL SUBOPT_0x5A
	CALL SUBOPT_0x5B
	BRSH PC+3
	JMP _0x105
	CALL SUBOPT_0x5A
	CALL SUBOPT_0x5C
; 0000 02D4                             }
_0x105:
_0x104:
; 0000 02D5                             bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 02D6                             break;
	RJMP _0xFF
; 0000 02D7                     	case MODE2_PRESSURE_DELAY_SET:	// Pressure Time
_0x101:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0xFF
; 0000 02D8                         	if (KeyDownCount > 30) {
	LDS  R26,_KeyDownCount_S0000004
	CPI  R26,LOW(0x1F)
	BRSH PC+3
	JMP _0x107
; 0000 02D9                             	SetData += 10;
	CALL SUBOPT_0x58
; 0000 02DA                         		if (SetData > PRESSURE_TIME_MAX) SetData = PRESSURE_TIME_MAX;
	CPI  R26,LOW(0xC9)
	LDI  R30,HIGH(0xC9)
	CPC  R27,R30
	BRSH PC+3
	JMP _0x108
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CALL SUBOPT_0x59
; 0000 02DB                             }else {
_0x108:
	RJMP _0x109
_0x107:
; 0000 02DC                         		if (++SetData > PRESSURE_TIME_MAX) SetData--;
	CALL SUBOPT_0x5A
	CALL SUBOPT_0x5D
	BRSH PC+3
	JMP _0x10A
	CALL SUBOPT_0x5A
	CALL SUBOPT_0x5C
; 0000 02DD                             }
_0x10A:
_0x109:
; 0000 02DE                             bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 02DF                             break;
; 0000 02E0                     }
_0xFF:
; 0000 02E1 
; 0000 02E2 					switch(HiddenStep)
	LDS  R30,_HiddenStep
; 0000 02E3 					{
; 0000 02E4 					case HIDDEN1_STEP:				// 압착 Step Set
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x10E
; 0000 02E5 						if (KeyDownCount > 30) {
	LDS  R26,_KeyDownCount_S0000004
	CPI  R26,LOW(0x1F)
	BRSH PC+3
	JMP _0x10F
; 0000 02E6 							Hidden1SetData += 10;
	CALL SUBOPT_0x5E
; 0000 02E7 							if (Hidden1SetData > PRESSURE_STEP_MAX) Hidden1SetData = PRESSURE_STEP_MAX;
	BRSH PC+3
	JMP _0x110
	CALL SUBOPT_0x5F
; 0000 02E8 						}else {
_0x110:
	RJMP _0x111
_0x10F:
; 0000 02E9 							if (++Hidden1SetData > PRESSURE_STEP_MAX) Hidden1SetData--;
	CALL SUBOPT_0x60
	CALL SUBOPT_0x61
	BRSH PC+3
	JMP _0x112
	CALL SUBOPT_0x60
	CALL SUBOPT_0x5C
; 0000 02EA 						}
_0x112:
_0x111:
; 0000 02EB 						bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 02EC 						break;
	RJMP _0x10D
; 0000 02ED 					case HIDDEN1_STEP_DELAY:		// 압착 Step Delay Set
_0x10E:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x10D
; 0000 02EE 						if (KeyDownCount > 30) {
	LDS  R26,_KeyDownCount_S0000004
	CPI  R26,LOW(0x1F)
	BRSH PC+3
	JMP _0x114
; 0000 02EF 							Hidden1SetData += 10;
	CALL SUBOPT_0x5E
; 0000 02F0 							if (Hidden1SetData > PRESSURE_STEP_DELAY_MAX) Hidden1SetData = PRESSURE_STEP_DELAY_MAX;
	BRSH PC+3
	JMP _0x115
	CALL SUBOPT_0x5F
; 0000 02F1 						}else {
_0x115:
	RJMP _0x116
_0x114:
; 0000 02F2 							if (++Hidden1SetData > PRESSURE_STEP_DELAY_MAX) Hidden1SetData--;
	CALL SUBOPT_0x60
	CALL SUBOPT_0x61
	BRSH PC+3
	JMP _0x117
	CALL SUBOPT_0x60
	CALL SUBOPT_0x5C
; 0000 02F3 						}
_0x117:
_0x116:
; 0000 02F4 						bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 02F5 						break;
; 0000 02F6 					}
_0x10D:
; 0000 02F7 					break;
	RJMP _0xFB
; 0000 02F8 
; 0000 02F9                 case KEY_DOWN:
_0xFC:
	CPI  R30,LOW(0x20)
	BREQ PC+3
	JMP _0xFB
; 0000 02FA                 	switch(Mode1Step)
	LDS  R30,_Mode1Step
; 0000 02FB                     {
; 0000 02FC                     	case MODE1_NOMAL:
	CPI  R30,0
	BREQ PC+3
	JMP _0x11C
; 0000 02FD                         	break;
	RJMP _0x11B
; 0000 02FE                         case MODE2_PRESSURE_SET:
_0x11C:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x11D
; 0000 02FF                         	if (KeyDownCount > 30) {
	LDS  R26,_KeyDownCount_S0000004
	CPI  R26,LOW(0x1F)
	BRSH PC+3
	JMP _0x11E
; 0000 0300                             	if (SetData > PRESSURE_MIN + 10) SetData -= 10;
	CALL SUBOPT_0x62
	SBIW R26,11
	BRSH PC+3
	JMP _0x11F
	CALL SUBOPT_0x63
; 0000 0301                                 else SetData = PRESSURE_MIN;
	RJMP _0x120
_0x11F:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL SUBOPT_0x59
; 0000 0302                         	}else {
_0x120:
	RJMP _0x121
_0x11E:
; 0000 0303 	                        	if (SetData > PRESSURE_MIN) SetData--;
	CALL SUBOPT_0x64
	BRLO PC+3
	JMP _0x122
	CALL SUBOPT_0x5A
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 0304                             }
_0x122:
_0x121:
; 0000 0305                             bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0306                             break;
	RJMP _0x11B
; 0000 0307                     	case MODE2_PRESSURE_DELAY_SET:	// Pressure Time
_0x11D:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0x11B
; 0000 0308                         	if (KeyDownCount > 30) {
	LDS  R26,_KeyDownCount_S0000004
	CPI  R26,LOW(0x1F)
	BRSH PC+3
	JMP _0x124
; 0000 0309                             	if (SetData > PRESSURE_TIME_MIN + 10) SetData -= 10;
	CALL SUBOPT_0x62
	SBIW R26,11
	BRSH PC+3
	JMP _0x125
	CALL SUBOPT_0x63
; 0000 030A                                 else SetData = PRESSURE_TIME_MIN;
	RJMP _0x126
_0x125:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL SUBOPT_0x59
; 0000 030B                         	}else {
_0x126:
	RJMP _0x127
_0x124:
; 0000 030C                             	if (SetData > PRESSURE_TIME_MIN) SetData--;
	CALL SUBOPT_0x64
	BRLO PC+3
	JMP _0x128
	CALL SUBOPT_0x5A
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 030D                             }
_0x128:
_0x127:
; 0000 030E                             bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 030F                             break;
; 0000 0310                     }
_0x11B:
; 0000 0311 
; 0000 0312 					switch(HiddenStep)
	LDS  R30,_HiddenStep
; 0000 0313 					{
; 0000 0314 					case HIDDEN1_STEP:				// 압착 Step Set
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x12C
; 0000 0315 						if (KeyDownCount > 30) {
	LDS  R26,_KeyDownCount_S0000004
	CPI  R26,LOW(0x1F)
	BRSH PC+3
	JMP _0x12D
; 0000 0316 							if (Hidden1SetData > PRESSURE_STEP_MIN + 10) Hidden1SetData -= 10;
	CALL SUBOPT_0x65
	SBIW R26,13
	BRSH PC+3
	JMP _0x12E
	CALL SUBOPT_0x66
; 0000 0317 							else Hidden1SetData = PRESSURE_STEP_MIN;
	RJMP _0x12F
_0x12E:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL SUBOPT_0x67
; 0000 0318 						}else {
_0x12F:
	RJMP _0x130
_0x12D:
; 0000 0319 							if (Hidden1SetData > PRESSURE_STEP_MIN) Hidden1SetData--;
	CALL SUBOPT_0x65
	SBIW R26,3
	BRSH PC+3
	JMP _0x131
	CALL SUBOPT_0x60
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 031A 						}
_0x131:
_0x130:
; 0000 031B 						bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 031C 						break;
	RJMP _0x12B
; 0000 031D 					case HIDDEN1_STEP_DELAY:		// 압착 Step Delay Set
_0x12C:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x12B
; 0000 031E 						if (KeyDownCount > 30) {
	LDS  R26,_KeyDownCount_S0000004
	CPI  R26,LOW(0x1F)
	BRSH PC+3
	JMP _0x133
; 0000 031F 							if (Hidden1SetData > PRESSURE_STEP_DELAY_MIN + 10) Hidden1SetData -= 10;
	CALL SUBOPT_0x65
	SBIW R26,12
	BRSH PC+3
	JMP _0x134
	CALL SUBOPT_0x66
; 0000 0320 							else Hidden1SetData = PRESSURE_STEP_DELAY_MIN;
	RJMP _0x135
_0x134:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL SUBOPT_0x67
; 0000 0321 						}else {
_0x135:
	RJMP _0x136
_0x133:
; 0000 0322 							if (Hidden1SetData > PRESSURE_STEP_DELAY_MIN) Hidden1SetData--;
	CALL SUBOPT_0x65
	SBIW R26,2
	BRSH PC+3
	JMP _0x137
	CALL SUBOPT_0x60
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 0323 						}
_0x137:
_0x136:
; 0000 0324 						bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0325 						break;
; 0000 0326 					}
_0x12B:
; 0000 0327                 	break;
; 0000 0328         	}
_0xFB:
; 0000 0329 
; 0000 032A 			if (Key == (SW_START1 | SW_START2))
	LDS  R26,_Key
	CPI  R26,LOW(0x81)
	BREQ PC+3
	JMP _0x138
; 0000 032B             {
; 0000 032C 				if (bAgingMode)
	LDS  R30,_bAgingMode
	CPI  R30,0
	BRNE PC+3
	JMP _0x139
; 0000 032D 				{
; 0000 032E 					KeyDownCount = 0;
	LDI  R30,LOW(0)
	STS  _KeyDownCount_S0000004,R30
; 0000 032F 					SetBuzzer(1, 2);
	CALL SUBOPT_0x1B
; 0000 0330 					if (!bRun)	//Aging Mode 시작
	LDS  R30,_bRun
	CPI  R30,0
	BREQ PC+3
	JMP _0x13A
; 0000 0331 					{
; 0000 0332 						bAgingEnd = 0;
	LDI  R30,LOW(0)
	STS  _bAgingEnd,R30
; 0000 0333 						if (!bAgingEnd)
	CPI  R30,0
	BREQ PC+3
	JMP _0x13B
; 0000 0334 						{
; 0000 0335 							if (bDoorSensorFail == 0 && bSafeSensorFail == 0 && !Emo && !bPressureFail)
	LDS  R26,_bDoorSensorFail
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x13D
	LDS  R26,_bSafeSensorFail
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x13D
	LDS  R30,_Emo
	CPI  R30,0
	BREQ PC+3
	JMP _0x13D
	LDS  R30,_bPressureFail
	CPI  R30,0
	BREQ PC+3
	JMP _0x13D
	RJMP _0x13E
_0x13D:
	RJMP _0x13C
_0x13E:
; 0000 0336 							{
; 0000 0337 								Mode1Step = 0;
	CALL SUBOPT_0x68
; 0000 0338 								bRun = 1;
; 0000 0339 								bRunAlarm = 0;
; 0000 033A 								bMenuDisplay = 1;
; 0000 033B 								bVarDisplay = 1;
; 0000 033C 							}else {
	RJMP _0x13F
_0x13C:
; 0000 033D 								SetBuzzer(1, 1);
	CALL SUBOPT_0x1F
; 0000 033E 								bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 033F 							}
_0x13F:
; 0000 0340 						}
; 0000 0341 					}else {
_0x13B:
	RJMP _0x140
_0x13A:
; 0000 0342 						bAgingEnd = 1;
	LDI  R30,LOW(1)
	STS  _bAgingEnd,R30
; 0000 0343 						if (bAgingEnd)
	CPI  R30,0
	BRNE PC+3
	JMP _0x141
; 0000 0344 						{
; 0000 0345 							//bRun = 0;
; 0000 0346 							bRunAlarm = 0;
	LDI  R30,LOW(0)
	STS  _bRunAlarm,R30
; 0000 0347 							bMenuDisplay = 1;
	CALL SUBOPT_0x26
; 0000 0348 							bVarDisplay = 1;
; 0000 0349 
; 0000 034A 							//SetBuzzer(0, 2);
; 0000 034B 						}
; 0000 034C 					}
_0x141:
_0x140:
; 0000 034D 				}
; 0000 034E             }
_0x139:
; 0000 034F 
; 0000 0350         }else {
_0x138:
	RJMP _0x142
_0xF8:
; 0000 0351         	if (Key == (SW_START1 | SW_START2))
	LDS  R26,_Key
	CPI  R26,LOW(0x81)
	BREQ PC+3
	JMP _0x143
; 0000 0352             {
; 0000 0353 				if (bReturnSensor == 1 || bEmoState == 1)
	LDS  R26,_bReturnSensor
	CPI  R26,LOW(0x1)
	BRNE PC+3
	JMP _0x145
	LDS  R26,_bEmoState
	CPI  R26,LOW(0x1)
	BRNE PC+3
	JMP _0x145
	RJMP _0x144
_0x145:
; 0000 0354 				{
; 0000 0355 					bReturnSensor = 2;
	LDI  R30,LOW(2)
	STS  _bReturnSensor,R30
; 0000 0356 					bEmoState = 2;
	STS  _bEmoState,R30
; 0000 0357 				}else if (!bAgingMode && bAutoMode && !bRun)
	RJMP _0x147
_0x144:
	LDS  R30,_bAgingMode
	CPI  R30,0
	BREQ PC+3
	JMP _0x149
	LDS  R30,_bAutoMode
	CPI  R30,0
	BRNE PC+3
	JMP _0x149
	LDS  R30,_bRun
	CPI  R30,0
	BREQ PC+3
	JMP _0x149
	RJMP _0x14A
_0x149:
	RJMP _0x148
_0x14A:
; 0000 0358 				{
; 0000 0359 					bAgingMode = 0;
	LDI  R30,LOW(0)
	STS  _bAgingMode,R30
; 0000 035A 					if (bDoorSensorFail == 0 && bSafeSensorFail == 0 && !Emo && !bPressureFail)
	LDS  R26,_bDoorSensorFail
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x14C
	LDS  R26,_bSafeSensorFail
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x14C
	LDS  R30,_Emo
	CPI  R30,0
	BREQ PC+3
	JMP _0x14C
	LDS  R30,_bPressureFail
	CPI  R30,0
	BREQ PC+3
	JMP _0x14C
	RJMP _0x14D
_0x14C:
	RJMP _0x14B
_0x14D:
; 0000 035B 					{
; 0000 035C 						Mode1Step = 0;
	CALL SUBOPT_0x68
; 0000 035D 						bRun = 1;
; 0000 035E 						bRunAlarm = 0;
; 0000 035F 						bMenuDisplay = 1;
; 0000 0360 						bVarDisplay = 1;
; 0000 0361 					}else {
	RJMP _0x14E
_0x14B:
; 0000 0362 						SetBuzzer(1, 1);
	CALL SUBOPT_0x1F
; 0000 0363 						bVarDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0364 					}
_0x14E:
; 0000 0365 				}
; 0000 0366             }
_0x148:
_0x147:
; 0000 0367         }
_0x143:
_0x142:
; 0000 0368     }else {	// 키 UP 상태
	RJMP _0x14F
_0xF6:
; 0000 0369     	if (PrevDownKey)
	LDS  R30,_PrevDownKey_S0000004
	CPI  R30,0
	BRNE PC+3
	JMP _0x150
; 0000 036A         {
; 0000 036B         	SetupExitTime = SETUP_EXIT_TIME;
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	STS  _SetupExitTime,R30
	STS  _SetupExitTime+1,R31
; 0000 036C     		if (KeyDownCount < 10)	// Short Key 1sec 이하
	LDS  R26,_KeyDownCount_S0000004
	CPI  R26,LOW(0xA)
	BRLO PC+3
	JMP _0x151
; 0000 036D         	{
; 0000 036E         		switch(PrevDownKey)
	LDS  R30,_PrevDownKey_S0000004
; 0000 036F                 {
; 0000 0370 				case KEY_MENU:	// Mode 설정
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x155
; 0000 0371 					/*
; 0000 0372                 	if (Mode1Step)
; 0000 0373                     {
; 0000 0374 						//  Type 설정 모드
; 0000 0375 						if (Mode1Step >= MODE1_OCTA && Mode1Step <= MODE1_ETC)
; 0000 0376 						{
; 0000 0377 							if (++Mode1Step >= 5) Mode1Step = 1;	// 복귀
; 0000 0378 //							sMode1Step = Mode1Step;
; 0000 0379 //							SetEeprom2(6, Mode1Step);
; 0000 037A 
; 0000 037B 						} else {
; 0000 037C 							//  압력/시간 설정모드
; 0000 037D  							if (Mode1Step >= MODE2_PRESSURE_SET && Mode1Step <= MODE2_PRESSURE_DELAY_SET)
; 0000 037E 							{
; 0000 037F 								if (++Mode1Step >= 7) Mode1Step = 5;
; 0000 0380 
; 0000 0381 								if (Mode1Step == MODE2_PRESSURE_SET) SetData = Pressure;
; 0000 0382 								else if (Mode1Step == MODE2_PRESSURE_DELAY_SET) SetData = PressureTime;
; 0000 0383 							}
; 0000 0384 						}
; 0000 0385 
; 0000 0386 	                    bMenuDisplay = 1;
; 0000 0387                     }
; 0000 0388 					*/
; 0000 0389                     break;
	RJMP _0x154
; 0000 038A 				case KEY_MODE:	// 자동/수동
_0x155:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x156
; 0000 038B                 	break;
	RJMP _0x154
; 0000 038C 
; 0000 038D 				case KEY_ENTER:
_0x156:
	CPI  R30,LOW(0x8)
	BREQ PC+3
	JMP _0x157
; 0000 038E 					if (HiddenStep)
	LDS  R30,_HiddenStep
	CPI  R30,0
	BRNE PC+3
	JMP _0x158
; 0000 038F 					{
; 0000 0390 						switch(HiddenStep)
; 0000 0391 						{
; 0000 0392 							case HIDDEN1_STEP:				// 압착 Step Set
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x15C
; 0000 0393 								PressureStep = Hidden1SetData;
	CALL SUBOPT_0x52
	CALL SUBOPT_0x69
; 0000 0394 								SetEeprom2(16, PressureStep);
	CALL SUBOPT_0x6A
; 0000 0395 
; 0000 0396 								HiddenStep = HIDDEN1_STEP_DELAY;
	LDI  R30,LOW(2)
	STS  _HiddenStep,R30
; 0000 0397 								Hidden1SetData = sPressureStepDelay;
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x6C
; 0000 0398 								bMenuDisplay = 1;
; 0000 0399 								SetBuzzer(0, 0);
	CALL _SetBuzzer
; 0000 039A 								break;
	RJMP _0x15B
; 0000 039B 							case HIDDEN1_STEP_DELAY:		// 압착 Step Delay Set
_0x15C:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x15B
; 0000 039C 								sPressureStepDelay = Hidden1SetData;
	CALL SUBOPT_0x52
	CALL SUBOPT_0x6D
; 0000 039D 								SetEeprom2(18, sPressureStepDelay);
	CALL SUBOPT_0x6E
; 0000 039E 
; 0000 039F 								HiddenStep = HIDDEN1_STEP;
	LDI  R30,LOW(1)
	CALL SUBOPT_0x6F
; 0000 03A0 								Hidden1SetData = PressureStep;
	CALL SUBOPT_0x6C
; 0000 03A1 								bMenuDisplay = 1;
; 0000 03A2 								SetBuzzer(0, 0);
	CALL _SetBuzzer
; 0000 03A3 								break;
; 0000 03A4 						}
_0x15B:
; 0000 03A5 					} else if (Mode1Step >= MODE1_OCTA && Mode1Step <= MODE1_ETC){ 	// Zone Mode일때만
	RJMP _0x15E
_0x158:
	LDS  R26,_Mode1Step
	CPI  R26,LOW(0x1)
	BRSH PC+3
	JMP _0x160
	CPI  R26,LOW(0x5)
	BRLO PC+3
	JMP _0x160
	RJMP _0x161
_0x160:
	RJMP _0x15F
_0x161:
; 0000 03A6 						// Mode Switching
; 0000 03A7 						sMode1Step = Mode1Step;
	LDS  R30,_Mode1Step
	STS  _sMode1Step,R30
; 0000 03A8 						SetEeprom2(6, Mode1Step);
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x70
; 0000 03A9 						switch (Mode1Step)
	LDS  R30,_Mode1Step
; 0000 03AA 						{
; 0000 03AB 						case MODE1_OCTA:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x165
; 0000 03AC 							Pressure = OCTA_PRESSURE;
	CALL SUBOPT_0x71
; 0000 03AD 							PressureTime = OCTA_PRESSURE_TIME;
; 0000 03AE 							break;
	RJMP _0x164
; 0000 03AF 						case MODE1_TAPE:
_0x165:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x166
; 0000 03B0 							Pressure = TYPE_PRESSURE;
	CALL SUBOPT_0x72
; 0000 03B1 							PressureTime = TYPE_PRESSURE_TIME;
	CALL SUBOPT_0x73
; 0000 03B2 							break;
	RJMP _0x164
; 0000 03B3 						case MODE1_BATTERY:
_0x166:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x167
; 0000 03B4 							Pressure = BATTERY_PRESSURE;
	CALL SUBOPT_0x71
; 0000 03B5 							PressureTime = BATTERY_PRESSURE_TIME;
; 0000 03B6 							break;
	RJMP _0x164
; 0000 03B7 						case MODE1_ETC:
_0x167:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x164
; 0000 03B8 							Pressure = GetEeprom2(2);
	CALL SUBOPT_0x74
	CALL SUBOPT_0x22
	CALL SUBOPT_0x75
; 0000 03B9 							PressureTime = GetEeprom2(0);
	CALL SUBOPT_0xA
	CALL SUBOPT_0x22
	CALL SUBOPT_0x76
; 0000 03BA 							break;
; 0000 03BB 						}
_0x164:
; 0000 03BC 
; 0000 03BD 						Mode1Step = MODE2_PRESSURE_SET;
	CALL SUBOPT_0x77
; 0000 03BE 						SetData = Pressure;
; 0000 03BF 						SetEeprom2(2, Pressure);
	CALL SUBOPT_0x74
	CALL SUBOPT_0x78
; 0000 03C0 						SetItv(Pressure);
; 0000 03C1 						bMenuDisplay = 1;
	CALL SUBOPT_0x79
; 0000 03C2 						SetBuzzer(0, 0);
	CALL _SetBuzzer
; 0000 03C3 					} else{
	RJMP _0x169
_0x15F:
; 0000 03C4 						switch(Mode1Step)
	LDS  R30,_Mode1Step
; 0000 03C5 						{
; 0000 03C6 						case MODE2_PRESSURE_SET:	// 압력
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x16D
; 0000 03C7 							Pressure = SetData;
	CALL SUBOPT_0x7A
	CALL SUBOPT_0x75
; 0000 03C8 							SetEeprom2(2, Pressure);
	CALL SUBOPT_0x74
	CALL SUBOPT_0x78
; 0000 03C9 							SetItv(Pressure);
; 0000 03CA 
; 0000 03CB 							Mode1Step = MODE2_PRESSURE_DELAY_SET;
	LDI  R30,LOW(6)
	STS  _Mode1Step,R30
; 0000 03CC 							SetData = PressureTime;
	CALL SUBOPT_0x7B
	CALL SUBOPT_0x59
; 0000 03CD 							bMenuDisplay = 1;
	CALL SUBOPT_0x79
; 0000 03CE 							SetBuzzer(0, 0);
	CALL _SetBuzzer
; 0000 03CF 							break;
	RJMP _0x16C
; 0000 03D0 						case MODE2_PRESSURE_DELAY_SET:	// 압력시간
_0x16D:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0x16C
; 0000 03D1 							PressureTime = SetData;
	CALL SUBOPT_0x7A
	CALL SUBOPT_0x76
; 0000 03D2 							SetEeprom2(0, PressureTime);
	CALL SUBOPT_0xA
	CALL SUBOPT_0x7C
; 0000 03D3 
; 0000 03D4 							Mode1Step = MODE2_PRESSURE_SET;
	CALL SUBOPT_0x77
; 0000 03D5 							SetData = Pressure;
; 0000 03D6 							bMenuDisplay = 1;
	CALL SUBOPT_0x79
; 0000 03D7 							SetBuzzer(0, 0);
	CALL _SetBuzzer
; 0000 03D8 							break;
; 0000 03D9 						}
_0x16C:
; 0000 03DA 					}
_0x169:
_0x15E:
; 0000 03DB 
; 0000 03DC 
; 0000 03DD                     if (bCalib && CalibStep >= 10){
	LDS  R30,_bCalib
	CPI  R30,0
	BRNE PC+3
	JMP _0x170
	LDS  R26,_CalibStep
	CPI  R26,LOW(0xA)
	BRSH PC+3
	JMP _0x170
	RJMP _0x171
_0x170:
	RJMP _0x16F
_0x171:
; 0000 03DE                         switch(CalibStep)
	LDS  R30,_CalibStep
; 0000 03DF                         {
; 0000 03E0                             case 12:
	CPI  R30,LOW(0xC)
	BREQ PC+3
	JMP _0x175
; 0000 03E1                             	CalItvMin = Ltc1865Read(0);
	CALL SUBOPT_0xA
	CALL SUBOPT_0x42
	CALL SUBOPT_0x23
; 0000 03E2                             	SetEeprom2(10, CalItvMin);
	CALL SUBOPT_0x21
	CALL SUBOPT_0x7D
; 0000 03E3                                 break;
	RJMP _0x174
; 0000 03E4 
; 0000 03E5                             case 13:
_0x175:
	CPI  R30,LOW(0xD)
	BREQ PC+3
	JMP _0x174
; 0000 03E6                             	CalItvMax = (unsigned long)((unsigned long)Ltc1865Read(0) * 1);
	CALL SUBOPT_0xA
	CALL SUBOPT_0x42
	CALL SUBOPT_0x7E
; 0000 03E7                             	SetEeprom4(12, CalItvMax);
	CALL SUBOPT_0x24
	CALL SUBOPT_0x7F
; 0000 03E8                                 break;
; 0000 03E9                         }
_0x174:
; 0000 03EA                        SetBuzzer(0, 0);
	CALL SUBOPT_0x1C
	CALL _SetBuzzer
; 0000 03EB                     }
; 0000 03EC             		break;
_0x16F:
	RJMP _0x154
; 0000 03ED 
; 0000 03EE 				case KEY_UP:
_0x157:
	CPI  R30,LOW(0x10)
	BREQ PC+3
	JMP _0x177
; 0000 03EF 					if (!HiddenStep)
	LDS  R30,_HiddenStep
	CPI  R30,0
	BREQ PC+3
	JMP _0x178
; 0000 03F0 					{
; 0000 03F1 						switch(Mode1Step)
	LDS  R30,_Mode1Step
; 0000 03F2 						{
; 0000 03F3 							case MODE1_NOMAL:
	CPI  R30,0
	BREQ PC+3
	JMP _0x17C
; 0000 03F4 								if (!bAutoMode)	// Manual Mode 동작
	LDS  R30,_bAutoMode
	CPI  R30,0
	BREQ PC+3
	JMP _0x17D
; 0000 03F5 								{
; 0000 03F6 									SetItv(PRESSURE_NOMAL);     // 15.01.27 기구적 실린더 동작 문제로 2.0k로 고정
	CALL SUBOPT_0xB
; 0000 03F7 									if (Sensor & CYL_X_IN_SENSOR || Sensor & CYL_X_OUT_SENSOR)
	LDS  R30,_Sensor
	ANDI R30,LOW(0x2)
	BREQ PC+3
	JMP _0x17F
	LDS  R30,_Sensor
	ANDI R30,LOW(0x1)
	BREQ PC+3
	JMP _0x17F
	RJMP _0x17E
_0x17F:
; 0000 03F8 									{
; 0000 03F9 										bCylYDown = !bCylYDown;
	LDS  R30,_bCylYDown
	CALL __LNEGB1
	STS  _bCylYDown,R30
; 0000 03FA 										if (bCylYDown) CYL_Y_DOWN;
	CPI  R30,0
	BRNE PC+3
	JMP _0x181
	CALL SUBOPT_0x17
; 0000 03FB 										else CYL_Y_UP;
	RJMP _0x182
_0x181:
	CALL SUBOPT_0x1A
; 0000 03FC 									}
_0x182:
; 0000 03FD 									bVarDisplay = 1;
_0x17E:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 03FE 								}
; 0000 03FF 								break;
_0x17D:
	RJMP _0x17B
; 0000 0400 							case MODE1_OCTA:
_0x17C:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x183
; 0000 0401 							case MODE1_TAPE:
	RJMP _0x184
_0x183:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x185
_0x184:
; 0000 0402 							case MODE1_BATTERY:
	RJMP _0x186
_0x185:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x187
_0x186:
; 0000 0403 							case MODE1_ETC:
	RJMP _0x188
_0x187:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x189
_0x188:
; 0000 0404 								if (++Mode1Step >= 5) Mode1Step = 4;	// 복귀
	LDS  R26,_Mode1Step
	SUBI R26,-LOW(1)
	STS  _Mode1Step,R26
	CPI  R26,LOW(0x5)
	BRSH PC+3
	JMP _0x18A
	LDI  R30,LOW(4)
	STS  _Mode1Step,R30
; 0000 0405 								bMenuDisplay = 1;
_0x18A:
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
; 0000 0406 								break;
	RJMP _0x17B
; 0000 0407 							case MODE2_PRESSURE_SET:
_0x189:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x18B
; 0000 0408 								if (++SetData > PRESSURE_MAX_) SetData--;
	CALL SUBOPT_0x5A
	CALL SUBOPT_0x5B
	BRSH PC+3
	JMP _0x18C
	CALL SUBOPT_0x5A
	CALL SUBOPT_0x5C
; 0000 0409 								bVarDisplay = 1;
_0x18C:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 040A 								break;
	RJMP _0x17B
; 0000 040B 							case MODE2_PRESSURE_DELAY_SET:	// Pressure Time
_0x18B:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0x17B
; 0000 040C 								if (++SetData > PRESSURE_TIME_MAX) SetData--;
	CALL SUBOPT_0x5A
	CALL SUBOPT_0x5D
	BRSH PC+3
	JMP _0x18E
	CALL SUBOPT_0x5A
	CALL SUBOPT_0x5C
; 0000 040D 								bVarDisplay = 1;
_0x18E:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 040E 								break;
; 0000 040F 						}
_0x17B:
; 0000 0410 					} else{
	RJMP _0x18F
_0x178:
; 0000 0411 						switch(HiddenStep)
	LDS  R30,_HiddenStep
; 0000 0412 						{
; 0000 0413 						case HIDDEN1_STEP:				// 압착 Step Set
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x193
; 0000 0414 							if (++Hidden1SetData > PRESSURE_STEP_MAX) Hidden1SetData--;
	CALL SUBOPT_0x60
	CALL SUBOPT_0x61
	BRSH PC+3
	JMP _0x194
	CALL SUBOPT_0x60
	CALL SUBOPT_0x5C
; 0000 0415 							bVarDisplay = 1;
_0x194:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0416 							break;
	RJMP _0x192
; 0000 0417 						case HIDDEN1_STEP_DELAY:		// 압착 Step Delay Set
_0x193:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x192
; 0000 0418 							if (++Hidden1SetData > PRESSURE_STEP_DELAY_MAX) Hidden1SetData--;
	CALL SUBOPT_0x60
	CALL SUBOPT_0x61
	BRSH PC+3
	JMP _0x196
	CALL SUBOPT_0x60
	CALL SUBOPT_0x5C
; 0000 0419 							bVarDisplay = 1;
_0x196:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 041A 							break;
; 0000 041B 						}
_0x192:
; 0000 041C 					}
_0x18F:
; 0000 041D                     SetBuzzer(0, 0);
	CALL SUBOPT_0x1C
	CALL _SetBuzzer
; 0000 041E                     break;
	RJMP _0x154
; 0000 041F 
; 0000 0420 				case KEY_DOWN:
_0x177:
	CPI  R30,LOW(0x20)
	BREQ PC+3
	JMP _0x197
; 0000 0421 					if (!HiddenStep)
	LDS  R30,_HiddenStep
	CPI  R30,0
	BREQ PC+3
	JMP _0x198
; 0000 0422 					{
; 0000 0423 						switch(Mode1Step)
	LDS  R30,_Mode1Step
; 0000 0424 						{
; 0000 0425 							case MODE1_NOMAL:
	CPI  R30,0
	BREQ PC+3
	JMP _0x19C
; 0000 0426 								if (!bAutoMode && !bCylYDown)
	LDS  R30,_bAutoMode
	CPI  R30,0
	BREQ PC+3
	JMP _0x19E
	LDS  R30,_bCylYDown
	CPI  R30,0
	BREQ PC+3
	JMP _0x19E
	RJMP _0x19F
_0x19E:
	RJMP _0x19D
_0x19F:
; 0000 0427 								{
; 0000 0428 									SetItv(PRESSURE_NOMAL);     // 15.01.27 기구적 실린더 동작 문제로 2.0k로 고정
	CALL SUBOPT_0xB
; 0000 0429 									if (Sensor & CYL_Y_UP_SENSOR)
	LDS  R30,_Sensor
	ANDI R30,LOW(0x4)
	BRNE PC+3
	JMP _0x1A0
; 0000 042A 									{
; 0000 042B 										bCylXIn = !bCylXIn;
	LDS  R30,_bCylXIn
	CALL __LNEGB1
	STS  _bCylXIn,R30
; 0000 042C 										if (bCylXIn) CYL_X_IN;
	CPI  R30,0
	BRNE PC+3
	JMP _0x1A1
	CALL SUBOPT_0x14
; 0000 042D 										else CYL_X_OUT;
	RJMP _0x1A2
_0x1A1:
	CALL SUBOPT_0x27
; 0000 042E 									}
_0x1A2:
; 0000 042F 									bVarDisplay = 1;
_0x1A0:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0430 								}
; 0000 0431 								break;
_0x19D:
	RJMP _0x19B
; 0000 0432 							case MODE1_OCTA:
_0x19C:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x1A3
; 0000 0433 							case MODE1_TAPE:
	RJMP _0x1A4
_0x1A3:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x1A5
_0x1A4:
; 0000 0434 							case MODE1_BATTERY:
	RJMP _0x1A6
_0x1A5:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x1A7
_0x1A6:
; 0000 0435 							case MODE1_ETC:
	RJMP _0x1A8
_0x1A7:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x1A9
_0x1A8:
; 0000 0436 								if (--Mode1Step <= 0) Mode1Step = 1;	// 복귀
	LDS  R26,_Mode1Step
	SUBI R26,LOW(1)
	STS  _Mode1Step,R26
	CPI  R26,0
	BREQ PC+3
	JMP _0x1AA
	LDI  R30,LOW(1)
	STS  _Mode1Step,R30
; 0000 0437 								bMenuDisplay = 1;
_0x1AA:
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
; 0000 0438 								break;
	RJMP _0x19B
; 0000 0439 							case MODE2_PRESSURE_SET:
_0x1A9:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x1AB
; 0000 043A 								if (SetData > PRESSURE_MIN) SetData--;
	CALL SUBOPT_0x64
	BRLO PC+3
	JMP _0x1AC
	CALL SUBOPT_0x5A
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 043B 								bVarDisplay = 1;
_0x1AC:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 043C 								break;
	RJMP _0x19B
; 0000 043D 							case MODE2_PRESSURE_DELAY_SET:	// Pressure Time
_0x1AB:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0x19B
; 0000 043E 								if (SetData > PRESSURE_TIME_MIN) SetData--;
	CALL SUBOPT_0x64
	BRLO PC+3
	JMP _0x1AE
	CALL SUBOPT_0x5A
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 043F 								bVarDisplay = 1;
_0x1AE:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0440 								break;
; 0000 0441 						}
_0x19B:
; 0000 0442 					} else{
	RJMP _0x1AF
_0x198:
; 0000 0443 						switch(HiddenStep)
	LDS  R30,_HiddenStep
; 0000 0444 						{
; 0000 0445 						case HIDDEN1_STEP:				// 압착 Step Set
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x1B3
; 0000 0446 							if (Hidden1SetData > PRESSURE_STEP_MIN) Hidden1SetData--;
	CALL SUBOPT_0x65
	SBIW R26,3
	BRSH PC+3
	JMP _0x1B4
	CALL SUBOPT_0x60
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 0447 							bVarDisplay = 1;
_0x1B4:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 0448 							break;
	RJMP _0x1B2
; 0000 0449 						case HIDDEN1_STEP_DELAY:		// 압착 Step Delay Set
_0x1B3:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x1B2
; 0000 044A 							if (Hidden1SetData > PRESSURE_STEP_DELAY_MIN) Hidden1SetData--;
	CALL SUBOPT_0x65
	SBIW R26,2
	BRSH PC+3
	JMP _0x1B6
	CALL SUBOPT_0x60
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 044B 							bVarDisplay = 1;
_0x1B6:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
; 0000 044C 							break;
; 0000 044D 						}
_0x1B2:
; 0000 044E 					}
_0x1AF:
; 0000 044F                     SetBuzzer(0, 0);
	CALL SUBOPT_0x1C
	CALL _SetBuzzer
; 0000 0450                     break;
	RJMP _0x154
; 0000 0451 				case KEY_FN:
_0x197:
	CPI  R30,LOW(0x40)
	BREQ PC+3
	JMP _0x154
; 0000 0452                     if (bCalib && CalibStep >= 10)
	LDS  R30,_bCalib
	CPI  R30,0
	BRNE PC+3
	JMP _0x1B9
	LDS  R26,_CalibStep
	CPI  R26,LOW(0xA)
	BRSH PC+3
	JMP _0x1B9
	RJMP _0x1BA
_0x1B9:
	RJMP _0x1B8
_0x1BA:
; 0000 0453                     {
; 0000 0454                         if (++CalibStep >= 12) CalibStep = 10;
	LDS  R26,_CalibStep
	SUBI R26,-LOW(1)
	STS  _CalibStep,R26
	CPI  R26,LOW(0xC)
	BRSH PC+3
	JMP _0x1BB
	LDI  R30,LOW(10)
	STS  _CalibStep,R30
; 0000 0455                     }
_0x1BB:
; 0000 0456                     SetBuzzer(0, 0);
_0x1B8:
	CALL SUBOPT_0x1C
	CALL _SetBuzzer
; 0000 0457                     bMenuDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
; 0000 0458                 	break;
; 0000 0459 
; 0000 045A                 }
_0x154:
; 0000 045B         	}else {	// Long Key
	RJMP _0x1BC
_0x151:
; 0000 045C                	switch(PrevDownKey)
	LDS  R30,_PrevDownKey_S0000004
; 0000 045D                 {
; 0000 045E 				case KEY_MENU:	// 압력/시간
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x1C0
; 0000 045F 					if (!HiddenStep)	// Hidden Mode가 아닐때만
	LDS  R30,_HiddenStep
	CPI  R30,0
	BREQ PC+3
	JMP _0x1C1
; 0000 0460 					{
; 0000 0461 						if (Mode1Step)
	LDS  R30,_Mode1Step
	CPI  R30,0
	BRNE PC+3
	JMP _0x1C2
; 0000 0462 						{
; 0000 0463 							Mode1Step = 0;
	LDI  R30,LOW(0)
	STS  _Mode1Step,R30
; 0000 0464 						}else {
	RJMP _0x1C3
_0x1C2:
; 0000 0465 							Mode1Step = 1;
	LDI  R30,LOW(1)
	STS  _Mode1Step,R30
; 0000 0466 						}
_0x1C3:
; 0000 0467 						SetData = Pressure;
	CALL SUBOPT_0x80
	CALL SUBOPT_0x59
; 0000 0468 						bMenuDisplay = 1;
	CALL SUBOPT_0x81
; 0000 0469 						SetBuzzer(0, 1);
	CALL _SetBuzzer
; 0000 046A 					}
; 0000 046B                     break;
_0x1C1:
	RJMP _0x1BF
; 0000 046C 
; 0000 046D 				case KEY_MODE:	// 자동/수동
_0x1C0:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x1C4
; 0000 046E                 	if (!bRun && Mode1Step == 0 && !HiddenStep)
	LDS  R30,_bRun
	CPI  R30,0
	BREQ PC+3
	JMP _0x1C6
	LDS  R26,_Mode1Step
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x1C6
	LDS  R30,_HiddenStep
	CPI  R30,0
	BREQ PC+3
	JMP _0x1C6
	RJMP _0x1C7
_0x1C6:
	RJMP _0x1C5
_0x1C7:
; 0000 046F                     {
; 0000 0470 						if (++bAutoMode >= 3) bAutoMode = 0;
	LDS  R26,_bAutoMode
	SUBI R26,-LOW(1)
	STS  _bAutoMode,R26
	CPI  R26,LOW(0x3)
	BRSH PC+3
	JMP _0x1C8
	LDI  R30,LOW(0)
	STS  _bAutoMode,R30
; 0000 0471 						if (bAutoMode == 1) bAutoMode = 2;		// 15.04.02 SIS 이원욱D 요청으로 AutoMode 삭제
_0x1C8:
	LDS  R26,_bAutoMode
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x1C9
	LDI  R30,LOW(2)
	STS  _bAutoMode,R30
; 0000 0472                         bMenuDisplay = 1;
_0x1C9:
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
; 0000 0473 						bAgingMode = 0;
	LDI  R30,LOW(0)
	STS  _bAgingMode,R30
; 0000 0474 						SetEeprom2(4, bAutoMode);
	CALL SUBOPT_0x82
; 0000 0475 						if (bAutoMode) mRunStepTime = 0;
	LDS  R30,_bAutoMode
	CPI  R30,0
	BRNE PC+3
	JMP _0x1CA
	CALL SUBOPT_0xC
	STS  _mRunStepTime,R30
	STS  _mRunStepTime+1,R31
	STS  _mRunStepTime+2,R22
	STS  _mRunStepTime+3,R23
; 0000 0476                     }
_0x1CA:
; 0000 0477                     SetBuzzer(0, 1);
_0x1C5:
	CALL SUBOPT_0x20
	CALL _SetBuzzer
; 0000 0478 					break;
	RJMP _0x1BF
; 0000 0479 				case KEY_ENTER:
_0x1C4:
	CPI  R30,LOW(0x8)
	BREQ PC+3
	JMP _0x1CB
; 0000 047A                 	break;
	RJMP _0x1BF
; 0000 047B 				case KEY_UP:
_0x1CB:
	CPI  R30,LOW(0x10)
	BREQ PC+3
	JMP _0x1CC
; 0000 047C                     break;
	RJMP _0x1BF
; 0000 047D                 case KEY_DOWN:
_0x1CC:
	CPI  R30,LOW(0x20)
	BREQ PC+3
	JMP _0x1CD
; 0000 047E                 	break;
	RJMP _0x1BF
; 0000 047F 				case KEY_FN:
_0x1CD:
	CPI  R30,LOW(0x40)
	BREQ PC+3
	JMP _0x1CE
; 0000 0480                 	if (TestMode)
	LDS  R30,_TestMode
	CPI  R30,0
	BRNE PC+3
	JMP _0x1CF
; 0000 0481                     {
; 0000 0482                 		bCalib = 1;
	LDI  R30,LOW(1)
	STS  _bCalib,R30
; 0000 0483                         CalibStep = 0;
	LDI  R30,LOW(0)
	STS  _CalibStep,R30
; 0000 0484                         CalibStepDelay = 100;
	__GETD1N 0x64
	CALL SUBOPT_0x83
; 0000 0485 	                    SetBuzzer(1, 0);
	CALL SUBOPT_0x84
; 0000 0486                     }
; 0000 0487                 	break;
_0x1CF:
	RJMP _0x1BF
; 0000 0488 				case KEY_FN | KEY_ENTER:
_0x1CE:
	CPI  R30,LOW(0x48)
	BREQ PC+3
	JMP _0x1D0
; 0000 0489 					if (!bRun && Mode1Step == 0)
	LDS  R30,_bRun
	CPI  R30,0
	BREQ PC+3
	JMP _0x1D2
	LDS  R26,_Mode1Step
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x1D2
	RJMP _0x1D3
_0x1D2:
	RJMP _0x1D1
_0x1D3:
; 0000 048A 					{
; 0000 048B 						bAgingMode = !bAgingMode;
	LDS  R30,_bAgingMode
	CALL __LNEGB1
	STS  _bAgingMode,R30
; 0000 048C 						bMenuDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
; 0000 048D 						// bAutoMode = 0;
; 0000 048E 					}
; 0000 048F 					SetBuzzer(0, 1);
_0x1D1:
	CALL SUBOPT_0x20
	CALL _SetBuzzer
; 0000 0490 					break;
	RJMP _0x1BF
; 0000 0491 
; 0000 0492                 case KEY_UP | KEY_DOWN:
_0x1D0:
	CPI  R30,LOW(0x30)
	BREQ PC+3
	JMP _0x1D4
; 0000 0493                 	TestMode = !TestMode;
	LDS  R30,_TestMode
	CALL __LNEGB1
	STS  _TestMode,R30
; 0000 0494                     bCalib = 0;
	LDI  R30,LOW(0)
	STS  _bCalib,R30
; 0000 0495                     bMenuDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
; 0000 0496                     SetBuzzer(1, 0);
	CALL SUBOPT_0x84
; 0000 0497                     break;
	RJMP _0x1BF
; 0000 0498 
; 0000 0499                 case KEY_FN | KEY_MENU: // 교정모드 키
_0x1D4:
	CPI  R30,LOW(0x42)
	BREQ PC+3
	JMP _0x1D5
; 0000 049A                     bCalib = !bCalib;
	LDS  R30,_bCalib
	CALL __LNEGB1
	STS  _bCalib,R30
; 0000 049B 					bMenuDisplay = 1;
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
; 0000 049C 
; 0000 049D                     if (bCalib)
	LDS  R30,_bCalib
	CPI  R30,0
	BRNE PC+3
	JMP _0x1D6
; 0000 049E                     {
; 0000 049F                         CalibStep = 10;
	LDI  R30,LOW(10)
	STS  _CalibStep,R30
; 0000 04A0                     }else {
	RJMP _0x1D7
_0x1D6:
; 0000 04A1                         SetItv(Pressure);
	CALL SUBOPT_0x16
; 0000 04A2                     }
_0x1D7:
; 0000 04A3                     SetBuzzer(1, 0);
	CALL SUBOPT_0x84
; 0000 04A4                     break;
	RJMP _0x1BF
; 0000 04A5 
; 0000 04A6 				case KEY_FN | KEY_MODE:	// Hidden Mode 1 진입
_0x1D5:
	CPI  R30,LOW(0x44)
	BREQ PC+3
	JMP _0x1BF
; 0000 04A7                 	if (!bRun && Mode1Step == 0)	// Mode 1 진입했을때만 구동
	LDS  R30,_bRun
	CPI  R30,0
	BREQ PC+3
	JMP _0x1DA
	LDS  R26,_Mode1Step
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x1DA
	RJMP _0x1DB
_0x1DA:
	RJMP _0x1D9
_0x1DB:
; 0000 04A8 					{
; 0000 04A9 						HiddenStep = !HiddenStep;
	LDS  R30,_HiddenStep
	CALL __LNEGB1
	CALL SUBOPT_0x6F
; 0000 04AA 						Hidden1SetData = PressureStep;
	CALL SUBOPT_0x67
; 0000 04AB 						bMenuDisplay = 1;
	CALL SUBOPT_0x81
; 0000 04AC 						SetBuzzer(0, 1);
	CALL _SetBuzzer
; 0000 04AD 					}
; 0000 04AE                     break;
_0x1D9:
; 0000 04AF                 }
_0x1BF:
; 0000 04B0             }
_0x1BC:
; 0000 04B1         }else {
	RJMP _0x1DC
_0x150:
; 0000 04B2 			if (SetupExitTime && Mode1Step)
	LDS  R30,_SetupExitTime
	LDS  R31,_SetupExitTime+1
	SBIW R30,0
	BRNE PC+3
	JMP _0x1DE
	LDS  R30,_Mode1Step
	CPI  R30,0
	BRNE PC+3
	JMP _0x1DE
	RJMP _0x1DF
_0x1DE:
	RJMP _0x1DD
_0x1DF:
; 0000 04B3             {
; 0000 04B4             	SetupExitTime--;
	LDI  R26,LOW(_SetupExitTime)
	LDI  R27,HIGH(_SetupExitTime)
	CALL SUBOPT_0x85
; 0000 04B5                 if (SetupExitTime == 0)
	LDS  R30,_SetupExitTime
	LDS  R31,_SetupExitTime+1
	SBIW R30,0
	BREQ PC+3
	JMP _0x1E0
; 0000 04B6                 {
; 0000 04B7                 	Mode1Step = 0;
	LDI  R30,LOW(0)
	STS  _Mode1Step,R30
; 0000 04B8                     bMenuDisplay = 1;
	CALL SUBOPT_0x81
; 0000 04B9                     SetBuzzer(0, 1);
	CALL _SetBuzzer
; 0000 04BA                 }
; 0000 04BB             }
_0x1E0:
; 0000 04BC         }
_0x1DD:
_0x1DC:
; 0000 04BD 		bLongKey = 0;
	LDI  R30,LOW(0)
	STS  _bLongKey,R30
; 0000 04BE     	KeyDownCount = 0;
	STS  _KeyDownCount_S0000004,R30
; 0000 04BF 		PrevDownKey = 0;
	STS  _PrevDownKey_S0000004,R30
; 0000 04C0     }
_0x14F:
; 0000 04C1 }
	RET
;
;/*
;void StepPressureSubroutine(void)
;{
;	int r = 0;
;	if (RunStep == RUN_CYL_DOWN)
;	{
;		if (Sensor & CYL_Y_DOWN_SENSOR)
;		{
;			if (PressureStepDelay)
;			{
;				PressureStepDelay--;
;			} else{
;				r = Pressure - DownPressure;
;				if(r < 0) r = 0;
;
;				if (r >= 20)
;				{
;					SetItv(DownPressure+=20);
;				}
;
;				if (r < 20)
;				{
;					DownPressure = Pressure;
;					SetItv(Pressure);
;					bDownPressureEnd = 1;
;					DownPressure = 0;
;				}
;				PressureStepDelay = 1;
;			}
;		}
;	}
;}
;*/
;
;void StepPressureSubroutine(void)
; 0000 04E6 {
_StepPressureSubroutine:
; 0000 04E7 	unsigned int DownPressureStep = Pressure / PressureStep;
; 0000 04E8 
; 0000 04E9 	if (RunStep == RUN_CYL_DOWN && !bEmoState && !bReturnSensor && !bDownPressureEnd)
	ST   -Y,R17
	ST   -Y,R16
;	DownPressureStep -> R16,R17
	LDS  R30,_PressureStep
	LDS  R31,_PressureStep+1
	CALL SUBOPT_0x86
	CLR  R22
	CLR  R23
	CALL __DIVD21U
	MOVW R16,R30
	LDS  R26,_RunStep
	CPI  R26,LOW(0x5)
	BREQ PC+3
	JMP _0x1E2
	LDS  R30,_bEmoState
	CPI  R30,0
	BREQ PC+3
	JMP _0x1E2
	LDS  R30,_bReturnSensor
	CPI  R30,0
	BREQ PC+3
	JMP _0x1E2
	LDS  R30,_bDownPressureEnd
	CPI  R30,0
	BREQ PC+3
	JMP _0x1E2
	RJMP _0x1E3
_0x1E2:
	RJMP _0x1E1
_0x1E3:
; 0000 04EA 	{
; 0000 04EB 		if (Sensor & CYL_Y_DOWN_SENSOR)
	LDS  R30,_Sensor
	ANDI R30,LOW(0x8)
	BRNE PC+3
	JMP _0x1E4
; 0000 04EC 		{
; 0000 04ED 			if (PressureStepDelay)
	LDS  R30,_PressureStepDelay
	LDS  R31,_PressureStepDelay+1
	SBIW R30,0
	BRNE PC+3
	JMP _0x1E5
; 0000 04EE 			{
; 0000 04EF 				PressureStepDelay--;
	LDI  R26,LOW(_PressureStepDelay)
	LDI  R27,HIGH(_PressureStepDelay)
	CALL SUBOPT_0x85
; 0000 04F0 			} else{
	RJMP _0x1E6
_0x1E5:
; 0000 04F1 				if (DownPressure <= Pressure)
	CALL SUBOPT_0x87
	CALL __CPD12
	BRSH PC+3
	JMP _0x1E7
; 0000 04F2 				{
; 0000 04F3 					DownPressure += DownPressureStep;
	MOVW R30,R16
	LDS  R26,_DownPressure
	LDS  R27,_DownPressure+1
	ADD  R30,R26
	ADC  R31,R27
	STS  _DownPressure,R30
	STS  _DownPressure+1,R31
; 0000 04F4 					if (DownPressure >= Pressure) DownPressure = Pressure;
	CALL SUBOPT_0x87
	CALL __CPD21
	BRSH PC+3
	JMP _0x1E8
	CALL SUBOPT_0x80
	STS  _DownPressure,R30
	STS  _DownPressure+1,R31
; 0000 04F5 
; 0000 04F6 					SetItv(DownPressure);
_0x1E8:
	LDS  R30,_DownPressure
	LDS  R31,_DownPressure+1
	CALL SUBOPT_0x15
; 0000 04F7 					//Lcdprintf(9, 3, "%d", DownPressure);
; 0000 04F8 
; 0000 04F9 					if (DownPressure >= Pressure)
	CALL SUBOPT_0x87
	CALL __CPD21
	BRSH PC+3
	JMP _0x1E9
; 0000 04FA 					{
; 0000 04FB 						bDownPressureEnd = 1;
	LDI  R30,LOW(1)
	STS  _bDownPressureEnd,R30
; 0000 04FC 						DownPressure = 0;
	CALL SUBOPT_0x1E
; 0000 04FD 					}
; 0000 04FE 					PressureStepDelay = sPressureStepDelay;
_0x1E9:
	CALL SUBOPT_0x6B
	STS  _PressureStepDelay,R30
	STS  _PressureStepDelay+1,R31
; 0000 04FF 				}
; 0000 0500 			}
_0x1E7:
_0x1E6:
; 0000 0501 		}
; 0000 0502 	}
_0x1E4:
; 0000 0503 }
_0x1E1:
	LD   R16,Y+
	LD   R17,Y+
	RET
;
;void PressureRewardSubroutine(void)
; 0000 0506 {
_PressureRewardSubroutine:
; 0000 0507 	unsigned long GetPressure;
; 0000 0508 
; 0000 0509  	if (bPressureReward && RunStepTime >= 50)	// Step 압력 설정 후 딜레이 500 ms 뒤
	SBIW R28,4
;	GetPressure -> Y+0
	LDS  R30,_bPressureReward
	CPI  R30,0
	BRNE PC+3
	JMP _0x1EB
	CALL SUBOPT_0x88
	__CPD2N 0x32
	BRSH PC+3
	JMP _0x1EB
	RJMP _0x1EC
_0x1EB:
	RJMP _0x1EA
_0x1EC:
; 0000 050A 	{
; 0000 050B 		GetPressure = GetItv();
	CALL SUBOPT_0x89
; 0000 050C 		if ((Pressure - GetPressure) > 0) SetItv(Pressure + abs(Pressure - GetPressure));	// 양수
	CALL SUBOPT_0x8A
	CALL __SUBD21
	CALL __CPD02
	BRLO PC+3
	JMP _0x1ED
	CALL SUBOPT_0x8A
	CALL SUBOPT_0x8B
	CALL __ADDD12
	CALL SUBOPT_0x15
; 0000 050D 		else if ((Pressure - GetPressure) < 0) SetItv(Pressure - abs(Pressure - GetPressure));	// 음수
	RJMP _0x1EE
_0x1ED:
	CALL SUBOPT_0x8A
	CALL __SUBD21
	RJMP _0x1EF
	CALL SUBOPT_0x8A
	CALL SUBOPT_0x8B
	CALL __SWAPD12
	CALL __SUBD12
	CALL SUBOPT_0x15
; 0000 050E 		//Lcdprintf(9, 3, "%d", GetPressure);
; 0000 050F 		bPressureReward = 0;
_0x1EF:
_0x1EE:
	LDI  R30,LOW(0)
	STS  _bPressureReward,R30
; 0000 0510 	}
; 0000 0511 }
_0x1EA:
	ADIW R28,4
	RET
;
;void PressureCheckSubroutine(void)
; 0000 0514 {
_PressureCheckSubroutine:
; 0000 0515 	unsigned long GetPressure;
; 0000 0516 
; 0000 0517 	if (bAutoMode == 2  && (RunStep == RUN_PRESSURE_DELAY) && !bRunAlarm)
	SBIW R28,4
;	GetPressure -> Y+0
	LDS  R26,_bAutoMode
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x1F1
	LDS  R26,_RunStep
	CPI  R26,LOW(0x6)
	BREQ PC+3
	JMP _0x1F1
	LDS  R30,_bRunAlarm
	CPI  R30,0
	BREQ PC+3
	JMP _0x1F1
	RJMP _0x1F2
_0x1F1:
	RJMP _0x1F0
_0x1F2:
; 0000 0518 	{
; 0000 0519 		GetPressure = GetItv();
	CALL SUBOPT_0x89
; 0000 051A 		if (RunStepTime >= 100)	// 1000ms Delay
	CALL SUBOPT_0x88
	__CPD2N 0x64
	BRSH PC+3
	JMP _0x1F3
; 0000 051B 		{
; 0000 051C 			if (abs(Pressure - GetPressure) > PRESSURE_LIMIT) bPressureFail = 1;
	CALL SUBOPT_0x8A
	CALL __SWAPD12
	CALL __SUBD12
	CALL SUBOPT_0x8C
	SBIW R30,51
	BRSH PC+3
	JMP _0x1F4
	LDI  R30,LOW(1)
	STS  _bPressureFail,R30
; 0000 051D //				else bPressureFail = 0;
; 0000 051E 		}
_0x1F4:
; 0000 051F 	}
_0x1F3:
; 0000 0520 }
_0x1F0:
	ADIW R28,4
	RET
;
;
;
;
;
;

	.CSEG
_ftrunc:
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
_floor:
	CALL SUBOPT_0x8D
	CALL __PUTPARD1
	CALL _ftrunc
	CALL SUBOPT_0x8E
    brne __floor1
__floor0:
	CALL SUBOPT_0x8D
	ADIW R28,4
	RET
__floor1:
    brtc __floor0
	CALL SUBOPT_0x8F
	__GETD1N 0x3F800000
	CALL SUBOPT_0x90
	ADIW R28,4
	RET
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

	.CSEG
_putchar:
_0x2020006:
	LDS  R30,192
	ANDI R30,LOW(0x20)
	BREQ PC+3
	JMP _0x2020008
	RJMP _0x2020006
_0x2020008:
	LD   R30,Y
	STS  198,R30
	ADIW R28,1
	RET
__put_G101:
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	SBIW R30,0
	BRNE PC+3
	JMP _0x2020016
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ PC+3
	JMP _0x2020017
	RJMP _0x2020018
_0x2020017:
	__CPWRN 16,17,2
	BRSH PC+3
	JMP _0x2020019
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X+,R30
	ST   X,R31
_0x2020018:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL SUBOPT_0x1
	LDD  R26,Y+6
	STD  Z+0,R26
_0x2020019:
	RJMP _0x202001A
_0x2020016:
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _putchar
_0x202001A:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,7
	RET
__ftoe_G101:
	CALL SUBOPT_0x91
	LDI  R30,LOW(128)
	STD  Y+2,R30
	LDI  R30,LOW(63)
	STD  Y+3,R30
	CALL __SAVELOCR4
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x202001E
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x2020000,0
	CALL SUBOPT_0x92
	RET
_0x202001E:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x202001D
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x2020000,1
	CALL SUBOPT_0x92
	RET
_0x202001D:
	LDD  R26,Y+11
	CPI  R26,LOW(0x7)
	BRSH PC+3
	JMP _0x2020020
	LDI  R30,LOW(6)
	STD  Y+11,R30
_0x2020020:
	LDD  R17,Y+11
_0x2020021:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BRNE PC+3
	JMP _0x2020023
	CALL SUBOPT_0x93
	RJMP _0x2020021
_0x2020023:
	CALL SUBOPT_0x94
	CALL __CPD10
	BREQ PC+3
	JMP _0x2020024
	LDI  R19,LOW(0)
	CALL SUBOPT_0x93
	RJMP _0x2020025
_0x2020024:
	LDD  R19,Y+11
	CALL SUBOPT_0x95
	BREQ PC+2
	BRCC PC+3
	JMP  _0x2020026
	CALL SUBOPT_0x93
_0x2020027:
	CALL SUBOPT_0x95
	BRSH PC+3
	JMP _0x2020029
	CALL SUBOPT_0x96
	CALL SUBOPT_0x97
	RJMP _0x2020027
_0x2020029:
	RJMP _0x202002A
_0x2020026:
_0x202002B:
	CALL SUBOPT_0x95
	BRLO PC+3
	JMP _0x202002D
	CALL SUBOPT_0x96
	CALL SUBOPT_0x98
	CALL SUBOPT_0x99
	SUBI R19,LOW(1)
	RJMP _0x202002B
_0x202002D:
	CALL SUBOPT_0x93
_0x202002A:
	CALL SUBOPT_0x94
	CALL SUBOPT_0x9A
	CALL SUBOPT_0x99
	CALL SUBOPT_0x95
	BRSH PC+3
	JMP _0x202002E
	CALL SUBOPT_0x96
	CALL SUBOPT_0x97
_0x202002E:
_0x2020025:
	LDI  R17,LOW(0)
_0x202002F:
	LDD  R30,Y+11
	CP   R30,R17
	BRSH PC+3
	JMP _0x2020031
	__GETD2S 4
	CALL SUBOPT_0x9B
	CALL SUBOPT_0x9A
	CALL __PUTPARD1
	CALL _floor
	__PUTD1S 4
	CALL SUBOPT_0x96
	CALL __DIVF21
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0x9C
	CALL SUBOPT_0x9D
	CALL __CBD1
	CALL __CDF1
	__GETD2S 4
	CALL __MULF12
	CALL SUBOPT_0x96
	CALL SUBOPT_0x90
	CALL SUBOPT_0x99
	MOV  R30,R17
	SUBI R17,-1
	CPI  R30,0
	BRNE PC+3
	JMP _0x2020032
	RJMP _0x202002F
_0x2020032:
	CALL SUBOPT_0x9C
	LDI  R30,LOW(46)
	ST   X,R30
	RJMP _0x202002F
_0x2020031:
	CALL SUBOPT_0x9E
	LDD  R26,Y+10
	STD  Z+0,R26
	CPI  R19,0
	BRLT PC+3
	JMP _0x2020033
	CALL SUBOPT_0x9C
	LDI  R30,LOW(45)
	ST   X,R30
	NEG  R19
_0x2020033:
	CPI  R19,10
	BRGE PC+3
	JMP _0x2020034
	CALL SUBOPT_0x9E
	MOVW R22,R30
	MOV  R26,R19
	LDI  R30,LOW(10)
	CALL __DIVB21
	SUBI R30,-LOW(48)
	MOVW R26,R22
	ST   X,R30
_0x2020034:
	CALL SUBOPT_0x9E
	MOVW R22,R30
	MOV  R26,R19
	LDI  R30,LOW(10)
	CALL __MODB21
	SUBI R30,-LOW(48)
	MOVW R26,R22
	ST   X,R30
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(0)
	ST   X,R30
	CALL __LOADLOCR4
	ADIW R28,16
	RET
__print_G101:
	SBIW R28,63
	SBIW R28,15
	CALL __SAVELOCR6
	LDI  R17,0
	__GETW1SX 84
	STD  Y+16,R30
	STD  Y+16+1,R31
_0x2020035:
	MOVW R26,R28
	SUBI R26,LOW(-(90))
	SBCI R27,HIGH(-(90))
	CALL SUBOPT_0x1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x2020037
	MOV  R30,R17
	CPI  R30,0
	BREQ PC+3
	JMP _0x202003B
	CPI  R18,37
	BREQ PC+3
	JMP _0x202003C
	LDI  R17,LOW(1)
	RJMP _0x202003D
_0x202003C:
	CALL SUBOPT_0x9F
_0x202003D:
	RJMP _0x202003A
_0x202003B:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x202003E
	CPI  R18,37
	BREQ PC+3
	JMP _0x202003F
	CALL SUBOPT_0x9F
	LDI  R17,LOW(0)
	RJMP _0x202003A
_0x202003F:
	LDI  R17,LOW(2)
	LDI  R30,LOW(0)
	STD  Y+19,R30
	LDI  R16,LOW(0)
	CPI  R18,45
	BREQ PC+3
	JMP _0x2020040
	LDI  R16,LOW(1)
	RJMP _0x202003A
_0x2020040:
	CPI  R18,43
	BREQ PC+3
	JMP _0x2020041
	LDI  R30,LOW(43)
	STD  Y+19,R30
	RJMP _0x202003A
_0x2020041:
	CPI  R18,32
	BREQ PC+3
	JMP _0x2020042
	LDI  R30,LOW(32)
	STD  Y+19,R30
	RJMP _0x202003A
_0x2020042:
	RJMP _0x2020043
_0x202003E:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x2020044
_0x2020043:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BREQ PC+3
	JMP _0x2020045
	ORI  R16,LOW(128)
	RJMP _0x202003A
_0x2020045:
	RJMP _0x2020046
_0x2020044:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x2020047
_0x2020046:
	CPI  R18,48
	BRSH PC+3
	JMP _0x2020049
	CPI  R18,58
	BRLO PC+3
	JMP _0x2020049
	RJMP _0x202004A
_0x2020049:
	RJMP _0x2020048
_0x202004A:
	MOV  R26,R21
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R21,R30
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x202003A
_0x2020048:
	LDI  R20,LOW(0)
	CPI  R18,46
	BREQ PC+3
	JMP _0x202004B
	LDI  R17,LOW(4)
	RJMP _0x202003A
_0x202004B:
	RJMP _0x202004C
	RJMP _0x202004D
_0x2020047:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x202004E
_0x202004D:
	CPI  R18,48
	BRSH PC+3
	JMP _0x2020050
	CPI  R18,58
	BRLO PC+3
	JMP _0x2020050
	RJMP _0x2020051
_0x2020050:
	RJMP _0x202004F
_0x2020051:
	ORI  R16,LOW(32)
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x202003A
_0x202004F:
_0x202004C:
	CPI  R18,108
	BREQ PC+3
	JMP _0x2020052
	ORI  R16,LOW(2)
	LDI  R17,LOW(5)
	RJMP _0x202003A
_0x2020052:
	RJMP _0x2020053
_0x202004E:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x202003A
_0x2020053:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BREQ PC+3
	JMP _0x2020058
	CALL SUBOPT_0xA0
	CALL SUBOPT_0xA1
	CALL SUBOPT_0xA0
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0xA2
	RJMP _0x2020059
	RJMP _0x202005A
_0x2020058:
	CPI  R30,LOW(0x45)
	BREQ PC+3
	JMP _0x202005B
_0x202005A:
	RJMP _0x202005C
_0x202005B:
	CPI  R30,LOW(0x65)
	BREQ PC+3
	JMP _0x202005D
_0x202005C:
	RJMP _0x202005E
_0x202005D:
	CPI  R30,LOW(0x66)
	BREQ PC+3
	JMP _0x202005F
_0x202005E:
	MOVW R30,R28
	ADIW R30,20
	STD  Y+10,R30
	STD  Y+10+1,R31
	CALL SUBOPT_0xA3
	CALL SUBOPT_0xA4
	CALL SUBOPT_0xA5
	LDD  R26,Y+9
	TST  R26
	BRPL PC+3
	JMP _0x2020060
	LDD  R26,Y+19
	CPI  R26,LOW(0x2B)
	BREQ PC+3
	JMP _0x2020061
	RJMP _0x2020062
_0x2020061:
	RJMP _0x2020063
_0x2020060:
	CALL SUBOPT_0xA6
	CALL __ANEGF1
	CALL SUBOPT_0xA7
	LDI  R30,LOW(45)
	STD  Y+19,R30
_0x2020062:
	SBRS R16,7
	RJMP _0x2020064
	LDD  R30,Y+19
	ST   -Y,R30
	CALL SUBOPT_0xA2
	RJMP _0x2020065
_0x2020064:
	CALL SUBOPT_0xA8
	LDD  R26,Y+19
	STD  Z+0,R26
_0x2020065:
_0x2020063:
	SBRC R16,5
	RJMP _0x2020066
	LDI  R20,LOW(6)
_0x2020066:
	CPI  R18,102
	BREQ PC+3
	JMP _0x2020067
	CALL SUBOPT_0xA6
	CALL __PUTPARD1
	ST   -Y,R20
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _ftoa
	RJMP _0x2020068
_0x2020067:
	CALL SUBOPT_0xA6
	CALL __PUTPARD1
	ST   -Y,R20
	ST   -Y,R18
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	ST   -Y,R31
	ST   -Y,R30
	CALL __ftoe_G101
_0x2020068:
	MOVW R30,R28
	ADIW R30,20
	CALL SUBOPT_0xA9
	RJMP _0x2020069
	RJMP _0x202006A
_0x202005F:
	CPI  R30,LOW(0x73)
	BREQ PC+3
	JMP _0x202006B
_0x202006A:
	CALL SUBOPT_0xA5
	CALL SUBOPT_0xAA
	CALL SUBOPT_0xA9
	RJMP _0x202006C
	RJMP _0x202006D
_0x202006B:
	CPI  R30,LOW(0x70)
	BREQ PC+3
	JMP _0x202006E
_0x202006D:
	CALL SUBOPT_0xA5
	CALL SUBOPT_0xAA
	STD  Y+10,R30
	STD  Y+10+1,R31
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x202006C:
	ANDI R16,LOW(127)
	CPI  R20,0
	BRNE PC+3
	JMP _0x2020070
	CP   R20,R17
	BRLO PC+3
	JMP _0x2020070
	RJMP _0x2020071
_0x2020070:
	RJMP _0x202006F
_0x2020071:
	MOV  R17,R20
_0x202006F:
_0x2020069:
	LDI  R20,LOW(0)
	LDI  R30,LOW(0)
	STD  Y+18,R30
	LDI  R19,LOW(0)
	RJMP _0x2020072
	RJMP _0x2020073
_0x202006E:
	CPI  R30,LOW(0x64)
	BREQ PC+3
	JMP _0x2020074
_0x2020073:
	RJMP _0x2020075
_0x2020074:
	CPI  R30,LOW(0x69)
	BREQ PC+3
	JMP _0x2020076
_0x2020075:
	ORI  R16,LOW(4)
	RJMP _0x2020077
_0x2020076:
	CPI  R30,LOW(0x75)
	BREQ PC+3
	JMP _0x2020078
_0x2020077:
	LDI  R30,LOW(10)
	STD  Y+18,R30
	SBRS R16,1
	RJMP _0x2020079
	__GETD1N 0x3B9ACA00
	CALL SUBOPT_0x99
	LDI  R17,LOW(10)
	RJMP _0x202007A
_0x2020079:
	__GETD1N 0x2710
	CALL SUBOPT_0x99
	LDI  R17,LOW(5)
	RJMP _0x202007A
	RJMP _0x202007B
_0x2020078:
	CPI  R30,LOW(0x58)
	BREQ PC+3
	JMP _0x202007C
_0x202007B:
	ORI  R16,LOW(8)
	RJMP _0x202007D
_0x202007C:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x20200BB
_0x202007D:
	LDI  R30,LOW(16)
	STD  Y+18,R30
	SBRS R16,1
	RJMP _0x202007F
	__GETD1N 0x10000000
	CALL SUBOPT_0x99
	LDI  R17,LOW(8)
	RJMP _0x202007A
_0x202007F:
	__GETD1N 0x1000
	CALL SUBOPT_0x99
	LDI  R17,LOW(4)
_0x202007A:
	CPI  R20,0
	BRNE PC+3
	JMP _0x2020080
	ANDI R16,LOW(127)
	RJMP _0x2020081
_0x2020080:
	LDI  R20,LOW(1)
_0x2020081:
	SBRS R16,1
	RJMP _0x2020082
	CALL SUBOPT_0xA5
	CALL SUBOPT_0xA3
	ADIW R26,4
	CALL SUBOPT_0xA4
	RJMP _0x2020083
_0x2020082:
	SBRS R16,2
	RJMP _0x2020084
	CALL SUBOPT_0xA5
	CALL SUBOPT_0xAA
	CALL __CWD1
	CALL SUBOPT_0xA7
	RJMP _0x2020085
_0x2020084:
	CALL SUBOPT_0xA5
	CALL SUBOPT_0xAA
	CLR  R22
	CLR  R23
	CALL SUBOPT_0xA7
_0x2020085:
_0x2020083:
	SBRS R16,2
	RJMP _0x2020086
	LDD  R26,Y+9
	TST  R26
	BRMI PC+3
	JMP _0x2020087
	CALL SUBOPT_0xA6
	CALL __ANEGD1
	CALL SUBOPT_0xA7
	LDI  R30,LOW(45)
	STD  Y+19,R30
_0x2020087:
	LDD  R30,Y+19
	CPI  R30,0
	BRNE PC+3
	JMP _0x2020088
	SUBI R17,-LOW(1)
	SUBI R20,-LOW(1)
	RJMP _0x2020089
_0x2020088:
	ANDI R16,LOW(251)
_0x2020089:
_0x2020086:
	MOV  R19,R20
_0x2020072:
	SBRC R16,0
	RJMP _0x202008A
_0x202008B:
	CP   R17,R21
	BRLO PC+3
	JMP _0x202008E
	CP   R19,R21
	BRLO PC+3
	JMP _0x202008E
	RJMP _0x202008F
_0x202008E:
	RJMP _0x202008D
_0x202008F:
	SBRS R16,7
	RJMP _0x2020090
	SBRS R16,2
	RJMP _0x2020091
	ANDI R16,LOW(251)
	LDD  R18,Y+19
	SUBI R17,LOW(1)
	RJMP _0x2020092
_0x2020091:
	LDI  R18,LOW(48)
_0x2020092:
	RJMP _0x2020093
_0x2020090:
	LDI  R18,LOW(32)
_0x2020093:
	CALL SUBOPT_0x9F
	SUBI R21,LOW(1)
	RJMP _0x202008B
_0x202008D:
_0x202008A:
_0x2020094:
	CP   R17,R20
	BRLO PC+3
	JMP _0x2020096
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x2020097
	CALL SUBOPT_0xAB
	BRNE PC+3
	JMP _0x2020098
	SUBI R21,LOW(1)
_0x2020098:
	SUBI R17,LOW(1)
	SUBI R20,LOW(1)
_0x2020097:
	LDI  R30,LOW(48)
	ST   -Y,R30
	CALL SUBOPT_0xA2
	CPI  R21,0
	BRNE PC+3
	JMP _0x2020099
	SUBI R21,LOW(1)
_0x2020099:
	SUBI R20,LOW(1)
	RJMP _0x2020094
_0x2020096:
	MOV  R19,R17
	LDD  R30,Y+18
	CPI  R30,0
	BREQ PC+3
	JMP _0x202009A
_0x202009B:
	CPI  R19,0
	BRNE PC+3
	JMP _0x202009D
	SBRS R16,3
	RJMP _0x202009E
	CALL SUBOPT_0xA8
	LPM  R30,Z
	ST   -Y,R30
	CALL SUBOPT_0xA2
	RJMP _0x202009F
_0x202009E:
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LD   R30,X+
	STD  Y+10,R26
	STD  Y+10+1,R27
	ST   -Y,R30
	CALL SUBOPT_0xA2
_0x202009F:
	CPI  R21,0
	BRNE PC+3
	JMP _0x20200A0
	SUBI R21,LOW(1)
_0x20200A0:
	SUBI R19,LOW(1)
	RJMP _0x202009B
_0x202009D:
	RJMP _0x20200A1
_0x202009A:
_0x20200A3:
	CALL SUBOPT_0xAC
	CALL __DIVD21U
	MOV  R18,R30
	CPI  R18,10
	BRSH PC+3
	JMP _0x20200A5
	SBRS R16,3
	RJMP _0x20200A6
	SUBI R18,-LOW(55)
	RJMP _0x20200A7
_0x20200A6:
	SUBI R18,-LOW(87)
_0x20200A7:
	RJMP _0x20200A8
_0x20200A5:
	SUBI R18,-LOW(48)
_0x20200A8:
	SBRS R16,4
	RJMP _0x20200A9
	RJMP _0x20200AA
_0x20200A9:
	CPI  R18,49
	BRLO PC+3
	JMP _0x20200AC
	CALL SUBOPT_0x96
	__CPD2N 0x1
	BRNE PC+3
	JMP _0x20200AC
	RJMP _0x20200AB
_0x20200AC:
	RJMP _0x20200AE
_0x20200AB:
	CP   R20,R19
	BRSH PC+3
	JMP _0x20200AF
	LDI  R18,LOW(48)
	RJMP _0x20200AE
_0x20200AF:
	CP   R21,R19
	BRSH PC+3
	JMP _0x20200B1
	SBRC R16,0
	RJMP _0x20200B1
	RJMP _0x20200B2
_0x20200B1:
	RJMP _0x20200B0
_0x20200B2:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x20200B3
	LDI  R18,LOW(48)
_0x20200AE:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x20200B4
	CALL SUBOPT_0xAB
	BRNE PC+3
	JMP _0x20200B5
	SUBI R21,LOW(1)
_0x20200B5:
_0x20200B4:
_0x20200B3:
_0x20200AA:
	CALL SUBOPT_0x9F
	CPI  R21,0
	BRNE PC+3
	JMP _0x20200B6
	SUBI R21,LOW(1)
_0x20200B6:
_0x20200B0:
	SUBI R19,LOW(1)
	CALL SUBOPT_0xAC
	CALL __MODD21U
	CALL SUBOPT_0xA7
	LDD  R30,Y+18
	CALL SUBOPT_0x96
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __DIVD21U
	CALL SUBOPT_0x99
_0x20200A2:
	CALL SUBOPT_0x94
	CALL __CPD10
	BRNE PC+3
	JMP _0x20200A4
	RJMP _0x20200A3
_0x20200A4:
_0x20200A1:
	SBRS R16,0
	RJMP _0x20200B7
_0x20200B8:
	CPI  R21,0
	BRNE PC+3
	JMP _0x20200BA
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0xA2
	RJMP _0x20200B8
_0x20200BA:
_0x20200B7:
_0x20200BB:
_0x2020059:
	LDI  R17,LOW(0)
_0x2020057:
_0x202003A:
	RJMP _0x2020035
_0x2020037:
	CALL __LOADLOCR6
	ADIW R28,63
	ADIW R28,29
	RET
_vsprintf:
	SBIW R28,2
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   Y,R30
	STD  Y+1,R31
	CALL SUBOPT_0xAD
	CALL SUBOPT_0xAD
	MOVW R30,R28
	ADIW R30,4
	CALL SUBOPT_0xAE
	CALL __print_G101
	LD   R26,Y
	LDD  R27,Y+1
	LDI  R30,LOW(0)
	ST   X,R30
	ADIW R28,8
	RET

	.CSEG
_abs:
    ld   r30,y+
    ld   r31,y+
    sbiw r30,0
    brpl __abs0
    com  r30
    com  r31
    adiw r30,1
__abs0:
    ret
_ftoa:
	CALL SUBOPT_0x91
	LDI  R30,LOW(0)
	STD  Y+2,R30
	LDI  R30,LOW(63)
	STD  Y+3,R30
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x204000D
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x2040000,0
	CALL SUBOPT_0xAF
	RET
_0x204000D:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x204000C
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x2040000,1
	CALL SUBOPT_0xAF
	RET
_0x204000C:
	LDD  R26,Y+12
	TST  R26
	BRMI PC+3
	JMP _0x204000F
	__GETD1S 9
	CALL __ANEGF1
	CALL SUBOPT_0xB0
	CALL SUBOPT_0xB1
	LDI  R30,LOW(45)
	ST   X,R30
_0x204000F:
	LDD  R26,Y+8
	CPI  R26,LOW(0x7)
	BRSH PC+3
	JMP _0x2040010
	LDI  R30,LOW(6)
	STD  Y+8,R30
_0x2040010:
	LDD  R17,Y+8
_0x2040011:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BRNE PC+3
	JMP _0x2040013
	CALL SUBOPT_0xB2
	CALL SUBOPT_0x9B
	CALL SUBOPT_0xB3
	RJMP _0x2040011
_0x2040013:
	CALL SUBOPT_0xB4
	CALL __ADDF12
	CALL SUBOPT_0xB0
	LDI  R17,LOW(0)
	__GETD1N 0x3F800000
	CALL SUBOPT_0xB3
_0x2040014:
	CALL SUBOPT_0xB4
	CALL __CMPF12
	BRSH PC+3
	JMP _0x2040016
	CALL SUBOPT_0xB2
	CALL SUBOPT_0x98
	CALL SUBOPT_0xB3
	SUBI R17,-LOW(1)
	RJMP _0x2040014
_0x2040016:
	CPI  R17,0
	BREQ PC+3
	JMP _0x2040017
	CALL SUBOPT_0xB1
	LDI  R30,LOW(48)
	ST   X,R30
	RJMP _0x2040018
_0x2040017:
_0x2040019:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BRNE PC+3
	JMP _0x204001B
	CALL SUBOPT_0xB2
	CALL SUBOPT_0x9B
	CALL SUBOPT_0x9A
	CALL __PUTPARD1
	CALL _floor
	CALL SUBOPT_0xB3
	CALL SUBOPT_0xB4
	CALL __DIVF21
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0xB1
	CALL SUBOPT_0x9D
	CALL SUBOPT_0xB2
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __CDF1
	CALL __MULF12
	CALL SUBOPT_0xB5
	CALL SUBOPT_0x90
	CALL SUBOPT_0xB0
	RJMP _0x2040019
_0x204001B:
_0x2040018:
	LDD  R30,Y+8
	CPI  R30,0
	BREQ PC+3
	JMP _0x204001C
	CALL SUBOPT_0xB6
	RET
_0x204001C:
	CALL SUBOPT_0xB1
	LDI  R30,LOW(46)
	ST   X,R30
_0x204001D:
	LDD  R30,Y+8
	SUBI R30,LOW(1)
	STD  Y+8,R30
	SUBI R30,-LOW(1)
	BRNE PC+3
	JMP _0x204001F
	CALL SUBOPT_0xB5
	CALL SUBOPT_0x98
	CALL SUBOPT_0xB0
	__GETD1S 9
	CALL __CFD1U
	MOV  R16,R30
	CALL SUBOPT_0xB1
	CALL SUBOPT_0x9D
	CALL SUBOPT_0xB5
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __CDF1
	CALL SUBOPT_0x90
	CALL SUBOPT_0xB0
	RJMP _0x204001D
_0x204001F:
	CALL SUBOPT_0xB6
	RET

	.DSEG

	.CSEG

	.CSEG
_strcpyf:
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
    movw r24,r26
strcpyf0:
	lpm  r0,z+
    st   x+,r0
    tst  r0
    brne strcpyf0
    movw r30,r24
    ret
_strlen:
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
    lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
_strncmpf:
    clr  r0
    clr  r1
    ld   r22,y+
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
strncmpf0:
    tst  r22
    breq strncmpf1
    dec  r22
    ld   r1,x+
	lpm  r0,z+
    cp   r0,r1
    brne strncmpf1
    tst  r0
    brne strncmpf0
strncmpf3:
    clr  r30
    ret
strncmpf1:
    sub  r1,r0
    breq strncmpf3
    ldi  r30,1
    brcc strncmpf2
    subi r30,2
strncmpf2:
    ret
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

	.CSEG
_usart0_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDS  R17,192
	LDS  R16,198
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0x2080003
	LDS  R30,_QueueLast
	LDS  R31,_QueueLast+1
	SUBI R30,LOW(-_QueueData)
	SBCI R31,HIGH(-_QueueData)
	ST   Z,R16
	LDI  R26,LOW(_QueueLast)
	LDI  R27,HIGH(_QueueLast)
	CALL SUBOPT_0xB7
	CPI  R30,LOW(0x100)
	LDI  R26,HIGH(0x100)
	CPC  R31,R26
	BRSH PC+3
	JMP _0x2080004
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _QueueLast,R30
	STS  _QueueLast+1,R31
_0x2080004:
_0x2080003:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
_usart1_rx_isr:
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDS  R17,200
	LDS  R16,206
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0x2080005
_0x2080005:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	RETI
_timer0_ovf_isr:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	LDI  R30,LOW(142)
	OUT  0x26,R30
	LDI  R26,LOW(_TickCount)
	LDI  R27,HIGH(_TickCount)
	CALL SUBOPT_0xB7
	LDI  R26,LOW(_IntCount)
	LDI  R27,HIGH(_IntCount)
	CALL SUBOPT_0xB7
	CPI  R30,LOW(0x1F4)
	LDI  R26,HIGH(0x1F4)
	CPC  R31,R26
	BRSH PC+3
	JMP _0x2080006
	LDI  R30,LOW(1)
	STS  _bHalfMainStart,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _IntCount,R30
	STS  _IntCount+1,R31
_0x2080006:
	LDS  R26,_IntCount
	LDS  R27,_IntCount+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21U
	SBIW R30,0
	BREQ PC+3
	JMP _0x2080007
	IN   R30,0x6
	COM  R30
	STS  _NewKey,R30
	LDS  R30,_OldKey
	LDS  R26,_NewKey
	CP   R30,R26
	BREQ PC+3
	JMP _0x2080008
	LDS  R30,_NewKey
	STS  _Key,R30
_0x2080008:
	LDS  R30,_NewKey
	STS  _OldKey,R30
	IN   R30,0xF
	COM  R30
	STS  _NewSensor,R30
	LDS  R30,_OldSensor
	LDS  R26,_NewSensor
	CP   R30,R26
	BREQ PC+3
	JMP _0x2080009
	LDS  R30,_NewSensor
	STS  _Sensor,R30
_0x2080009:
	LDS  R30,_NewSensor
	STS  _OldSensor,R30
	LDS  R30,265
	COM  R30
	ANDI R30,LOW(0xF)
	STS  _NewExtKey,R30
	LDS  R30,_OldExtKey
	LDS  R26,_NewExtKey
	CP   R30,R26
	BREQ PC+3
	JMP _0x208000A
	LDS  R30,_NewExtKey
	STS  _ExtKey,R30
_0x208000A:
	LDS  R30,_NewExtKey
	STS  _OldExtKey,R30
	IN   R30,0x9
	COM  R30
	ANDI R30,LOW(0x1)
	STS  _NewEmo,R30
	LDS  R30,_OldEmo
	LDS  R26,_NewEmo
	CP   R30,R26
	BREQ PC+3
	JMP _0x208000B
	LDS  R30,_NewEmo
	STS  _Emo,R30
	LDS  R30,_Emo
	CPI  R30,0
	BRNE PC+3
	JMP _0x208000C
	LDI  R30,LOW(1)
	STS  _bEmoState,R30
_0x208000C:
	RJMP _0x208000D
_0x208000B:
	LDS  R30,_bRun
	CPI  R30,0
	BREQ PC+3
	JMP _0x208000F
	LDS  R26,_bEmoState
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x208000F
	RJMP _0x2080010
_0x208000F:
	RJMP _0x208000E
_0x2080010:
	LDI  R30,LOW(0)
	STS  _bEmoState,R30
_0x208000E:
_0x208000D:
	LDS  R30,_NewEmo
	STS  _OldEmo,R30
	LDI  R30,LOW(1)
	STS  _bMainStart,R30
_0x2080007:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
_main:
	LDI  R30,LOW(128)
	STS  97,R30
	LDI  R30,LOW(0)
	STS  97,R30
	LDI  R30,LOW(247)
	OUT  0x2,R30
	LDI  R30,LOW(251)
	OUT  0x1,R30
	LDI  R30,LOW(255)
	OUT  0x5,R30
	LDI  R30,LOW(0)
	OUT  0x4,R30
	LDI  R30,LOW(255)
	OUT  0x8,R30
	LDI  R30,LOW(0)
	OUT  0x7,R30
	LDI  R30,LOW(255)
	OUT  0xB,R30
	LDI  R30,LOW(8)
	OUT  0xA,R30
	LDI  R30,LOW(255)
	OUT  0xE,R30
	LDI  R30,LOW(2)
	OUT  0xD,R30
	LDI  R30,LOW(255)
	OUT  0x11,R30
	LDI  R30,LOW(0)
	OUT  0x10,R30
	LDI  R30,LOW(63)
	OUT  0x14,R30
	LDI  R30,LOW(0)
	OUT  0x13,R30
	LDI  R30,LOW(255)
	STS  258,R30
	STS  257,R30
	LDI  R30,LOW(0)
	STS  261,R30
	LDI  R30,LOW(255)
	STS  260,R30
	LDI  R30,LOW(0)
	STS  264,R30
	LDI  R30,LOW(255)
	STS  263,R30
	STS  267,R30
	LDI  R30,LOW(0)
	STS  266,R30
	OUT  0x24,R30
	LDI  R30,LOW(3)
	OUT  0x25,R30
	LDI  R30,LOW(142)
	OUT  0x26,R30
	LDI  R30,LOW(0)
	OUT  0x27,R30
	OUT  0x28,R30
	STS  128,R30
	STS  129,R30
	STS  133,R30
	STS  132,R30
	STS  135,R30
	STS  134,R30
	STS  137,R30
	STS  136,R30
	STS  139,R30
	STS  138,R30
	STS  141,R30
	STS  140,R30
	STS  182,R30
	STS  176,R30
	STS  177,R30
	STS  178,R30
	STS  179,R30
	STS  180,R30
	STS  144,R30
	STS  145,R30
	STS  149,R30
	STS  148,R30
	STS  151,R30
	STS  150,R30
	STS  153,R30
	STS  152,R30
	STS  155,R30
	STS  154,R30
	STS  157,R30
	STS  156,R30
	STS  160,R30
	STS  161,R30
	STS  165,R30
	STS  164,R30
	STS  167,R30
	STS  166,R30
	STS  169,R30
	STS  168,R30
	STS  171,R30
	STS  170,R30
	STS  173,R30
	STS  172,R30
	STS  288,R30
	STS  289,R30
	STS  293,R30
	STS  292,R30
	STS  295,R30
	STS  294,R30
	STS  297,R30
	STS  296,R30
	STS  299,R30
	STS  298,R30
	STS  301,R30
	STS  300,R30
	STS  105,R30
	STS  106,R30
	OUT  0x1D,R30
	STS  107,R30
	STS  108,R30
	STS  109,R30
	STS  104,R30
	LDI  R30,LOW(1)
	STS  110,R30
	LDI  R30,LOW(0)
	STS  111,R30
	STS  112,R30
	STS  113,R30
	STS  114,R30
	STS  115,R30
	STS  192,R30
	LDI  R30,LOW(152)
	STS  193,R30
	LDI  R30,LOW(6)
	STS  194,R30
	LDI  R30,LOW(0)
	STS  197,R30
	LDI  R30,LOW(3)
	STS  196,R30
	LDI  R30,LOW(0)
	STS  200,R30
	LDI  R30,LOW(152)
	STS  201,R30
	LDI  R30,LOW(6)
	STS  202,R30
	LDI  R30,LOW(0)
	STS  205,R30
	LDI  R30,LOW(3)
	STS  204,R30
	LDI  R30,LOW(0)
	STS  209,R30
	STS  305,R30
	LDI  R30,LOW(128)
	OUT  0x30,R30
	LDI  R30,LOW(0)
	STS  123,R30
	STS  127,R30
	STS  122,R30
	OUT  0x2C,R30
	STS  188,R30
	sei
	CALL _HwInit
_0x2080011:
	CALL _CommSubroutine
	LDS  R30,_bMainStart
	CPI  R30,0
	BRNE PC+3
	JMP _0x2080014
	LDI  R30,LOW(0)
	STS  _bMainStart,R30
	CALL _UserMain
_0x2080014:
	LDS  R30,_bHalfMainStart
	CPI  R30,0
	BRNE PC+3
	JMP _0x2080015
	LDI  R30,LOW(0)
	STS  _bHalfMainStart,R30
	LDS  R30,_bBlink
	CALL __LNEGB1
	STS  _bBlink,R30
	CALL _HalfSecMain
_0x2080015:
	RJMP _0x2080011
_0x2080013:
_0x2080016:
	RJMP _0x2080016
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

	.CSEG
_Delay:
	CALL SUBOPT_0xB8
	__GETWRN 16,17,0
_0x20A0004:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R16,R30
	CPC  R17,R31
	BRLO PC+3
	JMP _0x20A0005
_0x20A0003:
	__ADDWRN 16,17,1
	RJMP _0x20A0004
_0x20A0005:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
_DelayMs:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _TickCount,R30
	STS  _TickCount+1,R31
_0x20A0006:
	LD   R30,Y
	LDD  R31,Y+1
	LDS  R26,_TickCount
	LDS  R27,_TickCount+1
	CP   R26,R30
	CPC  R27,R31
	BRLO PC+3
	JMP _0x20A0008
	RJMP _0x20A0006
_0x20A0008:
	ADIW R28,2
	RET
_Asc2Hex:
	LD   R26,Y
	CPI  R26,LOW(0x30)
	BRGE PC+3
	JMP _0x20A000A
	CPI  R26,LOW(0x3A)
	BRLT PC+3
	JMP _0x20A000A
	RJMP _0x20A000B
_0x20A000A:
	RJMP _0x20A0009
_0x20A000B:
	LD   R30,Y
	SUBI R30,LOW(48)
	ADIW R28,1
	RET
_0x20A0009:
	LD   R26,Y
	CPI  R26,LOW(0x41)
	BRGE PC+3
	JMP _0x20A000E
	CPI  R26,LOW(0x5B)
	BRLT PC+3
	JMP _0x20A000E
	RJMP _0x20A000F
_0x20A000E:
	RJMP _0x20A000D
_0x20A000F:
	LD   R30,Y
	SUBI R30,LOW(65)
	SUBI R30,-LOW(10)
	ADIW R28,1
	RET
_0x20A000D:
	LD   R26,Y
	CPI  R26,LOW(0x61)
	BRGE PC+3
	JMP _0x20A0012
	CPI  R26,LOW(0x7B)
	BRLT PC+3
	JMP _0x20A0012
	RJMP _0x20A0013
_0x20A0012:
	RJMP _0x20A0011
_0x20A0013:
	LD   R30,Y
	SUBI R30,LOW(97)
	SUBI R30,-LOW(10)
	ADIW R28,1
	RET
_0x20A0011:
	LDI  R30,LOW(255)
	ADIW R28,1
	RET
_0x20A0014:
_0x20A0010:
_0x20A000C:
	ADIW R28,1
	RET
_SetEeprom:
_0x20A0019:
	SBIS 0x1F,1
	RJMP _0x20A001B
	RJMP _0x20A0019
_0x20A001B:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	OUT  0x21+1,R31
	OUT  0x21,R30
	LD   R30,Y
	OUT  0x20,R30
	SBI  0x1F,2
	SBI  0x1F,1
	ADIW R28,3
	RET
_SetEeprom2:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R30
	CALL _SetEeprom
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ANDI R30,LOW(0xFF00)
	MOV  R30,R31
	LDI  R31,0
	ST   -Y,R30
	CALL _SetEeprom
	ADIW R28,4
	RET
_SetEeprom4:
	CALL SUBOPT_0xAD
	CALL SUBOPT_0xB9
	__ANDD1N 0xFF
	CALL SUBOPT_0xBA
	ADIW R30,1
	CALL SUBOPT_0xBB
	__ANDD1N 0xFF00
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(8)
	CALL __LSRD12
	CALL SUBOPT_0xBA
	ADIW R30,2
	CALL SUBOPT_0xBB
	__ANDD1N 0xFF0000
	CALL __LSRD16
	CALL SUBOPT_0xBA
	ADIW R30,3
	CALL SUBOPT_0xBB
	__ANDD1N 0xFF000000
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(24)
	CALL __LSRD12
	ST   -Y,R30
	CALL _SetEeprom
	ADIW R28,6
	RET
_GetEeprom:
	ST   -Y,R17
_0x20A0022:
	SBIS 0x1F,1
	RJMP _0x20A0024
	RJMP _0x20A0022
_0x20A0024:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	OUT  0x21+1,R31
	OUT  0x21,R30
	SBI  0x1F,0
	IN   R17,32
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,3
	RET
_GetEeprom2:
	CALL SUBOPT_0xB8
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	CALL SUBOPT_0xBC
	MOV  R16,R30
	CLR  R17
	MOV  R17,R16
	CLR  R16
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CALL SUBOPT_0xBC
	LDI  R31,0
	__ORWRR 16,17,30,31
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
_GetEeprom4:
	CALL SUBOPT_0x91
	CALL SUBOPT_0xBD
	ADIW R30,3
	CALL SUBOPT_0xBC
	CLR  R31
	CLR  R22
	CLR  R23
	CALL SUBOPT_0xBE
	ADIW R30,2
	CALL SUBOPT_0xBC
	CALL SUBOPT_0xBF
	CALL SUBOPT_0xBE
	ADIW R30,1
	CALL SUBOPT_0xBC
	CALL SUBOPT_0xBF
	CALL SUBOPT_0xC0
	LDI  R30,LOW(8)
	CALL __LSLD12
	CALL SUBOPT_0x8E
	CALL SUBOPT_0xAD
	CALL _GetEeprom
	CALL SUBOPT_0xBF
	CALL SUBOPT_0xC1
	ADIW R28,6
	RET
_SerialTxChar:
	LD   R30,Y
	CPI  R30,0
	BREQ PC+3
	JMP _0x20A0028
_0x20A0029:
	LDS  R30,192
	ANDI R30,LOW(0x20)
	BREQ PC+3
	JMP _0x20A002B
	RJMP _0x20A0029
_0x20A002B:
	LDD  R30,Y+1
	STS  198,R30
_0x20A002C:
	LDS  R30,192
	ANDI R30,LOW(0x40)
	BREQ PC+3
	JMP _0x20A002E
	RJMP _0x20A002C
_0x20A002E:
	RJMP _0x20A002F
_0x20A0028:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x20A0030
_0x20A0031:
	LDS  R30,200
	ANDI R30,LOW(0x20)
	BREQ PC+3
	JMP _0x20A0033
	RJMP _0x20A0031
_0x20A0033:
	LDD  R30,Y+1
	STS  206,R30
_0x20A0034:
	LDS  R30,200
	ANDI R30,LOW(0x40)
	BREQ PC+3
	JMP _0x20A0036
	RJMP _0x20A0034
_0x20A0036:
	RJMP _0x20A0037
_0x20A0030:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x20A0038
_0x20A0039:
	LDS  R30,208
	ANDI R30,LOW(0x20)
	BREQ PC+3
	JMP _0x20A003B
	RJMP _0x20A0039
_0x20A003B:
	LDD  R30,Y+1
	STS  214,R30
_0x20A003C:
	LDS  R30,208
	ANDI R30,LOW(0x40)
	BREQ PC+3
	JMP _0x20A003E
	RJMP _0x20A003C
_0x20A003E:
	RJMP _0x20A003F
_0x20A0038:
	LD   R26,Y
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x20A0040
_0x20A0041:
	LDS  R30,304
	ANDI R30,LOW(0x20)
	BREQ PC+3
	JMP _0x20A0043
	RJMP _0x20A0041
_0x20A0043:
	LDD  R30,Y+1
	STS  310,R30
_0x20A0044:
	LDS  R30,304
	ANDI R30,LOW(0x40)
	BREQ PC+3
	JMP _0x20A0046
	RJMP _0x20A0044
_0x20A0046:
_0x20A0040:
_0x20A003F:
_0x20A0037:
_0x20A002F:
	ADIW R28,2
	RET
_Sputs:
_0x20A0047:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X
	CPI  R30,0
	BRNE PC+3
	JMP _0x20A0049
	ST   -Y,R30
	LDD  R30,Y+1
	ST   -Y,R30
	CALL _SerialTxChar
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	RJMP _0x20A0047
_0x20A0049:
	ADIW R28,3
	RET
_Uartprintf0:
	PUSH R15
	CALL SUBOPT_0xC2
	MOVW R30,R28
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _Sputs
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,63
	ADIW R28,39
	POP  R15
	RET
_Dac7512Write:
	CALL SUBOPT_0xB8
	CBI  0x2,0
	SBI  0x2,0
	CBI  0x2,0
	__GETWRN 16,17,0
_0x20A0054:
	__CPWRN 16,17,16
	BRLT PC+3
	JMP _0x20A0055
	MOV  R30,R16
	LDI  R26,LOW(32768)
	LDI  R27,HIGH(32768)
	CALL __LSRW12
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	AND  R30,R26
	AND  R31,R27
	SBIW R30,0
	BRNE PC+3
	JMP _0x20A0056
	SBI  0x2,4
	RJMP _0x20A0057
_0x20A0056:
	CBI  0x2,4
_0x20A0057:
	CBI  0x2,3
	SBI  0x2,3
	CBI  0x2,3
_0x20A0053:
	__ADDWRN 16,17,1
	RJMP _0x20A0054
_0x20A0055:
	SBI  0x2,0
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
_Ltc1865Read:
	CALL __SAVELOCR6
	__GETWRN 16,17,0
	__GETWRN 18,19,0
	__GETWRN 20,21,0
	CBI  0x2,1
	SBI  0x2,1
	CBI  0x2,1
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,0
	BRNE PC+3
	JMP _0x20A005D
	__GETWRN 18,19,49152
	RJMP _0x20A005E
_0x20A005D:
	__GETWRN 18,19,32768
_0x20A005E:
	__GETWRN 20,21,0
_0x20A0060:
	__CPWRN 20,21,16
	BRLT PC+3
	JMP _0x20A0061
	LSL  R16
	ROL  R17
	MOV  R30,R20
	LDI  R26,LOW(32768)
	LDI  R27,HIGH(32768)
	CALL __LSRW12
	AND  R30,R18
	AND  R31,R19
	SBIW R30,0
	BRNE PC+3
	JMP _0x20A0062
	SBI  0x2,4
	RJMP _0x20A0063
_0x20A0062:
	CBI  0x2,4
_0x20A0063:
	SBIS 0x0,2
	RJMP _0x20A0064
	ORI  R16,LOW(1)
	RJMP _0x20A0065
_0x20A0064:
	ORI  R16,LOW(0)
_0x20A0065:
	CBI  0x2,3
	SBI  0x2,3
	CBI  0x2,3
_0x20A005F:
	__ADDWRN 20,21,1
	RJMP _0x20A0060
_0x20A0061:
	SBI  0x2,1
	MOVW R30,R16
	CALL __LOADLOCR6
	ADIW R28,8
	RET
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

	.CSEG
_LcdCommandWrite:
	CALL SUBOPT_0xC3
	CBI  0x2,7
	LD   R30,Y
	STS  258,R30
	SBI  0x2,5
	CBI  0x2,5
	CALL SUBOPT_0xC3
	ADIW R28,1
	RET
_LcdDataWrite:
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	CALL SUBOPT_0xC4
	SBI  0x2,7
	LD   R30,Y
	STS  258,R30
	SBI  0x2,5
	CBI  0x2,5
	ADIW R28,1
	RET
_LcdInit:
	CALL SUBOPT_0xC5
	CBI  0x2,6
	CBI  0x2,5
	CALL SUBOPT_0xC5
	LDI  R30,LOW(56)
	ST   -Y,R30
	CALL _LcdCommandWrite
	CALL SUBOPT_0xC5
	CALL SUBOPT_0x2F
	CALL SUBOPT_0xC5
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _LcdCommandWrite
	LDI  R30,LOW(6)
	ST   -Y,R30
	CALL _LcdCommandWrite
	CALL SUBOPT_0xC5
	RET
_LineDecision:
	LD   R30,Y
	CPI  R30,0
	BREQ PC+3
	JMP _0x20C0006
	LDD  R30,Y+1
	SUBI R30,-LOW(128)
	ST   -Y,R30
	CALL _LcdCommandWrite
	RJMP _0x20C0005
_0x20C0006:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x20C0007
	LDD  R30,Y+1
	SUBI R30,-LOW(192)
	ST   -Y,R30
	CALL _LcdCommandWrite
	RJMP _0x20C0005
_0x20C0007:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x20C0008
	LDD  R30,Y+1
	SUBI R30,-LOW(148)
	ST   -Y,R30
	CALL _LcdCommandWrite
	RJMP _0x20C0005
_0x20C0009:
	RJMP _0x20C000A
_0x20C0008:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x20C0009
_0x20C000A:
	LDD  R30,Y+1
	SUBI R30,-LOW(212)
	ST   -Y,R30
	CALL _LcdCommandWrite
_0x20C0005:
	ADIW R28,2
	RET
_LcdString:
_0x20C000C:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	CPI  R30,0
	BRNE PC+3
	JMP _0x20C000E
	ST   -Y,R30
	CALL _LcdDataWrite
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,1
	ST   Y,R30
	STD  Y+1,R31
	RJMP _0x20C000C
_0x20C000E:
	ADIW R28,2
	RET
_Lcdprintf:
	PUSH R15
	CALL SUBOPT_0xC2
	CALL SUBOPT_0xC6
	CALL SUBOPT_0xC6
	CALL _LineDecision
	MOVW R30,R28
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	CALL _LcdString
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,63
	ADIW R28,39
	POP  R15
	RET
_LcdClear:
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _LcdCommandWrite
	RET
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

	.DSEG

	.CSEG
_SetItv:
	CALL SUBOPT_0x91
	CALL SUBOPT_0xBD
	SBIW R30,0
	CLR  R22
	CLR  R23
	CALL SUBOPT_0xC0
	__GETD1N 0xFFF
	CALL __MULD12U
	CALL SUBOPT_0xC0
	__GETD1N 0x384
	CALL __DIVD21U
	CALL SUBOPT_0x8E
	LD   R30,Y
	LDD  R31,Y+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _Dac7512Write
	ADIW R28,6
	RET
_GetItv:
	CALL SUBOPT_0x91
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+3,R30
	CALL SUBOPT_0xA
	CALL SUBOPT_0x42
	CALL SUBOPT_0x8E
	CALL SUBOPT_0x44
	CALL SUBOPT_0x8F
	CALL __CPD21
	BRLO PC+3
	JMP _0x20E000B
	CALL SUBOPT_0x44
	CALL SUBOPT_0x8E
_0x20E000B:
	CALL SUBOPT_0x46
	CALL SUBOPT_0x8F
	CALL __CPD12
	BRLO PC+3
	JMP _0x20E000C
	CALL SUBOPT_0x46
	CALL SUBOPT_0x8E
_0x20E000C:
	CALL SUBOPT_0xC7
	CALL SUBOPT_0x8D
	CALL __SUBD12
	CALL SUBOPT_0xC0
	__GETD1N 0x384
	CALL __MULD12U
	CALL SUBOPT_0x8E
	CALL SUBOPT_0xC7
	CALL SUBOPT_0x46
	CALL __SUBD12
	CALL SUBOPT_0x8F
	CALL __DIVD21U
	CALL SUBOPT_0xC1
	CALL SUBOPT_0xC1
	ADIW R28,4
	RET
_FirstReturn:
	CALL _LcdInit
	CALL SUBOPT_0x1C
	__POINTW1FN _0x20E0000,0
	CALL SUBOPT_0x2A
	LDI  R30,LOW(18)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	__POINTW1FN _0x20E0000,19
	CALL SUBOPT_0x2A
	CALL SUBOPT_0x20
	__POINTW1FN _0x20E0000,22
	CALL SUBOPT_0x2A
	CALL SUBOPT_0x2B
	__POINTW1FN _0x20E0000,33
	CALL SUBOPT_0x2A
	CALL SUBOPT_0x2F
	CALL SUBOPT_0xA
	CALL _SetItv
	CALL SUBOPT_0xB
	CALL SUBOPT_0x1A
	CALL SUBOPT_0xC8
	CALL SUBOPT_0x27
	CALL SUBOPT_0xC8
	RET
_HwInit:
	LDS  R30,261
	ORI  R30,1
	STS  261,R30
	LDS  R30,261
	ORI  R30,2
	STS  261,R30
	CALL SUBOPT_0x57
	CALL SUBOPT_0x55
	CALL SUBOPT_0x56
	LDS  R30,264
	ANDI R30,0xFB
	STS  264,R30
	CALL SUBOPT_0x26
	LDI  R30,LOW(0)
	STS  _bEmoState,R30
	CALL _FirstReturn
	LDI  R30,LOW(1023)
	LDI  R31,HIGH(1023)
	CALL SUBOPT_0xC9
	SBIW R30,3
	BRNE PC+3
	JMP _0x20E000D
	CALL SUBOPT_0xA
	CALL SUBOPT_0x7C
	CALL SUBOPT_0x74
	CALL SUBOPT_0x80
	ST   -Y,R31
	ST   -Y,R30
	CALL _SetEeprom2
	CALL SUBOPT_0x82
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_sMode1Step
	CALL SUBOPT_0x70
	CALL SUBOPT_0x21
	CALL SUBOPT_0x7D
	CALL SUBOPT_0x24
	CALL SUBOPT_0x7F
	CALL SUBOPT_0x6A
	CALL SUBOPT_0x6E
	LDI  R30,LOW(1023)
	LDI  R31,HIGH(1023)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	CALL _SetEeprom2
	RJMP _0x20E000E
_0x20E000D:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CALL SUBOPT_0xC9
	STS  _bAutoMode,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL SUBOPT_0xC9
	STS  _sMode1Step,R30
	LDS  R26,_sMode1Step
	CPI  R26,LOW(0x5)
	BRSH PC+3
	JMP _0x20E000F
	LDI  R30,LOW(4)
	STS  _sMode1Step,R30
_0x20E000F:
	CALL SUBOPT_0x21
	CALL SUBOPT_0x22
	CALL SUBOPT_0x23
	CALL SUBOPT_0x24
	CALL SUBOPT_0x25
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	CALL SUBOPT_0xC9
	CALL SUBOPT_0x69
	LDS  R26,_PressureStep
	LDS  R27,_PressureStep+1
	SBIW R26,11
	BRSH PC+3
	JMP _0x20E0010
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL SUBOPT_0x69
_0x20E0010:
	LDI  R30,LOW(18)
	LDI  R31,HIGH(18)
	CALL SUBOPT_0xC9
	CALL SUBOPT_0x6D
	LDS  R26,_sPressureStepDelay
	LDS  R27,_sPressureStepDelay+1
	SBIW R26,11
	BRSH PC+3
	JMP _0x20E0011
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL SUBOPT_0x6D
_0x20E0011:
_0x20E000E:
	LDS  R30,_sMode1Step
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x20E0015
	CALL SUBOPT_0xCA
	RJMP _0x20E0014
_0x20E0015:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x20E0016
	CALL SUBOPT_0xCA
	RJMP _0x20E0014
_0x20E0016:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x20E0017
	CALL SUBOPT_0x73
	CALL SUBOPT_0x72
	RJMP _0x20E0014
_0x20E0017:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x20E0014
	CALL SUBOPT_0xA
	CALL SUBOPT_0x22
	CALL SUBOPT_0x76
	CALL SUBOPT_0x74
	CALL SUBOPT_0x22
	CALL SUBOPT_0x75
_0x20E0014:
	__POINTW1FN _0x20E0000,46
	CALL SUBOPT_0x6
	__POINTW1FN _0x20E0000,49
	CALL SUBOPT_0x6
	__POINTW1FN _0x20E0000,82
	CALL SUBOPT_0x6
	__POINTW1FN _0x20E0000,115
	CALL SUBOPT_0x6
	__POINTW1FN _0x20E0000,148
	CALL SUBOPT_0x6
	__POINTW1FN _0x20E0000,49
	CALL SUBOPT_0x6
	__POINTW1FN _0x20E0000,19
	CALL SUBOPT_0x6
	__POINTW1FN _0x20E0000,181
	CALL SUBOPT_0x6
	CALL _LcdInit
	CALL SUBOPT_0x16
	CALL _GetItv
	CALL SUBOPT_0x20
	CALL _SetBuzzer
	LDI  R30,LOW(0)
	STS  _TestMode,R30
	STS  _bCalib,R30
	RET
_BuzzerSubroutine:
	LDS  R30,_BuzzerOnCount
	LDS  R31,_BuzzerOnCount+1
	SBIW R30,0
	BRNE PC+3
	JMP _0x20E0019
	LDI  R26,LOW(_BuzzerOnCount)
	LDI  R27,HIGH(_BuzzerOnCount)
	CALL SUBOPT_0x85
	CALL SUBOPT_0xCB
	RJMP _0x20E001A
_0x20E0019:
	LDS  R30,_BuzzerOffCount
	LDS  R31,_BuzzerOffCount+1
	SBIW R30,0
	BRNE PC+3
	JMP _0x20E001B
	LDI  R26,LOW(_BuzzerOffCount)
	LDI  R27,HIGH(_BuzzerOffCount)
	CALL SUBOPT_0x85
	CALL SUBOPT_0xCC
	RJMP _0x20E001C
_0x20E001B:
	LDS  R30,_BuzzerRepeatCount
	LDS  R31,_BuzzerRepeatCount+1
	SBIW R30,0
	BRNE PC+3
	JMP _0x20E001D
	LDI  R26,LOW(_BuzzerRepeatCount)
	LDI  R27,HIGH(_BuzzerRepeatCount)
	CALL SUBOPT_0x85
	CALL SUBOPT_0x9
	RJMP _0x20E001E
_0x20E001D:
	LDS  R30,_bEmoState
	CPI  R30,0
	BREQ PC+3
	JMP _0x20E0020
	LDS  R30,_bReturnSensor
	CPI  R30,0
	BREQ PC+3
	JMP _0x20E0020
	RJMP _0x20E001F
_0x20E0020:
	LDS  R30,_bRun
	CPI  R30,0
	BRNE PC+3
	JMP _0x20E0022
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0x20E0023
	CALL SUBOPT_0xCB
	RJMP _0x20E0024
_0x20E0023:
	CALL SUBOPT_0xCC
_0x20E0024:
_0x20E0022:
	RJMP _0x20E0025
_0x20E001F:
	LDS  R30,_bPressureFail
	CPI  R30,0
	BRNE PC+3
	JMP _0x20E0026
	LDS  R30,_bRun
	CPI  R30,0
	BREQ PC+3
	JMP _0x20E0027
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0x20E0028
	CALL SUBOPT_0xCB
	RJMP _0x20E0029
_0x20E0028:
	CALL SUBOPT_0xCC
_0x20E0029:
	RJMP _0x20E002A
_0x20E0027:
	CALL SUBOPT_0xCB
_0x20E002A:
	RJMP _0x20E002B
_0x20E0026:
	CALL SUBOPT_0xCC
_0x20E002B:
_0x20E0025:
_0x20E001E:
_0x20E001C:
_0x20E001A:
	RET
_CalibSubroutine:
	CALL SUBOPT_0x91
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+3,R30
	LDS  R30,_bCalib
	CPI  R30,0
	BRNE PC+3
	JMP _0x20E002C
	LDS  R30,_CalibStepDelay
	LDS  R31,_CalibStepDelay+1
	LDS  R22,_CalibStepDelay+2
	LDS  R23,_CalibStepDelay+3
	CALL __CPD10
	BRNE PC+3
	JMP _0x20E002D
	LDI  R26,LOW(_CalibStepDelay)
	LDI  R27,HIGH(_CalibStepDelay)
	CALL SUBOPT_0xF
	LDS  R26,_CalibStep
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x20E002E
	CALL SUBOPT_0x89
	CALL SUBOPT_0x8F
	__CPD2N 0x1C3
	BRSH PC+3
	JMP _0x20E002F
	CALL SUBOPT_0xCD
	CALL SUBOPT_0xCE
	CALL __ADDD12
	CALL SUBOPT_0x7E
	RJMP _0x20E0030
_0x20E002F:
	CALL SUBOPT_0xCD
	CALL SUBOPT_0xCE
	CALL __SUBD21
	STS  _CalItvMax,R26
	STS  _CalItvMax+1,R27
	STS  _CalItvMax+2,R24
	STS  _CalItvMax+3,R25
_0x20E0030:
_0x20E002E:
	RJMP _0x20E0031
_0x20E002D:
	LDS  R30,_CalibStep
	CPI  R30,0
	BREQ PC+3
	JMP _0x20E0035
	CALL SUBOPT_0xCF
	CALL _SetItv
	__GETD1N 0x5DC
	CALL SUBOPT_0x83
	CALL SUBOPT_0x1C
	CALL _SetBuzzer
	RJMP _0x20E0034
_0x20E0035:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x20E0036
	CALL SUBOPT_0xCF
	CALL SUBOPT_0x42
	CALL SUBOPT_0x23
	CALL SUBOPT_0x21
	CALL SUBOPT_0x7D
	LDI  R30,LOW(450)
	LDI  R31,HIGH(450)
	CALL SUBOPT_0x15
	__GETD1N 0x1F4
	CALL SUBOPT_0x83
	CALL SUBOPT_0x1C
	CALL _SetBuzzer
	RJMP _0x20E0034
_0x20E0036:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x20E0037
	LDS  R30,_CalibStep
	SUBI R30,-LOW(1)
	STS  _CalibStep,R30
	CALL SUBOPT_0x24
	CALL SUBOPT_0x7F
	CALL SUBOPT_0x16
	CALL SUBOPT_0xC
	CALL SUBOPT_0x83
	LDI  R30,LOW(0)
	STS  _bCalib,R30
	CALL SUBOPT_0x84
	RJMP _0x20E0034
_0x20E0037:
	CPI  R30,LOW(0xA)
	BREQ PC+3
	JMP _0x20E0038
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CALL SUBOPT_0x15
	RJMP _0x20E0034
_0x20E0038:
	CPI  R30,LOW(0xB)
	BREQ PC+3
	JMP _0x20E0039
	LDI  R30,LOW(900)
	LDI  R31,HIGH(900)
	CALL SUBOPT_0x15
	RJMP _0x20E0034
_0x20E0039:
	CPI  R30,LOW(0xC)
	BREQ PC+3
	JMP _0x20E003A
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CALL SUBOPT_0x15
	RJMP _0x20E0034
_0x20E003A:
	CPI  R30,LOW(0xD)
	BREQ PC+3
	JMP _0x20E0034
	LDI  R30,LOW(900)
	LDI  R31,HIGH(900)
	CALL SUBOPT_0x15
_0x20E0034:
_0x20E0031:
_0x20E002C:
	ADIW R28,4
	RET
_UserMain:
	CALL _RunSubroutine
	CALL _DisplaySubroutine
	CALL _BuzzerSubroutine
	CALL _CalibSubroutine
	LDS  R26,_KeyRunCount
	SUBI R26,-LOW(1)
	STS  _KeyRunCount,R26
	SUBI R26,LOW(1)
	CPI  R26,LOW(0xA)
	BRSH PC+3
	JMP _0x20E003C
	LDS  R26,_bAutoMode
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x20E003D
	CALL _StepPressureSubroutine
_0x20E003D:
	CALL _KeySubroutine
	LDI  R30,LOW(0)
	STS  _KeyRunCount,R30
	CALL _PressureRewardSubroutine
	CALL _PressureCheckSubroutine
	LDS  R30,_Sensor
	ANDI R30,LOW(0x20)
	BRNE PC+3
	JMP _0x20E003E
	LDI  R30,LOW(0)
	STS  _bDoorSensorFail,R30
	RJMP _0x20E003F
_0x20E003E:
	LDI  R30,LOW(1)
	STS  _bDoorSensorFail,R30
_0x20E003F:
	LDS  R30,_Sensor
	ANDI R30,LOW(0x10)
	BRNE PC+3
	JMP _0x20E0040
	LDI  R30,LOW(0)
	STS  _bSafeSensorFail,R30
	RJMP _0x20E0041
_0x20E0040:
	LDI  R30,LOW(1)
	STS  _bSafeSensorFail,R30
_0x20E0041:
	LDS  R30,_bRun
	CPI  R30,0
	BREQ PC+3
	JMP _0x20E0042
	LDI  R30,LOW(0)
	STS  _bReturnSensor,R30
	RJMP _0x20E0043
_0x20E0042:
	LDS  R30,_bRun
	CPI  R30,0
	BRNE PC+3
	JMP _0x20E0045
	LDS  R30,_bDoorSensorFail
	CPI  R30,0
	BREQ PC+3
	JMP _0x20E0046
	LDS  R30,_bSafeSensorFail
	CPI  R30,0
	BREQ PC+3
	JMP _0x20E0046
	RJMP _0x20E0045
_0x20E0046:
	RJMP _0x20E0048
_0x20E0045:
	RJMP _0x20E0044
_0x20E0048:
	LDI  R30,LOW(1)
	STS  _bReturnSensor,R30
_0x20E0044:
_0x20E0043:
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
_0x20E003C:
	RET
_HalfSecMain:
	ST   -Y,R17
	ST   -Y,R16
	LDS  R30,_bBlink
	CPI  R30,0
	BRNE PC+3
	JMP _0x20E0049
	LDS  R30,261
	ANDI R30,0xFE
	STS  261,R30
	RJMP _0x20E004A
_0x20E0049:
	LDS  R30,261
	ORI  R30,1
	STS  261,R30
_0x20E004A:
	LDS  R30,_bDebug
	CPI  R30,0
	BRNE PC+3
	JMP _0x20E004B
	__POINTW1FN _0x20E0000,191
	CALL SUBOPT_0x3C
	LDS  R30,_RunStep
	CALL SUBOPT_0x7
	CALL SUBOPT_0xE
	CALL __PUTPARD1
	LDI  R24,12
	CALL _Uartprintf0
	ADIW R28,14
	__POINTW1FN _0x20E0000,227
	CALL SUBOPT_0x3B
	LDS  R30,_ExtKey
	CALL SUBOPT_0x7
	LDS  R30,_Sensor
	CALL SUBOPT_0x7
	LDS  R30,_Emo
	CALL SUBOPT_0x7
	LDI  R24,16
	CALL _Uartprintf0
	ADIW R28,18
	__POINTW1FN _0x20E0000,286
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x7
	LDI  R24,4
	CALL _Uartprintf0
	ADIW R28,6
	__POINTW1FN _0x20E0000,303
	CALL SUBOPT_0xAE
	CALL SUBOPT_0x42
	CALL SUBOPT_0x43
	CALL SUBOPT_0x42
	CALL SUBOPT_0xD0
	__POINTW1FN _0x20E0000,303
	CALL SUBOPT_0xAE
	CALL SUBOPT_0x42
	CALL SUBOPT_0x43
	CALL SUBOPT_0x42
	CALL SUBOPT_0xD0
_0x20E004B:
	LD   R16,Y+
	LD   R17,Y+
	RET

	.CSEG

	.DSEG
_TickCount:
	.BYTE 0x2
_PressureTime:
	.BYTE 0x4
_Pressure:
	.BYTE 0x4
_PressureStep:
	.BYTE 0x2
_PressureStepDelay:
	.BYTE 0x2
_sPressureStepDelay:
	.BYTE 0x2
_CalItvMin:
	.BYTE 0x4
_CalItvMax:
	.BYTE 0x4
_bReturnSensor:
	.BYTE 0x1
_bDebug:
	.BYTE 0x1
_bCalib:
	.BYTE 0x1
_bLongKey:
	.BYTE 0x1
_CalibStep:
	.BYTE 0x1
_CalibStepDelay:
	.BYTE 0x4
_TestMode:
	.BYTE 0x1
_bAgingMode:
	.BYTE 0x1
_bAgingEnd:
	.BYTE 0x1
_bAutoMode:
	.BYTE 0x1
_bCylXIn:
	.BYTE 0x1
_bCylYDown:
	.BYTE 0x1
_bPressureFail:
	.BYTE 0x1
_bDoorSensorFail:
	.BYTE 0x1
_bSafeSensorFail:
	.BYTE 0x1
_bMenuDisplay:
	.BYTE 0x1
_bVarDisplay:
	.BYTE 0x1
_KeyRunCount:
	.BYTE 0x1
_bRun:
	.BYTE 0x1
_RunStep:
	.BYTE 0x1
_RunStepDelay:
	.BYTE 0x4
_RunStepTime:
	.BYTE 0x4
_mRunStepTime:
	.BYTE 0x4
_bRunAlarm:
	.BYTE 0x1
_Mode1Step:
	.BYTE 0x1
_sMode1Step:
	.BYTE 0x1
_HiddenStep:
	.BYTE 0x1
_SetupExitTime:
	.BYTE 0x2
_SetData:
	.BYTE 0x2
_Hidden1SetData:
	.BYTE 0x2
_BuzzerOnTime:
	.BYTE 0x2
_BuzzerOffTime:
	.BYTE 0x2
_BuzzerRepeatCount:
	.BYTE 0x2
_BuzzerOnCount:
	.BYTE 0x2
_BuzzerOffCount:
	.BYTE 0x2
_ReadPressure:
	.BYTE 0x4
_DownPressure:
	.BYTE 0x2
_bEmoState:
	.BYTE 0x1
_bDownPressureEnd:
	.BYTE 0x1
_bPressureReward:
	.BYTE 0x1
_QueueData:
	.BYTE 0x100
_QueueFirst:
	.BYTE 0x2
_QueueLast:
	.BYTE 0x2
_CommCommandBuffer:
	.BYTE 0x32
_CommCommandSize:
	.BYTE 0x2
_Key:
	.BYTE 0x1
_ExtKey:
	.BYTE 0x1
_Sensor:
	.BYTE 0x1
_Emo:
	.BYTE 0x1
_bBlink:
	.BYTE 0x1
_TactTimeCheckIn_S0000002:
	.BYTE 0x2
_TactTimeCheckOut_S0000002:
	.BYTE 0x2
_TactTimeCheckDown_S0000002:
	.BYTE 0x2
_TactTimeCheckUp_S0000002:
	.BYTE 0x2
_KeyDownCount_S0000004:
	.BYTE 0x1
_PrevDownKey_S0000004:
	.BYTE 0x1
__seed_G102:
	.BYTE 0x4
_p_S1030024:
	.BYTE 0x2
_bMainStart:
	.BYTE 0x1
_bHalfMainStart:
	.BYTE 0x1
_IntCount:
	.BYTE 0x2
_NewKey:
	.BYTE 0x1
_NewExtKey:
	.BYTE 0x1
_NewSensor:
	.BYTE 0x1
_NewEmo:
	.BYTE 0x1
_OldKey:
	.BYTE 0x1
_OldExtKey:
	.BYTE 0x1
_OldSensor:
	.BYTE 0x1
_OldEmo:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDS  R26,_QueueFirst
	LDS  R27,_QueueFirst+1
	CP   R16,R26
	CPC  R17,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x1:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _CommCommandSize,R30
	STS  _CommCommandSize+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	LDS  R30,_CommCommandSize
	LDS  R31,_CommCommandSize+1
	SBIW R30,1
	SUBI R30,LOW(-_CommCommandBuffer)
	SBCI R31,HIGH(-_CommCommandBuffer)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(_CommCommandBuffer)
	LDI  R31,HIGH(_CommCommandBuffer)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL _strncmpf
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:65 WORDS
SUBOPT_0x6:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _Uartprintf0
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:36 WORDS
SUBOPT_0x7:
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x8:
	STS  _BuzzerOnTime,R30
	STS  _BuzzerOnTime+1,R31
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	STS  _BuzzerOffTime,R30
	STS  _BuzzerOffTime+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x9:
	LDS  R30,_BuzzerOnTime
	LDS  R31,_BuzzerOnTime+1
	STS  _BuzzerOnCount,R30
	STS  _BuzzerOnCount+1,R31
	LDS  R30,_BuzzerOffTime
	LDS  R31,_BuzzerOffTime+1
	STS  _BuzzerOffCount,R30
	STS  _BuzzerOffCount+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 24 TIMES, CODE SIZE REDUCTION:43 WORDS
SUBOPT_0xA:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0xB:
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _SetItv

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xC:
	__GETD1N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:63 WORDS
SUBOPT_0xD:
	STS  _RunStepDelay,R30
	STS  _RunStepDelay+1,R31
	STS  _RunStepDelay+2,R22
	STS  _RunStepDelay+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xE:
	LDS  R30,_RunStepDelay
	LDS  R31,_RunStepDelay+1
	LDS  R22,_RunStepDelay+2
	LDS  R23,_RunStepDelay+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xF:
	CALL __GETD1P_INC
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
	CALL __PUTDP1_DEC
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 25 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0x10:
	__GETD1N 0xA
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x11:
	CALL __MODD21U
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x12:
	CALL SUBOPT_0xC
	STS  _RunStepTime,R30
	STS  _RunStepTime+1,R31
	STS  _RunStepTime+2,R22
	STS  _RunStepTime+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x13:
	STS  _RunStep,R30
	CALL SUBOPT_0x10
	RJMP SUBOPT_0xD

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x14:
	LDS  R30,264
	ORI  R30,1
	STS  264,R30
	LDS  R30,264
	ANDI R30,0xFD
	STS  264,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x15:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _SetItv

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x16:
	LDS  R30,_Pressure
	LDS  R31,_Pressure+1
	RJMP SUBOPT_0x15

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x17:
	LDS  R30,264
	ANDI R30,0xFB
	STS  264,R30
	LDS  R30,264
	ORI  R30,8
	STS  264,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x18:
	__GETD1N 0x64
	RJMP SUBOPT_0xD

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x19:
	LDS  R26,_PressureTime
	LDS  R27,_PressureTime+1
	LDS  R24,_PressureTime+2
	LDS  R25,_PressureTime+3
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x1A:
	LDS  R30,264
	ORI  R30,4
	STS  264,R30
	LDS  R30,264
	ANDI R30,0XF7
	STS  264,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1B:
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	JMP  _SetBuzzer

;OPTIMIZER ADDED SUBROUTINE, CALLED 26 TIMES, CODE SIZE REDUCTION:47 WORDS
SUBOPT_0x1C:
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1D:
	LDS  R30,264
	ORI  R30,2
	STS  264,R30
	LDS  R30,264
	ANDI R30,0xFE
	STS  264,R30
	LDI  R30,LOW(1)
	STS  _bVarDisplay,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _DownPressure,R30
	STS  _DownPressure+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1F:
	LDI  R30,LOW(1)
	ST   -Y,R30
	ST   -Y,R30
	JMP  _SetBuzzer

;OPTIMIZER ADDED SUBROUTINE, CALLED 25 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0x20:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x21:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x22:
	CALL _GetEeprom2
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x23:
	STS  _CalItvMin,R30
	STS  _CalItvMin+1,R31
	STS  _CalItvMin+2,R22
	STS  _CalItvMin+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x24:
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x25:
	CALL _GetEeprom4
	STS  _CalItvMax,R30
	STS  _CalItvMax+1,R31
	STS  _CalItvMax+2,R22
	STS  _CalItvMax+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x26:
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
	STS  _bVarDisplay,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x27:
	LDS  R30,264
	ORI  R30,2
	STS  264,R30
	LDS  R30,264
	ANDI R30,0xFE
	STS  264,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:57 WORDS
SUBOPT_0x28:
	CLR  R22
	CLR  R23
	STS  _mRunStepTime,R30
	STS  _mRunStepTime+1,R31
	STS  _mRunStepTime+2,R22
	STS  _mRunStepTime+3,R23
	LDS  R26,_mRunStepTime
	LDS  R27,_mRunStepTime+1
	LDS  R24,_mRunStepTime+2
	LDS  R25,_mRunStepTime+3
	CALL SUBOPT_0x10
	RJMP SUBOPT_0x11

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x29:
	LDI  R30,LOW(13)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 66 TIMES, CODE SIZE REDUCTION:257 WORDS
SUBOPT_0x2A:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _Lcdprintf
	ADIW R28,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x2B:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x2C:
	CALL __DIVD21U
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x2D:
	CALL __MODD21U
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x2E:
	LDS  R26,_Pressure
	LDS  R27,_Pressure+1
	LDS  R24,_Pressure+2
	LDS  R25,_Pressure+3
	__GETD1N 0x64
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2F:
	LDI  R30,LOW(12)
	ST   -Y,R30
	JMP  _LcdCommandWrite

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x30:
	__POINTW1FN _0x0,422
	RJMP SUBOPT_0x2A

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x31:
	__POINTW1FN _0x0,443
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xC
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x32:
	CALL __PUTPARD1
	LDI  R24,8
	CALL _Lcdprintf
	ADIW R28,12
	LDI  R30,LOW(15)
	ST   -Y,R30
	JMP  _LcdCommandWrite

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x33:
	__POINTW1FN _0x0,460
	RJMP SUBOPT_0x2A

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x34:
	LDI  R30,LOW(12)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	__POINTW1FN _0x0,493
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:35 WORDS
SUBOPT_0x35:
	__GETD1N 0x5
	CALL __PUTPARD1
	__GETD1N 0x32
	CALL __PUTPARD1
	LDI  R24,8
	CALL _Lcdprintf
	ADIW R28,12
	LDI  R30,LOW(12)
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	__POINTW1FN _0x0,501
	ST   -Y,R31
	ST   -Y,R30
	__GETD1N 0xB
	CALL __PUTPARD1
	__GETD1N 0x7
	CALL __PUTPARD1
	LDI  R24,8
	CALL _Lcdprintf
	ADIW R28,12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x36:
	CALL __PUTPARD1
	LDI  R24,8
	CALL _Lcdprintf
	ADIW R28,12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x37:
	LDI  R30,LOW(12)
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	__POINTW1FN _0x0,501
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x38:
	LDI  R24,8
	CALL _Lcdprintf
	ADIW R28,12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x39:
	CALL __PUTPARD1
	CALL SUBOPT_0x10
	RJMP SUBOPT_0x32

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3A:
	CALL _GetItv
	STS  _ReadPressure,R30
	STS  _ReadPressure+1,R31
	STS  _ReadPressure+2,R22
	STS  _ReadPressure+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3B:
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_Key
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3C:
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_bRun
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3D:
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_Mode1Step
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3E:
	LDI  R24,4
	CALL _Lcdprintf
	ADIW R28,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:77 WORDS
SUBOPT_0x3F:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	__POINTW1FN _0x0,680
	ST   -Y,R31
	ST   -Y,R30
	LDS  R26,_ReadPressure
	LDS  R27,_ReadPressure+1
	LDS  R24,_ReadPressure+2
	LDS  R25,_ReadPressure+3
	__GETD1N 0x64
	RJMP SUBOPT_0x2C

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:57 WORDS
SUBOPT_0x40:
	LDS  R26,_ReadPressure
	LDS  R27,_ReadPressure+1
	LDS  R24,_ReadPressure+2
	LDS  R25,_ReadPressure+3
	__GETD1N 0x64
	RJMP SUBOPT_0x2D

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x41:
	__POINTW1FN _0x0,739
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x42:
	CALL _Ltc1865Read
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x43:
	CALL __PUTPARD1
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x44:
	LDS  R30,_CalItvMin
	LDS  R31,_CalItvMin+1
	LDS  R22,_CalItvMin+2
	LDS  R23,_CalItvMin+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x45:
	CALL __PUTPARD1
	RJMP SUBOPT_0x3E

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x46:
	LDS  R30,_CalItvMax
	LDS  R31,_CalItvMax+1
	LDS  R22,_CalItvMax+2
	LDS  R23,_CalItvMax+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x47:
	LDI  R30,LOW(16)
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	__POINTW1FN _0x0,501
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x48:
	LDS  R26,_RunStepTime
	LDS  R27,_RunStepTime+1
	LDS  R24,_RunStepTime+2
	LDS  R25,_RunStepTime+3
	CALL SUBOPT_0x10
	CALL __DIVD21U
	MOVW R26,R30
	MOVW R24,R22
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x49:
	LDS  R26,_mRunStepTime
	LDS  R27,_mRunStepTime+1
	LDS  R24,_mRunStepTime+2
	LDS  R25,_mRunStepTime+3
	CALL SUBOPT_0x10
	CALL __DIVD21U
	MOVW R26,R30
	MOVW R24,R22
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 20 TIMES, CODE SIZE REDUCTION:35 WORDS
SUBOPT_0x4A:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4B:
	__POINTW1FN _0x0,726
	RJMP SUBOPT_0x2A

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4C:
	LDS  R26,_SetData
	LDS  R27,_SetData+1
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4D:
	CALL __DIVW21U
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4E:
	CALL __MODW21U
	CLR  R22
	CLR  R23
	RJMP SUBOPT_0x36

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4F:
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	JMP  _LineDecision

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x50:
	LDI  R30,LOW(12)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	__POINTW1FN _0x0,501
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x51:
	LDS  R26,_SetData
	LDS  R27,_SetData+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x52:
	LDS  R30,_Hidden1SetData
	LDS  R31,_Hidden1SetData+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x53:
	LDS  R26,_Hidden1SetData
	LDS  R27,_Hidden1SetData+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x54:
	LDS  R30,261
	ORI  R30,8
	STS  261,R30
	LDS  R30,261
	ANDI R30,0xEF
	STS  261,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x55:
	LDS  R30,261
	ORI  R30,8
	STS  261,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x56:
	LDS  R30,261
	ORI  R30,0x10
	STS  261,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x57:
	LDS  R30,261
	ORI  R30,4
	STS  261,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x58:
	LDS  R30,_SetData
	LDS  R31,_SetData+1
	ADIW R30,10
	STS  _SetData,R30
	STS  _SetData+1,R31
	LDS  R26,_SetData
	LDS  R27,_SetData+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x59:
	STS  _SetData,R30
	STS  _SetData+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x5A:
	LDI  R26,LOW(_SetData)
	LDI  R27,HIGH(_SetData)
	LD   R30,X+
	LD   R31,X+
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5B:
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	CPI  R30,LOW(0x259)
	LDI  R26,HIGH(0x259)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x5C:
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
	ADIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5D:
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	CPI  R30,LOW(0xC9)
	LDI  R26,HIGH(0xC9)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x5E:
	CALL SUBOPT_0x52
	ADIW R30,10
	STS  _Hidden1SetData,R30
	STS  _Hidden1SetData+1,R31
	LDS  R26,_Hidden1SetData
	LDS  R27,_Hidden1SetData+1
	SBIW R26,11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5F:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	STS  _Hidden1SetData,R30
	STS  _Hidden1SetData+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x60:
	LDI  R26,LOW(_Hidden1SetData)
	LDI  R27,HIGH(_Hidden1SetData)
	LD   R30,X+
	LD   R31,X+
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x61:
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x62:
	LDS  R26,_SetData
	LDS  R27,_SetData+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x63:
	LDS  R30,_SetData
	LDS  R31,_SetData+1
	SBIW R30,10
	RJMP SUBOPT_0x59

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x64:
	CALL SUBOPT_0x62
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x65:
	LDS  R26,_Hidden1SetData
	LDS  R27,_Hidden1SetData+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x66:
	CALL SUBOPT_0x52
	SBIW R30,10
	STS  _Hidden1SetData,R30
	STS  _Hidden1SetData+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x67:
	STS  _Hidden1SetData,R30
	STS  _Hidden1SetData+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x68:
	LDI  R30,LOW(0)
	STS  _Mode1Step,R30
	LDI  R30,LOW(1)
	STS  _bRun,R30
	LDI  R30,LOW(0)
	STS  _bRunAlarm,R30
	RJMP SUBOPT_0x26

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x69:
	STS  _PressureStep,R30
	STS  _PressureStep+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x6A:
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_PressureStep
	LDS  R31,_PressureStep+1
	ST   -Y,R31
	ST   -Y,R30
	JMP  _SetEeprom2

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6B:
	LDS  R30,_sPressureStepDelay
	LDS  R31,_sPressureStepDelay+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6C:
	CALL SUBOPT_0x67
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
	RJMP SUBOPT_0x1C

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6D:
	STS  _sPressureStepDelay,R30
	STS  _sPressureStepDelay+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6E:
	LDI  R30,LOW(18)
	LDI  R31,HIGH(18)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x6B
	ST   -Y,R31
	ST   -Y,R30
	JMP  _SetEeprom2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6F:
	STS  _HiddenStep,R30
	LDS  R30,_PressureStep
	LDS  R31,_PressureStep+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x70:
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	JMP  _SetEeprom2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x71:
	__GETD1N 0x226
	STS  _Pressure,R30
	STS  _Pressure+1,R31
	STS  _Pressure+2,R22
	STS  _Pressure+3,R23
	__GETD1N 0x75
	STS  _PressureTime,R30
	STS  _PressureTime+1,R31
	STS  _PressureTime+2,R22
	STS  _PressureTime+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x72:
	__GETD1N 0x12C
	STS  _Pressure,R30
	STS  _Pressure+1,R31
	STS  _Pressure+2,R22
	STS  _Pressure+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x73:
	__GETD1N 0x2E
	STS  _PressureTime,R30
	STS  _PressureTime+1,R31
	STS  _PressureTime+2,R22
	STS  _PressureTime+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x74:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x75:
	STS  _Pressure,R30
	STS  _Pressure+1,R31
	STS  _Pressure+2,R22
	STS  _Pressure+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x76:
	STS  _PressureTime,R30
	STS  _PressureTime+1,R31
	STS  _PressureTime+2,R22
	STS  _PressureTime+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x77:
	LDI  R30,LOW(5)
	STS  _Mode1Step,R30
	LDS  R30,_Pressure
	LDS  R31,_Pressure+1
	RJMP SUBOPT_0x59

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x78:
	LDS  R30,_Pressure
	LDS  R31,_Pressure+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _SetEeprom2
	RJMP SUBOPT_0x16

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x79:
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
	RJMP SUBOPT_0x1C

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7A:
	LDS  R30,_SetData
	LDS  R31,_SetData+1
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7B:
	LDS  R30,_PressureTime
	LDS  R31,_PressureTime+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7C:
	CALL SUBOPT_0x7B
	ST   -Y,R31
	ST   -Y,R30
	JMP  _SetEeprom2

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x7D:
	LDS  R30,_CalItvMin
	LDS  R31,_CalItvMin+1
	ST   -Y,R31
	ST   -Y,R30
	JMP  _SetEeprom2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7E:
	STS  _CalItvMax,R30
	STS  _CalItvMax+1,R31
	STS  _CalItvMax+2,R22
	STS  _CalItvMax+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7F:
	CALL SUBOPT_0x46
	CALL __PUTPARD1
	JMP  _SetEeprom4

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x80:
	LDS  R30,_Pressure
	LDS  R31,_Pressure+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x81:
	LDI  R30,LOW(1)
	STS  _bMenuDisplay,R30
	RJMP SUBOPT_0x20

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x82:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_bAutoMode
	RJMP SUBOPT_0x70

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x83:
	STS  _CalibStepDelay,R30
	STS  _CalibStepDelay+1,R31
	STS  _CalibStepDelay+2,R22
	STS  _CalibStepDelay+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x84:
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _SetBuzzer

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x85:
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x86:
	LDS  R26,_Pressure
	LDS  R27,_Pressure+1
	LDS  R24,_Pressure+2
	LDS  R25,_Pressure+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x87:
	LDS  R30,_Pressure
	LDS  R31,_Pressure+1
	LDS  R22,_Pressure+2
	LDS  R23,_Pressure+3
	LDS  R26,_DownPressure
	LDS  R27,_DownPressure+1
	CLR  R24
	CLR  R25
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x88:
	LDS  R26,_RunStepTime
	LDS  R27,_RunStepTime+1
	LDS  R24,_RunStepTime+2
	LDS  R25,_RunStepTime+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x89:
	CALL _GetItv
	__PUTD1S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x8A:
	__GETD1S 0
	RJMP SUBOPT_0x86

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x8B:
	CALL __SWAPD12
	CALL __SUBD12
	ST   -Y,R31
	ST   -Y,R30
	CALL _abs
	CALL SUBOPT_0x86
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8C:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _abs

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x8D:
	__GETD1S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:31 WORDS
SUBOPT_0x8E:
	__PUTD1S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x8F:
	__GETD2S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x90:
	CALL __SWAPD12
	CALL __SUBF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x91:
	SBIW R28,4
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x92:
	ST   -Y,R31
	ST   -Y,R30
	CALL _strcpyf
	CALL __LOADLOCR4
	ADIW R28,16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x93:
	__GETD2S 4
	__GETD1N 0x41200000
	CALL __MULF12
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x94:
	__GETD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x95:
	__GETD1S 4
	__GETD2S 12
	CALL __CMPF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x96:
	__GETD2S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x97:
	__GETD1N 0x3DCCCCCD
	CALL __MULF12
	__PUTD1S 12
	SUBI R19,-LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x98:
	__GETD1N 0x41200000
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x99:
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x9A:
	__GETD2N 0x3F000000
	CALL __ADDF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x9B:
	__GETD1N 0x3DCCCCCD
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x9C:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,1
	STD  Y+8,R26
	STD  Y+8+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9D:
	MOV  R30,R16
	SUBI R30,-LOW(48)
	ST   X,R30
	MOV  R30,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x9E:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:36 WORDS
SUBOPT_0x9F:
	ST   -Y,R18
	__GETW1SX 87
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,19
	ST   -Y,R31
	ST   -Y,R30
	JMP  __put_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0xA0:
	__GETW1SX 88
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0xA1:
	SBIW R30,4
	__PUTW1SX 88
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:57 WORDS
SUBOPT_0xA2:
	__GETW1SX 87
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,19
	ST   -Y,R31
	ST   -Y,R30
	JMP  __put_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0xA3:
	__GETW2SX 88
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA4:
	CALL __GETD1P
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xA5:
	CALL SUBOPT_0xA0
	RJMP SUBOPT_0xA1

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA6:
	__GETD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xA7:
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA8:
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ADIW R30,1
	STD  Y+10,R30
	STD  Y+10+1,R31
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xA9:
	STD  Y+10,R30
	STD  Y+10+1,R31
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen
	MOV  R17,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xAA:
	CALL SUBOPT_0xA3
	ADIW R26,4
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0xAB:
	ANDI R16,LOW(251)
	LDD  R30,Y+19
	ST   -Y,R30
	__GETW1SX 87
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	SUBI R30,LOW(-(87))
	SBCI R31,HIGH(-(87))
	ST   -Y,R31
	ST   -Y,R30
	CALL __put_G101
	CPI  R21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xAC:
	CALL SUBOPT_0x94
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xAD:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xAE:
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xAF:
	ST   -Y,R31
	ST   -Y,R30
	CALL _strcpyf
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xB0:
	__PUTD1S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xB1:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,1
	STD  Y+6,R26
	STD  Y+6+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB2:
	__GETD2S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB3:
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xB4:
	__GETD1S 2
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB5:
	__GETD2S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xB6:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB7:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB8:
	ST   -Y,R17
	ST   -Y,R16
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB9:
	__GETD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xBA:
	ST   -Y,R30
	CALL _SetEeprom
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xBB:
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xB9

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xBC:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _GetEeprom

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xBD:
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+3,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xBE:
	CALL SUBOPT_0x8E
	CALL SUBOPT_0x8F
	LDI  R30,LOW(8)
	CALL __LSLD12
	CALL SUBOPT_0x8E
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xBF:
	CALL SUBOPT_0x8F
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __ORD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC0:
	CALL SUBOPT_0x8E
	RJMP SUBOPT_0x8F

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC1:
	CALL SUBOPT_0x8E
	RJMP SUBOPT_0x8D

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0xC2:
	MOV  R15,R24
	SBIW R28,63
	SBIW R28,37
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	SUBI R26,LOW(-(98))
	SBCI R27,HIGH(-(98))
	CALL __ADDW2R15
	MOVW R16,R26
	MOVW R30,R28
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	SUBI R26,LOW(-(104))
	SBCI R27,HIGH(-(104))
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	JMP  _vsprintf

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC3:
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _Delay

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xC4:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _Delay

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xC5:
	LDI  R30,LOW(5000)
	LDI  R31,HIGH(5000)
	RJMP SUBOPT_0xC4

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xC6:
	MOVW R26,R28
	SUBI R26,LOW(-(105))
	SBCI R27,HIGH(-(105))
	CALL __ADDW2R15
	LD   R30,X
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC7:
	LDS  R26,_CalItvMin
	LDS  R27,_CalItvMin+1
	LDS  R24,_CalItvMin+2
	LDS  R25,_CalItvMin+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC8:
	LDI  R30,LOW(2000)
	LDI  R31,HIGH(2000)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _DelayMs

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xC9:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _GetEeprom2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xCA:
	__GETD1N 0x75
	CALL SUBOPT_0x76
	__GETD1N 0x226
	RJMP SUBOPT_0x75

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xCB:
	LDS  R30,261
	ORI  R30,0x20
	STS  261,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xCC:
	LDS  R30,261
	ANDI R30,0xDF
	STS  261,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xCD:
	CALL SUBOPT_0x8D
	__SUBD1N 450
	RJMP SUBOPT_0x8C

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xCE:
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	LDS  R26,_CalItvMax
	LDS  R27,_CalItvMax+1
	LDS  R24,_CalItvMax+2
	LDS  R25,_CalItvMax+3
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xCF:
	LDS  R30,_CalibStep
	SUBI R30,-LOW(1)
	STS  _CalibStep,R30
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD0:
	CALL __PUTPARD1
	LDI  R24,8
	CALL _Uartprintf0
	ADIW R28,10
	RET


	.CSEG
__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ADDD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	RET

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__SUBD21:
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	RET

__ORD12:
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSRW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSRW12R
__LSRW12L:
	LSR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRW12L
__LSRW12R:
	RET

__LSLD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSLD12R
__LSLD12L:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R0
	BRNE __LSLD12L
__LSLD12R:
	RET

__LSRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSRD12R
__LSRD12L:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRD12L
__LSRD12R:
	RET

__LSRD16:
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	RET

__CBD1:
	MOV  R31,R30
	ADD  R31,R31
	SBC  R31,R31
	MOV  R22,R31
	MOV  R23,R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__LNEGB1:
	TST  R30
	LDI  R30,1
	BREQ __LNEGB1F
	CLR  R30
__LNEGB1F:
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__DIVB21U:
	CLR  R0
	LDI  R25,8
__DIVB21U1:
	LSL  R26
	ROL  R0
	SUB  R0,R30
	BRCC __DIVB21U2
	ADD  R0,R30
	RJMP __DIVB21U3
__DIVB21U2:
	SBR  R26,1
__DIVB21U3:
	DEC  R25
	BRNE __DIVB21U1
	MOV  R30,R26
	MOV  R26,R0
	RET

__DIVB21:
	RCALL __CHKSIGNB
	RCALL __DIVB21U
	BRTC __DIVB211
	NEG  R30
__DIVB211:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODB21:
	CLT
	SBRS R26,7
	RJMP __MODB211
	NEG  R26
	SET
__MODB211:
	SBRC R30,7
	NEG  R30
	RCALL __DIVB21U
	MOV  R30,R26
	BRTC __MODB212
	NEG  R30
__MODB212:
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__CHKSIGNB:
	CLT
	SBRS R30,7
	RJMP __CHKSB1
	NEG  R30
	SET
__CHKSB1:
	SBRS R26,7
	RJMP __CHKSB2
	NEG  R26
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSB2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__GETD1P_INC:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	RET

__PUTDP1_DEC:
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF129
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

__CPD12:
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	RET

__CPD21:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
