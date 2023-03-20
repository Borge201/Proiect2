
;CodeVisionAVR C Compiler V3.29 Evaluation
;(C) Copyright 1998-2016 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega164P
;Program type           : Application
;Clock frequency        : 10.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega164P
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

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
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
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

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x04FF
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

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
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
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
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
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

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
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

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
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

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
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
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
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

	.MACRO __PUTBSR
	STD  Y+@1,R@0
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
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
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

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
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
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
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
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
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

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _nrTotalPuls=R4
	.DEF _contorIn=R3
	.DEF _contorSec=R6
	.DEF _contorMin=R5
	.DEF _contorHr=R8
	.DEF _val_afisor=R7
	.DEF _button_pressed=R10
	.DEF _check_pulse=R9
	.DEF _cont_pulse=R12
	.DEF _in_semnal_p=R11

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

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
	JMP  _timer0_ovf_isr
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

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x1,0x0,0x0
	.DB  0x0,0x0


__GLOBAL_INI_TBL:
	.DW  0x0A
	.DW  0x03
	.DW  __REG_VARS*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
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

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x200

	.CSEG
;/*******************************************************
;This program was created by the CodeWizardAVR V3.29
;Automatic Program Generator
;© Copyright 1998-2016 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : PLEASE_GOD_HELP_ME
;Version :
;Date    : 16/03/2023
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega164P
;Program type            : Application
;AVR Core Clock frequency: 10.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
;
;#include <io.h>
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
;// Declare your global variables here
;
;// Timer 0 overflow interrupt service routine
;//tine minte logica invers
;char nrTotalPuls = 0;  //valoarea initiala
;char arrayOre[24]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
;char contorIn=0;
;char contorSec=0;
;char contorMin=0;
;char contorHr=1;
;char val_afisor;
;// variabila de verificare a butonului
;char button_pressed;
;char check_pulse; //modifica pini conform cerintei
;char cont_pulse=0;
;char in_semnal_p;
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 002A {

	.CSEG
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 002B // Reinitialize Timer 0 value
; 0000 002C TCNT0=0x63;
	LDI  R30,LOW(99)
	OUT  0x26,R30
; 0000 002D //artificiu pentru demonstrare in simulator nu vrea sai mearga
; 0000 002E //pe orice alta frecventa
; 0000 002F //pentru frecventa de 20MHz TCNT0 ar trebui sa fie (pune aici vaoarea in hexa dorita pentru 10.086 ms)
; 0000 0030 // Place your code here
; 0000 0031 contorIn=contorIn+1;
	INC  R3
; 0000 0032 if(contorIn%25==0){
	MOV  R26,R3
	CLR  R27
	LDI  R30,LOW(25)
	LDI  R31,HIGH(25)
	RCALL __MODW21
	SBIW R30,0
	BRNE _0x3
; 0000 0033 // contorIn pentru 4MHz si TCNT0 ales numara o secunda odata ce ajunge la valoarea de 25
; 0000 0034 //pentru 20Mhz ar trebui sa fie 100
; 0000 0035     contorSec=contorSec+1;
	INC  R6
; 0000 0036     contorIn=0;
	CLR  R3
; 0000 0037 }
; 0000 0038 if(contorSec%60==0){
_0x3:
	MOV  R26,R6
	RCALL SUBOPT_0x0
	BRNE _0x4
; 0000 0039     contorMin=contorMin+1;
	INC  R5
; 0000 003A     contorSec=0;
	CLR  R6
; 0000 003B }
; 0000 003C if(contorMin%60==0){
_0x4:
	MOV  R26,R5
	RCALL SUBOPT_0x0
	BRNE _0x5
; 0000 003D contorHr=contorHr+1;
	INC  R8
; 0000 003E contorMin=0;
	CLR  R5
; 0000 003F }
; 0000 0040 arrayOre[contorHr]=nrTotalPuls;
_0x5:
	MOV  R30,R8
	LDI  R31,0
	SUBI R30,LOW(-_arrayOre)
	SBCI R31,HIGH(-_arrayOre)
	ST   Z,R4
; 0000 0041  if(contorHr%24==0){
	MOV  R26,R8
	CLR  R27
	LDI  R30,LOW(24)
	LDI  R31,HIGH(24)
	RCALL __MODW21
	SBIW R30,0
	BRNE _0x6
; 0000 0042   contorHr=1;
	LDI  R30,LOW(1)
	MOV  R8,R30
; 0000 0043   }
; 0000 0044 
; 0000 0045 
; 0000 0046 }
_0x6:
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
; .FEND
;
;
;
;
;
;
;char get_Curent_state(void)
; 0000 004E  {    //citim cei 6 biti de la dsp pentru valoarea curentului
_get_Curent_state:
; .FSTART _get_Curent_state
; 0000 004F   unsigned char val;
; 0000 0050 
; 0000 0051   val=PINB & 0b11000000;    //schimba in port C
	ST   -Y,R17
;	val -> R17
	IN   R30,0x3
	ANDI R30,LOW(0xC0)
	MOV  R17,R30
; 0000 0052   val=val<<2;
	LSL  R17
	LSL  R17
; 0000 0053   val=2>>val;
	MOV  R30,R17
	LDI  R26,LOW(2)
	RCALL __LSRB12
	MOV  R17,R30
; 0000 0054   //shiftam biti pentru a avea doar codul de stare pentru LEDuri
; 0000 0055   return val;
	RJMP _0x2000002
; 0000 0056  }
; .FEND
;
;void LED_Stare_Curent(void)
; 0000 0059 {char LEDstate;
_LED_Stare_Curent:
; .FSTART _LED_Stare_Curent
; 0000 005A LEDstate=get_Curent_state();
	ST   -Y,R17
;	LEDstate -> R17
	RCALL _get_Curent_state
	MOV  R17,R30
; 0000 005B  if(LEDstate==0b11111110){   //schimba in port D2, D3, D4
	CPI  R17,254
	BRNE _0x7
; 0000 005C  PORTB=0b11111110;
	LDI  R30,LOW(254)
	RJMP _0x2E
; 0000 005D  }else if(LEDstate==0b11111101){
_0x7:
	CPI  R17,253
	BRNE _0x9
; 0000 005E  PORTB=0b11111101;
	LDI  R30,LOW(253)
	RJMP _0x2E
; 0000 005F  }else if(LEDstate==0b11111011){
_0x9:
	CPI  R17,251
	BRNE _0xB
; 0000 0060  PORTB=0b11111011;
	LDI  R30,LOW(251)
	RJMP _0x2E
; 0000 0061  }
; 0000 0062  else {
_0xB:
; 0000 0063  PORTB=0xFF;// nu ne afiseaza niciun led
	LDI  R30,LOW(255)
_0x2E:
	OUT  0x5,R30
; 0000 0064  }
; 0000 0065 //aceasta functie preia valoarea trimisa de dsp( valorile sunt intre anumite nivele
; 0000 0066 //exemplu nivel 0 (LED0) corespunde unei valori intre (10mA-100mA) s.s.m.d.
; 0000 0067 }
_0x2000002:
	LD   R17,Y+
	RET
; .FEND
;/*
;void Afisor_2Cifre(int value){  //vei lua PORTA complet, PortD7,portB 0->4 14 biti pentur 2 cifre 7 biti din port A o sa ...
;//placeholder pentru porti liberi pentru 2 cifre
; cifra0=value%10;
; cifra1=(value/10)%10;
;if(cifra0==0)
;esle if(cifra0==1)
;else if(cifra0==2)
;else if(cifra0==3)
;else if(cifra0==4)
;else if(cifra0==5)
;else if(cifra0==6)
;else if(cifra0==7)
;else if(cifra0==8)
;else if(cifra0==9)
;
;if(cifra1==0)
;else if(cifra1==1)
;else if(cifra1==2)
;else if(cifra1==3)
;else if(cifra1==4)
;else if(cifra1==5)
;else if(cifra1==6)
;else if(cifra1==7)
;else if(cifra1==8)
;else if(cifra1==8)
;}
;*/
;
;
;
;char ValAfisorButon(void){
; 0000 0087 char ValAfisorButon(void){
_ValAfisorButon:
; .FSTART _ValAfisorButon
; 0000 0088 char SUMA;
; 0000 0089 //ar trebui sa ma mai gandesc cu butonul ca un fel de multi switch ca nu e un switch
; 0000 008A //ar trebui sa il pun intr-o
; 0000 008B char buffer_calc;
; 0000 008C char i;
; 0000 008D if(button_pressed==0)//buton apasat   butonul este PportD5, cu portD6 allways on
	RCALL __SAVELOCR4
;	SUMA -> R17
;	buffer_calc -> R16
;	i -> R19
	TST  R10
	BRNE _0xD
; 0000 008E //fa astfel incat daca butonul a fost apasat sa ne arate 12 ore de consum cat timp e apasat si daca "nu a fost apasat" s ...
; 0000 008F  {
; 0000 0090   SUMA=0;
	LDI  R17,LOW(0)
; 0000 0091   if(contorHr>8)
	LDI  R30,LOW(8)
	CP   R30,R8
	BRSH _0xE
; 0000 0092   {      buffer_calc=contorHr-8;
	MOV  R30,R8
	SUBI R30,LOW(8)
	MOV  R16,R30
; 0000 0093   for(i=buffer_calc;i<=contorHr;i++)
	MOV  R19,R16
_0x10:
	CP   R8,R19
	BRLO _0x11
; 0000 0094   {   SUMA=SUMA+arrayOre[i];
	RCALL SUBOPT_0x1
; 0000 0095   }
	SUBI R19,-1
	RJMP _0x10
_0x11:
; 0000 0096   }
; 0000 0097   else{
	RJMP _0x12
_0xE:
; 0000 0098     buffer_calc=8-contorHr;
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x2
; 0000 0099     for(i=24-buffer_calc;i<=24;i++)
_0x14:
	CPI  R19,25
	BRSH _0x15
; 0000 009A     { SUMA=SUMA+arrayOre[i];
	RCALL SUBOPT_0x1
; 0000 009B     }
	SUBI R19,-1
	RJMP _0x14
_0x15:
; 0000 009C     for(i=1;i<=contorHr;i++){
	LDI  R19,LOW(1)
_0x17:
	CP   R8,R19
	BRLO _0x18
; 0000 009D     SUMA=SUMA+arrayOre[i];}
	RCALL SUBOPT_0x1
	SUBI R19,-1
	RJMP _0x17
_0x18:
; 0000 009E   }
_0x12:
; 0000 009F   return val_afisor=SUMA;
	MOV  R30,R17
	MOV  R7,R30
	RJMP _0x2000001
; 0000 00A0   //sfarsitul functiei de 24 de ore
; 0000 00A1  }
; 0000 00A2    else
_0xD:
; 0000 00A3   {SUMA=0;
	LDI  R17,LOW(0)
; 0000 00A4 
; 0000 00A5   if(contorHr>4)
	LDI  R30,LOW(4)
	CP   R30,R8
	BRSH _0x1A
; 0000 00A6    {
; 0000 00A7    buffer_calc=contorHr-4;
	MOV  R30,R8
	SUBI R30,LOW(4)
	MOV  R16,R30
; 0000 00A8     for(i=buffer_calc;i<=contorHr;i++)
	MOV  R19,R16
_0x1C:
	CP   R8,R19
	BRLO _0x1D
; 0000 00A9       {
; 0000 00AA       SUMA=SUMA+arrayOre[i];
	RCALL SUBOPT_0x1
; 0000 00AB       }
	SUBI R19,-1
	RJMP _0x1C
_0x1D:
; 0000 00AC     }
; 0000 00AD     else  {
	RJMP _0x1E
_0x1A:
; 0000 00AE        buffer_calc=4-contorHr;
	LDI  R30,LOW(4)
	RCALL SUBOPT_0x2
; 0000 00AF        for(i=24-buffer_calc;i<=24;i++)
_0x20:
	CPI  R19,25
	BRSH _0x21
; 0000 00B0         {
; 0000 00B1         SUMA=SUMA+arrayOre[i];
	RCALL SUBOPT_0x1
; 0000 00B2         }
	SUBI R19,-1
	RJMP _0x20
_0x21:
; 0000 00B3        for(i=1;i<=contorHr;i++)
	LDI  R19,LOW(1)
_0x23:
	CP   R8,R19
	BRLO _0x24
; 0000 00B4        {
; 0000 00B5        SUMA=SUMA+arrayOre[i];
	RCALL SUBOPT_0x1
; 0000 00B6        }
	SUBI R19,-1
	RJMP _0x23
_0x24:
; 0000 00B7      // ar trebui sa ne arate consumul de kWh pentru ultimele 4 ore cat timp apasam
; 0000 00B8         }
_0x1E:
; 0000 00B9    return val_afisor=SUMA;
	MOV  R30,R17
	MOV  R7,R30
; 0000 00BA   }
; 0000 00BB }
_0x2000001:
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
;
;
;
;
;
;
;
;
;
;void main(void)
; 0000 00C6 {
_main:
; .FSTART _main
; 0000 00C7 // Declare your local variables here
; 0000 00C8 
; 0000 00C9 // Crystal Oscillator division factor: 1
; 0000 00CA #pragma optsize-
; 0000 00CB CLKPR=(1<<CLKPCE);
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 00CC CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 00CD #ifdef _OPTIMIZE_SIZE_
; 0000 00CE #pragma optsize+
; 0000 00CF #endif
; 0000 00D0 
; 0000 00D1 // Input/Output Ports initialization
; 0000 00D2 // Port A initialization
; 0000 00D3 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00D4 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	OUT  0x1,R30
; 0000 00D5 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00D6 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x2,R30
; 0000 00D7 
; 0000 00D8 // Port B initialization
; 0000 00D9 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 00DA DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(255)
	OUT  0x4,R30
; 0000 00DB // State: Bit7=1 Bit6=1 Bit5=1 Bit4=1 Bit3=1 Bit2=1 Bit1=1 Bit0=1
; 0000 00DC PORTB=(1<<PORTB7) | (1<<PORTB6) | (1<<PORTB5) | (1<<PORTB4) | (1<<PORTB3) | (1<<PORTB2) | (1<<PORTB1) | (1<<PORTB0);
	OUT  0x5,R30
; 0000 00DD 
; 0000 00DE // Port C initialization
; 0000 00DF // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00E0 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0000 00E1 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00E2 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x8,R30
; 0000 00E3 
; 0000 00E4 // Port D initialization
; 0000 00E5 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00E6 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0xA,R30
; 0000 00E7 // State: Bit7=P Bit6=P Bit5=P Bit4=T Bit3=P Bit2=P Bit1=T Bit0=P
; 0000 00E8 PORTD=(1<<PORTD7) | (1<<PORTD6) | (1<<PORTD5) | (0<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (0<<PORTD1) | (1<<PORTD0);
	LDI  R30,LOW(237)
	OUT  0xB,R30
; 0000 00E9 
; 0000 00EA // Timer/Counter 0 initialization
; 0000 00EB // Clock source: System Clock
; 0000 00EC // Clock value: 9.766 kHz
; 0000 00ED // Mode: Normal top=0xFF
; 0000 00EE // OC0A output: Disconnected
; 0000 00EF // OC0B output: Disconnected
; 0000 00F0 // Timer Period: 20.07 ms
; 0000 00F1 TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 00F2 TCCR0B=(0<<WGM02) | (1<<CS02) | (0<<CS01) | (1<<CS00);
	LDI  R30,LOW(5)
	OUT  0x25,R30
; 0000 00F3 TCNT0=0x3C;
	LDI  R30,LOW(60)
	OUT  0x26,R30
; 0000 00F4 OCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0000 00F5 OCR0B=0x00;
	OUT  0x28,R30
; 0000 00F6 
; 0000 00F7 // Timer/Counter 1 initialization
; 0000 00F8 // Clock source: System Clock
; 0000 00F9 // Clock value: Timer1 Stopped
; 0000 00FA // Mode: Normal top=0xFFFF
; 0000 00FB // OC1A output: Disconnected
; 0000 00FC // OC1B output: Disconnected
; 0000 00FD // Noise Canceler: Off
; 0000 00FE // Input Capture on Falling Edge
; 0000 00FF // Timer1 Overflow Interrupt: Off
; 0000 0100 // Input Capture Interrupt: Off
; 0000 0101 // Compare A Match Interrupt: Off
; 0000 0102 // Compare B Match Interrupt: Off
; 0000 0103 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	STS  128,R30
; 0000 0104 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	STS  129,R30
; 0000 0105 TCNT1H=0x00;
	STS  133,R30
; 0000 0106 TCNT1L=0x00;
	STS  132,R30
; 0000 0107 ICR1H=0x00;
	STS  135,R30
; 0000 0108 ICR1L=0x00;
	STS  134,R30
; 0000 0109 OCR1AH=0x00;
	STS  137,R30
; 0000 010A OCR1AL=0x00;
	STS  136,R30
; 0000 010B OCR1BH=0x00;
	STS  139,R30
; 0000 010C OCR1BL=0x00;
	STS  138,R30
; 0000 010D 
; 0000 010E // Timer/Counter 2 initialization
; 0000 010F // Clock source: System Clock
; 0000 0110 // Clock value: Timer2 Stopped
; 0000 0111 // Mode: Normal top=0xFF
; 0000 0112 // OC2A output: Disconnected
; 0000 0113 // OC2B output: Disconnected
; 0000 0114 ASSR=(0<<EXCLK) | (0<<AS2);
	STS  182,R30
; 0000 0115 TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (0<<COM2B1) | (0<<COM2B0) | (0<<WGM21) | (0<<WGM20);
	STS  176,R30
; 0000 0116 TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	STS  177,R30
; 0000 0117 TCNT2=0x00;
	STS  178,R30
; 0000 0118 OCR2A=0x00;
	STS  179,R30
; 0000 0119 OCR2B=0x00;
	STS  180,R30
; 0000 011A 
; 0000 011B // Timer/Counter 0 Interrupt(s) initialization
; 0000 011C TIMSK0=(0<<OCIE0B) | (0<<OCIE0A) | (1<<TOIE0);
	LDI  R30,LOW(1)
	STS  110,R30
; 0000 011D 
; 0000 011E // Timer/Counter 1 Interrupt(s) initialization
; 0000 011F TIMSK1=(0<<ICIE1) | (0<<OCIE1B) | (0<<OCIE1A) | (0<<TOIE1);
	LDI  R30,LOW(0)
	STS  111,R30
; 0000 0120 
; 0000 0121 // Timer/Counter 2 Interrupt(s) initialization
; 0000 0122 TIMSK2=(0<<OCIE2B) | (0<<OCIE2A) | (0<<TOIE2);
	STS  112,R30
; 0000 0123 
; 0000 0124 // External Interrupt(s) initialization
; 0000 0125 // INT0: Off
; 0000 0126 // INT1: Off
; 0000 0127 // INT2: Off
; 0000 0128 // Interrupt on any change on pins PCINT0-7: Off
; 0000 0129 // Interrupt on any change on pins PCINT8-15: Off
; 0000 012A // Interrupt on any change on pins PCINT16-23: Off
; 0000 012B // Interrupt on any change on pins PCINT24-31: Off
; 0000 012C EICRA=(0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	STS  105,R30
; 0000 012D EIMSK=(0<<INT2) | (0<<INT1) | (0<<INT0);
	OUT  0x1D,R30
; 0000 012E PCICR=(0<<PCIE3) | (0<<PCIE2) | (0<<PCIE1) | (0<<PCIE0);
	STS  104,R30
; 0000 012F 
; 0000 0130 // USART0 initialization
; 0000 0131 // USART0 disabled
; 0000 0132 UCSR0B=(0<<RXCIE0) | (0<<TXCIE0) | (0<<UDRIE0) | (0<<RXEN0) | (0<<TXEN0) | (0<<UCSZ02) | (0<<RXB80) | (0<<TXB80);
	STS  193,R30
; 0000 0133 
; 0000 0134 // USART1 initialization
; 0000 0135 // USART1 disabled
; 0000 0136 UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
	STS  201,R30
; 0000 0137 
; 0000 0138 // Analog Comparator initialization
; 0000 0139 // Analog Comparator: Off
; 0000 013A // The Analog Comparator's positive input is
; 0000 013B // connected to the AIN0 pin
; 0000 013C // The Analog Comparator's negative input is
; 0000 013D // connected to the AIN1 pin
; 0000 013E ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 013F ADCSRB=(0<<ACME);
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 0140 // Digital input buffer on AIN0: On
; 0000 0141 // Digital input buffer on AIN1: On
; 0000 0142 DIDR1=(0<<AIN0D) | (0<<AIN1D);
	STS  127,R30
; 0000 0143 
; 0000 0144 // ADC initialization
; 0000 0145 // ADC disabled
; 0000 0146 ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	STS  122,R30
; 0000 0147 
; 0000 0148 // SPI initialization
; 0000 0149 // SPI disabled
; 0000 014A SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0x2C,R30
; 0000 014B 
; 0000 014C // TWI initialization
; 0000 014D // TWI disabled
; 0000 014E TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	STS  188,R30
; 0000 014F 
; 0000 0150 // Globally enable interrupts
; 0000 0151 #asm("sei")
	SEI
; 0000 0152  check_pulse=PINC.0;//portile pentru primirea datelor
	LDI  R30,0
	SBIC 0x6,0
	LDI  R30,1
	MOV  R9,R30
; 0000 0153  in_semnal_p=PINC.1;
	LDI  R30,0
	SBIC 0x6,1
	LDI  R30,1
	MOV  R11,R30
; 0000 0154 while (1)
_0x25:
; 0000 0155       {
; 0000 0156       LED_Stare_Curent();
	RCALL _LED_Stare_Curent
; 0000 0157       if(check_pulse==0 ) //fal portC.0
	TST  R9
	BRNE _0x28
; 0000 0158       {
; 0000 0159         cont_pulse=0;
	CLR  R12
; 0000 015A         while(check_pulse!=1) // fal port C.1
_0x29:
	LDI  R30,LOW(1)
	CP   R30,R9
	BREQ _0x2B
; 0000 015B           {if(in_semnal_p==0) // DSP ar trebui sa trimita semnal de genul 1110111
	TST  R11
	BRNE _0x2C
; 0000 015C             {
; 0000 015D             cont_pulse=cont_pulse+1;
	INC  R12
; 0000 015E             }
; 0000 015F           }
_0x2C:
	RJMP _0x29
_0x2B:
; 0000 0160       }
; 0000 0161       nrTotalPuls=cont_pulse;
_0x28:
	MOV  R4,R12
; 0000 0162       ValAfisorButon();
	RCALL _ValAfisorButon
; 0000 0163       }
	RJMP _0x25
; 0000 0164  }
_0x2D:
	RJMP _0x2D
; .FEND

	.DSEG
_arrayOre:
	.BYTE 0x18

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x0:
	CLR  R27
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	RCALL __MODW21
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x1:
	MOV  R30,R19
	LDI  R31,0
	SUBI R30,LOW(-_arrayOre)
	SBCI R31,HIGH(-_arrayOre)
	LD   R30,Z
	ADD  R17,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	SUB  R30,R8
	MOV  R16,R30
	LDI  R30,LOW(24)
	SUB  R30,R16
	MOV  R19,R30
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__LSRB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSRB12R
__LSRB12L:
	LSR  R30
	DEC  R0
	BRNE __LSRB12L
__LSRB12R:
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

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	NEG  R27
	NEG  R26
	SBCI R27,0
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

;END OF CODE MARKER
__END_OF_CODE:
