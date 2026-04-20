# JC BASIC V1.0 — Especificación formal (núcleo actual)

## 1) Sintaxis soportada
- Programa por líneas numeradas (`10 PRINT "HOLA"`).
- Múltiples sentencias por línea con `:`.
- Comentarios con `REM` o `'`.
- Sentencias principales: `LET` (o asignación implícita), `PRINT`, `INPUT`, `IF ... THEN ... [ELSE ...]`, `FOR ... TO ... [STEP ...] / NEXT`, `WHILE / WEND`, `DO / UNTIL`, `GOTO`, `GOSUB`, `RETURN`, `ON ... GOTO/GOSUB`, `DIM`, `DATA/READ/RESTORE`, `POKE/PEEK`, `LOAD/SAVE`, `OPEN/WRITE/READFILE/CLOSE`, `CLS`, `LOCATE`, `BEEP`, `BEEP1`, `SOUND`.

## 2) Expresiones
Precedencia (de mayor a menor):
1. Paréntesis
2. Unarios `+`, `-`, `NOT`
3. Potencia `^` (asociación derecha)
4. `*`, `/`, `MOD`
5. `+`, `-`
6. Relacionales `=`, `<>`, `<`, `>`, `<=`, `>=`
7. `AND`
8. `OR`

## 3) Tipos de datos
- Numérico (por defecto).
- String (`$` al final del identificador, ej. `A$`).
- Arrays numéricos o string via `DIM`.
- Variables no existentes:
  - numéricas inicializan a `0`
  - string inicializan a `""`

## 4) Reglas sin ambigüedad
- `ELSE` pertenece al `IF` más cercano (regla de parser por anidación).
- `FOR/NEXT`:
  - `NEXT` resuelve el `FOR` activo más interno de la variable.
  - Si la variable del bucle se modifica dentro del cuerpo, `NEXT` usa contador interno del frame del `FOR` (ejecución estable).
- `GOTO`/`GOSUB` a línea inexistente -> `Undefined line`.
- `NEXT` sin `FOR` -> `NEXT without FOR`.
- `RETURN` sin `GOSUB` -> `RETURN without GOSUB`.

## 5) Ejecución determinista
- PRNG determinista (LCG) para `RND`/`RAN#` con semilla fija al iniciar `RUN`.
- Yield cooperativo por conteo de pasos (no por tiempo de reloj).
- Límite máximo de pasos por ejecución para cortar bucles infinitos (`Execution limit exceeded`).

## 6) Casos límite
- División entre cero -> `Division by zero`.
- Índices fuera de rango -> `Subscript out of range`.
- Expresión inválida/sintaxis inválida -> `Syntax error`.
- `READ` sin datos -> `Out of DATA`.

## 7) Errores estandarizados
- 1 `Syntax error`
- 2 `Undefined line`
- 3 `Division by zero`
- 4 `Out of memory`
- 5 `Subscript out of range`
- 6 `Out of DATA`
- 7 `Type mismatch`
- 8 `NEXT without FOR`
- 9 `RETURN without GOSUB`
- 10 `WEND without WHILE`
- 11 `UNTIL without DO`
- 12 `Illegal quantity`
- 13 `Execution limit exceeded`

## 8) Suite mínima recomendada
- Casos normales: `test/01_math_suite.bas`, `test/02_string_suite.bas`, `test/05_loops_for_while.bas`.
- Ambigüedades/flujo: `test/14_final_smoke.bas`, `test/17_load_vfs_style.bas`.
- Edge cases/runtime: `test/08_memory_poke.bas`, `test/19_font_and_poke_c64.bas`, `test/20_sid_poke_and_beep1.bas`.
