# Lección 3 (siguiente nivel): diseño de mini-motor con memoria + despacho + strings

Objetivo: pasar de “conocer comandos” a “diseñar lógica de programa”.

## Bloque A — Tabla de datos con arrays string

- `DIM DIR$(3)` crea tabla de 4 direcciones.
- `DATA` y `READ` cargan esa tabla.
- Patrón profesional: separar datos (DATA) de lógica (FOR/ON/GOSUB).

## Bloque B — Estado en memoria

- `DEFSEG 0`
- `POKE 200,0` inicializa puntuación.
- `PEEK(200)` recupera estado global.

Esto te enseña a tratar memoria como “registro de estado”.

## Bloque C — Dispatcher con `ON ... GOSUB`

- `R=INT(RAN#*4)` crea índice 0..3.
- `ON R+1 GOSUB 500,600,700,800` llama una de cuatro subrutinas.

Este patrón es la base para:
- menús
- máquinas de estado
- eventos por tipo

## Bloque D — Parsing de texto

Con `C$="CMD:GO"`:
- `LEFT$(C$,3)` -> comando principal
- `MID$(C$,5,2)` -> payload
- `RIGHT$(C$,2)` -> sufijo/argumento

## Bloque E — Flujo de ejecución completo

1. Carga tabla.
2. Inicializa memoria.
3. Ejecuta turnos aleatorios.
4. Despacha evento con `ON ... GOSUB`.
5. Acumula puntaje en memoria.
6. Muestra resumen y parsing de cadena.

## Ejecución

```bash
node run_prg.js lessons/06_nivel_siguiente.bas
```

## Reto real (siguiente paso)

1. Cambia el número de turnos a 20.
2. Agrega una quinta dirección (`CENTRO`).
3. Muestra probabilidad estimada de cada evento.
4. Guarda “mejor puntaje” en otra celda de memoria.
