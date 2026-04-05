# Clase en chat: BASIC básico (entrada/salida, operadores, bucles y control)

Este material está pensado para que podamos aprender **aquí mismo en chat** y validar cada ejemplo con `run_prg.js`.

## 1) Entrada y salida

- `PRINT` muestra texto/valores.
- `INPUT "PROMPT";VAR` pide dato al usuario.

Ejemplo:

```basic
10 INPUT "NOMBRE";N$
20 PRINT "HOLA ";N$
```

## 2) Múltiples sentencias en una línea

Usa `:` para encadenar:

```basic
10 A=5:B=2:PRINT A+B
```

## 3) Operadores básicos

- Aritméticos: `+ - * / ^`
- Comparadores: `= <> < > <= >=`
- Lógicos bit a bit: `AND OR NOT`

## 4) IF THEN ELSE

```basic
10 IF X>=10 THEN PRINT "ALTO" ELSE PRINT "BAJO"
```

## 5) Bucles

### FOR / NEXT
```basic
10 FOR I=1 TO 3
20 PRINT I
30 NEXT I
```

### WHILE / WEND
```basic
10 J=3
20 WHILE J>0
30 PRINT J
40 J=J-1
50 WEND
```

## 6) GOTO (uso controlado)

```basic
10 IF K=1 THEN GOTO 100
20 PRINT "NO"
30 END
100 PRINT "SI"
```

## 7) Demo completa

- Archivo: `lessons/04_basico_total.bas`
- Ejecución sugerida (sin interacción manual):

```bash
node run_prg.js --file lessons/04_basico_total.bas --inputs JUAN,20
```

## 8) Dinámica de trabajo desde ahora

Cuando me pases tu código:
1. Te explico cada línea.
2. Lo corro en el intérprete real.
3. Te reporto salida real vs esperada.
4. Lo optimizamos juntos.

## 9) Modo "solo chat" (sin crear archivos)

Copia y pega cada bloque directamente en el modo interactivo:

```bash
node run_prg.js
```

Luego escribe líneas numeradas y al final `RUN`.

Secuencia recomendada:
1. Entrada/salida.
2. Operadores/comparadores.
3. IF/THEN.
4. FOR/NEXT.
5. WHILE/WEND.
6. ON GOTO / ON GOSUB.

Con esto puedes practicar paso a paso sin tocar más archivos en el proyecto.
