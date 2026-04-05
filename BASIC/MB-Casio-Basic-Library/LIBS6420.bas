10 X=0
15 X=0
20 X=0
30 X=0
40 GOSUB"LIB0:S6410":GOSUB 400:x=y:y=x*x:x=n+SQR(2*n)*x+2/3*(y-1)+x*(y-7)/9/SQR(2*n)-2/405/n*(y*(3*y+7)-16):IF x<0 THEN x=0
50 IF n>100 THEN 80
60 X=0
80 y=x:RETURN
100 q=p:GOSUB"LIB0:S6220":GOSUB 400:p=y
110 z=EXP(((n-1)*LN(x/n)-LN(4*PI*x)+n-x-1/n/6)/2)
120 x=x+(p-q)/z:p=q:x=ROUND(x,-6):RETURN
400 X=0
500 X=0
510 X=0