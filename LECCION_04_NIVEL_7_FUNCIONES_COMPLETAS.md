# Lección 4 (Nivel 7): cierre del lenguaje y mapa de funciones

Esta lección es el cierre práctico: recorre casi todo lo implementado en el intérprete.

## 1) Núcleo matemático

- Constantes/aleatorio: `PI`, `RAN#`
- Aritmética útil: `ABS`, `INT`, `FIX`, `FRAC`, `ROUND`, `SQR`, `EXP`, `LOG`, `LN`, `FACT`, `SGN`

## 2) Núcleo de strings

- Conversión: `CHR$`, `ASC`, `STR$`, `VAL`
- Corte de texto: `LEN`, `LEFT$`, `MID$`, `RIGHT$`

## 3) Memoria simulada

- `DEFSEG`, `POKE`, `PEEK`

## 4) Control avanzado

- `GOSUB/RETURN`
- `ON ... GOTO`
- `ON ... GOSUB`

## 5) Programa integral

Archivo: `lessons/07_funciones_total.bas`

Qué demuestra:
1. Cálculo matemático variado.
2. Conversión y manipulación de strings.
3. Lectura/escritura de memoria.
4. Subrutinas y despacho múltiple.

## 6) Comando de ejecución

```bash
node run_prg.js lessons/07_funciones_total.bas
```

## 7) Qué te falta para “dominarlo”

1. Diseñar tus propias librerías de subrutinas (`GOSUB`).
2. Encadenar DATA/READ con arrays para tablas complejas.
3. Usar memoria como almacenamiento de estado entre módulos.
4. Construir menús con `ON ... GOTO/GOSUB`.

Cuando quieras, en el chat hacemos tu proyecto final y te lo reviso línea por línea.
