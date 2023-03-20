
;CodeVisionAVR C Compiler V3.29 Evaluation
;(C) Copyright 1998-2016 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega164
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

	#pragma AVRPART ADMIN PART_NAME ATmega164
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
	.DEF _cifra0=R14
	.DEF _cifra1=R13

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
;� Copyright 1998-2016 Pavel Haiduc, HP InfoTech s.r.l.
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
;Chip type               : ATmega164
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
	INC  R3
; 0000 002F if(contorIn%25==0){
	MOV  R26,R3
	CLR  R27
	LDI  R30,LOW(25)
	LDI  R31,HIGH(25)
	RCALL __MODW21
	SBIW R30,0
	BRNE _0x3
; 0000 0030 // contorIn pentru 4MHz si TCNT0 ales numara o secunda odata ce ajunge la valoarea de 25
; 0000 0031 //pentru 20Mhz ar trebui sa fie 100
; 0000 0032     contorSec=contorSec+1;
	INC  R6
; 0000 0033     contorIn=0;
	CLR  R3
; 0000 0034 }
; 0000 0035 if(contorSec%60==0){
_0x3:
	MOV  R26,R6
	RCALL SUBOPT_0x0
	BRNE _0x4
; 0000 0036     contorMin=contorMin+1;
	INC  R5
; 0000 0037     contorSec=0;
	CLR  R6
; 0000 0038 }
; 0000 0039 if(contorMin%60==0){
_0x4:
	MOV  R26,R5
	RCALL SUBOPT_0x0
	BRNE _0x5
; 0000 003A contorHr=contorHr+1;
	INC  R8
; 0000 003B contorMin=0;
	CLR  R5
; 0000 003C }
; 0000 003D arrayOre[contorHr]=nrTotalPuls;
_0x5:
	MOV  R30,R8
	LDI  R31,0
	SUBI R30,LOW(-_arrayOre)
	SBCI R31,HIGH(-_arrayOre)
	ST   Z,R4
; 0000 003E  if(contorHr%24==0){
	MOV  R26,R8
	CLR  R27
	LDI  R30,LOW(24)
	LDI  R31,HIGH(24)
	RCALL __MODW21
	SBIW R30,0
	BRNE _0x6
; 0000 003F   contorHr=1;
	LDI  R30,LOW(1)
	MOV  R8,R30
; 0000 0040   }
; 0000 0041 }
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
;char get_Curent_state(void)
; 0000 0045  {    //citim cei 6 biti de la dsp pentru valoarea curentului
_get_Curent_state:
; .FSTART _get_Curent_state
; 0000 0046   unsigned char val;
; 0000 0047 
; 0000 0048   val=PINC & 0b00111111;    //schimba in port C
	ST   -Y,R17
;	val -> R17
	IN   R30,0x6
	ANDI R30,LOW(0x3F)
	MOV  R17,R30
; 0000 0049   val=val<<2;
	LSL  R17
	LSL  R17
; 0000 004A   val=2>>val;
	MOV  R30,R17
	LDI  R26,LOW(2)
	RCALL __LSRB12
	MOV  R17,R30
; 0000 004B   //shiftam biti pentru a avea doar codul de stare pentru LEDuri
; 0000 004C   return val;
	RJMP _0x2000002
; 0000 004D  }
; .FEND
;
;
;void LED_Stare_Curent(void)
; 0000 0051 {char LEDstate;
_LED_Stare_Curent:
; .FSTART _LED_Stare_Curent
; 0000 0052 LEDstate=get_Curent_state();
	ST   -Y,R17
;	LEDstate -> R17
	RCALL _get_Curent_state
	MOV  R17,R30
; 0000 0053  if(LEDstate==0b00000001){   //schimba in port D2, D3, D4
	CPI  R17,1
	BRNE _0x7
; 0000 0054  PORTD.4=1;  // reprezinta o valoare scauzta 10mA-1.5ish A
	SBI  0xB,4
; 0000 0055  PORTD.3=0;
	RJMP _0x187
; 0000 0056  PORTD.2=0;
; 0000 0057  }else if(LEDstate==0b00000010){
_0x7:
	CPI  R17,2
	BRNE _0xF
; 0000 0058  PORTD.4=0;
	CBI  0xB,4
; 0000 0059  PORTD.3=1;     // reprezinta o valoare medie  1.501 A -3.5 A
	SBI  0xB,3
; 0000 005A  PORTD.2=0;
	RJMP _0x188
; 0000 005B  }else if(LEDstate==0b00000100){
_0xF:
	CPI  R17,4
	BRNE _0x17
; 0000 005C  PORTD.4=0;
	CBI  0xB,4
; 0000 005D  PORTD.3=0;
	CBI  0xB,3
; 0000 005E  PORTD.2=1;   // reprezinta o valoare mare 3.501 A- 5A
	SBI  0xB,2
; 0000 005F 
; 0000 0060  }
; 0000 0061  else {
	RJMP _0x1E
_0x17:
; 0000 0062  PORTD.4=0;
	CBI  0xB,4
; 0000 0063  PORTD.3=0;
_0x187:
	CBI  0xB,3
; 0000 0064  PORTD.2=0;// nu ne afiseaza niciun led
_0x188:
	CBI  0xB,2
; 0000 0065  }
_0x1E:
; 0000 0066 //aceasta functie preia valoarea trimisa de dsp( valorile sunt intre anumite nivele
; 0000 0067 }
	RJMP _0x2000002
