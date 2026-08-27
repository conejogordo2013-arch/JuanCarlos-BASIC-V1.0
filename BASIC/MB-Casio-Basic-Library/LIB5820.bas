5 GOTO10010
10 DATAC,0,10,20
20 DATAx,nx,10,30
30 DATAx,1,20,40
40 DATA1/x,-1/x,30,50
50 DATA,1/(2),40,60
60 DATAa,aloga,50,70
70 DATAe,e,60,80
80 DATAe,ne,70,90
90 DATAlogx,1/x,80,100
100 DATAx,x(logx+1),90,110
110 DATAsinx,cosx,100,120
120 DATAcosx,-sinx,110,130
130 DATAtanx,secx,120,140
140 DATAcotx,-cosecx,130,150
150 DATAsecx,secxtanx,140,160
160 DATAcosecx,-cosecxcotx,150,170
170 DATAsinax,acosax,160,180
180 DATAcosax,-asinax,170,190
190 DATAtanax,asecax,180,200
200 DATAcotax,-acosecax,190,210
210 DATAsinx,1/(1-x)          (y</2),200,220
220 DATAcosx,-1/(1-x)           (0<y<),210,230
230 DATAtanx,1/(1+x)           (y</2),220,240
240 DATAcotx,-1/(1+x)          (y</2),230,250
250 DATAsecx,"1/(x(x-1))    (0<y<,x>1)",240,260
260 DATAcosecx,"1/(x(x-1))  (y</2,x>1)",250,270
270 DATAsinhx,coshx,260,280
280 DATAcoshx,sinhx,270,290
290 DATAtanhx,sechx,280,300
300 DATAcothx,-cosechx,290,310
310 DATAsechx,-sechxtanhx,300,320
320 DATAcosechx,-cosechxcothx,310,330
330 DATAsinhx,1/(1+x),320,340
340 DATAcoshx,"1/(x-1)         (y>0,x>1)",330,350
350 DATAtanhx,1/(1-x)              (x<1),340,360
360 DATAcothx,1/(1-x)              (x>1),350,370
370 DATAsechx,-1/(x(1-x))        (0<x<1),360,380
380 DATAcosechx,-1/(x(x+1)),370,380
10010 MODE8:DIM:x=10:y=380:r=x
10020 DEFCHR$(255)="A2A49C92A2"
10030 DEFCHR$(254)="0000FE0000"
10110 RESTORE(r)
10120 READm$,n$,b,c
10130 l$="["+MID$(STR$(r/10),2)+"]":l=32-LEN(l$)
10140 CLS:PRINT"y =";m$;TAB(l);l$;"y";CHR$(131);"=";n$;
10150 z=ASC(INPUT$(1,@))
10170 IFz=29 ANDr<>x THENr=x:GOTO10110
10180 IFz=28 ANDr<>y THENr=y:GOTO10110
10190 IFz=30 ANDr<>b THENr=b:GOTO10110
10200 IF(z=31 ORz=13) ANDr<>c THENr=c:GOTO10110
10280 GOTO10150
