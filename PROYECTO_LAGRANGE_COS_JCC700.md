# Proyecto matemático JCC-700: interpolación de Lagrange + coseno

Este proyecto demuestra una tarea básica de **ingeniería informática**: estimar
la latencia de un servicio con pocas mediciones y contrastar la estimación contra
un modelo trigonométrico de referencia. Usa el mismo método de interpolación de
Lagrange expuesto por la biblioteca Casio `LIB5230` y añade operaciones `COS`
propias del intérprete JCC-700.

## Archivos

- Programa ejecutable: `lessons/37_proyecto_lagrange_cos_ingenieria.bas`.
- Biblioteca original de referencia: `BASIC/MB-Casio-Basic-Library/LIB5230.bas`.
- Verificación automática: `scripts/run_lagrange_cos_project.sh`.

## Qué calcula

El programa modela una latencia sintética en milisegundos:

```text
latencia(x) = 20 + 5 * COS(x)
```

Toma tres muestras en `x=0`, `x=10` y `x=20`, construye el polinomio de
Lagrange de grado 2 y estima la latencia en `x=15`. Después calcula el valor
real con `COS(15)` y compara el error. Si el error es menor que `0.1`, imprime
`JCC-700 OK`.

## Cómo ejecutarlo

```bash
node run_prg.js --file lessons/37_proyecto_lagrange_cos_ingenieria.bas
```

Salida esperada aproximada:

```text
LAGRANGE=24.82995273776936
COS REAL=24.82962913144534
ERROR=0.00032360632402017586
JCC-700 OK
```

Para validarlo automáticamente:

```bash
./scripts/run_lagrange_cos_project.sh
```

## Por qué prueba que la JCC-700 sirve para cálculo básico

- Ejecuta aritmética con paréntesis, productos y divisiones encadenadas.
- Usa `COS` para generar y verificar una señal periódica simple.
- Aplica interpolación de Lagrange, la misma técnica de `LIB5230`, en un caso de
  ingeniería informática entendible: estimación de latencia a partir de muestras.
- Comprueba el error contra un valor de referencia y emite un resultado de OK.
