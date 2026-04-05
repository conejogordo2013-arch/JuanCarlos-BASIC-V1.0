# Lección 2 (nivel que pediste): memoria, strings, arrays, DATA, POKE/PEEK y ON GOTO/GOSUB

Aquí arrancamos directamente donde tú quieres.

## 1) DIM + DATA + READ (arrays)

```basic
10 DIM A(2)
20 DATA 11,22,33
30 FOR I=0 TO 2
40 READ A(I)
50 NEXT I
```

- `DIM A(2)` crea índices `0,1,2`.
- `DATA` guarda literales.
- `READ` consume en orden.

## 2) Memoria: DEFSEG / POKE / PEEK

```basic
10 DEFSEG 0
20 POKE 100,65
30 PRINT PEEK(100)
```

- `POKE dir,valor` escribe un byte.
- `PEEK(dir)` lo lee.

## 3) Strings: CHR$, LEFT$, MID$, RIGHT$

```basic
10 S$="MEMORIA"
20 PRINT CHR$(65)
30 PRINT LEFT$(S$,3)
40 PRINT MID$(S$,2,3)
50 PRINT RIGHT$(S$,2)
```

## 4) Aleatorio: RAN#

```basic
10 X=RAN#
20 PRINT X
```

Devuelve un número en rango `[0,1)`.

## 5) Subrutinas y despacho: GOSUB / ON GOSUB / ON GOTO

```basic
10 K=2
20 ON K GOTO 100,200,300
...
100 PRINT "A"

500 M=1
510 ON M GOSUB 700,800
```

- `ON expr GOTO l1,l2,l3` salta según `expr`.
- `ON expr GOSUB l1,l2` llama subrutina y luego `RETURN`.

## 6) Demo completa

Archivo: `lessons/05_memoria_strings_control.bas`

Ejecuta:

```bash
node run_prg.js lessons/05_memoria_strings_control.bas
```

## 7) Práctica inmediata (tu turno)

Reto rápido:
1. Cambia `K=2` por `K=3` y verifica a qué línea cae `ON GOTO`.
2. Cambia `M=1` por `M=2` y verifica qué subrutina ejecuta `ON GOSUB`.
3. Haz `POKE 101,66` y muestra `CHR$(PEEK(101))`.

Pégame tu versión y te la pruebo yo en el intérprete real.

## 8) Explicación función por función (qué hace, cuándo usarla, ejemplo)

### DIM
- **Qué hace:** reserva un arreglo.
- **Cuándo usar:** cuando necesitas lista indexada (`A(0)`, `A(1)`...).
- **Ejemplo:** `DIM A(10)`

### DATA / READ
- **Qué hacen:** `DATA` guarda literales en el programa; `READ` los va leyendo en orden.
- **Cuándo usar:** inicialización de tablas sin pedir `INPUT`.
- **Ejemplo:**
  - `DATA 5,8,13`
  - `READ X` (lee 5), luego otro `READ X` (lee 8)

### DEFSEG
- **Qué hace:** define el segmento base para memoria (`PEEK/POKE`).
- **Cuándo usar:** cuando trabajas direcciones de memoria virtual del intérprete.
- **Ejemplo:** `DEFSEG 0`

### POKE
- **Qué hace:** escribe un byte en memoria (`0..255`).
- **Cuándo usar:** simulación de hardware/memoria o buffers.
- **Ejemplo:** `POKE 100,65`

### PEEK
- **Qué hace:** lee un byte de memoria.
- **Cuándo usar:** verificar cambios hechos con `POKE` o inspeccionar memoria.
- **Ejemplo:** `PRINT PEEK(100)`

### CHR$(n)
- **Qué hace:** convierte código ASCII numérico a carácter.
- **Cuándo usar:** construir strings carácter a carácter.
- **Ejemplo:** `CHR$(65)` devuelve `A`.

### LEFT$(s$,n)
- **Qué hace:** toma `n` caracteres por la izquierda.
- **Cuándo usar:** prefijos, parsing rápido.
- **Ejemplo:** `LEFT$("MEMORIA",3)` => `MEM`

### MID$(s$,inicio,long)
- **Qué hace:** corta subcadena desde posición (base 1) con longitud.
- **Cuándo usar:** extraer partes internas de texto.
- **Ejemplo:** `MID$("MEMORIA",2,3)` => `EMO`

### RIGHT$(s$,n)
- **Qué hace:** toma `n` caracteres por la derecha.
- **Cuándo usar:** sufijos/extensiones.
- **Ejemplo:** `RIGHT$("MEMORIA",2)` => `IA`

### RAN#
- **Qué hace:** genera decimal aleatorio en `[0,1)`.
- **Cuándo usar:** simulaciones, juegos, decisiones pseudoaleatorias.
- **Ejemplo:** `X=RAN#`

### GOSUB / RETURN
- **Qué hace:** llama una subrutina y vuelve.
- **Cuándo usar:** reutilizar bloques de código sin repetir líneas.
- **Ejemplo:**
  - `GOSUB 700`
  - `700 PRINT "SUB"`
  - `710 RETURN`

### ON expr GOTO ...
- **Qué hace:** salto múltiple por índice.
- **Cuándo usar:** menús/estados (1->línea1, 2->línea2...).
- **Ejemplo:** `ON K GOTO 100,200,300`

### ON expr GOSUB ...
- **Qué hace:** llamada múltiple a subrutinas por índice.
- **Cuándo usar:** despachar acciones reutilizables por opción.
- **Ejemplo:** `ON M GOSUB 700,800`

## 9) Errores típicos y cómo evitarlos

1. **`READ` sin suficientes `DATA`** -> error de datos agotados.
2. **`MID$` con índice mal calculado** -> devuelve texto inesperado.
3. **`ON ...` con índice fuera de rango** -> no salta a ninguna línea.
4. **`GOSUB` sin `RETURN`** -> flujo roto.
5. **Confundir `CHR$` (texto) con número** -> usa variables `$` para strings.
