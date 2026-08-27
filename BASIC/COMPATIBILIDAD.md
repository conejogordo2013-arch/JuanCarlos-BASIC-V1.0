# Compatibilidad y alcance de la biblioteca Casio

Esta carpeta conserva programas BASIC de la biblioteca para **Casio FX-850P/880P**. Son programas de un dialecto y un hardware distintos de JuanCarlos BASIC; por tanto, «cargar sin error» y «reproducir la función original» son comprobaciones diferentes.

## Comprobación automática incluida

Ejecute desde la raíz del repositorio:

```bash
./scripts/check_basic_compat.sh
```

El script localiza exactamente los **142** archivos `.bas` de `MB-Casio-Basic-Library`, los carga uno a uno en el intérprete real que usa `run_prg.js` y exige `READY` sin errores de sintaxis. El comando falla si cambia el número de programas, si cualquiera no llega a `READY` o si aparece un error de parseo. No ejecuta `RUN`: muchos programas esperan teclas, ficheros, periféricos o direcciones de memoria del Casio, y automatizar entradas inventadas no demostraría su resultado original.

## Resultado que sí certifican las pruebas

`check_basic_compat.sh` certifica que cada fichero puede incorporarse al intérprete sin que su carga produzca los errores comprobados. `run_casio_library_smoke.sh` inicia los 142 programas y se detiene controladamente al alcanzar la primera entrada de teclado, sin inyectar valores inventados. No certifica equivalencia matemática, de pantalla ni de hardware. Para esa verificación funcional hay que seguir el procedimiento y las limitaciones descritos en el [manual de la biblioteca](MANUAL_BIBLIOTECA_CASIO.md).

## Conservación del código

Los programas de la biblioteca no se han sustituido por stubs como parte de esta comprobación. Los ficheros `.legacy.txt` presentes son copias históricas ya incluidas en el árbol; no deben tomarse como evidencia de que el `.bas` vecino sea un reemplazo. Antes de adaptar un programa, compárelo con su copia histórica cuando exista y valide el resultado en un Casio compatible o con datos de referencia.
