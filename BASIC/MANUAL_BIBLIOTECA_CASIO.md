# Manual de la biblioteca Casio FX-850P/880P

## 1. Qué contiene esta biblioteca

`MB-Casio-Basic-Library` contiene 142 programas BASIC procedentes de la biblioteca para las calculadoras/ordenadores de bolsillo Casio FX-850P y FX-880P. El índice original está en [`LIB_INFO.htm`](MB-Casio-Basic-Library/LIB_INFO.htm). Cada `LIBxxxx.bas` es un programa independiente; los prefijos `LIBM` y `LIBS` identifican subprogramas de estadística y el prefijo `LIBK` identifica el menú/lanzador.

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

La prueba de carga verifica el contrato mínimo reproducible: hay 142 ficheros `.bas`, todos se cargan y todos devuelven `READY` sin errores de parseo. Para ejecutar toda la colección sin inventar respuestas, use además `./scripts/run_casio_library_smoke.sh`: inicia cada programa y lo detiene de forma controlada en su primera petición de teclado o de `INPUT`. Esto comprueba que cada programa alcanza su frontera interactiva sin convertir una entrada ausente en un dato falso; tampoco sustituye la validación funcional con datos de referencia.

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
* Las líneas con `GOTO "LIB0:..."` o llamadas entre ficheros requieren la organización de programas del Casio; no son importaciones de Node.js.
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

## 6. Conservación y contribuciones

No modifique un `LIB*.bas` para «hacerlo pasar» en un intérprete distinto. Si necesita una versión portada, cree un fichero nuevo fuera de `MB-Casio-Basic-Library`, documente el programa fuente, las diferencias de dialecto y casos de prueba con resultados conocidos. Mantenga los `.legacy.txt` existentes: son material histórico y no una autorización para sobrescribir el original.

Al informar un problema, incluya: el fichero y la línea, el comando exacto, las entradas/pulsaciones, la salida observada, la salida esperada y si la prueba se hizo en hardware Casio, emulador o JuanCarlos BASIC. Esto permite distinguir un defecto de portabilidad de una diferencia de comportamiento original.
