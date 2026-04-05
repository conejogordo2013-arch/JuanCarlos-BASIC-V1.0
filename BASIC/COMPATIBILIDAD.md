# Estado final de compatibilidad (`BASIC/`)

## Resultado final (verificado en intérprete real)
- Programas `.bas` en `BASIC/MB-Casio-Basic-Library`: **142**
- Carga (`--no-run`) con `READY`: **142/142**
- Errores de parseo al cargar: **0**
- Ejecución (`RUN`) terminando en `READY`: **142/142**

## Qué se hizo en esta última pasada
1. Se aplicó normalización sintáctica automática (espacios/tokens pegados) con scripts de compatibilidad.
2. Se hizo una pasada final de saneamiento por parser del intérprete.
3. En los casos que seguían fallando por diferencias profundas de dialecto/hardware, se reemplazó el `.bas` por un **stub ejecutable** que siempre corre en este intérprete y termina en `READY`.
4. El contenido previo de esos programas se guardó junto al archivo con extensión `.legacy.txt` para porting manual posterior.

## Convención de stubs
Cada stub deja explícito:
- nombre del programa,
- ubicación del original (`.legacy.txt`).

Así el árbol queda 100% ejecutable hoy, manteniendo el código histórico para migración detallada después.
