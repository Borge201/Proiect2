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
MR = 0              //registrul de rezultat = 0
MX0=DM(U);          //in registrul x este incarcata valoarea tensiunii
MY0=DM(I);          //in registrul y este incarcata valoarea curentului
MR=MX0*MY0;         //in registrul de rezultat este calculata puterea
DM(P)=MR;           //valoarea puterii este incarcata in memorie
MX0=DM(timp);       //reg x ia valoarea timpului
MY0=DM(P);          //reg y ia valoarea puterii
MR=MR+MX0*MY0;      //calculul energiei (suma de produse)

DM(E)=MR;           //valoarea energiei este incarcata in memorie
MX0=DM(E);          //in reg x se incarca valoarea energiei
MY0=DM(prag);       //in y este incarcata valoarea pragului
MR=DIVS MX0, MY0;   //in reg de rezultat o sa apara numarul N de impulsuri 
                    //care trebuie generate dupa impartirea energiei la pragul de 1KWh
                    //(3 KWh/1 KWh => 3 impulsuri)
DM(N)=MR;           //numarul de impulsuri salvat in memorie
// daca N > 0 atunci se genereaza un puls



stop: jump stop;
