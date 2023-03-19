/*******************************************************
This program was created by the CodeWizardAVR V3.29 
Automatic Program Generator
� Copyright 1998-2016 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : PLEASE_GOD_HELP_ME
Version : 
Date    : 16/03/2023
Author  : 
Company : 
Comments: 


Chip type               : ATmega164P
Program type            : Application
AVR Core Clock frequency: 10.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/

#include <io.h>

// Declare your global variables here

// Timer 0 overflow interrupt service routine
char nrTotalPuls = 0;  //valoarea initiala
char arrayOre[24]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
char contorIn=0;
char contorSec=0;
char contorMin=0;
char contorHr=1;
int val_afisor;
// variabila de verificare a butonului
char button_pressed;
char check_pulse; //modifica pini conform cerintei
char cont_pulse=0;
char in_semnal_p;
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
// Reinitialize Timer 0 value
TCNT0=0x63;       
//artificiu pentru demonstrare in simulator nu vrea sai mearga
//pe orice alta frecventa
//pentru frecventa de 20MHz TCNT0 ar trebui sa fie (pune aici vaoarea in hexa dorita pentru 10.086 ms)
// Place your code here
contorIn=contorIn+1;
if(contorIn%25==0){
// contorIn pentru 4MHz si TCNT0 ales numara o secunda odata ce ajunge la valoarea de 25
//pentru 20Mhz ar trebui sa fie 100
    contorSec=contorSec+1;
    contorIn=0;
}
if(contorSec%60==0){
    contorMin=contorMin+1;
    contorSec=0;
}
if(contorMin%60==0){
contorHr=contorHr+1;
contorMin=0;
}
arrayOre[contorHr]=nrTotalPuls;
 if(contorHr%24==0){
  contorHr=1;
  }
 

}






char get_Curent_state(void)
 {    //citim cei 6 biti de la dsp pentru valoarea curentului
  unsigned char val;
  
  val=PINB & 0b00111111; 
  val=val<<2;
  val=2>>val;
  //shiftam biti pentru a avea doar codul de stare pentru LEDuri                       
  return val; 
 }

void LED_Stare_Curent(void)
{char LEDstate;
LEDstate=get_Curent_state();
 if(LEDstate==0b000001){
 PORTB=0b00000001;
 }else if(LEDstate==0b000010){
 PORTB=0b00000010;
 }else if(LEDstate==0b000010){
 PORTB=0b00000100;
 }else if(LEDstate==0b000100){
 PORTB=0b00001000;
 }else if(LEDstate==0b001000){
 PORTB=0b00010000;
 }else if(LEDstate==0b010000){
 PORTB=0b00100000;
 }else if(LEDstate==0b100000){
 PORTB=0b01000000;
 }else if(LEDstate==0b000011){
 PORTB=0b10000000;
 }else {
 PORTB=0x00;
 }
//aceasta functie preia valoarea trimisa de dsp( valorile sunt intre anumite nivele
//exemplu nivel 0 (LED0) corespunde unei valori intre (0A-100mA) s.s.m.d. 
}
/*
void Afisor_2Cifre(int value){
//placeholder pentru porti liberi pentru 2 cifre
 cifra0=value%10;
 cifra1=(value/10)%10;
if(cifra0==0)
esle if(cifra0==1)
else if(cifra0==2)
else if(cifra0==3)
else if(cifra0==4)
else if(cifra0==5)
else if(cifra0==6)
else if(cifra0==7)
else if(cifra0==8)
else if(cifra0==9)

if(cifra1==0)
else if(cifra1==1)
else if(cifra1==2)
else if(cifra1==3)
else if(cifra1==4)
else if(cifra1==5)
else if(cifra1==6)
else if(cifra1==7)
else if(cifra1==8)
else if(cifra1==8)
}
*/



