# Manual JCC-120 — Scientific Library 120

## 1. Qué contiene esta biblioteca

La **JCC-120 / Scientific Library 120** expone los 120 programas científicos principales de `MB-Casio-Basic-Library`; el directorio conserva además módulos auxiliares hasta completar 142 ficheros BASIC procedentes de la biblioteca para las calculadoras/ordenadores de bolsillo Casio FX-850P y FX-880P. El índice original está en [`LIB_INFO.htm`](MB-Casio-Basic-Library/LIB_INFO.htm). Cada `LIBxxxx.bas` es un programa independiente; los prefijos `LIBM` y `LIBS` identifican subprogramas de estadística y el prefijo `LIBK` identifica el menú/lanzador.

La biblioteca se conserva para consulta, uso en una máquina compatible y trabajo de portabilidad. No es una API de JuanCarlos BASIC ni sus ficheros se importan automáticamente desde las lecciones.

## 2. Ejecución en JuanCarlos BASIC

Desde la raíz del proyecto puede cargar y ejecutar un programa:

```bash
node run_prg.js --file BASIC/MB-Casio-Basic-Library/LIB5010.bas
```

Para cargarlo sin iniciarlo, use la modalidad adecuada para comprobaciones de sintaxis:

```bash
node run_prg.js --file BASIC/MB-Casio-Basic-Library/LIB5010.bas --no-run
```

El ejecutor acepta respuestas en cola para programas que usen `INPUT`:

```bash
node run_prg.js --file programa.bas --inputs 12,7
```

No suministre entradas ficticias para declarar una prueba funcional satisfactoria: los programas originales suelen ser interactivos y algunas teclas se leen con `INPUT$` o con el teclado específico del Casio.

## 3. Verificación de toda la colección

Use siempre el comprobador de la raíz:

```bash
./scripts/check_basic_compat.sh
```

La prueba de carga verifica el contrato mínimo reproducible: hay 142 ficheros `.bas` preservados (120 entradas científicas más auxiliares/menús), todos se cargan y todos devuelven `READY` sin errores de parseo. Para ejecutar toda la colección sin inventar respuestas, use además `./scripts/run_casio_library_smoke.sh`: inicia cada programa y lo detiene de forma controlada en su primera petición de teclado o de `INPUT`. Esto comprueba que cada programa alcanza su frontera interactiva sin convertir una entrada ausente en un dato falso; tampoco sustituye la validación funcional con datos de referencia.

Para validar **un** programa de forma funcional:

1. Consulte su propósito en `LIB_INFO.htm`.
2. Elija entradas con resultado conocido y anote el resultado esperado.
3. Ejecútelo en un FX-850P/880P o entorno que implemente su dialecto y periféricos.
4. Repita la ejecución en JuanCarlos BASIC solo si no usa extensiones de Casio no implementadas.
5. Registre tanto las entradas como la salida; no cambie el `.bas` original durante la prueba.

## 4. Límites de compatibilidad importantes

Los programas usan construcciones y dispositivos específicos, entre ellos `MODE`, `DEFSEG`, `PEEK`, `POKE`, `DEFCHR$`, `LPRINT`, puertos `COM`/`CAS`, teclado por `INPUT$` y llamadas a otros programas. JuanCarlos BASIC puede cargar el texto, pero no garantiza que estas características tengan la semántica del hardware Casio. En particular:

* Los tests de memoria, ROM, impresora, RS-232 y cinta requieren el dispositivo original o un emulador fiel.
* Los subprogramas `LIBM*` y `LIBS*` deben conservarse junto a los programas estadísticos que los llaman.
* Las líneas con `GOTO "LIB0:..."` o llamadas entre ficheros se resuelven con el cargador de bibliotecas de la JCC cuando el módulo existe en el árbol.
* `RESTORE n` reposiciona `READ` en la primera línea `DATA` igual o posterior a `n`, necesario para índices, tablas y formularios científicos.
* Un programa interactivo puede permanecer esperando una tecla de forma correcta. No debe clasificarse como fallido por ese motivo.

## 5. Catálogo por área

Los nombres y descripciones siguientes son una traducción orientativa del índice original; el nombre del fichero es la referencia normativa.

