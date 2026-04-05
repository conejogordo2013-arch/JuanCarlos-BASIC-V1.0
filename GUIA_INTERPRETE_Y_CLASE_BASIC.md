# Guía del Intérprete JuanCarlos BASIC V1.0

Esta guía resume cómo está construido el intérprete, qué soporta de BASIC y cómo probar programas **en el intérprete real** (el mismo runtime de `V1.0.html`) desde consola.

## 1) Arquitectura rápida

- El núcleo del intérprete vive dentro de `V1.0.html` (lexer, parser, runtime, UI LCD/terminal).
- `run_prg.js` carga ese HTML, extrae el bloque `<script>` y lo ejecuta con `vm` de Node.js para poder correr `.bas` sin navegador.
- Hay una carpeta `test/` con programas BASIC de validación.

## 2) Cómo ejecutar el intérprete real

### Modo archivo

```bash
node run_prg.js test/14_final_smoke.bas
```

### Modo interactivo (REPL)

```bash
node run_prg.js
# o
node run_prg.js --direct
```

### Simular teclado e INPUT en pruebas

```bash
node run_prg.js --file mi.bas --keys abc --inputs 10,HOLA
```

- `--keys` alimenta `INKEY$`.
- `--inputs` alimenta `INPUT` en cola.

## 3) Qué comandos BASIC soporta

### Gestión / entorno

- `RUN`, `LIST`, `LIST ALL`, `NEW`, `NEW ALL`, `CLEAR`, `TRON`, `TROFF`, `VARLIST`, `FRE`

### Flujo

- `GOTO`, `GOSUB`, `RETURN`, `IF ... THEN ... ELSE ...`, `FOR ... TO ... STEP ...`, `NEXT`, `WHILE`, `WEND`, `ON ... GOTO|GOSUB`

### I/O y pantalla

- `PRINT`, `PRINT USING`, `INPUT`, `LOCATE`, `CLS`, `BEEP`

### Datos

- `LET` (y asignación implícita `A=5`), `DIM`, `DATA`, `READ`, `RESTORE`

### Memoria / errores

- `PEEK` (función), `POKE`, `DEFSEG`, `ON ERROR GOTO`, `ON ERROR 0`, `RESUME`

## 4) Funciones implementadas

- Trig/hiperbólicas: `SIN`, `COS`, `TAN`, `ASN`, `ACS`, `ATN`, `HSIN`, `HCOS`, `HTAN`
- Matemáticas: `LOG`, `LN`, `EXP`, `SQR`, `ABS`, `SGN`, `INT`, `FIX`, `FRAC`, `ROUND`, `FACT`, `PI`, `RAN#`
- Cadenas: `CHR$`, `ASC`, `STR$`, `VAL`, `LEN`, `LEFT$`, `RIGHT$`, `MID$`
- Sistema: `PEEK`, `INKEY$`

## 5) Reglas importantes del runtime

- Variables con sufijo `$` son de texto; sin `$` son numéricas.
- Si lees una variable no inicializada, se auto-crea con `0` o `""`.
- Arreglos usan límites **inclusivos** (`DIM A(10)` crea índices `0..10`).
- Comparaciones devuelven `-1` (verdadero) o `0` (falso), estilo BASIC clásico.
- `AND`, `OR`, `NOT` son bit a bit sobre enteros.
- `PRINT` con `;` al final no agrega salto de línea.
- `RUN` hace `resetState()`: limpia variables/arreglos/errores antes de ejecutar.

## 6) Diferencias o límites a tener en cuenta

- En la lista de funciones aparecen nombres no implementados aún en runtime (`NPR`, `NCR`, `POL`, `REC`, `ANGLE`, `HASN`, `HACS`, `HATN`), por lo que hoy producirán error de “función no implementada”.
- `INPUT$`, `EDIT`, `PASS`, `OPEN`, `CLOSE`, `SAVE`, `LOAD` están en keywords, pero no tienen handler runtime dedicado.
- `PRINT USING` está implementado de forma básica (más simple que algunos BASIC históricos).

## 7) Flujo de trabajo recomendado para exprimirlo

1. Escribe tu programa en `mi_programa.bas`.
2. Ejecútalo con `node run_prg.js mi_programa.bas`.
3. Si usa `INPUT`, agrega `--inputs` para pruebas repetibles.
4. Si usa `INKEY$`, agrega `--keys`.
5. Activa `TRON` para depurar saltos por línea.
6. Crea variantes pequeñas y compáralas contra un resultado esperado.

## 8) Plan de clase BASIC (cómo te voy a enseñar)

Cuando me mandes código:

1. Te explico qué hace línea por línea.
2. Lo pruebo en este intérprete real (`node run_prg.js ...`).
3. Te digo si el resultado coincide con lo esperado.
4. Si falla, te doy versión corregida y la vuelvo a probar.
5. Te propongo mejora de estilo (legibilidad, robustez, velocidad).

Sugerencia de ruta de aprendizaje:

- Nivel 1: `PRINT`, variables, operadores.
- Nivel 2: `IF`, `GOTO`, `GOSUB`.
- Nivel 3: `FOR/NEXT`, `WHILE/WEND`.
- Nivel 4: `INPUT`, `DATA/READ`, arreglos.
- Nivel 5: `PEEK/POKE`, control de errores (`ON ERROR`, `RESUME`).

### Protocolo fijo contigo (a partir de ahora)

Cada vez que me mandes un programa BASIC (o yo te proponga uno), voy a seguir este checklist:

1. Ejecutarlo en el intérprete real con `node run_prg.js`.
2. Verificar que en la salida aparezca `READY` al finalizar.
3. Comparar salida real vs salida esperada y marcar **correcto/incorrecto**.
4. Si falla, corregir el programa y volver a ejecutarlo hasta que termine en `READY` y con resultado correcto.

Formato de validación que usaré:

- **Programa probado:** `<archivo o bloque>`
- **Comando:** `node run_prg.js ...`
- **¿Termina en READY?:** Sí / No
- **Resultado esperado:** `...`
- **Resultado real:** `...`
- **Veredicto:** ✅ Correcto / ❌ Requiere ajuste

## 9) Comandos útiles de validación rápida

```bash
# Ejecutar toda la suite de ejemplos
for f in test/*.bas; do node run_prg.js "$f" > /dev/null || break; done

# Ejecutar un archivo y guardar salida
node run_prg.js mi_programa.bas > salida.txt

# Probar interactivo
node run_prg.js
```

## 10) Evaluación rápida de JuanCarlos BASIC

Fortalezas:
- Intérprete funcional con parser propio y ejecución sin `eval`.
- Muy buen set educativo: control de flujo, arrays, DATA/READ, memoria y subrutinas.
- Runner CLI (`run_prg.js`) práctico para pruebas repetibles.

Áreas de mejora:
- Hay keywords listadas que aún no están implementadas en runtime.
- Algunas funciones esperadas por listado no tienen implementación activa.
- Sería ideal añadir aserciones formales de salida para cada test `.bas`.
