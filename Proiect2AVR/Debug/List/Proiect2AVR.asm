
;CodeVisionAVR C Compiler V3.29 Evaluation
;(C) Copyright 1998-2016 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega164P
;Program type           : Application
;Clock frequency        : 20.000000 MHz
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
	.DEF _contorIn=R4
	.DEF _contorSec=R3
	.DEF _contorMin=R6
	.DEF _contorHr=R5
	.DEF _val_afisor=R8
	.DEF _cont_pulse=R7
	.DEF _totalConsum=R10
	.DEF _consZi=R9
	.DEF _j=R12
	.DEF _ultimStare=R13
	.DEF _ultimStare_msb=R14
	.DEF _cifra0=R11

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
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0


__GLOBAL_INI_TBL:
	.DW  0x0C
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
;Project : Proiect2
;Version :
;Date    : 20/03/2023
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega164P
;Program type            : Application
;AVR Core Clock frequency: 20.000000 MHz
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
;char arrayOre[24]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
;char contorIn=0;
;char contorSec=0;
;char contorMin=0;
;char contorHr=0;
;char val_afisor;
;char cont_pulse=0;
;char totalConsum=0;
;char consZi=0;
;char j=0;
;
;int ultimStare=0;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 0028 {

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
; 0000 0029 // Reinitialize Timer 0 value
; 0000 002A //TCNT0=0x3C;   //acesta este valoarea timerului pentru a obtine o perioada de 10ms.
; 0000 002B //vom folosi pentru simulare un artificiu deoarece simulatorul merge in 4 MHz
; 0000 002C TCNT0=0x63;
	LDI  R30,LOW(99)
	OUT  0x26,R30
; 0000 002D // Place your code here
; 0000 002E contorIn=contorIn+1;
	INC  R4
; 0000 002F PIND.6=0;
	CBI  0x9,6
; 0000 0030 if(contorIn%100==0){
	MOV  R26,R4
	CLR  R27
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RCALL __MODW21
	SBIW R30,0
	BRNE _0x5
; 0000 0031 // contorIn pentru 4MHz si TCNT0 ales numara o secunda odata ce ajunge la valoarea de 25
; 0000 0032 //pentru 20Mhz ar trebui sa fie 100
; 0000 0033     contorSec=contorSec+1;
	INC  R3
; 0000 0034     contorIn=0;
	CLR  R4
; 0000 0035     PIND.6=1;
	SBI  0x9,6
; 0000 0036 }
; 0000 0037 if(contorSec%60==0){
_0x5:
	MOV  R26,R3
	RCALL SUBOPT_0x0
	BRNE _0x8
; 0000 0038     contorMin=contorMin+1;
	INC  R6
; 0000 0039     contorSec=0;
	CLR  R3
; 0000 003A 
; 0000 003B }
; 0000 003C if(contorMin%60==0){
_0x8:
	MOV  R26,R6
	RCALL SUBOPT_0x0
	BRNE _0x9
; 0000 003D contorHr=contorHr+1;
	INC  R5
; 0000 003E contorMin=0;
	CLR  R6
; 0000 003F }
; 0000 0040 // o sa ne caculeze consumul la sfarsitul zilei si apoi o sa ne
; 0000 0041 // treaca in cealalta zi
; 0000 0042  if(contorHr%24==0){
_0x9:
	MOV  R26,R5
	CLR  R27
	LDI  R30,LOW(24)
	LDI  R31,HIGH(24)
	RCALL __MODW21
	SBIW R30,0
	BRNE _0xA
; 0000 0043  consZi=0;
	CLR  R9
; 0000 0044  for(j=0;j<24;j++)
	CLR  R12
_0xC:
	LDI  R30,LOW(24)
	CP   R12,R30
	BRSH _0xD
; 0000 0045  {consZi=consZi+arrayOre[j];
	MOV  R30,R12
	RCALL SUBOPT_0x1
	ADD  R9,R30
; 0000 0046  }
	INC  R12
	RJMP _0xC
_0xD:
; 0000 0047   contorHr=0;
	CLR  R5
; 0000 0048   }
; 0000 0049 }
_0xA:
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
;void LED_Stare_Curent(void)
; 0000 004B {
_LED_Stare_Curent:
; .FSTART _LED_Stare_Curent
; 0000 004C  if(PINC.2==1 && PINC.3==0){   //schimba in port D2, D3, D4   cod 10
	SBIS 0x6,2
	RJMP _0xF
	SBIS 0x6,3
	RJMP _0x10
_0xF:
	RJMP _0xE
_0x10:
; 0000 004D  PORTD.4=1;  // reprezinta o valoare scauzta 10mA-1.5ish A
	SBI  0xB,4
; 0000 004E  PORTD.3=0;
	RJMP _0x226
; 0000 004F  PORTD.2=0;
; 0000 0050  }else if(PINC.3==1 && PINC.2==0){
_0xE:
	SBIS 0x6,3
	RJMP _0x19
	SBIS 0x6,2
	RJMP _0x1A
_0x19:
	RJMP _0x18
_0x1A:
; 0000 0051  PORTD.4=0;
	CBI  0xB,4
; 0000 0052  PORTD.3=1;     // reprezinta o valoare medie  1.501 A -3.5 A   cod 01
	SBI  0xB,3
; 0000 0053  PORTD.2=0;
	RJMP _0x227
; 0000 0054  }else if(PINC.3==1 && PINC.2==1){
_0x18:
	SBIS 0x6,3
	RJMP _0x23
	SBIC 0x6,2
	RJMP _0x24
_0x23:
	RJMP _0x22
_0x24:
; 0000 0055  PORTD.4=0;
	CBI  0xB,4
; 0000 0056  PORTD.3=0;
	CBI  0xB,3
; 0000 0057  PORTD.2=1;   // reprezinta o valoare mare 3.501 A- 5A  cod 11
	SBI  0xB,2
; 0000 0058 
; 0000 0059  }
; 0000 005A  else {
	RJMP _0x2B
_0x22:
; 0000 005B  PORTD.4=0;
	CBI  0xB,4
; 0000 005C  PORTD.3=0;
_0x226:
	CBI  0xB,3
; 0000 005D  PORTD.2=0;// nu ne afiseaza niciun led
_0x227:
	CBI  0xB,2
; 0000 005E  }
_0x2B:
; 0000 005F //aceasta functie preia valoarea trimisa de dsp( valorile sunt intre anumite nivele
; 0000 0060 }
	RET
