# Lección 6: Extensiones implementadas y roadmap de funciones grandes

## Ya implementado en esta iteración

- `HEX$(n)` -> número a hexadecimal string
- `HEXVAL(s$)` -> string hexadecimal a número
- `INT$(n)` -> entero como string
- `LOCATE$(s$,sub$)` -> posición (1-based) de subcadena
- `LCOLOR(hex$)` -> cambia color de texto terminal y retorna el color aplicado
- `NEWFUNCTION/NEWFUNCTION$` y alias `FUNCTION/FUNCTION$` con `NFUNC/NFUNC$`
- `CALL("FN",x,y)` para funciones globales y `CALL("INST","MET",x,y)` para métodos
- Compleción de funciones pendientes: `NPR`, `NCR`, `POL`, `REC`, `ANGLE`, `HASN`, `HACS`, `HATN`
- `LOAD("archivo.bas", "NS", 1)` con include múltiple + namespace por offset de líneas + cache anti-recarga
- `GPHYCS x,y,ch` básico para dibujar un carácter en LCD/terminal
- `CLASS` + `METHOD` + `INSTANCE` + `SETPROP` + `CALL(...)`/`PROP(...)` para OOP básico
- I/O básico: `OPEN`, `WRITE`, `READFILE`, `CLOSE`
- Equivalente TRY/CATCH básico: `TRY <linea>` / `CATCH` (alias de ON ERROR)
- Operador `MOD` en expresiones

## Pendiente (fase siguiente, por complejidad)

- `GPHYCS(...)` motor gráfico completo (canvas, líneas, formas, plots)
- OOP completo con herencia/polimorfismo/encapsulación formal
- `LOAD` web completo con include seguro entre archivos en navegador
- Archivos en navegador (persistencia sandbox sin Node fs)

## Siguiente plan técnico recomendado

1. Crear backend gráfico sobre `<canvas>` para `GPHYCS` extendido.
2. Definir mini-sistema de objetos (`CLASS`, `NEW`, `CALL`) con tabla de métodos.
3. Mejorar `LOAD` con include incremental y resolución segura multiplataforma.
4. Agregar pruebas automatizadas por feature (golden outputs).