| Área | Programas principales |
| --- | --- |
| Sistema | `LIB0400` prueba de memoria e interfaces; `LIB0800` descarga; `LIB0900` conversión; `LIB1000` cálculos de memoria; `LIBK0630` menú e inicio. |
| Álgebra y análisis numérico | `LIB5010` factorización prima; `LIB5020` MCD/MCM; `LIB5040` eliminación de Gauss; `LIB5050`, `LIB5060` ecuaciones cuadrática y cúbica; `LIB5080`, `LIB5090` raíces por Newton y bisección; `LIB5100` matrices; `LIB5200` Romberg; `LIB5220` Runge-Kutta; `LIB5230` interpolación de Lagrange. |
| Funciones especiales y complejos | `LIB5250` gamma; `LIB5260`–`LIB5290` Bessel J/Y/I/K; `LIB5300` números complejos; `LIB5350` conversión binario-decimal-hexadecimal. |
| Geometría | `LIB5510`–`LIB5570` rectas, círculos y tangentes; `LIB5600`–`LIB5675` áreas y superficies; `LIB5700`–`LIB5760` volúmenes y poliedros. |
| Cálculo | `LIB5800` factorización; `LIB5810` trigonometría; `LIB5820` diferenciales; `LIB5830` integrales; `LIB5840` transformada de Laplace. |
| Física y conversiones | `LIB5900` tabla periódica; `LIB5910` constantes científicas; `LIB5920` disociación electrolítica; `LIB5930` movimiento/energía; `LIB5932` ondas; `LIB5934` circuitos; `LIB5936` campos; `LIB5938` termodinámica; `LIB5950`–`LIB5980` conversiones métricas. |
| Probabilidad y estadística | `LIB6210`–`LIB6240` distribuciones; `LIB6310`–`LIB6330` frecuencias acumuladas; `LIB6410`–`LIB6460` cuantiles y aleatorios; `LIB6500`–`LIB6680` estimación y regresión; `LIB6710`–`LIB6772` contrastes. Sus auxiliares son `LIBM6510`, `LIBM6710`–`LIBM6770` y `LIBS6020`–`LIBS6440`. |


## 6. Lista completa de librerías JCC-120

La lista siguiente es la referencia rápida integrada en la interfaz. Las 120 entradas científicas principales se complementan con menús y módulos auxiliares para conservar la colección completa sin tocar los `.bas` originales.

