.section/dm data1;
// intrari
.var E;
.var U;
.var I;
.var P;
.var A;
.var timp;
.var prag;
.var N;


.var output[1000];

.section/pm IVreset;

jump start;nop;nop;nop;
rti;nop;nop;nop;
rti;nop;nop;nop;
rti;nop;nop;nop;
rti;nop;nop;nop;
rti;nop;nop;nop;
rti;nop;nop;nop;

.section/pm program;

calcul:
MR = 0
MX0=DM(U);
MY0=DM(I);
MR=MX0*MY0;
DM(P)=MR;
MX0=DM(timp);
MY0=DM(P);
MR=MR+MX0*MY0;   //calculul energiei

DM(E)=MR;
MX0=DM(E);
MY0=DM(prag);
MR=DIVS MX0, MY0;
DM(N)=MR;
// daca N > 0 atunci se genereaza un puls



stop: jump stop;