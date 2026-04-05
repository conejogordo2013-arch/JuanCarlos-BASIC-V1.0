# Lección 1 paso a paso (con paciencia): PRINT, INPUT, IF y bucles

Objetivo: que domines lo básico escribiendo, ejecutando y entendiendo cada línea.

## Paso 0 — Ejecuta un primer programa mínimo

Crea `mi_paso0.bas`:

```basic
10 PRINT "HOLA, MUNDO BASIC"
20 END
```

Ejecuta:

```bash
node run_prg.js mi_paso0.bas
```

## Paso 1 — Entrada y salida

Crea `mi_paso1.bas`:

```basic
10 INPUT "COMO TE LLAMAS";N$
20 PRINT "HOLA ";N$
30 END
```

Ejecuta con entrada simulada:

```bash
node run_prg.js --file mi_paso1.bas --inputs CARLOS
```

## Paso 2 — Operadores y comparadores

Crea `mi_paso2.bas`:

```basic
10 A=8:B=3
20 PRINT "SUMA=";A+B
30 PRINT "RESTA=";A-B
40 PRINT "MULT=";A*B
50 PRINT "DIV=";A/B
60 PRINT "POT=";A^B
70 PRINT "A>B => ";A>B
80 PRINT "A=8 => ";A=8
90 END
```

## Paso 3 — IF THEN ELSE

Crea `mi_paso3.bas`:

```basic
10 INPUT "EDAD";E
20 IF E>=18 THEN GOTO 40
30 GOTO 50
40 PRINT "ERES MAYOR"
45 GOTO 60
50 PRINT "ERES MENOR"
60 END
```

## Paso 4 — FOR / NEXT

Crea `mi_paso4.bas`:

```basic
10 S=0
20 FOR I=1 TO 5
30 S=S+I
40 NEXT I
50 PRINT "SUMA=";S
60 END
```

## Paso 5 — WHILE / WEND

Crea `mi_paso5.bas`:

```basic
10 C=3
20 WHILE C>0
30 PRINT "CUENTA=";C
40 C=C-1
50 WEND
60 END
```

## Paso 6 — Reto final de la lección

Haz un programa que:
1. Pida nombre y edad.
2. Diga si es mayor/menor.
3. Imprima una cuenta de 1 a 3 con `FOR`.
4. Imprima una cuenta regresiva de 3 a 1 con `WHILE`.

Si me lo pegas aquí, yo te lo pruebo en el intérprete real y te lo corrijo con calma.