| Código | Archivo | Función / primera descripción |
| --- | --- | --- |
| 0400 | `LIB0400` | 10 CLEAR:CLS:DEFSEG=0:K=PEEK(&H6B4)/4+PEEK(&H6B5)*64 20 IF K<32 THENK1=8:K2=K-K1 30 IF K=32 OR K=64 THENK1=32: |
| 0800 | `LIB0800` | 10 DATA1E,28,A8,28,1E,0,2,7C,80,0,8,4,FE,80,80,0,20,40,80,0,C6,AA,92,82,C6,72,8E,80,8E,72,AA,54,AA,54,AA,FE,FE |
| 0900 | `LIB0900` | 10 MODE8:DEFSEG=0:GOTO110 20 GOSUB20 30 OPENp$ FORINPUTAS#1:IFASC(INPUT$(1,1))<>2 THENCLOSE:GOTO30 ELSERETURN |
| 1000 | `LIB1000` | 5 ONERRORGOTO500 10 MODE8:DIM:ERASEa,a$:DIMa(3),a$(1):DEFSEG=0 100 CLS:PRINT" MC[�] MR[�] M-[�] M+[�]"; |
| 5010 | `LIB5010` | 5 ONERRORGOTO1000 10 MODE8:DIM:x=2:c$=CHR$(5) 20 CLS:PRINT"Prime factors (2�Base<10��)";:a$=" *" |
| 5020 | `LIB5020` | 5 ONERRORGOTO1000 10 MODE8:DIM:c$=CHR$(5):a=1:b=1 20 CLS:PRINT"G.C.M. & L.C.M. (1�a,b<10��)"; |
| 5040 | `LIB5040` | 5 ONERRORGOTO2000:DEFSEG=0 10 MODE8:DIM:ERASEa:c$=CHR$(5):n=2:m$="ax1+bx2+cx3+dx4+ex5+fx6+gx7" 30 CLS:PRINT"ax |
| 5050 | `LIB5050` | 5 ONERRORGOTO1000 10 MODE8:DIM:c$=CHR$(5):a=1:b=0:c=0 20 CLS:PRINT"ax�+bx+c=0"; |
| 5060 | `LIB5060` | 5 ONERRORGOTO1000 10 MODE8:DIM:c$=CHR$(5):ANGLE0:a=1:b=0:c=0:d=0 20 CLS:PRINT"ax�+bx�+cx+d=0"; |
| 5080 | `LIB5080` | 5 ONERRORGOTO1000 10 DEFCHR$(255)="0000FE0000":MODE8:DIM:PRINTCHR$(15); 30 f$="":c$=CHR$(5):s=0:h=1e-5:e=1e-7: |
| 5090 | `LIB5090` | 5 ONERRORGOTO1000 10 DEFCHR$(255)="0000FE0000":MODE8:DIM:PRINTCHR$(15); 30 f$="":c$=CHR$(5):s=0:t=0:e=1e-7:m=3 |
| 5100 | `LIB5100` | 5 ONERRORGOTO2000:DEFSEG=0 10 CLS:MODE8:DIM:ERASEa,b,d:DIMa(1,1),b(1,1),d(1,1):m=1:n=1:o=1:p=1:q=1:r=1:c$=CHR$ |
| 5200 | `LIB5200` | 5 ONERRORGOTO1000 10 DEFCHR$(255)="0000FE0000":MODE8:DIM:PRINTCHR$(15); 30 f$="":c$=CHR$(5):a=0:b=0:e=1e-7:m=8 |
| 5220 | `LIB5220` | 5 ONERRORGOTO1000 10 DEFCHR$(254)="060A12227E":MODE8:DIM:PRINTCHR$(15); 30 f$="":c$=CHR$(5):a=0:b=0:h=1:ANGLE1 |
| 5230 | `LIB5230` | 5 ONERRORGOTO1000:DEFSEG=0 10 MODE8:DIM:c$=CHR$(5):n=2:x=0:ERASEa,b:m$="Lagrange's interpolation" 20 CLS:PRINT |
| 5250 | `LIB5250` | 5 ONERRORGOTO1000 10 MODE8:DIM:ERASEa:DIMa(8):c$=CHR$(5):DEFCHR$(255)="82FE8280C0" 20 RESTORE400:FORi=0 TO8:RE |
| 5260 | `LIB5260` | 5 ONERRORGOTO500 10 MODE8:DIM:c$=CHR$(5) 20 CLS:PRINT"Jn(x) (0�n�9,0�x�30)"; |
| 5270 | `LIB5270` | 5 ONERRORGOTO500 10 MODE8:DIM:c$=CHR$(5) 20 CLS:PRINT"Yn(x) (0�n�9,0<x�30)"; |
| 5280 | `LIB5280` | 5 ONERRORGOTO500 10 MODE8:DIM:c$=CHR$(5) 20 CLS:PRINT"In(x) (0�n�9,0�x�10)"; |
| 5290 | `LIB5290` | 5 ONERRORGOTO500 10 MODE8:DIM:c$=CHR$(5) 20 CLS:PRINT"Kn(x) (0�n�9,0<x�10)"; |
| 5300 | `LIB5300` | 5 ONERRORGOTO1000 10 MODE8:DIM:DEFCHR$(255)="0000FE0000":e=0:f=0:c=0:d=0:g=0:h=0:l$=CHR$(5):GOSUB580 20 a=e:b= |
| 5350 | `LIB5350` | 5 ONERRORGOTO2000 10 CLS:MODE8:DIM:a=1:x=0:y=0:c$=CHR$(5):p=2^31:q=2^32:r=0:x$=" 0":ERASEa$,b$:DIMa$(5),b$(15) |
| 5510 | `LIB5510` | 5 ONERRORGOTO500 10 MODE8:DIM:ERASEa:DIMa(5):a$="x1y1x2y2ab":c$=CHR$(5) 20 CLS:PRINT"y=ax+b �- (x1,y1),(x2,y2) |
| 5520 | `LIB5520` | 5 ONERRORGOTO500 10 MODE8:DIM:a=0:c=0:c$=CHR$(5) 20 CLS:PRINT"Angle(�) �- y=ax+b,y=cx+d"; |
| 5530 | `LIB5530` | 5 ONERRORGOTO500 10 MODE8:DIM:ERASEa:DIMa(3):a$="a b x1y1":c$=CHR$(5) 20 CLS:PRINT"Distance �- y=ax+b,(x1,y1)" |
| 5540 | `LIB5540` | 5 ONERRORGOTO500 10 MODE8:DIM:ERASEa:DIMa(1):c$=CHR$(5):x=0:y=0:a=0:m$="XY" 20 CLS:PRINT"(X,Y) �- (x,y),angle( |
| 5550 | `LIB5550` | 5 ONERRORGOTO500 10 MODE8:DIM:ERASEa:DIMa(8):l$="abr":m$="x1y1x2y2x3y3":c$=CHR$(5) 20 CLS:PRINT"Circle (x1,y1 |
| 5560 | `LIB5560` | 5 ONERRORGOTO500 10 MODE8:DIM:ERASEa:DIMa(4):a$="a b r x1y1":c$=CHR$(5) 20 CLS:PRINT"(x-a)�+(y-b)�=r�,(x1,y1)" |
| 5570 | `LIB5570` | 5 ONERRORGOTO500 10 MODE8:DIM:ERASEa,b,c$:DIMa(4),b(7),c$(7):a$="a b r x1y1":c$=CHR$(5) 20 CLS:PRINT"(x-a)�+(y |
| 5600 | `LIB5600` | 5 ONERRORGOTO900 20 MODE8:DIM:a=0:b=0:c=0:h=0:d=0:c$=CHR$(5) 30 CLS:PRINT"Area (triangle)";TAB(0);"1:ah/2 2:a |
| 5605 | `LIB5605` | 5 ONERRORGOTO900 20 MODE8:DIM:a=0:b=0:h=0:c$=CHR$(5) 30 CLS:PRINT"(a+b)h/2 a:b:base h:height"; |
| 5610 | `LIB5610` | 5 ONERRORGOTO900 20 MODE8:DIM:a=0:b=0:c=0:h=0:c$=CHR$(5) 30 CLS:PRINT"Area (parallelogram)";TAB(0);"1:ah |
| 5615 | `LIB5615` | 5 ONERRORGOTO100 20 MODE8:DIM:r=0:c$=CHR$(5) 30 CLS:PRINT"�r� r:radius"; |
| 5620 | `LIB5620` | 5 ONERRORGOTO900 20 MODE8:DIM:l=0:r=0:a=0:c$=CHR$(5):ANGLE0 30 CLS:PRINT"Area (sector)";TAB(0);"1:lr/2 2:� |
| 5625 | `LIB5625` | 5 ONERRORGOTO900 10 ANGLE1:MODE8:DIM:l=0:r=0:c$=CHR$(5):n$="(lr-r�sin(l/r))/2" 50 m$=n$+" l:arc":s$="l":z= |
| 5630 | `LIB5630` | 5 ONERRORGOTO900 20 MODE8:DIM:a=0:b=0:c$=CHR$(5) 30 CLS:PRINT"�ab a:b:radius"; |
| 5635 | `LIB5635` | 5 ONERRORGOTO900 10 MODE8:DIM:ERASEa,a$:DIMa(2),a$(2):a$(0)="r:inside":a$(1)="R:outside":a$(2)="l:side" 20 ANG |
| 5650 | `LIB5650` | 5 ONERRORGOTO900 20 MODE8:DIM:r=0:c$=CHR$(5) 30 CLS:PRINT"4�r� r:radius"; |
| 5655 | `LIB5655` | 5 ONERRORGOTO900 20 MODE8:DIM:a=0:b=0:r=0:h=0:c$=CHR$(5) 30 CLS:PRINT"2�rh+�(a�+b�) h:height"; |
| 5660 | `LIB5660` | 5 ONERRORGOTO900 20 MODE8:DIM:r=0:h=0:c$=CHR$(5) 30 CLS:PRINT"2�rh+�ar,a=�(h(2r-h)) r:radius"; |
| 5665 | `LIB5665` | 5 ONERRORGOTO900 20 MODE8:DIM:r=0:h=0:c$=CHR$(5) 30 CLS:PRINT"2�rh+2�r� r:radius h:height"; |
| 5670 | `LIB5670` | 5 ONERRORGOTO900 20 MODE8:DIM:r=0:h=0:c$=CHR$(5) 30 CLS:PRINT"�r�(r�+h�)+�r� r:radius"; |
| 5675 | `LIB5675` | 5 ONERRORGOTO900 20 MODE8:DIM:r=0:s=0:h=0:c$=CHR$(5) 30 CLS:PRINT"�(R+r)�(h�+(R-r)�)+�(R�+r�)"; |
| 5700 | `LIB5700` | 5 ONERRORGOTO900 20 MODE8:DIM:r=0:c$=CHR$(5) 30 CLS:PRINT"4�r�/3 r:radius"; |
| 5705 | `LIB5705` | 5 ONERRORGOTO900 20 MODE8:DIM:a=0:b=0:h=0:c$=CHR$(5) 30 CLS:PRINT"�h(3a�+3b�+h�)/6 a:b:radius"; |
| 5710 | `LIB5710` | 5 ONERRORGOTO900 20 MODE8:DIM:r=0:h=0:c$=CHR$(5) 30 CLS:PRINT"2�r�h/3 r:radius h:height"; |
| 5715 | `LIB5715` | 5 ONERRORGOTO900 20 MODE8:DIM:r=0:h=0:c$=CHR$(5) 30 CLS:PRINT"�r�h r:radius h:height"; |
| 5720 | `LIB5720` | 5 ONERRORGOTO900 20 MODE8:DIM:r=0:h=0:c$=CHR$(5) 30 CLS:PRINT"�r�h/3 r:radius h:height"; |
| 5725 | `LIB5725` | 5 ONERRORGOTO900 20 MODE8:DIM:r=0:s=0:h=0:c$=CHR$(5) 30 CLS:PRINT"�h(r�+rR+R�)/3 r:R:radius"; |
| 5730 | `LIB5730` | 5 ONERRORGOTO900 20 MODE8:DIM:a=0:b=0:c=0:h=0:c$=CHR$(5) 30 CLS:PRINT"bh(2a+c)/6 a:b:c:edge h:height"; |
| 5735 | `LIB5735` | 5 ONERRORGOTO900 20 MODE8:DIM:a=0:b=0:h=0:c$=CHR$(5) 30 CLS:PRINT"abh/3 a:b:edge h:height"; |
| 5740 | `LIB5740` | 5 ONERRORGOTO900 20 MODE8:DIM:a=0:b=0:c=0:d=0:h=0:c$=CHR$(5) 30 CLS:PRINT"h(ab+cd+�(abcd))/3 a:b:c:d:edge"; |
| 5745 | `LIB5745` | 5 ONERRORGOTO900 20 MODE8:DIM:a=0:b=0:c=0:c$=CHR$(5) 30 CLS:PRINT"4�abc/3 a:b:c:radius"; |
| 5750 | `LIB5750` | 5 ONERRORGOTO900 10 MODE8:DIM:ERASEa,a$:DIMa(2),a$(2):a$(0)="r:inside":a$(1)="R:outside":a$(2)="l:side" 20 s=0 |
| 5760 | `LIB5760` | 5 ONERRORGOTO900 10 MODE8:DIM:ERASEa,a$:DIMa(4),a$(4):c$=CHR$(5) 15 RESTORE800:FORi=0 TO4:READa$(i):NEXT |
| 5800 | `LIB5800` | 5 GOTO10010 10 DATAa�-b�,(a+b)(a-b),10,20 20 DATAa��b�,(a�b)(a��ab+b�),10,30 |
| 5810 | `LIB5810` | 5 GOTO10010 10 DATAsin��+cos��,1,10,20 20 DATA1+tan��,sec��,10,30 |
| 5820 | `LIB5820` | 5 GOTO10010 10 DATAC,0,10,20 20 DATAx�,nx��,10,30 |
| 5830 | `LIB5830` | 5 GOTO10010 10 DATA,x+C,10,20 20 DATAx�,x���/(n+1)+C (n+1�0),10,30 |
| 5840 | `LIB5840` | 5 GOTO10010 10 DATA1/p,1,10,20 20 DATA1/p�,t,10,30 |
| 5900 | `LIB5900` | 10 GOTO310 100 DATAAc Actinium 89(7-3a) 227.0278 101 DATAAg Silver 47(5-1b) 107.8682 |
| 5910 | `LIB5910` | 5 GOTO10010 10 DATAF ,9.648456,�10� [C�mol�],�10� [emu�mol�],E4,E3,10,20 20 DATAG ,6.6720,�10��� [m��s���kg�], |
| 5920 | `LIB5920` | 5 GOTO10010 10 DATAHCOOH,HCOO� + H�,10,20,1.77�10��,a, 20 DATACH�COOH,CH�COO� + H�,10,30,1.75�10��,a, |
| 5930 | `LIB5930` | 5 GOTO10010 10 DATAUniformly accelerated motion,"v=v�+at , a=�v/�t , s=v�t+at�/2",10,20, 20 DATANewton's equat |
| 5932 | `LIB5932` | 5 GOTO10010 10 DATAWave,"v=�/T=f� , y=a�sin2�(t/T-x/�)",10,20, 20 DATAWave of string,v=�(F/�),10,30,1,3E404848 |
| 5934 | `LIB5934` | 5 GOTO10010 10 DATAOhm's law,"V=IR (I=Q/t , R=��l/S)",10,20,1,3E40484830 20 DATAResistance,"R=R�+R� , 1/R=1/ |
| 5936 | `LIB5936` | 5 GOTO10010 10 DATACoulomb's law (electric f.),"F=k��Q�Q�/r� , k�=9*10�[N�m�/C�]",10,20, 20 DATAElectric field |
| 5938 | `LIB5938` | 5 GOTO10010 10 DATAAbsolute temperature,T[K]=t[�C]+273.15,10,20, 20 DATAHeat capacity,Q=CT=mcT,10,30, |
| 5950 | `LIB5950` | 5 GOTO10010 10 DATAx[cm],0.01x[m],X[m]=0.01*x[cm],10,20 20 DATAx[cm],0.393701x[in],X[in]=.393701*x[cm],10,30 |
| 5960 | `LIB5960` | 5 GOTO10010 10 DATAx[m�],0.01x[a],X[a]=0.01*x[m�],10,20 20 DATAx[m�],0.000247105x[acre],X[acre]=2.47105E-4*x[m |
| 5970 | `LIB5970` | 5 GOTO10010 10 DATAx[cm�],0.000001x[m�],X[m�]=1e-6*x[cm�],10,20 20 DATAx[cm�],0.0610237x[in�],X[in�]=.0610237* |
| 5980 | `LIB5980` | 5 GOTO10010 10 DATAx[g],0.001x[Kg],X[Kg]=.001*x[g],10,20 20 DATAx[g],0.0352740x[oz],X[oz]=.035274*x[g],10,30 |
| 6210 | `LIB6210` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):x=0 20 CLS:PRINT"Upper probability N(0,1�)"; 30 LOCATE0,1:PRINTc$;"x=";x;"? |
| 6220 | `LIB6220` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):n=1:x=0:DEFCHR$(254)="3E02040830" 20 CLS:PRINT"Upper probability X�(x�,�)"; |
| 6230 | `LIB6230` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):n=1:x=0:DEFCHR$(254)="3E02040830" 20 CLS:PRINT"Upper probability t(x,�)"; 3 |
| 6240 | `LIB6240` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):n=1:m=1:x=0:DEFCHR$(254)="3E02040830":DEFCHR$(252)="123E020000":DEFCHR$(253)= |
| 6310 | `LIB6310` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):x=0:n=2:p=0 20 CLS:PRINT"Cumulative frequency B(x,n,P)"; 30 z=n:s$="n":GOSUB |
| 6320 | `LIB6320` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):k=0:x=0:DEFCHR$(254)="424C300806" 20 CLS:PRINT"Cumulative frequency P(x,�)"; |
| 6330 | `LIB6330` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):m=2:k=1:n=1:x=0 20 CLS:PRINT"Cumulative frequency H(x,n,M,N)"; 30 z=m:s$="N": |
| 6410 | `LIB6410` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):p=0 20 CLS:PRINT"Percentage points N(0,1�)"; 30 LOCATE0,1:PRINTc$;"p=";p;"? |
| 6420 | `LIB6420` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):n=1:p=0:DEFCHR$(254)="3E02040830" 20 CLS:PRINT"Percentage points X�(x�,�)"; |
| 6430 | `LIB6430` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):n=1:p=0:DEFCHR$(254)="3E02040830" 20 CLS:PRINT"Percentage points t(x,�)"; 3 |
| 6440 | `LIB6440` | 10 MODE8:DIM:GOSUB500:c$=CHR$(5):n=1:m=1:p=0:DEFCHR$(254)="3E02040830":DEFCHR$(252)="123E020000":DEFCHR$(253)= |
| 6450 | `LIB6450` | 10 MODE8:DIM:CLS:ANGLE1 20 x=RAN#(1):IFx=0 THEN20 25 y=RAN#(1):IFy=0 THEN25 |
| 6460 | `LIB6460` | 5 ONERRORGOTO100 10 MODE8:DIM:DEFCHR$(254)="424C300806":k=1 20 CLS:PRINT"E(�,t)"; |
| 6500 | `LIB6500` | 5 ONERRORGOTO1000 10 MODE8:DIM:ERASEa,a$:DIMa(5),a$(1):a$(1)="Input":a$(0)="Delete":c$=CHR$(5) 20 CLS:PRINT"St |
| 6510 | `LIB6510` | 10 sq=0:GOTO"LIB0:M6510" |
| 6520 | `LIB6520` | 10 sq=1:GOTO"LIB0:M6510" |
| 6530 | `LIB6530` | 10 sq=2:GOTO"LIB0:M6510" |
| 6540 | `LIB6540` | 10 sq=3:GOTO"LIB0:M6510" |
| 6610 | `LIB6610` | 10 MODE8:DIM:GOSUB900:c$=CHR$(5):DEFCHR$(254)="A2A49C92A2":t$="N(�,��) a<�<b ��:known" 20 CLS:PRINTt$;TAB(0); |
| 6620 | `LIB6620` | 10 MODE8:DIM:GOSUB900:c$=CHR$(5):DEFCHR$(254)="A2A49C92A2":t$="N(�,��) a<�<b" 20 CLS:PRINTt$;TAB(0);"input new |
| 6630 | `LIB6630` | 10 MODE8:DIM:GOSUB900:c$=CHR$(5):t$="N(�,��) a<��<b" 20 CLS:PRINTt$;TAB(0);"input new data (Y/N) ?";:a$=INPUT$ |
| 6640 | `LIB6640` | 10 MODE8:DIM:GOSUB900:c$=CHR$(5):t$="N(�,��) a<�<b" 20 CLS:PRINTt$;TAB(0);"input new data (Y/N) ?";:a$=INPUT$( |
| 6650 | `LIB6650` | 10 MODE8:DIM:GOSUB900:c$=CHR$(5):DEFCHR$(252)="123E020000":DEFCHR$(253)="2E2A3A0000":t$="N(��,���),N(��,���) a |
| 6660 | `LIB6660` | 10 MODE8:DIM:GOSUB900:c$=CHR$(5):DEFCHR$(252)="123E020000":DEFCHR$(253)="2E2A3A0000":DEFCHR$(254)="A2A49C92A2" |
| 6670 | `LIB6670` | 10 MODE8:DIM:GOSUB900:c$=CHR$(5):f=95:r=0:s=0 45 CLS:PRINT"B(1,p) a<p<b"; 50 z=r:s$="n":GOSUB500:r=z |
| 6680 | `LIB6680` | 10 MODE8:DIM:GOSUB900:c$=CHR$(5):f=95:DEFCHR$(252)="123E020000":DEFCHR$(253)="2E2A3A0000":r=0:s=0:t=0:u=0 45 C |
| 6710 | `LIB6710` | 10 sq=226:GOSUB"LIB0:M6710" |
| 6711 | `LIB6711` | 10 sq=62:GOSUB"LIB0:M6710" |
| 6712 | `LIB6712` | 10 sq=60:GOSUB"LIB0:M6710" |
| 6720 | `LIB6720` | 10 sq=226:GOSUB"LIB0:M6720" |
| 6721 | `LIB6721` | 10 sq=62:GOSUB"LIB0:M6720" |
| 6722 | `LIB6722` | 10 sq=60:GOSUB"LIB0:M6720" |
| 6730 | `LIB6730` | 10 sq=226:GOSUB"LIB0:M6730" |
| 6731 | `LIB6731` | 10 sq=62:GOSUB"LIB0:M6730" |
| 6732 | `LIB6732` | 10 sq=60:GOSUB"LIB0:M6730" |
| 6740 | `LIB6740` | 10 sq=226:GOSUB"LIB0:M6740" |
| 6741 | `LIB6741` | 10 sq=62:GOSUB"LIB0:M6740" |
| 6742 | `LIB6742` | 10 sq=60:GOSUB"LIB0:M6740" |
| 6750 | `LIB6750` | 10 sq=226:GOSUB"LIB0:M6750" |
| 6751 | `LIB6751` | 10 sq=62:GOSUB"LIB0:M6750" |
| 6752 | `LIB6752` | 10 sq=60:GOSUB"LIB0:M6750" |
| 6760 | `LIB6760` | 10 sq=226:GOSUB"LIB0:M6760" |
| 6761 | `LIB6761` | 10 sq=62:GOSUB"LIB0:M6760" |
| 6762 | `LIB6762` | 10 sq=60:GOSUB"LIB0:M6760" |
| 6770 | `LIB6770` | 10 sq=226:GOSUB"LIB0:M6770" |
| 6771 | `LIB6771` | 10 sq=62:GOSUB"LIB0:M6770" |
| 6772 | `LIB6772` | 10 sq=60:GOSUB"LIB0:M6770" |
| 0630 | `LIBK0630` | 10 CLS:GOTO10000 1000 DATA"Memory calculations [MC],[MR],[M-],[M+]",,1000,5010 5010 DATA"Prime fac |
| 6510 | `LIBM6510` | 5 ONERRORGOTO1000:RESTORE :MODE8:DIM:ERASEa,a$:DIMa(14),a$(5):c$=CHR$(5):IFsq<0ORsq>3ORFRACsq<>0THENsq=0 12 IF |
| 6710 | `LIBM6710` | 5 IFsq<>60 ANDsq<>62 THENsq=226 10 MODE8:DIM:GOSUB900:ERASEb$:DIMb$(1):b$(0)="Reject":b$(1)="Accept":t$="Test |
| 6720 | `LIBM6720` | 5 IFsq<>60 ANDsq<>62 THENsq=226 10 MODE8:DIM:GOSUB900:ERASEb$:DIMb$(1):b$(0)="Reject":b$(1)="Accept":t$="Test |
| 6730 | `LIBM6730` | 5 IFsq<>60 ANDsq<>62 THENsq=226 10 MODE8:DIM:GOSUB900:ERASEb$:DIMb$(1):b$(0)="Reject":b$(1)="Accept":t$="Test |
| 6740 | `LIBM6740` | 5 IFsq<>60 ANDsq<>62 THENsq=226 10 MODE8:DIM:GOSUB900:ERASEb$:DIMb$(1):b$(0)="Reject":b$(1)="Accept":t$="Test |
| 6750 | `LIBM6750` | 5 IFsq<>60 ANDsq<>62 THENsq=226 10 MODE8:DIM:GOSUB900:ERASEb$:DIMb$(1):b$(0)="Reject":b$(1)="Accept":t$="Test |
| 6760 | `LIBM6760` | 5 IFsq<>60 ANDsq<>62 THENsq=226 10 MODE8:DIM:GOSUB900:ERASEb$:DIMb$(1):b$(0)="Reject":b$(1)="Accept":t$="Test |
| 6770 | `LIBM6770` | 5 IFsq<>60 ANDsq<>62 THENsq=226 10 MODE8:DIM:GOSUB900:ERASEb$:DIMb$(1):b$(0)="Reject":b$(1)="Accept":t$="Test |
| 6020 | `LIBS6020` | 5 ONERRORGOTO1000 10 MODE8:DIM:ERASEa,a$:DIMa(5),a$(1):a$(1)="Input":a$(0)="Delete":c$=CHR$(5) 20 CLS:PRINT"In |
| 6030 | `LIBS6030` | 5 ONERRORGOTO1000 10 MODE8:DIM:ERASEa,a$:DIMa(5),a$(1):a$(1)="Input":a$(0)="Delete":c$=CHR$(5):sf=0 20 CLS:PRI |
| 6210 | `LIBS6210` | 5 ONERRORGOTO500 10 y=ABSx:p=0 15 IFy>100 THEN60 |
| 6220 | `LIBS6220` | 10 GOSUB400:IFx=<0 THENp=1:GOTO80 20 IFn>100 THENz=x:x=((x/n)^(1/3)-(1-2/9/n))/SQR(2/9/n):GOSUB"LIB0:S6210":GO |
| 6230 | `LIBS6230` | 5 ONERRORGOTO500 10 ANGLE1:y=ATN(x/SQRn):z=COSy^2 20 IFn MOD 2=0 THENa=SINy/2:b=.5 ELSEb=.5+y/PI:IFn=1 THENa=0 |
| 6240 | `LIBS6240` | 5 ONERRORGOTO500 10 ANGLE1:IFx=<0 THENp=1:GOTO80 20 IFm MOD 2=0 THENz=m/(m+n*x):GOSUB100:p=1-p:GOTO80 |
| 6310 | `LIBS6310` | 5 ONERRORGOTO500 10 IFp=1 THENIFn=x THENs=1:f=1:GOTO80 ELSEs=0:f=0:GOTO80 20 q=1-p:f=q^n:s=f:z=p/q:y=n+1 |
| 6320 | `LIBS6320` | 5 ONERRORGOTO500 10 f=EXP(-k):s=f 20 FORi=1 TOx:f=f*k/i:s=s+f:NEXT |
| 6330 | `LIBS6330` | 5 ONERRORGOTO500 10 GOSUB100:s=f:q=k+1:y=n+1 30 FORi=1 TOx:f=f*(q-i)*(y-i)/i/(z+i):s=s+f:NEXT |
| 6410 | `LIBS6410` | 5 ONERRORGOTO500 10 IFp=<0 ORp>=1 THEN* 20 y=-LN(4*p*(1-p)) |
| 6420 | `LIBS6420` | 10 GOSUB400:IFp>1 ORp=<0 THEN* 15 IFp=1 THENx=0:GOTO80 20 IFn=1 THENq=p:p=q/2:GOSUB"LIB0:S6410":GOSUB400:x=y*y |
| 6430 | `LIBS6430` | 20 GOSUB400:ANGLE1:IFp>=1 ORp=<0 THEN* 30 GOSUB"LIB0:S6410":GOSUB400:x=y:y=x^2 40 a=(y+1)/4:b=((5*y+16)*y+3)/9 |
| 6440 | `LIBS6440` | 10 GOSUB400:ANGLE1:IFp>1 ORp=<0 THEN* 15 IFp=1 THENx=0:GOTO80 20 IFm=1 THENm=p:p=.5-p/2:GOSUB"LIB0:S6430":GOSU |
| INFO | `LIB_INFO` | Liste aller Library-Programme des Casio FX-850P/880P Seite 1/3 FILENAME SI |

## 7. Conservación y contribuciones

No modifique un `LIB*.bas` para «hacerlo pasar» en un intérprete distinto. Si necesita una versión portada, cree un fichero nuevo fuera de `MB-Casio-Basic-Library`, documente el programa fuente, las diferencias de dialecto y casos de prueba con resultados conocidos. Mantenga los `.legacy.txt` existentes: son material histórico y no una autorización para sobrescribir el original.

Al informar un problema, incluya: el fichero y la línea, el comando exacto, las entradas/pulsaciones, la salida observada, la salida esperada y si la prueba se hizo en hardware Casio, emulador o JuanCarlos BASIC. Esto permite distinguir un defecto de portabilidad de una diferencia de comportamiento original.
