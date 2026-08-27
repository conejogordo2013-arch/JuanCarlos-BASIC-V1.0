5 GOTO10010
10 DATA1/p,1,10,20
20 DATA1/p,t,10,30
30 DATA1/p,"t/(n-1)!        (n=1,2,3,)",20,40
40 DATA1/(pm),e,30,50
50 DATA1/(p(p+m)),1/m(1-e),40,60
60 DATA1/(p(p+m)),1/m(e+mt-1),50,70
70 DATAa/(p+a),sinat,60,80
80 DATAp/(p+a),cosat,70,90
90 DATA1/(p+a),1/asinat,80,100
100 DATAa/(p-a),sinhat,90,110
110 DATAp/(p-a),coshat,100,120
120 DATA1/(p-a),1/asinhat,110,130
130 DATA1/(p(p+a)),1/a(1-cosat),120,140
140 DATA1/(p(p+a)),1/a(at-sinat),130,150
150 DATA1/((p+m)(p+n)),1/(n-m)(e-e),140,160
160 DATAp/((p+m)(p+n)),1/(m-n)(me-ne),150,170
170 DATA1/(p+m),te,160,180
180 DATA1/(p+m),"1/(n-1)!te  (n=1,2,3,)",170,190
190 DATAp/(p+m),e(1-mt),180,200
200 DATA1/(p(p+m)),1/m(1-(1+mt)e),190,210
210 DATA1/(p(p+m)),t/m-2/m+2/me+t/me,200,220
220 DATA(p+n)/(p+m),((n-m)t+1)e,210,230
230 DATA1/(p+a),1/2a(sinat-atcosat),220,240
240 DATAp/(p+a),t/2asinat,230,250
250 DATAp/(p+a),1/2a(sinat+atcosat),240,260
260 DATA(p-a)/(p+a),tcosat,250,270
270 DATA1/((p+m)+n),1/nesinnt,260,280
280 DATA(p+m)/((p+m)+n),ecosnt,270,290
290 DATA1/(p-a),1/2a(sinhat-sinat),280,300
300 DATAp/(p-a),1/2a(coshat-cosat),290,310
310 DATAp/(p-a),1/2a(sinhat+sinat),300,320
320 DATAp/(p-a),1/2(coshat+cosat),310,330
330 DATAp/(p+4a),1/2asinatsinhat,320,340
340 DATA4a/(p+4a),sinatcoshat-cosatsinhat,330,350
350 DATA1/p((p-m)/(p+m)),-1+2e,340,360
360 DATA1/p((p-m)/(p+m)),2/m-t-2/me,350,360
10010 MODE8:DIM:x=10:y=360:r=x
10020 DEFCHR$(255)="7840384038"
10030 DEFCHR$(254)="40F8480000"
10040 DEFCHR$(253)="90B8900000"
10050 DEFCHR$(252)="7850502000"
10110 RESTORE(r)
10120 READm$,n$,b,c
10130 l$="["+MID$(STR$(r/10),2)+"]":l=32-LEN(l$)
10140 CLS:PRINT"F(p)=";m$;TAB(l);l$;n$;
10150 z=ASC(INPUT$(1,@))
10170 IFz=29 ANDr<>x THENr=x:GOTO10110
10180 IFz=28 ANDr<>y THENr=y:GOTO10110
10190 IFz=30 ANDr<>b THENr=b:GOTO10110
10200 IF(z=31 ORz=13) ANDr<>c THENr=c:GOTO10110
10280 GOTO10150