; .FEND
;char cifra0;
;char cifra1;
;char cifra2;
;
;void Afisor_2Cifre(char value){
; 0000 0065 void Afisor_2Cifre(char value){
_Afisor_2Cifre:
; .FSTART _Afisor_2Cifre
; 0000 0066 //vei lua PORTA complet, PortD7,portB 0->4 14 biti pentur 2 cifre 7 biti din port A o sai setezi pentru prima cifra rest ...
; 0000 0067 //tine minte afisorul este pe logica inversa
; 0000 0068  cifra0=value%10;
	ST   -Y,R17
	MOV  R17,R26
;	value -> R17
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL __MODW21
	MOV  R11,R30
; 0000 0069  cifra1=(value/10)%10;
	MOV  R26,R17
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL SUBOPT_0x2
	STS  _cifra1,R30
; 0000 006A  cifra2=(value/100)%10;
	MOV  R26,R17
	LDI  R27,0
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RCALL SUBOPT_0x2
	STS  _cifra2,R30
; 0000 006B if(cifra0==0)
	TST  R11
	BRNE _0x32
; 0000 006C {
; 0000 006D PORTA.0=0;  //pin 17 4E
	CBI  0x2,0
; 0000 006E PORTA.1=0;  //pin 18 4D
	RCALL SUBOPT_0x3
; 0000 006F PORTA.2=0;  //pin 19 4C
; 0000 0070 PORTA.3=0;  //pin 20 4B
; 0000 0071 PORTA.4=0;  //pin 21 4A
; 0000 0072 PORTA.5=0;  //pin 22 4F
	CBI  0x2,5
; 0000 0073 PORTA.6=1;  //pin 23 4G
	SBI  0x2,6
; 0000 0074 }
; 0000 0075 else if(cifra0==1)
	RJMP _0x41
_0x32:
	LDI  R30,LOW(1)
	CP   R30,R11
	BRNE _0x42
; 0000 0076 {
; 0000 0077 PORTA.0=1;  //pin 17 4E
	RCALL SUBOPT_0x4
; 0000 0078 PORTA.1=1;  //pin 18 4D
; 0000 0079 PORTA.2=0;  //pin 19 4C
; 0000 007A PORTA.3=0;  //pin 20 4B
; 0000 007B PORTA.4=1;  //pin 20 4A
; 0000 007C PORTA.5=1;  //pin 20 4F
	SBI  0x2,5
; 0000 007D PORTA.6=1;  //pin 20 4G
	SBI  0x2,6
; 0000 007E }
; 0000 007F else if(cifra0==2)
	RJMP _0x51
_0x42:
	LDI  R30,LOW(2)
	CP   R30,R11
	BRNE _0x52
; 0000 0080 {PORTA.0=0;  //pin 17 4E
	CBI  0x2,0
; 0000 0081 PORTA.1=0;  //pin 18 4D
	CBI  0x2,1
; 0000 0082 PORTA.2=1;  //pin 19 4C
	SBI  0x2,2
; 0000 0083 PORTA.3=0;  //pin 20 4B
	CBI  0x2,3
; 0000 0084 PORTA.4=0;  //pin 20 4A
	CBI  0x2,4
; 0000 0085 PORTA.5=1;  //pin 20 4F
	SBI  0x2,5
; 0000 0086 PORTA.6=0;  //pin 20 4G
	RJMP _0x228
; 0000 0087 }
; 0000 0088 else if(cifra0==3)
_0x52:
	LDI  R30,LOW(3)
	CP   R30,R11
	BRNE _0x62
; 0000 0089 {PORTA.0=1;  //pin 17 4E
	SBI  0x2,0
; 0000 008A PORTA.1=0;  //pin 18 4D
	RCALL SUBOPT_0x3
; 0000 008B PORTA.2=0;  //pin 19 4C
; 0000 008C PORTA.3=0;  //pin 20 4B
; 0000 008D PORTA.4=0;  //pin 20 4A
; 0000 008E PORTA.5=1;  //pin 20 4F
	SBI  0x2,5
; 0000 008F PORTA.6=0;  //pin 20 4G
	RJMP _0x228
; 0000 0090 }
; 0000 0091 else if(cifra0==4)
_0x62:
	LDI  R30,LOW(4)
	CP   R30,R11
	BRNE _0x72
; 0000 0092 {PORTA.0=1;  //pin 17 4E
	RCALL SUBOPT_0x4
; 0000 0093 PORTA.1=1;  //pin 18 4D
; 0000 0094 PORTA.2=0;  //pin 19 4C
; 0000 0095 PORTA.3=0;  //pin 20 4B
; 0000 0096 PORTA.4=1;  //pin 20 4A
; 0000 0097 PORTA.5=0;  //pin 20 4F
	RJMP _0x229
; 0000 0098 PORTA.6=0;  //pin 20 4G
; 0000 0099 }
; 0000 009A else if(cifra0==5)
_0x72:
	LDI  R30,LOW(5)
	CP   R30,R11
	BRNE _0x82
; 0000 009B {PORTA.0=1;  //pin 17 4E
	SBI  0x2,0
; 0000 009C PORTA.1=0;  //pin 18 4D
	CBI  0x2,1
; 0000 009D PORTA.2=0;  //pin 19 4C
	CBI  0x2,2
; 0000 009E PORTA.3=1;  //pin 20 4B
	SBI  0x2,3
; 0000 009F PORTA.4=0;  //pin 20 4A
	RJMP _0x22A
; 0000 00A0 PORTA.5=0;  //pin 20 4F
; 0000 00A1 PORTA.6=0;  //pin 20 4G
; 0000 00A2 }
; 0000 00A3 else if(cifra0==6)
_0x82:
	LDI  R30,LOW(6)
	CP   R30,R11
	BRNE _0x92
; 0000 00A4 {PORTA.0=0;  //pin 17 4E
	CBI  0x2,0
; 0000 00A5 PORTA.1=0;  //pin 18 4D
	CBI  0x2,1
; 0000 00A6 PORTA.2=0;  //pin 19 4C
	CBI  0x2,2
; 0000 00A7 PORTA.3=1;  //pin 20 4B
	SBI  0x2,3
; 0000 00A8 PORTA.4=0;  //pin 20 4A
	RJMP _0x22A
; 0000 00A9 PORTA.5=0;  //pin 20 4F
; 0000 00AA PORTA.6=0;  //pin 20 4G
; 0000 00AB }
; 0000 00AC else if(cifra0==7)
_0x92:
	LDI  R30,LOW(7)
	CP   R30,R11
	BRNE _0xA2
; 0000 00AD {PORTA.0=1;  //pin 17 4E
	SBI  0x2,0
; 0000 00AE PORTA.1=1;  //pin 18 4D
	SBI  0x2,1
; 0000 00AF PORTA.2=0;  //pin 19 4C
	CBI  0x2,2
; 0000 00B0 PORTA.3=0;  //pin 20 4B
	CBI  0x2,3
; 0000 00B1 PORTA.4=0;  //pin 20 4A
	CBI  0x2,4
; 0000 00B2 PORTA.5=1;  //pin 20 4F
	SBI  0x2,5
; 0000 00B3 PORTA.6=1;  //pin 20 4G
	SBI  0x2,6
; 0000 00B4 }
; 0000 00B5 else if(cifra0==8)
	RJMP _0xB1
_0xA2:
	LDI  R30,LOW(8)
	CP   R30,R11
	BRNE _0xB2
; 0000 00B6 {PORTA.0=0;  //pin 17 4E
	CBI  0x2,0
; 0000 00B7 PORTA.1=0;  //pin 18 4D
	RJMP _0x22B
; 0000 00B8 PORTA.2=0;  //pin 19 4C
; 0000 00B9 PORTA.3=0;  //pin 20 4B
; 0000 00BA PORTA.4=0;  //pin 20 4A
; 0000 00BB PORTA.5=0;  //pin 20 4F
; 0000 00BC PORTA.6=0;  //pin 20 4G
; 0000 00BD }
; 0000 00BE else if(cifra0==9)
_0xB2:
	LDI  R30,LOW(9)
	CP   R30,R11
	BRNE _0xC2
; 0000 00BF {PORTA.0=1;  //pin 17 4E
	SBI  0x2,0
; 0000 00C0 PORTA.1=0;  //pin 18 4D
_0x22B:
	CBI  0x2,1
; 0000 00C1 PORTA.2=0;  //pin 19 4C
	CBI  0x2,2
; 0000 00C2 PORTA.3=0;  //pin 20 4B
	CBI  0x2,3
; 0000 00C3 PORTA.4=0;  //pin 20 4A
_0x22A:
	CBI  0x2,4
; 0000 00C4 PORTA.5=0;  //pin 20 4F
_0x229:
	CBI  0x2,5
; 0000 00C5 PORTA.6=0;  //pin 20 4G
_0x228:
	CBI  0x2,6
; 0000 00C6 }
; 0000 00C7 if(cifra1==0)
_0xC2:
_0xB1:
_0x51:
_0x41:
	LDS  R30,_cifra1
	CPI  R30,0
	BRNE _0xD1
; 0000 00C8 {
; 0000 00C9 PORTA.7=0;  // pin 13 3E
	CBI  0x2,7
; 0000 00CA PORTD.7=0;  // pin 14 3D
	RCALL SUBOPT_0x5
; 0000 00CB PORTB.0=0;  // pin 15 3C
; 0000 00CC PORTB.1=0;  // pin 24 3B
; 0000 00CD PORTB.2=0;  // pin 25 3A
; 0000 00CE PORTB.3=0;  // pin 26 3F
	CBI  0x5,3
; 0000 00CF PORTB.4=1;  // pin 27 3G
	SBI  0x5,4
; 0000 00D0 }
; 0000 00D1 else if(cifra1==1)
	RJMP _0xE0
_0xD1:
	LDS  R26,_cifra1
	CPI  R26,LOW(0x1)
	BRNE _0xE1
; 0000 00D2 {
; 0000 00D3 PORTA.7=1;  // pin 13 3E
	RCALL SUBOPT_0x6
; 0000 00D4 PORTD.7=1;  // pin 14 3D
; 0000 00D5 PORTB.0=0;  // pin 15 3C
; 0000 00D6 PORTB.1=0;  // pin 24 3B
; 0000 00D7 PORTB.2=1;  // pin 25 3A
; 0000 00D8 PORTB.3=1;  // pin 26 3F
	SBI  0x5,3
; 0000 00D9 PORTB.4=1;  // pin 27 3G
	SBI  0x5,4
; 0000 00DA }
; 0000 00DB else if(cifra1==2)
	RJMP _0xF0
_0xE1:
	LDS  R26,_cifra1
	CPI  R26,LOW(0x2)
	BRNE _0xF1
; 0000 00DC {
; 0000 00DD PORTA.7=0;  // pin 13 3E
	CBI  0x2,7
; 0000 00DE PORTD.7=0;  // pin 14 3D
	CBI  0xB,7
; 0000 00DF PORTB.0=1;  // pin 15 3C
	SBI  0x5,0
; 0000 00E0 PORTB.1=0;  // pin 24 3B
	CBI  0x5,1
; 0000 00E1 PORTB.2=0;  // pin 25 3A
	CBI  0x5,2
; 0000 00E2 PORTB.3=1;  // pin 26 3F
	SBI  0x5,3
; 0000 00E3 PORTB.4=0;  // pin 27 3G
	RJMP _0x22C
; 0000 00E4 }
; 0000 00E5 else if(cifra1==3)
_0xF1:
	LDS  R26,_cifra1
	CPI  R26,LOW(0x3)
	BRNE _0x101
; 0000 00E6 {
; 0000 00E7 PORTA.7=1;  // pin 13 3E
	SBI  0x2,7
; 0000 00E8 PORTD.7=0;  // pin 14 3D
	RCALL SUBOPT_0x5
; 0000 00E9 PORTB.0=0;  // pin 15 3C
; 0000 00EA PORTB.1=0;  // pin 24 3B
; 0000 00EB PORTB.2=0;  // pin 25 3A
; 0000 00EC PORTB.3=1;  // pin 26 3F
	SBI  0x5,3
; 0000 00ED PORTB.4=0;  // pin 27 3G
	RJMP _0x22C
; 0000 00EE }
; 0000 00EF else if(cifra1==4)
_0x101:
	LDS  R26,_cifra1
	CPI  R26,LOW(0x4)
	BRNE _0x111
; 0000 00F0 {
; 0000 00F1 PORTA.7=1;  // pin 13 3E
	RCALL SUBOPT_0x6
; 0000 00F2 PORTD.7=1;  // pin 14 3D
; 0000 00F3 PORTB.0=0;  // pin 15 3C
; 0000 00F4 PORTB.1=0;  // pin 24 3B
; 0000 00F5 PORTB.2=1;  // pin 25 3A
; 0000 00F6 PORTB.3=0;  // pin 26 3F
	RJMP _0x22D
; 0000 00F7 PORTB.4=0;  // pin 27 3G
; 0000 00F8 }
; 0000 00F9 else if(cifra1==5)
_0x111:
	LDS  R26,_cifra1
	CPI  R26,LOW(0x5)
	BRNE _0x121
; 0000 00FA {
; 0000 00FB PORTA.7=1;  // pin 13 3E
	SBI  0x2,7
; 0000 00FC PORTD.7=0;  // pin 14 3D
	CBI  0xB,7
; 0000 00FD PORTB.0=0;  // pin 15 3C
	CBI  0x5,0
; 0000 00FE PORTB.1=1;  // pin 24 3B
	SBI  0x5,1
; 0000 00FF PORTB.2=0;  // pin 25 3A
	RJMP _0x22E
; 0000 0100 PORTB.3=0;  // pin 26 3F
; 0000 0101 PORTB.4=0;  // pin 27 3G
; 0000 0102 }
; 0000 0103 else if(cifra1==6)
_0x121:
	LDS  R26,_cifra1
	CPI  R26,LOW(0x6)
	BRNE _0x131
; 0000 0104 {
; 0000 0105 PORTA.7=0;  // pin 13 3E
	CBI  0x2,7
; 0000 0106 PORTD.7=0;  // pin 14 3D
	CBI  0xB,7
; 0000 0107 PORTB.0=0;  // pin 15 3C
	CBI  0x5,0
; 0000 0108 PORTB.1=1;  // pin 24 3B
	SBI  0x5,1
; 0000 0109 PORTB.2=0;  // pin 25 3A
	RJMP _0x22E
; 0000 010A PORTB.3=0;  // pin 26 3F
; 0000 010B PORTB.4=0;  // pin 27 3G
; 0000 010C }
; 0000 010D else if(cifra1==7)
_0x131:
	LDS  R26,_cifra1
	CPI  R26,LOW(0x7)
	BRNE _0x141
; 0000 010E {
; 0000 010F PORTA.7=1;  // pin 13 3E
	SBI  0x2,7
; 0000 0110 PORTD.7=1;  // pin 14 3D
	SBI  0xB,7
; 0000 0111 PORTB.0=0;  // pin 15 3C
	CBI  0x5,0
; 0000 0112 PORTB.1=0;  // pin 24 3B
	CBI  0x5,1
; 0000 0113 PORTB.2=0;  // pin 25 3A
	CBI  0x5,2
; 0000 0114 PORTB.3=1;  // pin 26 3F
	SBI  0x5,3
; 0000 0115 PORTB.4=1;  // pin 27 3G
	SBI  0x5,4
; 0000 0116 }
; 0000 0117 else if(cifra1==8)
	RJMP _0x150
_0x141:
	LDS  R26,_cifra1
	CPI  R26,LOW(0x8)
	BRNE _0x151
; 0000 0118 {
; 0000 0119 PORTA.7=1;  // pin 13 3E
	SBI  0x2,7
; 0000 011A PORTD.7=1;  // pin 14 3D
	SBI  0xB,7
; 0000 011B PORTB.0=1;  // pin 15 3C
	SBI  0x5,0
; 0000 011C PORTB.1=1;  // pin 24 3B
	SBI  0x5,1
; 0000 011D PORTB.2=1;  // pin 25 3A
	SBI  0x5,2
; 0000 011E PORTB.3=1;  // pin 26 3F
	SBI  0x5,3
; 0000 011F PORTB.4=1;  // pin 27 3G
	SBI  0x5,4
; 0000 0120 }
; 0000 0121 else if(cifra1==9)
	RJMP _0x160
_0x151:
	LDS  R26,_cifra1
	CPI  R26,LOW(0x9)
	BRNE _0x161
; 0000 0122 {
; 0000 0123 PORTA.7=1;  // pin 13 3E
	SBI  0x2,7
; 0000 0124 PORTD.7=0;  // pin 14 3D
	CBI  0xB,7
; 0000 0125 PORTB.0=0;  // pin 15 3C
	CBI  0x5,0
; 0000 0126 PORTB.1=0;  // pin 24 3B
	CBI  0x5,1
; 0000 0127 PORTB.2=0;  // pin 25 3A
_0x22E:
	CBI  0x5,2
; 0000 0128 PORTB.3=0;  // pin 26 3F
_0x22D:
	CBI  0x5,3
; 0000 0129 PORTB.4=0;  // pin 27 3G
_0x22C:
	CBI  0x5,4
; 0000 012A }
; 0000 012B 
; 0000 012C if(cifra2==0){
_0x161:
_0x160:
_0x150:
_0xF0:
_0xE0:
	LDS  R30,_cifra2
	CPI  R30,0
	BRNE _0x170
; 0000 012D PORTB.5=0;  // pin 9 2E
	CBI  0x5,5
; 0000 012E PORTB.6=0;  // pin 10 2D
	RCALL SUBOPT_0x7
; 0000 012F PORTB.7=0;  // pin 11 2C
; 0000 0130 PORTD.0=0;  // pin 29 2B
; 0000 0131 PORTD.1=0;  // pin 30 2A
; 0000 0132 PORTC.6=0;  // pin 31 2F
	CBI  0x8,6
; 0000 0133 PORTC.7=1;  // pin 32 2G
	SBI  0x8,7
; 0000 0134 }
; 0000 0135 else if(cifra2==1)
	RJMP _0x17F
_0x170:
	LDS  R26,_cifra2
	CPI  R26,LOW(0x1)
	BRNE _0x180
; 0000 0136 {
; 0000 0137 PORTB.5=1;  // pin 9 2E
	RCALL SUBOPT_0x8
; 0000 0138 PORTB.6=1;  // pin 10 2D
; 0000 0139 PORTB.7=0;  // pin 11 2C
; 0000 013A PORTD.0=0;  // pin 29 2B
; 0000 013B PORTD.1=1;  // pin 30 2A
; 0000 013C PORTC.6=1;  // pin 31 2F
	SBI  0x8,6
; 0000 013D PORTC.7=1;  // pin 32 2G
	SBI  0x8,7
; 0000 013E 
; 0000 013F }
; 0000 0140 else if(cifra2==2)
	RJMP _0x18F
_0x180:
	LDS  R26,_cifra2
	CPI  R26,LOW(0x2)
	BRNE _0x190
; 0000 0141 {
; 0000 0142 PORTB.5=0;  // pin 9 2E
	CBI  0x5,5
; 0000 0143 PORTB.6=0;  // pin 10 2D
	CBI  0x5,6
; 0000 0144 PORTB.7=1;  // pin 11 2C
	SBI  0x5,7
; 0000 0145 PORTD.0=0;  // pin 29 2B
	CBI  0xB,0
; 0000 0146 PORTD.1=0;  // pin 30 2A
	CBI  0xB,1
; 0000 0147 PORTC.6=1;  // pin 31 2F
	SBI  0x8,6
; 0000 0148 PORTC.7=0;  // pin 32 2G
	RJMP _0x22F
; 0000 0149 }
; 0000 014A else if(cifra2==3)
_0x190:
	LDS  R26,_cifra2
	CPI  R26,LOW(0x3)
	BRNE _0x1A0
; 0000 014B {
; 0000 014C PORTB.5=1;  // pin 9 2E
	SBI  0x5,5
; 0000 014D PORTB.6=0;  // pin 10 2D
	RCALL SUBOPT_0x7
; 0000 014E PORTB.7=0;  // pin 11 2C
; 0000 014F PORTD.0=0;  // pin 29 2B
; 0000 0150 PORTD.1=0;  // pin 30 2A
; 0000 0151 PORTC.6=1;  // pin 31 2F
	SBI  0x8,6
; 0000 0152 PORTC.7=0;  // pin 32 2G
	RJMP _0x22F
; 0000 0153 
; 0000 0154 }
; 0000 0155 else if(cifra2==4)
_0x1A0:
	LDS  R26,_cifra2
	CPI  R26,LOW(0x4)
	BRNE _0x1B0
; 0000 0156 {
; 0000 0157 PORTB.5=1;  // pin 9 2E
	RCALL SUBOPT_0x8
; 0000 0158 PORTB.6=1;  // pin 10 2D
; 0000 0159 PORTB.7=0;  // pin 11 2C
; 0000 015A PORTD.0=0;  // pin 29 2B
; 0000 015B PORTD.1=1;  // pin 30 2A
; 0000 015C PORTC.6=0;  // pin 31 2F
	RJMP _0x230
; 0000 015D PORTC.7=0;  // pin 32 2G
; 0000 015E }
; 0000 015F else if(cifra2==5)
_0x1B0:
	LDS  R26,_cifra2
	CPI  R26,LOW(0x5)
	BRNE _0x1C0
; 0000 0160 {
; 0000 0161 PORTB.5=1;  // pin 9 2E
	SBI  0x5,5
; 0000 0162 PORTB.6=0;  // pin 10 2D
	CBI  0x5,6
; 0000 0163 PORTB.7=0;  // pin 11 2C
	CBI  0x5,7
; 0000 0164 PORTD.0=1;  // pin 29 2B
	SBI  0xB,0
; 0000 0165 PORTD.1=0;  // pin 30 2A
	RJMP _0x231
; 0000 0166 PORTC.6=0;  // pin 31 2F
; 0000 0167 PORTC.7=0;  // pin 32 2G
; 0000 0168 }
; 0000 0169 else if(cifra2==6)
_0x1C0:
	LDS  R26,_cifra2
	CPI  R26,LOW(0x6)
	BRNE _0x1D0
; 0000 016A {
; 0000 016B PORTB.5=0;  // pin 9 2E
	CBI  0x5,5
; 0000 016C PORTB.6=0;  // pin 10 2D
	CBI  0x5,6
; 0000 016D PORTB.7=0;  // pin 11 2C
	CBI  0x5,7
; 0000 016E PORTD.0=1;  // pin 29 2B
	SBI  0xB,0
; 0000 016F PORTD.1=0;  // pin 30 2A
	RJMP _0x231
; 0000 0170 PORTC.6=0;  // pin 31 2F
; 0000 0171 PORTC.7=0;  // pin 32 2G
; 0000 0172 }
; 0000 0173 else if(cifra2==7)
_0x1D0:
	LDS  R26,_cifra2
	CPI  R26,LOW(0x7)
	BRNE _0x1E0
; 0000 0174 {
; 0000 0175 PORTB.5=1;  // pin 9 2E
	SBI  0x5,5
; 0000 0176 PORTB.6=1;  // pin 10 2D
	SBI  0x5,6
; 0000 0177 PORTB.7=0;  // pin 11 2C
	CBI  0x5,7
; 0000 0178 PORTD.0=0;  // pin 29 2B
	CBI  0xB,0
; 0000 0179 PORTD.1=0;  // pin 30 2A
	CBI  0xB,1
; 0000 017A PORTC.6=1;  // pin 31 2F
	SBI  0x8,6
; 0000 017B PORTC.7=1;  // pin 32 2G
	SBI  0x8,7
; 0000 017C }
; 0000 017D else if(cifra2==8)
	RJMP _0x1EF
_0x1E0:
	LDS  R26,_cifra2
	CPI  R26,LOW(0x8)
	BRNE _0x1F0
; 0000 017E {
; 0000 017F PORTB.5=1;  // pin 9 2E
	SBI  0x5,5
; 0000 0180 PORTB.6=1;  // pin 10 2D
	SBI  0x5,6
; 0000 0181 PORTB.7=1;  // pin 11 2C
	SBI  0x5,7
; 0000 0182 PORTD.0=1;  // pin 29 2B
	SBI  0xB,0
; 0000 0183 PORTD.1=1;  // pin 30 2A
	SBI  0xB,1
; 0000 0184 PORTC.6=1;  // pin 31 2F
	SBI  0x8,6
; 0000 0185 PORTC.7=1;  // pin 32 2G
	SBI  0x8,7
; 0000 0186 }
; 0000 0187 else if(cifra2==9)
	RJMP _0x1FF
_0x1F0:
	LDS  R26,_cifra2
	CPI  R26,LOW(0x9)
	BRNE _0x200
; 0000 0188 {
; 0000 0189 PORTB.5=1;  // pin 9 2E
	SBI  0x5,5
; 0000 018A PORTB.6=0;  // pin 10 2D
	CBI  0x5,6
; 0000 018B PORTB.7=0;  // pin 11 2C
	CBI  0x5,7
; 0000 018C PORTD.0=0;  // pin 29 2B
	CBI  0xB,0
; 0000 018D PORTD.1=0;  // pin 30 2A
_0x231:
	CBI  0xB,1
; 0000 018E PORTC.6=0;  // pin 31 2F
_0x230:
	CBI  0x8,6
; 0000 018F PORTC.7=0;  // pin 32 2G
_0x22F:
	CBI  0x8,7
; 0000 0190 }
; 0000 0191 }
_0x200:
_0x1FF:
_0x1EF:
_0x18F:
_0x17F:
	LD   R17,Y+
	RET
; .FEND
;
;
;char ValAfisorButon(void){
; 0000 0194 char ValAfisorButon(void){
_ValAfisorButon:
; .FSTART _ValAfisorButon
; 0000 0195 char SUMA=0;
; 0000 0196 char i;
; 0000 0197 if(PIND.5==0)//buton apasat   butonul este portD5, cu portD6 allways on pentru LED
	ST   -Y,R17
	ST   -Y,R16
;	SUMA -> R17
;	i -> R16
	LDI  R17,0
	SBIC 0x9,5
	RJMP _0x20F
; 0000 0198  {// ne va afisa ultimele 24 de ore de consum
; 0000 0199   SUMA=0;
	LDI  R17,LOW(0)
; 0000 019A   if(consZi==0)
	TST  R9
	BRNE _0x210
; 0000 019B   {if(contorHr<24)
	LDI  R30,LOW(24)
	CP   R5,R30
	BRSH _0x211
; 0000 019C      { for(i=0;i<contorHr+1;i++)
	LDI  R16,LOW(0)
_0x213:
	MOV  R30,R5
	LDI  R31,0
	ADIW R30,1
	MOV  R26,R16
	LDI  R27,0
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x214
; 0000 019D       {   SUMA=SUMA+arrayOre[i];
	MOV  R30,R16
	RCALL SUBOPT_0x1
	ADD  R17,R30
; 0000 019E       // ne va arata consumul pana la ora curenta de la pornire
; 0000 019F       }
	SUBI R16,-1
	RJMP _0x213
_0x214:
; 0000 01A0       val_afisor=SUMA;
	RJMP _0x232
; 0000 01A1       }
; 0000 01A2    else
_0x211:
; 0000 01A3    { for(i=0;i<contorHr;i++)
	LDI  R16,LOW(0)
_0x217:
	CP   R16,R5
	BRSH _0x218
; 0000 01A4       {   SUMA=SUMA+arrayOre[i];
	MOV  R30,R16
	RCALL SUBOPT_0x1
	ADD  R17,R30
; 0000 01A5       // ne va arata consumul pana la ora curenta de la pornire in caz ca consZi e 0
; 0000 01A6       }
	SUBI R16,-1
	RJMP _0x217
_0x218:
; 0000 01A7       val_afisor=SUMA;
_0x232:
	MOV  R8,R17
; 0000 01A8    }
; 0000 01A9   }
; 0000 01AA   else{
	RJMP _0x219
_0x210:
; 0000 01AB   val_afisor=consZi;
	MOV  R8,R9
; 0000 01AC   }
_0x219:
; 0000 01AD 
; 0000 01AE   //sfarsitul buton apasat
; 0000 01AF  }
; 0000 01B0    else
	RJMP _0x21A
_0x20F:
; 0000 01B1   {val_afisor=totalConsum;
	MOV  R8,R10
; 0000 01B2         }
_0x21A:
; 0000 01B3    return val_afisor;
	MOV  R30,R8
	RJMP _0x2000001
; 0000 01B4   }
; .FEND
;
;
;void PinStareMod(int pinStare)
; 0000 01B8 {
_PinStareMod:
; .FSTART _PinStareMod
; 0000 01B9 
; 0000 01BA if(pinStare!=ultimStare){
	ST   -Y,R17
	ST   -Y,R16
	MOVW R16,R26
;	pinStare -> R16,R17
	__CPWRR 13,14,16,17
	BREQ _0x21B
; 0000 01BB if(pinStare==0){
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x21C
; 0000 01BC  cont_pulse=cont_pulse;
; 0000 01BD  }
; 0000 01BE  else{
	RJMP _0x21D
_0x21C:
; 0000 01BF   cont_pulse=cont_pulse+1;
	INC  R7
; 0000 01C0  }
_0x21D:
; 0000 01C1  ultimStare=pinStare;
	__MOVEWRR 13,14,16,17
; 0000 01C2  }
; 0000 01C3  }
_0x21B:
_0x2000001:
	LD   R16,Y+
	LD   R17,Y+
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
;
;
;
;void main(void)
; 0000 01D1 {
_main:
; .FSTART _main
; 0000 01D2 // Declare your local variables here
; 0000 01D3  //DSP ar trebui sa trimita ceva de genul 00100 pentru un puls simplu
; 0000 01D4 // Crystal Oscillator division factor: 1
; 0000 01D5 #pragma optsize-
; 0000 01D6 CLKPR=(1<<CLKPCE);
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 01D7 CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 01D8 #ifdef _OPTIMIZE_SIZE_
; 0000 01D9 #pragma optsize+
; 0000 01DA #endif
; 0000 01DB 
; 0000 01DC // Input/Output Ports initialization
; 0000 01DD // Port A initialization
; 0000 01DE // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 01DF DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
	LDI  R30,LOW(255)
	OUT  0x1,R30
; 0000 01E0 // State: Bit7=1 Bit6=1 Bit5=1 Bit4=1 Bit3=1 Bit2=1 Bit1=1 Bit0=1
; 0000 01E1 PORTA=(1<<PORTA7) | (1<<PORTA6) | (1<<PORTA5) | (1<<PORTA4) | (1<<PORTA3) | (1<<PORTA2) | (1<<PORTA1) | (1<<PORTA0);
	OUT  0x2,R30
; 0000 01E2 
; 0000 01E3 // Port B initialization
; 0000 01E4 // Function: Bit7=In Bit6=In Bit5=In Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 01E5 DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
	OUT  0x4,R30
; 0000 01E6 // State: Bit7=T Bit6=T Bit5=T Bit4=1 Bit3=1 Bit2=1 Bit1=1 Bit0=1
; 0000 01E7 PORTB=(1<<PORTB7) | (1<<PORTB6) | (1<<PORTB5) | (1<<PORTB4) | (1<<PORTB3) | (1<<PORTB2) | (1<<PORTB1) | (1<<PORTB0);
	OUT  0x5,R30
; 0000 01E8 
; 0000 01E9 // Port C initialization
; 0000 01EA // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 01EB DDRC=(1<<DDC7) | (1<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	LDI  R30,LOW(192)
	OUT  0x7,R30
; 0000 01EC // State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=P Bit2=P Bit1=P Bit0=P
; 0000 01ED PORTC=(1<<PORTC7) | (1<<PORTC6) | (1<<PORTC5) | (1<<PORTC4) | (1<<PORTC3) | (1<<PORTC2) | (1<<PORTC1) | (1<<PORTC0);
	LDI  R30,LOW(255)
	OUT  0x8,R30
; 0000 01EE 
; 0000 01EF // Port D initialization
; 0000 01F0 // Function: Bit7=Out Bit6=In Bit5=In Bit4=Out Bit3=Out Bit2=Out Bit1=In Bit0=In
; 0000 01F1 DDRD=(1<<DDD7) | (1<<DDD6) | (0<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
	LDI  R30,LOW(223)
	OUT  0xA,R30
; 0000 01F2 // State: Bit7=1 Bit6=0 Bit5=T Bit4=0 Bit3=0 Bit2=0 Bit1=T Bit0=T
; 0000 01F3 PORTD=(1<<PORTD7) | (1<<PORTD6) | (0<<PORTD5) | (1<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (1<<PORTD1) | (1<<PORTD0);
	OUT  0xB,R30
; 0000 01F4 
; 0000 01F5 // Timer/Counter 0 initialization
; 0000 01F6 // Clock source: System Clock
; 0000 01F7 // Clock value: 19.531 kHz
; 0000 01F8 // Mode: Normal top=0xFF
; 0000 01F9 // OC0A output: Disconnected
; 0000 01FA // OC0B output: Disconnected
; 0000 01FB // Timer Period: 10.035 ms
; 0000 01FC TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 01FD TCCR0B=(0<<WGM02) | (1<<CS02) | (0<<CS01) | (1<<CS00);
	LDI  R30,LOW(5)
	OUT  0x25,R30
; 0000 01FE TCNT0=0x3C;
	LDI  R30,LOW(60)
	OUT  0x26,R30
; 0000 01FF OCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0000 0200 OCR0B=0x00;
	OUT  0x28,R30
; 0000 0201 
; 0000 0202 // Timer/Counter 1 initialization
; 0000 0203 // Clock source: System Clock
; 0000 0204 // Clock value: Timer1 Stopped
; 0000 0205 // Mode: Normal top=0xFFFF
; 0000 0206 // OC1A output: Disconnected
; 0000 0207 // OC1B output: Disconnected
; 0000 0208 // Noise Canceler: Off
; 0000 0209 // Input Capture on Falling Edge
; 0000 020A // Timer1 Overflow Interrupt: Off
; 0000 020B // Input Capture Interrupt: Off
; 0000 020C // Compare A Match Interrupt: Off
; 0000 020D // Compare B Match Interrupt: Off
; 0000 020E TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	STS  128,R30
; 0000 020F TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	STS  129,R30
; 0000 0210 TCNT1H=0x00;
	STS  133,R30
; 0000 0211 TCNT1L=0x00;
	STS  132,R30
; 0000 0212 ICR1H=0x00;
	STS  135,R30
; 0000 0213 ICR1L=0x00;
	STS  134,R30
; 0000 0214 OCR1AH=0x00;
	STS  137,R30
; 0000 0215 OCR1AL=0x00;
	STS  136,R30
; 0000 0216 OCR1BH=0x00;
	STS  139,R30
; 0000 0217 OCR1BL=0x00;
	STS  138,R30
; 0000 0218 
; 0000 0219 // Timer/Counter 2 initialization
; 0000 021A // Clock source: System Clock
; 0000 021B // Clock value: Timer2 Stopped
; 0000 021C // Mode: Normal top=0xFF
; 0000 021D // OC2A output: Disconnected
; 0000 021E // OC2B output: Disconnected
; 0000 021F ASSR=(0<<EXCLK) | (0<<AS2);
	STS  182,R30
; 0000 0220 TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (0<<COM2B1) | (0<<COM2B0) | (0<<WGM21) | (0<<WGM20);
	STS  176,R30
; 0000 0221 TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	STS  177,R30
; 0000 0222 TCNT2=0x00;
	STS  178,R30
; 0000 0223 OCR2A=0x00;
	STS  179,R30
; 0000 0224 OCR2B=0x00;
	STS  180,R30
; 0000 0225 
; 0000 0226 // Timer/Counter 0 Interrupt(s) initialization
; 0000 0227 TIMSK0=(0<<OCIE0B) | (0<<OCIE0A) | (1<<TOIE0);
	LDI  R30,LOW(1)
	STS  110,R30
; 0000 0228 
; 0000 0229 // Timer/Counter 1 Interrupt(s) initialization
; 0000 022A TIMSK1=(0<<ICIE1) | (0<<OCIE1B) | (0<<OCIE1A) | (0<<TOIE1);
	LDI  R30,LOW(0)
	STS  111,R30
; 0000 022B 
; 0000 022C // Timer/Counter 2 Interrupt(s) initialization
; 0000 022D TIMSK2=(0<<OCIE2B) | (0<<OCIE2A) | (0<<TOIE2);
	STS  112,R30
; 0000 022E 
; 0000 022F // External Interrupt(s) initialization
; 0000 0230 // INT0: Off
; 0000 0231 // INT1: Off
; 0000 0232 // INT2: Off
; 0000 0233 // Interrupt on any change on pins PCINT0-7: Off
; 0000 0234 // Interrupt on any change on pins PCINT8-15: Off
; 0000 0235 // Interrupt on any change on pins PCINT16-23: Off
; 0000 0236 // Interrupt on any change on pins PCINT24-31: Off
; 0000 0237 EICRA=(0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	STS  105,R30
; 0000 0238 EIMSK=(0<<INT2) | (0<<INT1) | (0<<INT0);
	OUT  0x1D,R30
; 0000 0239 PCICR=(0<<PCIE3) | (0<<PCIE2) | (0<<PCIE1) | (0<<PCIE0);
	STS  104,R30
; 0000 023A 
; 0000 023B // USART0 initialization
; 0000 023C // USART0 disabled
; 0000 023D UCSR0B=(0<<RXCIE0) | (0<<TXCIE0) | (0<<UDRIE0) | (0<<RXEN0) | (0<<TXEN0) | (0<<UCSZ02) | (0<<RXB80) | (0<<TXB80);
	STS  193,R30
; 0000 023E 
; 0000 023F // USART1 initialization
; 0000 0240 // USART1 disabled
; 0000 0241 UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
	STS  201,R30
; 0000 0242 
; 0000 0243 // Analog Comparator initialization
; 0000 0244 // Analog Comparator: Off
; 0000 0245 // The Analog Comparator's positive input is
; 0000 0246 // connected to the AIN0 pin
; 0000 0247 // The Analog Comparator's negative input is
; 0000 0248 // connected to the AIN1 pin
; 0000 0249 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 024A ADCSRB=(0<<ACME);
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 024B // Digital input buffer on AIN0: On
; 0000 024C // Digital input buffer on AIN1: On
; 0000 024D DIDR1=(0<<AIN0D) | (0<<AIN1D);
	STS  127,R30
; 0000 024E 
; 0000 024F // ADC initialization
; 0000 0250 // ADC disabled
; 0000 0251 ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	STS  122,R30
; 0000 0252 
; 0000 0253 // SPI initialization
; 0000 0254 // SPI disabled
; 0000 0255 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0x2C,R30
; 0000 0256 
; 0000 0257 // TWI initialization
; 0000 0258 // TWI disabled
; 0000 0259 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	STS  188,R30
; 0000 025A 
; 0000 025B // Globally enable interrupts
; 0000 025C #asm("sei")
	SEI
; 0000 025D 
; 0000 025E while (1)
_0x21E:
; 0000 025F       {
; 0000 0260       LED_Stare_Curent();
	RCALL _LED_Stare_Curent
; 0000 0261 
; 0000 0262       if(PINC.0==1 )
	SBIS 0x6,0
	RJMP _0x221
; 0000 0263       {
; 0000 0264         cont_pulse=0;
	CLR  R7
; 0000 0265         while(PINC.0!=0)
_0x222:
	SBIS 0x6,0
	RJMP _0x224
; 0000 0266           {
; 0000 0267             PinStareMod(PINC.1);
	LDI  R30,0
	SBIC 0x6,1
	LDI  R30,1
	LDI  R31,0
	MOVW R26,R30
	RCALL _PinStareMod
; 0000 0268           }
	RJMP _0x222
_0x224:
; 0000 0269       }
; 0000 026A       totalConsum=totalConsum+cont_pulse;
_0x221:
	ADD  R10,R7
; 0000 026B       arrayOre[contorHr]= arrayOre[contorHr]+cont_pulse ;
	MOV  R26,R5
	LDI  R27,0
	SUBI R26,LOW(-_arrayOre)
	SBCI R27,HIGH(-_arrayOre)
	MOV  R30,R5
	RCALL SUBOPT_0x1
	ADD  R30,R7
	ST   X,R30
; 0000 026C       cont_pulse=0;
	CLR  R7
; 0000 026D       Afisor_2Cifre(ValAfisorButon());
	RCALL _ValAfisorButon
	MOV  R26,R30
	RCALL _Afisor_2Cifre
; 0000 026E       }
	RJMP _0x21E
; 0000 026F }
_0x225:
	RJMP _0x225
; .FEND

	.DSEG
_arrayOre:
	.BYTE 0x18
_cifra1:
	.BYTE 0x1
_cifra2:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x0:
	CLR  R27
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	RCALL __MODW21
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1:
	LDI  R31,0
	SUBI R30,LOW(-_arrayOre)
	SBCI R31,HIGH(-_arrayOre)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	RCALL __DIVW21
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL __MODW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	CBI  0x2,1
	CBI  0x2,2
	CBI  0x2,3
	CBI  0x2,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4:
	SBI  0x2,0
	SBI  0x2,1
	CBI  0x2,2
	CBI  0x2,3
	SBI  0x2,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	CBI  0xB,7
	CBI  0x5,0
	CBI  0x5,1
	CBI  0x5,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	SBI  0x2,7
	SBI  0xB,7
	CBI  0x5,0
	CBI  0x5,1
	SBI  0x5,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	CBI  0x5,6
	CBI  0x5,7
	CBI  0xB,0
	CBI  0xB,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x8:
	SBI  0x5,5
	SBI  0x5,6
	CBI  0x5,7
	CBI  0xB,0
	SBI  0xB,1
	RET

;RUNTIME LIBRARY

	.CSEG
__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
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

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
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

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	NEG  R27
	NEG  R26
	SBCI R27,0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

;END OF CODE MARKER
__END_OF_CODE:
