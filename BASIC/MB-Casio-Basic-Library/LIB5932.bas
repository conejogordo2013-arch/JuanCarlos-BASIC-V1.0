5 GOTO10010
10 DATAWave,"v=/T=f , y=asin2(t/T-x/)",10,20,
20 DATAWave of string,v=(F/),10,30,1,3E40484830
30 DATAInterference,"l-l=(2n+1)/2 , l-l=n",20,40,
40 DATAStationary wave,"l=n/2 , l=(2n-1)/4   (n0)",30,50,
50 DATARefraction,n=sin/sin=v/v=/,40,60,
60 DATANatural frequency (wave),f=(1/2l)(T/),50,70,1,3E40484830
70 DATAVelocity of sound,v=331.5+0.61T,60,80,
80 DATADoppler effect,f=f(v-v)/(v-v),70,90,
90 DATABeat,f=f-f    (f>f),80,100,
100 DATAReflectivity,R=((n-n)/(n+n)),90,110,
110 DATACritical angle,sin=n/n,100,120,
120 DATAde Broglie wave,=h/mv,110,130,
130 DATAQuantum condition,2r=nh/mv=n,120,140,
140 DATAPhotoelectron,1/2mv=h-W,130,150,1,3E02040830
150 DATAFrequency condition,h=Em-En    (m>n),140,160,
160 DATALight wave,"=c/ , c=2.998*10 [m/s]",150,160,1,3E02040830
10010 MODE8:DIM:x=10:y=160:r=x
10020 DEFCHR$(255)="424C300806"
10030 DEFCHR$(253)="2E2A3A0000"
10050 DEFCHR$(252)="123E020000"
10110 RESTORE(r)
10120 CLS:READm$,n$,b,c,d:IFd=1 THENREADd$:DEFCHR$(254)=d$
10130 l$="["+MID$(STR$(r/10),2)+"]":l=32-LEN(l$)
10140 PRINTm$;TAB(l);l$;n$;
10150 z=ASC(INPUT$(1,@))
10170 IFz=29 ANDr<>x THENr=x:GOTO10110
10180 IFz=28 ANDr<>y THENr=y:GOTO10110
10190 IFz=30 ANDr<>b THENr=b:GOTO10110
10200 IF(z=31 ORz=13) ANDr<>c THENr=c:GOTO10110
10280 GOTO10150
