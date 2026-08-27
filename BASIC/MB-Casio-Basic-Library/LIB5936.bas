5 GOTO10010
10 DATACoulomb's law (electric f.),"F=kQQ/r , k=9*10[Nm/C]",10,20,
20 DATAElectric field,"E=V/d , F=QE , W=QV",10,30,
30 DATACapacitance,"Q=CV , C=S/d",20,40,
40 DATACapacitance,"C=C+C , 1/C=1/C+1/C",30,50,
50 DATADielectric constant,"D=E , C=C",40,60,
60 DATAElectrostatic energy,U=1/2QV=1/2CV,50,70,
70 DATAElectrons in electric field,"a=QE/m , 1/2mv=eV",60,80,
80 DATACoulomb's law (magnetic f.),"F=kmm/r , k=10/(4)",70,90,
90 DATAMagnetic field,"H=I/2r , H=I/2r , H=nI",80,100,
100 DATAMagnetic field,F=IHl=IBl,90,110,
110 DATAMagnetic flux density,B=m/4r=H,100,120,
120 DATALorentz force,"F=QvB , r=mv/QB",110,130,
130 DATAElectrons in magnetic field,"1/2mv=QBr/2m , =v/r=QB/m",120,140,
140 DATAFaraday's law of induction,V=-n/t,130,150,
150 DATAElectromagnetic induction,"V=El=vBl , I=vBl/R",140,160,
160 DATAMutual induction,V=-MI/t,150,170,
170 DATASelf-induction,V=-LI/t,160,170,
10010 MODE8:DIM:x=10:y=170:r=x
10020 DEFCHR$(254)="3E020C223E"
10040 DEFCHR$(253)="2E2A3A0000"
10050 DEFCHR$(252)="123E020000"
10110 RESTORE(r)
10120 CLS:READm$,n$,b,c,d
10130 l$="["+MID$(STR$(r/10),2)+"]":l=32-LEN(l$)
10140 PRINTm$;TAB(l);l$;n$;:LOCATE0,0:LOCATE1,1
10150 z=ASC(INPUT$(1,@))
10170 IFz=29 ANDr<>x THENr=x:GOTO10110
10180 IFz=28 ANDr<>y THENr=y:GOTO10110
10190 IFz=30 ANDr<>b THENr=b:GOTO10110
10200 IF(z=31 ORz=13) ANDr<>c THENr=c:GOTO10110
10280 GOTO10150