; .FEND
;char cifra0;
;char cifra1;
;
;void Afisor_2Cifre(char value){  //vei lua PORTA complet, PortD7,portB 0->4 14 biti pentur 2 cifre 7 biti din port A o s ...
; 0000 006B void Afisor_2Cifre(char value){
_Afisor_2Cifre:
; .FSTART _Afisor_2Cifre
; 0000 006C //placeholder pentru porti liberi pentru 2 cifre
; 0000 006D //tine minte afisorul este pe logica inversa
; 0000 006E  cifra0=value%10;
	ST   -Y,R17
	MOV  R17,R26
;	value -> R17
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL __MODW21
	MOV  R14,R30
; 0000 006F  cifra1=(value/10)%10;
	MOV  R26,R17
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL __DIVW21
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL __MODW21
	MOV  R13,R30
; 0000 0070 if(cifra0==0)
	TST  R14
	BRNE _0x25
; 0000 0071 {
; 0000 0072 PORTA.0=0;  //pin 17 4E
	CBI  0x2,0
; 0000 0073 PORTA.1=0;  //pin 18 4D
	RCALL SUBOPT_0x1
; 0000 0074 PORTA.2=0;  //pin 19 4C
; 0000 0075 PORTA.3=0;  //pin 20 4B
; 0000 0076 PORTA.4=0;  //pin 20 4A
; 0000 0077 PORTA.5=0;  //pin 20 4F
	CBI  0x2,5
; 0000 0078 PORTA.6=1;  //pin 20 4G
	SBI  0x2,6
; 0000 0079 }
; 0000 007A else if(cifra0==1)
	RJMP _0x34
_0x25:
	LDI  R30,LOW(1)
	CP   R30,R14
	BRNE _0x35
; 0000 007B {
; 0000 007C PORTA.0=1;  //pin 17 4E
	RCALL SUBOPT_0x2
; 0000 007D PORTA.1=1;  //pin 18 4D
; 0000 007E PORTA.2=0;  //pin 19 4C
; 0000 007F PORTA.3=0;  //pin 20 4B
; 0000 0080 PORTA.4=1;  //pin 20 4A
; 0000 0081 PORTA.5=1;  //pin 20 4F
	SBI  0x2,5
; 0000 0082 PORTA.6=1;  //pin 20 4G
	SBI  0x2,6
; 0000 0083 }
; 0000 0084 else if(cifra0==2)
	RJMP _0x44
_0x35:
	LDI  R30,LOW(2)
	CP   R30,R14
	BRNE _0x45
; 0000 0085 {PORTA.0=0;  //pin 17 4E
	CBI  0x2,0
; 0000 0086 PORTA.1=0;  //pin 18 4D
	CBI  0x2,1
; 0000 0087 PORTA.2=1;  //pin 19 4C
	SBI  0x2,2
; 0000 0088 PORTA.3=0;  //pin 20 4B
	CBI  0x2,3
; 0000 0089 PORTA.4=0;  //pin 20 4A
	CBI  0x2,4
; 0000 008A PORTA.5=1;  //pin 20 4F
	SBI  0x2,5
; 0000 008B PORTA.6=0;  //pin 20 4G
	RJMP _0x189
; 0000 008C }
; 0000 008D else if(cifra0==3)
_0x45:
	LDI  R30,LOW(3)
	CP   R30,R14
	BRNE _0x55
; 0000 008E {PORTA.0=1;  //pin 17 4E
	SBI  0x2,0
; 0000 008F PORTA.1=0;  //pin 18 4D
	RCALL SUBOPT_0x1
; 0000 0090 PORTA.2=0;  //pin 19 4C
; 0000 0091 PORTA.3=0;  //pin 20 4B
; 0000 0092 PORTA.4=0;  //pin 20 4A
; 0000 0093 PORTA.5=1;  //pin 20 4F
	SBI  0x2,5
; 0000 0094 PORTA.6=0;  //pin 20 4G
	RJMP _0x189
; 0000 0095 }
; 0000 0096 else if(cifra0==4)
_0x55:
	LDI  R30,LOW(4)
	CP   R30,R14
	BRNE _0x65
; 0000 0097 {PORTA.0=1;  //pin 17 4E
	RCALL SUBOPT_0x2
; 0000 0098 PORTA.1=1;  //pin 18 4D
; 0000 0099 PORTA.2=0;  //pin 19 4C
; 0000 009A PORTA.3=0;  //pin 20 4B
; 0000 009B PORTA.4=1;  //pin 20 4A
; 0000 009C PORTA.5=0;  //pin 20 4F
	RJMP _0x18A
; 0000 009D PORTA.6=0;  //pin 20 4G
; 0000 009E }
; 0000 009F else if(cifra0==5)
_0x65:
	LDI  R30,LOW(5)
	CP   R30,R14
	BRNE _0x75
; 0000 00A0 {PORTA.0=1;  //pin 17 4E
	SBI  0x2,0
; 0000 00A1 PORTA.1=0;  //pin 18 4D
	CBI  0x2,1
; 0000 00A2 PORTA.2=0;  //pin 19 4C
	CBI  0x2,2
; 0000 00A3 PORTA.3=1;  //pin 20 4B
	SBI  0x2,3
; 0000 00A4 PORTA.4=0;  //pin 20 4A
	RJMP _0x18B
; 0000 00A5 PORTA.5=0;  //pin 20 4F
; 0000 00A6 PORTA.6=0;  //pin 20 4G
; 0000 00A7 }
; 0000 00A8 else if(cifra0==6)
_0x75:
	LDI  R30,LOW(6)
	CP   R30,R14
	BRNE _0x85
; 0000 00A9 {PORTA.0=0;  //pin 17 4E
	CBI  0x2,0
; 0000 00AA PORTA.1=0;  //pin 18 4D
	CBI  0x2,1
; 0000 00AB PORTA.2=0;  //pin 19 4C
	CBI  0x2,2
; 0000 00AC PORTA.3=1;  //pin 20 4B
	SBI  0x2,3
; 0000 00AD PORTA.4=0;  //pin 20 4A
	RJMP _0x18B
; 0000 00AE PORTA.5=0;  //pin 20 4F
; 0000 00AF PORTA.6=0;  //pin 20 4G
; 0000 00B0 }
; 0000 00B1 else if(cifra0==7)
_0x85:
	LDI  R30,LOW(7)
	CP   R30,R14
	BRNE _0x95
; 0000 00B2 {PORTA.0=1;  //pin 17 4E
	SBI  0x2,0
; 0000 00B3 PORTA.1=1;  //pin 18 4D
	SBI  0x2,1
; 0000 00B4 PORTA.2=0;  //pin 19 4C
	CBI  0x2,2
; 0000 00B5 PORTA.3=0;  //pin 20 4B
	CBI  0x2,3
; 0000 00B6 PORTA.4=0;  //pin 20 4A
	CBI  0x2,4
; 0000 00B7 PORTA.5=1;  //pin 20 4F
	SBI  0x2,5
; 0000 00B8 PORTA.6=1;  //pin 20 4G
	SBI  0x2,6
; 0000 00B9 }
; 0000 00BA else if(cifra0==8)
	RJMP _0xA4
_0x95:
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0xA5
; 0000 00BB {PORTA.0=0;  //pin 17 4E
	CBI  0x2,0
; 0000 00BC PORTA.1=0;  //pin 18 4D
	RJMP _0x18C
; 0000 00BD PORTA.2=0;  //pin 19 4C
; 0000 00BE PORTA.3=0;  //pin 20 4B
; 0000 00BF PORTA.4=0;  //pin 20 4A
; 0000 00C0 PORTA.5=0;  //pin 20 4F
; 0000 00C1 PORTA.6=0;  //pin 20 4G
; 0000 00C2 }
; 0000 00C3 else if(cifra0==9)
_0xA5:
	LDI  R30,LOW(9)
	CP   R30,R14
	BRNE _0xB5
; 0000 00C4 {PORTA.0=1;  //pin 17 4E
	SBI  0x2,0
; 0000 00C5 PORTA.1=0;  //pin 18 4D
_0x18C:
	CBI  0x2,1
; 0000 00C6 PORTA.2=0;  //pin 19 4C
	CBI  0x2,2
; 0000 00C7 PORTA.3=0;  //pin 20 4B
	CBI  0x2,3
; 0000 00C8 PORTA.4=0;  //pin 20 4A
_0x18B:
	CBI  0x2,4
; 0000 00C9 PORTA.5=0;  //pin 20 4F
_0x18A:
	CBI  0x2,5
; 0000 00CA PORTA.6=0;  //pin 20 4G
_0x189:
	CBI  0x2,6
; 0000 00CB }
; 0000 00CC if(cifra1==0)
_0xB5:
_0xA4:
_0x44:
_0x34:
	TST  R13
	BRNE _0xC4
; 0000 00CD {
; 0000 00CE PORTA.7=0;  // pin 13 3E
	CBI  0x2,7
; 0000 00CF PORTD.7=0;  // pin 14 3D
	RCALL SUBOPT_0x3
; 0000 00D0 PORTB.0=0;  // pin 15 3C
; 0000 00D1 PORTB.1=0;  // pin 24 3B
; 0000 00D2 PORTB.2=0;  // pin 25 3A
; 0000 00D3 PORTB.3=0;  // pin 26 3F
	CBI  0x5,3
; 0000 00D4 PORTB.4=1;  // pin 27 3G
	SBI  0x5,4
; 0000 00D5 }
; 0000 00D6 else if(cifra1==1)
	RJMP _0xD3
_0xC4:
	LDI  R30,LOW(1)
	CP   R30,R13
	BRNE _0xD4
; 0000 00D7 {
; 0000 00D8 PORTA.7=1;  // pin 13 3E
	RCALL SUBOPT_0x4
; 0000 00D9 PORTD.7=1;  // pin 14 3D
; 0000 00DA PORTB.0=0;  // pin 15 3C
; 0000 00DB PORTB.1=0;  // pin 24 3B
; 0000 00DC PORTB.2=1;  // pin 25 3A
; 0000 00DD PORTB.3=1;  // pin 26 3F
	SBI  0x5,3
; 0000 00DE PORTB.4=1;  // pin 27 3G
	SBI  0x5,4
; 0000 00DF }
; 0000 00E0 else if(cifra1==2)
	RJMP _0xE3
_0xD4:
	LDI  R30,LOW(2)
	CP   R30,R13
	BRNE _0xE4
; 0000 00E1 {
; 0000 00E2 PORTA.7=0;  // pin 13 3E
	CBI  0x2,7
; 0000 00E3 PORTD.7=0;  // pin 14 3D
	CBI  0xB,7
; 0000 00E4 PORTB.0=1;  // pin 15 3C
	SBI  0x5,0
; 0000 00E5 PORTB.1=0;  // pin 24 3B
	CBI  0x5,1
; 0000 00E6 PORTB.2=0;  // pin 25 3A
	CBI  0x5,2
; 0000 00E7 PORTB.3=1;  // pin 26 3F
	SBI  0x5,3
; 0000 00E8 PORTB.4=0;  // pin 27 3G
	RJMP _0x18D
; 0000 00E9 }
; 0000 00EA else if(cifra1==3)
_0xE4:
	LDI  R30,LOW(3)
	CP   R30,R13
	BRNE _0xF4
; 0000 00EB {
; 0000 00EC PORTA.7=1;  // pin 13 3E
	SBI  0x2,7
; 0000 00ED PORTD.7=0;  // pin 14 3D
	RCALL SUBOPT_0x3
; 0000 00EE PORTB.0=0;  // pin 15 3C
; 0000 00EF PORTB.1=0;  // pin 24 3B
; 0000 00F0 PORTB.2=0;  // pin 25 3A
; 0000 00F1 PORTB.3=1;  // pin 26 3F
	SBI  0x5,3
; 0000 00F2 PORTB.4=0;  // pin 27 3G
	RJMP _0x18D
; 0000 00F3 }
; 0000 00F4 else if(cifra1==4)
_0xF4:
	LDI  R30,LOW(4)
	CP   R30,R13
	BRNE _0x104
; 0000 00F5 {
; 0000 00F6 PORTA.7=1;  // pin 13 3E
	RCALL SUBOPT_0x4
; 0000 00F7 PORTD.7=1;  // pin 14 3D
; 0000 00F8 PORTB.0=0;  // pin 15 3C
; 0000 00F9 PORTB.1=0;  // pin 24 3B
; 0000 00FA PORTB.2=1;  // pin 25 3A
; 0000 00FB PORTB.3=0;  // pin 26 3F
	RJMP _0x18E
; 0000 00FC PORTB.4=0;  // pin 27 3G
; 0000 00FD }
; 0000 00FE else if(cifra1==5)
_0x104:
	LDI  R30,LOW(5)
	CP   R30,R13
	BRNE _0x114
; 0000 00FF {
; 0000 0100 PORTA.7=1;  // pin 13 3E
	SBI  0x2,7
; 0000 0101 PORTD.7=0;  // pin 14 3D
	CBI  0xB,7
; 0000 0102 PORTB.0=0;  // pin 15 3C
	CBI  0x5,0
; 0000 0103 PORTB.1=1;  // pin 24 3B
	SBI  0x5,1
; 0000 0104 PORTB.2=0;  // pin 25 3A
	RJMP _0x18F
; 0000 0105 PORTB.3=0;  // pin 26 3F
; 0000 0106 PORTB.4=0;  // pin 27 3G
; 0000 0107 }
; 0000 0108 else if(cifra1==6)
_0x114:
	LDI  R30,LOW(6)
	CP   R30,R13
	BRNE _0x124
; 0000 0109 {
; 0000 010A PORTA.7=0;  // pin 13 3E
	CBI  0x2,7
; 0000 010B PORTD.7=0;  // pin 14 3D
	CBI  0xB,7
; 0000 010C PORTB.0=0;  // pin 15 3C
	CBI  0x5,0
; 0000 010D PORTB.1=1;  // pin 24 3B
	SBI  0x5,1
; 0000 010E PORTB.2=0;  // pin 25 3A
	RJMP _0x18F
; 0000 010F PORTB.3=0;  // pin 26 3F
; 0000 0110 PORTB.4=0;  // pin 27 3G
; 0000 0111 }
; 0000 0112 else if(cifra1==7)
_0x124:
	LDI  R30,LOW(7)
	CP   R30,R13
	BRNE _0x134
; 0000 0113 {
; 0000 0114 PORTA.7=1;  // pin 13 3E
	SBI  0x2,7
; 0000 0115 PORTD.7=1;  // pin 14 3D
	SBI  0xB,7
; 0000 0116 PORTB.0=0;  // pin 15 3C
	CBI  0x5,0
; 0000 0117 PORTB.1=0;  // pin 24 3B
	CBI  0x5,1
; 0000 0118 PORTB.2=0;  // pin 25 3A
	CBI  0x5,2
; 0000 0119 PORTB.3=1;  // pin 26 3F
	SBI  0x5,3
; 0000 011A PORTB.4=1;  // pin 27 3G
	SBI  0x5,4
; 0000 011B }
; 0000 011C else if(cifra1==8)
	RJMP _0x143
_0x134:
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0x144
; 0000 011D {
; 0000 011E PORTA.7=1;  // pin 13 3E
	SBI  0x2,7
; 0000 011F PORTD.7=1;  // pin 14 3D
	SBI  0xB,7
; 0000 0120 PORTB.0=1;  // pin 15 3C
	SBI  0x5,0
; 0000 0121 PORTB.1=1;  // pin 24 3B
	SBI  0x5,1
; 0000 0122 PORTB.2=1;  // pin 25 3A
	SBI  0x5,2
; 0000 0123 PORTB.3=1;  // pin 26 3F
	SBI  0x5,3
; 0000 0124 PORTB.4=1;  // pin 27 3G
	SBI  0x5,4
; 0000 0125 }
; 0000 0126 else if(cifra1==9)
	RJMP _0x153
_0x144:
	LDI  R30,LOW(9)
	CP   R30,R13
	BRNE _0x154
; 0000 0127 {
; 0000 0128 PORTA.7=1;  // pin 13 3E
	SBI  0x2,7
; 0000 0129 PORTD.7=0;  // pin 14 3D
	CBI  0xB,7
; 0000 012A PORTB.0=0;  // pin 15 3C
	CBI  0x5,0
; 0000 012B PORTB.1=0;  // pin 24 3B
	CBI  0x5,1
; 0000 012C PORTB.2=0;  // pin 25 3A
_0x18F:
	CBI  0x5,2
; 0000 012D PORTB.3=0;  // pin 26 3F
_0x18E:
	CBI  0x5,3
; 0000 012E PORTB.4=0;  // pin 27 3G
_0x18D:
	CBI  0x5,4
; 0000 012F }
; 0000 0130 }
_0x154:
_0x153:
_0x143:
_0xE3:
_0xD3:
_0x2000002:
	LD   R17,Y+
	RET
; .FEND
;
;
;char ValAfisorButon(void){
; 0000 0133 char ValAfisorButon(void){
_ValAfisorButon:
; .FSTART _ValAfisorButon
; 0000 0134 char SUMA;
; 0000 0135 //ar trebui sa ma mai gandesc cu butonul ca un fel de multi switch ca nu e un switch
; 0000 0136 //ar trebui sa il pun intr-o
; 0000 0137 char buffer_calc;
; 0000 0138 char i;
; 0000 0139 if(button_pressed==0)//buton apasat   butonul este PportD5, cu portD6 allways on
	RCALL __SAVELOCR4
;	SUMA -> R17
;	buffer_calc -> R16
;	i -> R19
	TST  R10
	BRNE _0x163
; 0000 013A //fa astfel incat daca butonul a fost apasat sa ne arate 12 ore de consum cat timp e apasat si daca "nu a fost apasat" s ...
; 0000 013B  {
; 0000 013C   SUMA=0;
	LDI  R17,LOW(0)
; 0000 013D   if(contorHr>8)
	LDI  R30,LOW(8)
	CP   R30,R8
	BRSH _0x164
; 0000 013E   {      buffer_calc=contorHr-8;
	MOV  R30,R8
	SUBI R30,LOW(8)
	MOV  R16,R30
; 0000 013F   for(i=buffer_calc;i<=contorHr;i++)
	MOV  R19,R16
_0x166:
	CP   R8,R19
	BRLO _0x167
; 0000 0140   {   SUMA=SUMA+arrayOre[i];
	RCALL SUBOPT_0x5
; 0000 0141   }
	SUBI R19,-1
	RJMP _0x166
_0x167:
; 0000 0142   }
; 0000 0143   else{
	RJMP _0x168
_0x164:
; 0000 0144     buffer_calc=8-contorHr;
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x6
; 0000 0145     for(i=24-buffer_calc;i<=24;i++)
_0x16A:
	CPI  R19,25
	BRSH _0x16B
; 0000 0146     { SUMA=SUMA+arrayOre[i];
	RCALL SUBOPT_0x5
; 0000 0147     }
	SUBI R19,-1
	RJMP _0x16A
_0x16B:
; 0000 0148     for(i=1;i<=contorHr;i++){
	LDI  R19,LOW(1)
_0x16D:
	CP   R8,R19
	BRLO _0x16E
; 0000 0149     SUMA=SUMA+arrayOre[i];}
	RCALL SUBOPT_0x5
	SUBI R19,-1
	RJMP _0x16D
_0x16E:
; 0000 014A   }
_0x168:
; 0000 014B   return val_afisor=SUMA;
	MOV  R30,R17
	MOV  R7,R30
	RJMP _0x2000001
; 0000 014C   //sfarsitul functiei de 24 de ore
; 0000 014D  }
; 0000 014E    else
_0x163:
; 0000 014F   {SUMA=0;
	LDI  R17,LOW(0)
; 0000 0150 
; 0000 0151   if(contorHr>4)
	LDI  R30,LOW(4)
	CP   R30,R8
	BRSH _0x170
; 0000 0152    {
; 0000 0153    buffer_calc=contorHr-4;
	MOV  R30,R8
	SUBI R30,LOW(4)
	MOV  R16,R30
; 0000 0154     for(i=buffer_calc;i<=contorHr;i++)
	MOV  R19,R16
_0x172:
	CP   R8,R19
	BRLO _0x173
; 0000 0155       {
; 0000 0156       SUMA=SUMA+arrayOre[i];
	RCALL SUBOPT_0x5
; 0000 0157       }
	SUBI R19,-1
	RJMP _0x172
_0x173:
; 0000 0158     }
; 0000 0159     else  {
	RJMP _0x174
_0x170:
; 0000 015A        buffer_calc=4-contorHr;
	LDI  R30,LOW(4)
	RCALL SUBOPT_0x6
; 0000 015B        for(i=24-buffer_calc;i<=24;i++)
_0x176:
	CPI  R19,25
	BRSH _0x177
; 0000 015C         {
; 0000 015D         SUMA=SUMA+arrayOre[i];
	RCALL SUBOPT_0x5
; 0000 015E         }
	SUBI R19,-1
	RJMP _0x176
_0x177:
; 0000 015F        for(i=1;i<=contorHr;i++)
	LDI  R19,LOW(1)
_0x179:
	CP   R8,R19
	BRLO _0x17A
; 0000 0160        {
; 0000 0161        SUMA=SUMA+arrayOre[i];
	RCALL SUBOPT_0x5
; 0000 0162        }
	SUBI R19,-1
	RJMP _0x179
_0x17A:
; 0000 0163      // ar trebui sa ne arate consumul de kWh pentru ultimele 4 ore cat timp apasam
; 0000 0164         }
_0x174:
; 0000 0165    return val_afisor=SUMA;
	MOV  R30,R17
	MOV  R7,R30
; 0000 0166   }
; 0000 0167 }
_0x2000001:
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
;
;
;
;void main(void)
; 0000 016C {
_main:
; .FSTART _main
; 0000 016D // Declare your local variables here
; 0000 016E 
; 0000 016F // Crystal Oscillator division factor: 1
; 0000 0170 #pragma optsize-
; 0000 0171 CLKPR=(1<<CLKPCE);
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0172 CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 0173 #ifdef _OPTIMIZE_SIZE_
; 0000 0174 #pragma optsize+
; 0000 0175 #endif
; 0000 0176 
; 0000 0177 // Input/Output Ports initialization
; 0000 0178 // Port A initialization
; 0000 0179 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 017A DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
	LDI  R30,LOW(255)
	OUT  0x1,R30
; 0000 017B // State: Bit7=1 Bit6=1 Bit5=1 Bit4=1 Bit3=1 Bit2=1 Bit1=1 Bit0=1
; 0000 017C PORTA=(1<<PORTA7) | (1<<PORTA6) | (1<<PORTA5) | (1<<PORTA4) | (1<<PORTA3) | (1<<PORTA2) | (1<<PORTA1) | (1<<PORTA0);
	OUT  0x2,R30
; 0000 017D 
; 0000 017E // Port B initialization
; 0000 017F // Function: Bit7=In Bit6=In Bit5=In Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0180 DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(31)
	OUT  0x4,R30
; 0000 0181 // State: Bit7=T Bit6=T Bit5=T Bit4=1 Bit3=1 Bit2=1 Bit1=1 Bit0=1
; 0000 0182 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (1<<PORTB4) | (1<<PORTB3) | (1<<PORTB2) | (1<<PORTB1) | (1<<PORTB0);
	OUT  0x5,R30
; 0000 0183 
; 0000 0184 // Port C initialization
; 0000 0185 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0186 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0000 0187 // State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=P Bit2=P Bit1=P Bit0=P
; 0000 0188 PORTC=(1<<PORTC7) | (1<<PORTC6) | (1<<PORTC5) | (1<<PORTC4) | (1<<PORTC3) | (1<<PORTC2) | (1<<PORTC1) | (1<<PORTC0);
	LDI  R30,LOW(255)
	OUT  0x8,R30
; 0000 0189 
; 0000 018A // Port D initialization
; 0000 018B // Function: Bit7=Out Bit6=In Bit5=In Bit4=Out Bit3=Out Bit2=Out Bit1=In Bit0=In
; 0000 018C DDRD=(1<<DDD7) | (0<<DDD6) | (0<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (0<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(156)
	OUT  0xA,R30
; 0000 018D // State: Bit7=1 Bit6=T Bit5=T Bit4=1 Bit3=1 Bit2=1 Bit1=T Bit0=T
; 0000 018E PORTD=(1<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (1<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0xB,R30
; 0000 018F 
; 0000 0190 // Timer/Counter 0 initialization
; 0000 0191 // Clock source: System Clock
; 0000 0192 // Clock value: 19.531 kHz
; 0000 0193 // Mode: Normal top=0xFF
; 0000 0194 // OC0A output: Disconnected
; 0000 0195 // OC0B output: Disconnected
; 0000 0196 // Timer Period: 10.035 ms
; 0000 0197 TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 0198 TCCR0B=(0<<WGM02) | (1<<CS02) | (0<<CS01) | (1<<CS00);
	LDI  R30,LOW(5)
	OUT  0x25,R30
; 0000 0199 TCNT0=0x3C;
	LDI  R30,LOW(60)
	OUT  0x26,R30
; 0000 019A OCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0000 019B OCR0B=0x00;
	OUT  0x28,R30
; 0000 019C 
; 0000 019D // Timer/Counter 1 initialization
; 0000 019E // Clock source: System Clock
; 0000 019F // Clock value: Timer1 Stopped
; 0000 01A0 // Mode: Normal top=0xFFFF
; 0000 01A1 // OC1A output: Disconnected
; 0000 01A2 // OC1B output: Disconnected
; 0000 01A3 // Noise Canceler: Off
; 0000 01A4 // Input Capture on Falling Edge
; 0000 01A5 // Timer1 Overflow Interrupt: Off
; 0000 01A6 // Input Capture Interrupt: Off
; 0000 01A7 // Compare A Match Interrupt: Off
; 0000 01A8 // Compare B Match Interrupt: Off
; 0000 01A9 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	STS  128,R30
; 0000 01AA TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	STS  129,R30
; 0000 01AB TCNT1H=0x00;
	STS  133,R30
; 0000 01AC TCNT1L=0x00;
	STS  132,R30
; 0000 01AD ICR1H=0x00;
	STS  135,R30
; 0000 01AE ICR1L=0x00;
	STS  134,R30
; 0000 01AF OCR1AH=0x00;
	STS  137,R30
; 0000 01B0 OCR1AL=0x00;
	STS  136,R30
; 0000 01B1 OCR1BH=0x00;
	STS  139,R30
; 0000 01B2 OCR1BL=0x00;
	STS  138,R30
; 0000 01B3 
; 0000 01B4 // Timer/Counter 2 initialization
; 0000 01B5 // Clock source: System Clock
; 0000 01B6 // Clock value: Timer2 Stopped
; 0000 01B7 // Mode: Normal top=0xFF
; 0000 01B8 // OC2A output: Disconnected
; 0000 01B9 // OC2B output: Disconnected
; 0000 01BA ASSR=(0<<EXCLK) | (0<<AS2);
	STS  182,R30
; 0000 01BB TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (0<<COM2B1) | (0<<COM2B0) | (0<<WGM21) | (0<<WGM20);
	STS  176,R30
; 0000 01BC TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	STS  177,R30
; 0000 01BD TCNT2=0x00;
	STS  178,R30
; 0000 01BE OCR2A=0x00;
	STS  179,R30
; 0000 01BF OCR2B=0x00;
	STS  180,R30
; 0000 01C0 
; 0000 01C1 // Timer/Counter 0 Interrupt(s) initialization
; 0000 01C2 TIMSK0=(0<<OCIE0B) | (0<<OCIE0A) | (1<<TOIE0);
	LDI  R30,LOW(1)
	STS  110,R30
; 0000 01C3 
; 0000 01C4 // Timer/Counter 1 Interrupt(s) initialization
; 0000 01C5 TIMSK1=(0<<ICIE1) | (0<<OCIE1B) | (0<<OCIE1A) | (0<<TOIE1);
	LDI  R30,LOW(0)
	STS  111,R30
; 0000 01C6 
; 0000 01C7 // Timer/Counter 2 Interrupt(s) initialization
; 0000 01C8 TIMSK2=(0<<OCIE2B) | (0<<OCIE2A) | (0<<TOIE2);
	STS  112,R30
; 0000 01C9 
; 0000 01CA // External Interrupt(s) initialization
; 0000 01CB // INT0: Off
; 0000 01CC // INT1: Off
; 0000 01CD // INT2: Off
; 0000 01CE // Interrupt on any change on pins PCINT0-7: Off
; 0000 01CF // Interrupt on any change on pins PCINT8-15: Off
; 0000 01D0 // Interrupt on any change on pins PCINT16-23: Off
; 0000 01D1 // Interrupt on any change on pins PCINT24-31: Off
; 0000 01D2 EICRA=(0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	STS  105,R30
; 0000 01D3 EIMSK=(0<<INT2) | (0<<INT1) | (0<<INT0);
	OUT  0x1D,R30
; 0000 01D4 PCICR=(0<<PCIE3) | (0<<PCIE2) | (0<<PCIE1) | (0<<PCIE0);
	STS  104,R30
; 0000 01D5 
; 0000 01D6 // USART0 initialization
; 0000 01D7 // USART0 disabled
; 0000 01D8 UCSR0B=(0<<RXCIE0) | (0<<TXCIE0) | (0<<UDRIE0) | (0<<RXEN0) | (0<<TXEN0) | (0<<UCSZ02) | (0<<RXB80) | (0<<TXB80);
	STS  193,R30
; 0000 01D9 
; 0000 01DA // USART1 initialization
; 0000 01DB // USART1 disabled
; 0000 01DC UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
	STS  201,R30
; 0000 01DD 
; 0000 01DE // Analog Comparator initialization
; 0000 01DF // Analog Comparator: Off
; 0000 01E0 // The Analog Comparator's positive input is
; 0000 01E1 // connected to the AIN0 pin
; 0000 01E2 // The Analog Comparator's negative input is
; 0000 01E3 // connected to the AIN1 pin
; 0000 01E4 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 01E5 ADCSRB=(0<<ACME);
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 01E6 // Digital input buffer on AIN0: On
; 0000 01E7 // Digital input buffer on AIN1: On
; 0000 01E8 DIDR1=(0<<AIN0D) | (0<<AIN1D);
	STS  127,R30
; 0000 01E9 
; 0000 01EA // ADC initialization
; 0000 01EB // ADC disabled
; 0000 01EC ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	STS  122,R30
; 0000 01ED 
; 0000 01EE // SPI initialization
; 0000 01EF // SPI disabled
; 0000 01F0 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0x2C,R30
; 0000 01F1 
; 0000 01F2 // TWI initialization
; 0000 01F3 // TWI disabled
; 0000 01F4 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	STS  188,R30
; 0000 01F5 
; 0000 01F6 // Globally enable interrupts
; 0000 01F7 #asm("sei")
	SEI
; 0000 01F8 
; 0000 01F9 while (1)
_0x17B:
; 0000 01FA       check_pulse=PINC.0;//portile pentru primirea datelor
	LDI  R30,0
	SBIC 0x6,0
	LDI  R30,1
	MOV  R9,R30
	RJMP _0x17B
; 0000 01FB in_semnal_p=PINC.1;
; 0000 01FC while (1)
_0x17E:
; 0000 01FD       {
; 0000 01FE       LED_Stare_Curent();
	RCALL _LED_Stare_Curent
; 0000 01FF       if(check_pulse==1 ) //fal portC.0
	LDI  R30,LOW(1)
	CP   R30,R9
	BRNE _0x181
; 0000 0200       {
; 0000 0201         cont_pulse=0;
	CLR  R12
; 0000 0202         while(check_pulse!=0) // fal port C.1
_0x182:
	TST  R9
	BREQ _0x184
; 0000 0203           {if(in_semnal_p==1) // DSP ar trebui sa trimita semnal de genul 1110111
	LDI  R30,LOW(1)
	CP   R30,R11
	BRNE _0x185
; 0000 0204             {
; 0000 0205             cont_pulse=cont_pulse+1;
	INC  R12
; 0000 0206             }
; 0000 0207           }
_0x185:
	RJMP _0x182
_0x184:
; 0000 0208       }
; 0000 0209       nrTotalPuls=cont_pulse;
_0x181:
	MOV  R4,R12
; 0000 020A       Afisor_2Cifre(ValAfisorButon());
	RCALL _ValAfisorButon
	MOV  R26,R30
	RCALL _Afisor_2Cifre
; 0000 020B       }
	RJMP _0x17E
; 0000 020C }
_0x186:
	RJMP _0x186
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	CBI  0x2,1
	CBI  0x2,2
	CBI  0x2,3
	CBI  0x2,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	SBI  0x2,0
	SBI  0x2,1
	CBI  0x2,2
	CBI  0x2,3
	SBI  0x2,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	CBI  0xB,7
	CBI  0x5,0
	CBI  0x5,1
	CBI  0x5,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4:
	SBI  0x2,7
	SBI  0xB,7
	CBI  0x5,0
	CBI  0x5,1
	SBI  0x5,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x5:
	MOV  R30,R19
	LDI  R31,0
	SUBI R30,LOW(-_arrayOre)
	SBCI R31,HIGH(-_arrayOre)
	LD   R30,Z
	ADD  R17,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
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