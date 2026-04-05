# Curso exprés: Exprime tu intérprete BASIC desde 0

Este curso está pensado para **tu propio intérprete** (`V1.0.html`) y para ejecutarlo con `run_prg.js`.

## Regla del juego (cómo vamos a trabajar tú y yo)

Cada vez que me mandes código:

1. Lo reviso línea por línea.
2. Lo corro en el intérprete real.
3. Te digo salida esperada vs salida real.
4. Te doy versión mejorada si hace falta.
5. Lo vuelvo a ejecutar para confirmar.

## Arranque rápido

```bash
node run_prg.js lessons/01_hola_variables.bas
node run_prg.js lessons/02_if_loops.bas
node run_prg.js lessons/03_arrays_data.bas
```

## Lección 1 — Variables, operadores, texto

Archivo: `lessons/01_hola_variables.bas`

Qué practicas:
- `PRINT`
- Asignaciones numéricas y string (`$`)
- Precedencia de operadores (`*` antes que `+`)

Reto:
- Cambia la fórmula en línea 50 para calcular `(A+B)*2`.
- Agrega una línea que imprima `A^2`.

## Lección 2 — Decisiones y bucles

Archivo: `lessons/02_if_loops.bas`

Qué practicas:
- `IF ... THEN ... ELSE`
- `FOR ... NEXT`
- `WHILE ... WEND`

Reto:
- Haz una cuenta regresiva desde 10 a 0 con `FOR STEP -1`.
- Cambia la suma `1..5` por `1..100`.

## Lección 3 — Arreglos y datos embebidos

Archivo: `lessons/03_arrays_data.bas`

Qué practicas:
- `DIM`
- `DATA` / `READ`
- Acumulación en arreglos

Reto:
- Pasa de 4 elementos a 6.
- Calcula promedio además del total.

## Chuleta mínima para exprimirlo

- Variables numéricas: `A`, `X1`, `TOTAL`
- Variables string: `N$`, `MSG$`
- Verdadero/Falso: `-1` / `0`
- `PRINT` con `;` no mete salto de línea
- Índices de arrays: desde `0` hasta el tope de `DIM`

## Siguiente paso conmigo

Mándame tu primer programa y dime qué resultado esperas.
Yo te lo valido en el intérprete real y lo optimizamos juntos.
