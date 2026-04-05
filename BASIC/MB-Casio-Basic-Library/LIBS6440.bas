10 X=0
15 X=0
20 X=0
30 X=0
40 X=0
50 X=0
60 GOSUB 200
80 y=x:RETURN
100 GOSUB"LIB0:S6420":GOSUB 400:x=y:a=n-2
110 x=x/n*(1+((x-a)/2+(((4*x-11*a)*x+a*(7*n-10))/24+(((2*x-10*a)*x+a*(17*n-26))*x-a*a*(9*n-6))/48/m)/m)/m):RETURN
200 GOSUB 100
210 d=x:c=p:GOSUB"LIB0:S6240":GOSUB 400:p=c
220 z=n+m:z=EXP((z*LN(z/(n*x+m))+(n-2)*LNx+LN(n*m/z)-LN(4*PI)-(1/n+1/m-1/z)/6)/2):x=x+(y-p)/z
230 IF ABS(d-x)>3E-4 THEN 210 ELSE RETURN
400 X=0
500 X=0
510 X=0