5 X=0
10 GOSUB 100:s=f:q=k+1:y=n+1
30 X=0
80 s=1-s+f:RETURN
100 q=m-k:y=m-n:z=m-k-n:f=1
110 X=0
120 f=(q+.5)*LNq+(y+.5)*LNy-(m+.5)*LNm-(z+.5)*LNz+(1/q+1/y-1/m-1/z)/12:f=EXPf:RETURN
500 X=0
510 X=0