int ValAfisorButon(void){
int SUMA;
//ar trebui sa ma mai gandesc cu butonul ca un fel de multi switch ca nu e un switch
//ar trebui sa il pun intr-o
char buffer_calc;
char i;
if(button_pressed==0)//buton apasat
//fa astfel incat daca butonul a fost apasat sa ne arate 12 ore de consum cat timp e apasat si daca "nu a fost apasat" sa ne arate ultimele 24 de ore
 { 
  SUMA=0;
  for(i=1;i<=24;i++)
  {   SUMA=SUMA+arrayOre[i];
  }
  return val_afisor=SUMA;                          
  //sfarsitul functiei de 24 de ore
 }
   else
 {SUMA=0;
  
  if(contorHr>12)
   {
   buffer_calc=contorHr-12;
    for(i=buffer_calc;i<=contorHr;i++)
      {
      SUMA=SUMA+arrayOre[i];
      }
    }
    else  {
       buffer_calc=12-contorHr;
       for(i=24-buffer_calc;i<=24;i++)
        {
        SUMA=SUMA+arrayOre[i];
        }
       for(i=1;i<=contorHr;i++)
       {
       SUMA=SUMA+arrayOre[i];
       }
    return val_afisor=SUMA;


  }
 
  }
    }
  







 
void main(void)
{
// Declare your local variables here

// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=(1<<CLKPCE);
CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
// State: Bit7=1 Bit6=1 Bit5=1 Bit4=1 Bit3=1 Bit2=1 Bit1=1 Bit0=1 
PORTB=(1<<PORTB7) | (1<<PORTB6) | (1<<PORTB5) | (1<<PORTB4) | (1<<PORTB3) | (1<<PORTB2) | (1<<PORTB1) | (1<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=P Bit6=P Bit5=P Bit4=T Bit3=P Bit2=P Bit1=T Bit0=P 
PORTD=(1<<PORTD7) | (1<<PORTD6) | (1<<PORTD5) | (0<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (0<<PORTD1) | (1<<PORTD0);

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 9.766 kHz
// Mode: Normal top=0xFF
// OC0A output: Disconnected
// OC0B output: Disconnected
// Timer Period: 20.07 ms
TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
TCCR0B=(0<<WGM02) | (1<<CS02) | (0<<CS01) | (1<<CS00);
TCNT0=0x3C;
OCR0A=0x00;
OCR0B=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2A output: Disconnected
// OC2B output: Disconnected
ASSR=(0<<EXCLK) | (0<<AS2);
TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (0<<COM2B1) | (0<<COM2B0) | (0<<WGM21) | (0<<WGM20);
TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (0<<CS20);
TCNT2=0x00;
OCR2A=0x00;
OCR2B=0x00;

// Timer/Counter 0 Interrupt(s) initialization
TIMSK0=(0<<OCIE0B) | (0<<OCIE0A) | (1<<TOIE0);

// Timer/Counter 1 Interrupt(s) initialization
TIMSK1=(0<<ICIE1) | (0<<OCIE1B) | (0<<OCIE1A) | (0<<TOIE1);

// Timer/Counter 2 Interrupt(s) initialization
TIMSK2=(0<<OCIE2B) | (0<<OCIE2A) | (0<<TOIE2);

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// Interrupt on any change on pins PCINT0-7: Off
// Interrupt on any change on pins PCINT8-15: Off
// Interrupt on any change on pins PCINT16-23: Off
// Interrupt on any change on pins PCINT24-31: Off
EICRA=(0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
EIMSK=(0<<INT2) | (0<<INT1) | (0<<INT0);
PCICR=(0<<PCIE3) | (0<<PCIE2) | (0<<PCIE1) | (0<<PCIE0);

// USART0 initialization
// USART0 disabled
UCSR0B=(0<<RXCIE0) | (0<<TXCIE0) | (0<<UDRIE0) | (0<<RXEN0) | (0<<TXEN0) | (0<<UCSZ02) | (0<<RXB80) | (0<<TXB80);

// USART1 initialization
// USART1 disabled
UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);

// Analog Comparator initialization
// Analog Comparator: Off
// The Analog Comparator's positive input is
// connected to the AIN0 pin
// The Analog Comparator's negative input is
// connected to the AIN1 pin
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
ADCSRB=(0<<ACME);
// Digital input buffer on AIN0: On
// Digital input buffer on AIN1: On
DIDR1=(0<<AIN0D) | (0<<AIN1D);

// ADC initialization
// ADC disabled
ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);

// SPI initialization
// SPI disabled
SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);

// TWI initialization
// TWI disabled
TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);

// Globally enable interrupts
#asm("sei")

while (1)
      {
      LED_Stare_Curent();
      if(check_pulse==1)
      {
        cont_pulse=0;
        while(check_pulse!=0)
          {if(in_semnal_p==1)
            {
            cont_pulse=cont_pulse+1;
            }
          }
      }
      nrTotalPuls=cont_pulse;
      ValAfisorButon();
      
      
      
      
      
      
      
      
      
      }
 }
