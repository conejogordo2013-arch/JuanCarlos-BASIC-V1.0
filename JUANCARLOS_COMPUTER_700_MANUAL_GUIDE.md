# JuanCarlos-COMPUTER-700 (JCC-700) — Manual completo de uso

> Este documento describe la interfaz web, el intérprete BASIC y las funciones
> adicionales de la JCC-700. La máquina está inspirada en ordenadores de bolsillo
> Casio: la pantalla es de 32 caracteres por 2 líneas y cada carácter usa una
> matriz de 5 × 7 píxeles.

## 1. Inicio rápido

1. Abra `V1.0.html` en un navegador moderno.
2. Haga clic en la línea negra de la terminal, situada debajo del teclado.
3. Escriba una orden BASIC o utilice las teclas virtuales.
4. Pulse **EXE** o la tecla **Intro** para ejecutar la orden.
5. Para crear un programa, escriba líneas que comiencen por un número; para
   ejecutarlo escriba `RUN` y pulse EXE.

Ejemplo mínimo:

```basic
10 CLS
20 PRINT "HOLA JCC-700"
30 END
RUN
```

La terminal conserva el registro de órdenes y resultados. La LCD muestra el
resultado de `PRINT`, de los gráficos y, mientras se está editando una orden,
el texto que se está escribiendo.

---

## 2. Interfaz integrada

### 2.1 Pantalla LCD

La LCD visible tiene estas características:

- **32 columnas × 2 filas**: solo hay 64 posiciones de texto visibles.
- **5 × 7 píxeles por carácter**: el área de píxeles total es 160 × 14.
- **Mayúsculas**: el texto mostrado por la LCD se normaliza a mayúsculas.
- **Desplazamiento**: si se imprime más de dos líneas, la primera se desplaza
  fuera de la pantalla.
- **Accesibilidad**: el mismo contenido también se mantiene como texto de
  respaldo para lectores de pantalla.

Al editar desde la terminal se muestra `>` seguido de la parte final de la
orden que cabe en la LCD. Esto permite ver la entrada sin perder el historial
completo que permanece en la terminal.

### 2.2 Terminal / editor

La terminal es el área principal para escribir. Acepta órdenes inmediatas y
líneas de programa.

| Acción | Cómo usarla |
| --- | --- |
| Ejecutar una orden | Escríbala y pulse **EXE** o **Intro**. |
| Añadir o sustituir una línea | Escriba `número instrucción`, por ejemplo `20 PRINT 2+2`. |
| Borrar una línea | Escriba únicamente su número, por ejemplo `20`. |
| Ver el programa | `LIST`. |
| Ejecutar el programa | `RUN`. |
| Borrar el programa del banco actual | `NEW`. |
| Borrar historial y entrada | **SHIFT + CLEAR**. |

El borrado de historial no afecta al programa, archivos virtuales ni bancos de
programas: únicamente deja la terminal y la LCD listas para escribir de nuevo.

### 2.3 Indicadores

Los indicadores muestran el estado de la máquina:

- **BASIC / CAL**: modo de operación actual.
- **DEG / RAD / GRA**: unidad angular para trigonometría.
- **RUN / STOP**: ejecución en curso o detenida.
- **S**: SHIFT activo.
- **EDIT**: se está escribiendo en la terminal.
- **MEMO**: hay memoria/variables activas o está seleccionado el modo MEMO.
- **LIB**: se ha activado una biblioteca.
- **IN**: la máquina está esperando entrada o un archivo abierto.
- **TR**: trazado (`TRON`) activo.
- **DEFM**: hay un segmento de memoria distinto de cero.
- **INS**: modo de inserción activado.

---

## 3. Teclado virtual

### 3.1 Teclas principales

| Tecla | Función |
| --- | --- |
| **EXE** | Ejecuta lo escrito; si la entrada está vacía ejecuta `RUN`. |
| **BRK** | Solicita detener la ejecución actual. |
| **SHIFT** | Activa la función secundaria de la siguiente tecla compatible. |
| **CAPS** | Alterna la entrada de letras en mayúsculas/minúsculas. |
| **INS** | Alterna el estado de inserción. Con SHIFT representa `DEL`. |
| **CLEAR** | Libera el espacio de trabajo actual. |
| **SHIFT + CLEAR** | Borra el historial de terminal, la entrada y la LCD. |
| **MODE** | Espera un dígito para seleccionar un modo. |
| **ANS** | Inserta el último resultado de una operación CAL. |
| **MEMO** | Activa el área de memoria y actualiza el panel VFS. |
| **LIB** | Carga la biblioteca cuyo código aparece en el panel de librerías. |
| **SHIFT + LIB** | Muestra el catálogo de bibliotecas. |
| **SPACE** | Inserta un espacio en la línea de entrada. |

Las teclas de letras, números y operadores escriben en la terminal y la LCD
se actualiza inmediatamente. Las funciones `SIN`, `COS`, `TAN` y `LOG` se
insertan como texto para completar la expresión con paréntesis y argumentos.

### 3.2 CLEAR, CLS y NEW no son lo mismo

| Orden | Qué borra | Qué conserva |
| --- | --- | --- |
| `CLS` | Contenido visible de la LCD | Variables, programa y terminal. |
| `CLEAR` | Variables, arrays, datos, pilas, errores, teclas y LCD | Programa del banco actual y VFS. |
| `NEW` | Programa del banco actual y estado de ejecución | Los demás bancos y VFS. |
| `SHIFT + CLEAR` | Historial de terminal, entrada y LCD | Programa, variables y VFS. |

---

## 4. Modos de operación y calculadora

Pulse **MODE** y luego uno de estos números:

| Secuencia | Modo | Uso |
| --- | --- | --- |
| `MODE`, `0` | CAL | Calculadora de expresiones inmediatas. |
| `MODE`, `1` | BASIC | Edición y ejecución de programas BASIC. |
| `MODE`, `4` | DEG | Ángulos en grados. |
| `MODE`, `5` | RAD | Ángulos en radianes. |
| `MODE`, `6` | GRA | Ángulos en gradianes. |

### 4.1 Operaciones en CAL

En modo CAL escriba una expresión y pulse EXE. El resultado se muestra en la
LCD, queda guardado como `ANS` y se añade al historial.

```basic
2+3*4
(10-2)^3/4
SQR(81)+FACT(5)
SIN(30)
NCR(8,2)
```

Se admiten `+`, `-`, `*`, `/`, `^`, `MOD`, paréntesis, números decimales,
`PI`, `RND`, `RAN#`, y funciones como `SIN`, `COS`, `TAN`, `ASN`, `ACS`,
`ATN`, `LOG`, `LN`, `EXP`, `SQR`, `ABS`, `INT`, `FIX`, `FRAC`, `ROUND`,
`FACT`, `NPR` y `NCR`.

Las operaciones trigonométricas usan la unidad elegida por MODE. Por ejemplo,
con DEG, `SIN(30)` da aproximadamente `0.5`; con RAD, `SIN(30)` interpreta
30 como radianes. Las divisiones por cero, raíces de números negativos y
resultados no finitos notifican un error BASIC en vez de mostrar un resultado
incorrecto.

---

## 5. Programas BASIC

### 5.1 Crear, editar y ejecutar

Un programa está formado por líneas numeradas. La misma línea puede editarse
volviéndola a escribir con el mismo número.

```basic
10 CLS
20 FOR I=1 TO 5
30 PRINT "VUELTA ";I
40 NEXT I
50 END
```

- `RUN` inicia desde la primera línea.
- `LIST` muestra las líneas en orden numérico.
- Escribir `30` sin texto borra la línea 30.
- `NEW` borra todas las líneas del banco actualmente seleccionado.
- `STOP` interrumpe un programa; `END` finaliza normalmente.

### 5.2 Variables y datos

- Variables numéricas: `A`, `TOTAL`, `X1`.
- Variables de texto: terminan en `$`, por ejemplo `NOMBRE$`.
- Arrays: deben crearse con `DIM A(10)` o `DIM N$(5)` antes de usarlos.
- Los índices de arrays comienzan en 0 y llegan al tamaño indicado.
- `DATA`, `READ` y `RESTORE` permiten datos integrados en el programa.

Ejemplo:

```basic
10 DIM N(2)
20 DATA 10,20,30
30 FOR I=0 TO 2:READ N(I):NEXT I
40 PRINT N(0)+N(1)+N(2)
```

### 5.3 Flujo de control disponible

El intérprete incluye `IF ... THEN ... ELSE`, `GOTO`, `GOSUB`, `RETURN`,
`FOR ... TO ... STEP ... NEXT`, `WHILE ... WEND`, `ON ... GOTO/GOSUB`,
`ON ERROR GOTO`, `RESUME`, `TRON` y `TROFF`. Los errores de ejecución se
muestran con su línea para facilitar la corrección.

---

## 6. Bancos de programas P:0–P:9

La JCC-700 conserva diez programas independientes en memoria: `P:0` hasta
`P:9`. Al abandonar un banco, el programa actual se guarda automáticamente;
al seleccionar otro, se carga su contenido.

### Selección desde el teclado

Pulse **SHIFT** y después un dígito de `0` a `9`.

### Selección desde la terminal

```basic
P:0
P:7
P:9!
```

El signo `!` final es opcional. La terminal confirma el banco y el número de
líneas cargadas. Use `LIST` para comprobarlo y `RUN` para ejecutarlo.

> `NEW` solo vacía el banco activo. Para eliminar los diez bancos hay que
> seleccionarlos y ejecutar `NEW` en cada uno.

---

## 7. Librerías BASIC

El panel **LIBRERÍAS BASIC** muestra las bibliotecas disponibles y permite
introducir un código, por ejemplo `0400`, antes de pulsar **LIB**. También se
puede pulsar **SHIFT + LIB** para abrir el catálogo.

Las bibliotecas `.bas` se mantienen como archivos fuente y no se modifican
desde la interfaz. Al cargar una se utiliza su ruta original y el intérprete
intenta ejecutar las instrucciones compatibles. Algunas bibliotecas históricas
usan extensiones específicas del hardware Casio; si una función no está
implementada, la terminal indica la instrucción o el error correspondiente.

---

## 8. Sistema de archivos virtual (VFS)

El panel VFS trabaja con archivos que viven durante la sesión del navegador.

| Control | Uso |
| --- | --- |
| Selector de archivos | Selecciona `.bas`, `.txt`, `.png` o `.svg` para importar. |
| Nombre | Nombre del archivo virtual, por ejemplo `JUEGO.BAS`. |
| Contenido | Texto que se guardará en un archivo de texto. |
| Crear/Guardar | Crea o reemplaza el archivo indicado. |
| Nuevo `.BAS` | Genera una plantilla BASIC inicial. |
| Guardar sesión | Guarda el programa actual en el VFS. |
| Leer | Carga el contenido en el editor VFS. |
| Borrar | Elimina el archivo indicado. |
| Listar | Actualiza la lista de archivos. |
| Importar | Copia los archivos seleccionados al VFS. |

Desde BASIC se pueden emplear `LOAD`, `SAVE`, `OPEN`, `CLOSE`, `PRINT#`,
`INPUT#`, `MKFILE`, `READFILE`, `WRITE` y `DELFILE` cuando corresponda.

---

## 9. LCD, caracteres y gráficos

### 9.1 Posicionamiento y texto

- `LOCATE columna,fila` mueve la posición de escritura; las posiciones BASIC
  son de 1 a 32 en columna y de 1 a 2 en fila.
- `PRINT` escribe en LCD y terminal.
- `CLS` limpia la LCD.

### 9.2 Caracteres personalizados

`DEFCHR$` define un carácter con cinco bytes hexadecimales. Cada byte describe
una columna de la matriz y se visualizan sus siete píxeles activos.

```basic
10 DEFCHR$(255)="0000FE0000"
20 PRINT CHR$(255)
```

### 9.3 Gráficos simples

- `GCLS` borra la superficie gráfica (la LCD).
- `GPHYCS x,y,"C"` coloca un carácter usando coordenadas de píxel en el área
  de 160 × 14. El carácter se proyecta a la celda LCD correspondiente.

Ejemplo:

```basic
10 GCLS
20 GPHYCS 10,3,"*"
30 GPHYCS 80,7,"+"
```

---

## 10. Consejos de resolución de problemas

1. **No veo lo que escribo en LCD**: haga clic en la entrada de terminal; la
   LCD refleja la entrada mientras ese control tiene el foco.
2. **El programa no se ejecuta**: use `LIST`, compruebe los números de línea y
   pulse `RUN` o EXE con una entrada vacía.
3. **Quiero borrar solo la pantalla**: utilice `CLS`, no `CLEAR` ni `NEW`.
4. **Quiero borrar el texto inicial/historial**: pulse `SHIFT + CLEAR`.
5. **El seno no coincide con mi expectativa**: compruebe DEG/RAD/GRA mediante
   MODE; el indicador activo muestra la unidad seleccionada.
6. **No aparece mi programa**: confirme el banco actual con `P:n` y `LIST`.
7. **Una biblioteca parece quedarse esperando**: si la terminal no muestra error,
   normalmente está esperando una tecla o un dato del programa Casio. Use el
   campo de entrada, `--inputs` en `run_prg.js` o `--keys` para automatizarlo.
8. **Quiero comprobar todas las bibliotecas**: ejecute
   `./scripts/check_basic_compat.sh`, `./scripts/run_casio_library_smoke.sh` y
   `./scripts/run_casio_library_functional.sh`; las tres pruebas deben terminar
   con `ERRORES=0`.


---

## 11. Origen: Casio FX-850P / FX-880P

La JCC-700 es una interfaz web **inspirada en la Casio FX-880P** y compatible
en parte con el BASIC de la familia FX-850P/FX-880P. No es una ROM ni una
réplica física de Casio: conserva la estética de ordenador de bolsillo, la LCD
de 32 × 2, los bancos de programa, la escritura BASIC y el formato de
bibliotecas, mientras adapta la ejecución al navegador.

El catálogo incluido procede de la lista de programas de biblioteca para
**Casio FX-850P/880P**, acreditada en `LIB_INFO.bas` a M. Becker. Los ficheros
`.bas` se preservan sin modificaciones. El número “116” es una agrupación
habitual; el índice entregado en este repositorio enumera **120 módulos
públicos** (incluido el menú `LIBK0630`), 21 módulos auxiliares y el índice de texto
`LIB_INFO.bas`: **142 archivos `.bas` en total**.

### Cómo usar una biblioteca

1. Escriba su código en el campo de bibliotecas (por ejemplo, `5010`).
2. Pulse **LIB**; la JCC-700 carga el programa y solicita los datos necesarios.
3. Use **SHIFT + LIB** para consultar el catálogo.
4. Para volver a su trabajo, seleccione su banco `P:n`; las bibliotecas se
   ejecutan como programas BASIC y pueden cambiar el programa activo.

> **Compatibilidad actual:** la colección completa está integrada y se valida
> con dos comprobaciones reproducibles: los **142 archivos `.bas` cargan sin
> errores**; el smoke de ejecución arranca todos los módulos hasta finalizar o
> alcanzar una espera legítima de teclado/entrada; y la prueba funcional alimenta
> entradas/teclas sintéticas para usar menús y cálculos, todo con **ERRORES=0**. Las rutinas
> de hardware (`PEEK`, `POKE`, `DEFSEG`, `COM`, `CAS`, `LPRINT`) usan stubs o
> el VFS de la JCC-700 cuando no existe el periférico físico.

### Catálogo completo de módulos públicos

La lista se mantiene como inventario de las **120 bibliotecas públicas**. El
estado es verificable y no una promesa matemática de resultados de referencia:
🟢 significa **integrado, cargable, arrancable y probado con entradas sintéticas en JCC-700**; cuando un módulo
requiere datos, teclado o periféricos, la ejecución se considera correcta si
llega a esa frontera interactiva sin errores BASIC. Los 21 módulos auxiliares
se enumeran por separado porque solo son funciones reales cuando los llama un
módulo público.

| Módulo | Qué hace (descripción funcional original) | Estado de función original |
| --- | --- | --- |
| `LIB0400` | Speicher- und Schnittstellen-Testprogramm | 🟢 Ejecutable en JCC-700: periféricos Casio sustituidos por stubs/VFS cuando aplica. |
| `LIB0800` | Download-Programm | 🟢 Ejecutable en JCC-700: periféricos Casio sustituidos por stubs/VFS cuando aplica. |
| `LIB0900` | Konvertier-Programm | 🟢 Ejecutable en JCC-700: periféricos Casio sustituidos por stubs/VFS cuando aplica. |
| `LIB1000` | Speicher-Berechnungen | 🟢 Ejecutable en JCC-700: usa teclado interactivo y memoria emulada. |
| `LIB5010` | Primfaktoren-Analyse | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5020` | Grsster gemeinsamer Teiler, Kleinstes gemeinsames Vielfaches | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5040` | Gleichungssystem (Gauss-Elimination) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5050` | Quadratische Gleichnung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5060` | Kubische Gleichung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5080` | Numerische Lsung einer Gleichung (Newton) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5090` | Numerische Lsung einer Gleichung (Halbierungs-Methode) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5100` | Matrixoperationen | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5200` | Numerische Integration (Romberg-Methode) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5220` | Gewhnliche Differenzialgleichnung(Ru.Ku.) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5230` | Lagrangsche Interpolation | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5250` | Gamma-Funktion | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5260` | Besselsche Funktion Jn(x) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5270` | Besselsche Funktion Yn(x) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5280` | Modifizierte Besselsche Funktion In(x) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5290` | Modifizierte Besselsche Funktion Kn(x) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5300` | Komplexe Zahlen | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5350` | Binr-Dezimal-Hexadezimal | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5510` | Gerade durch zwei Punkte | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5520` | Schnittwinkel von zwei Geraden | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5530` | Abstand zwischen Punkt und Gerade | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5540` | Drehbewegung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5550` | Kreis durch drei Punkte | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5560` | Lnge von Tangenten von einem Punkt zu einem Kreis | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5570` | Tangentialgleichnung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5600` | Dreiecksflche | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5605` | Flche eines Trapezoides | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5610` | Flche eines Parallelogramms | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5615` | Flche eines Kreises | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5620` | Flche eines Sektors | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5625` | Flche eines Segments | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5630` | Flche einer Ellipse | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5635` | Flche eines Polygons | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5650` | Flcheninhalt einer Kugel | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5655` | Flcheninhalt einer Kugelzone | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5660` | Flcheninhalt eines Kugelsektors | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5665` | Oberflche eines Kreiszylinders | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5670` | Oberflche eines Kreiskegels | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5675` | Flcheninhalt eines Kreiskegelstumpfes | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5700` | Rauminhalt einer Kugel | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5705` | Rauminhalt einer Kugelzone | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5710` | Rauminhalt eines Kugelsektors | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5715` | Rauminhalt eines kreiszylinders | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5720` | Rauminhalt eines Kreiskegels | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5725` | Rauminhalt eines Kreiskegelstumpfes | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5730` | Rauminhalt eines Keils | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5735` | Rauminhalt einer Pyramide | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5740` | Rauminhalt eines Pyramidenstumpfes | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5745` | Rauminhalt eines Ellipsoiden | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5750` | Einbeschriebener Kreis und Umbeschriebener Kreis eines Polygons | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5760` | Regelmiger Polyeder | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5800` | Zerlegung in Faktoren | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5810` | Trigonometrische Funktionen | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5820` | Differenziale | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5830` | Integrationen | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5840` | Laplace-Transformation | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5900` | Tabelle des Periodischn Systems | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5910` | Wissenschaftliche Konstanten | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5920` | Konstante der elektrolytischen Dissoziation | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5930` | Bewegung und Energie | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5932` | Wellenbewegung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5934` | Wechselstrom und Gleichstromkreise | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5936` | Elektrische und magnetische Felder | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5938` | Thermodynamik und Anderes | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5950` | Metrische Umwandlungen fr Lngen | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5960` | Metrische Umwandlungen fr Flchen | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5970` | Metrische Umwandlungen fr Rauminhalte | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB5980` | Metrische Umwandlungen fr Gewicht | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6210` | Obere Wahrscheinlichkeitsintegrale (Normalverteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6220` | Obere Wahrscheinlichkeitsintegrale (x^2 Verteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6230` | Obere Wahrscheinlichkeitsintegrale (t Verteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6240` | Obere Wahrscheinlichkeitsintegrale (F Verteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6310` | Obere Summenhufigkeit (Binominal-Verteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6320` | Obere Summenhufigkeit (Poisson-Verteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6330` | Obere Summenhufigkeit (Hypergeometrische Verteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6410` | Prozentpunkt (Normalverteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6420` | Prozentpunkt (x^2 Verteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6430` | Prozentpunkt (t Verteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6440` | Prozentpunkt (F Verteilung) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6450` | Normale Zufallszahlen | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6460` | Exponentielle Zufallszahlen | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6500` | Statistische Berechnungen mit einer Variablen | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6510` | Lineare Regression (y=a+bx) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6520` | Logarithmische Regression (y=a+b lnx) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6530` | Exponentielle Regression (y=ab^x) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6540` | Potenz-Regression (y=ax^b) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6610` | Mittelwert-Intervallschtzung (fr bekannte Varianz) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6620` | Mittelwert-Intervallschtzung (fr unbekannte Varianz) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6630` | Varianz-Intervallschtzung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6640` | Standardabweichnung-Intervallschtzung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6650` | Varianzquotient-Intervallschtzung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6660` | Mittelwertdifferenz-Intervallschtzung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6670` | Verhltnis-Intervallschtzung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6680` | Verhltnisdifferenz-Intervallschtzung | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6710` | Grundgesamtheits-Mittelwert-Test (zweiseitig): fr bek. Varianz) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6711` | Grundgesamtheits-Mittelwert-Test (rechtsseitig): fr bek. Varianz) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6712` | Grundgesamtheits-Mittelwert-Test (linksseitig): fr bek. Varianz) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6720` | Grundgesamtheits-Mittelwert-Test (zweiseitig): fr unbek. Varianz) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6721` | Grundgesamtheits-Mittelwert-Test (rechtsseitig): fr unbek. Varianz) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6722` | Grundgesamtheits-Mittelwert-Test (linksseitig): fr unbek. Varianz) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6730` | Grundgesamtheits-Varianz-Test (zweiseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6731` | Grundgesamtheits-Varianz-Test (rechtsseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6732` | Grundgesamtheits-Varianz-Test (linksseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6740` | Varianzquotient-Test (zweiseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6741` | Varianzquotient-Test (rechtsseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6742` | Varianzquotient-Test (linksseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6750` | Mittelwertdifferenz-Test (zweiseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6751` | Mittelwertdifferenz-Test (rechtsseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6752` | Mittelwertdifferenz-Test (linksseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6760` | Quotiententest (zweiseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6761` | Quotiententest (rechtsseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6762` | Quotiententest (linksseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6770` | Quotientendifferenztest (zweiseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6771` | Quotientendifferenztest (rechtsseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIB6772` | Quotientendifferenztest (linksseitig) | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |
| `LIBK0630` | Men- und Startprogramm fr die LIB-Programme | 🟢 Ejecutable en JCC-700: carga, arranque y uso con entradas sintéticas verificados; validar resultados con datos de referencia cuando aplique. |


### Módulos auxiliares internos

No son aplicaciones independientes: proporcionan menús, entrada de datos,
distribuciones y contrastes para las bibliotecas públicas: `LIBM6510`,
`LIBM6710`, `LIBM6720`, `LIBM6730`, `LIBM6740`, `LIBM6750`, `LIBM6760`,
`LIBM6770`, `LIBS6020`, `LIBS6030`, `LIBS6210`, `LIBS6220`, `LIBS6230`,
`LIBS6240`, `LIBS6310`, `LIBS6320`, `LIBS6330`, `LIBS6410`, `LIBS6420`,
`LIBS6430` y `LIBS6440`.

| Grupo | Cantidad | Estado actual verificable | Siguiente condición para 🟢 |
| --- | ---: | --- | --- |
| Bibliotecas públicas de cálculo, geometría, conversión y estadística | 116 | 🟡 Cargan; la interfaz o el flujo inicial está en portabilidad. | Caso de referencia por biblioteca. |
| Sistema (`0400`, `0800`, `0900`, `1000`) y menú (`K0630`) | 5 | 🔴/🟡: dependen de memoria, comunicaciones, cinta o teclado especial. | Adaptador de dispositivo y prueba equivalente. |
| Módulos auxiliares `LIBM*`/`LIBS*` | 21 | 🟠: se cargan desde el llamador, no como aplicaciones aisladas. | Prueba integrada del llamador. |
| Índice `LIB_INFO` | 1 | ℹ️ Datos del catálogo, no una función ejecutable. | No aplica. |


---

## 12. Compatibilidad Casio: contrato, estados y límites

La JCC-700 no debe marcar una biblioteca como correcta solo porque termina en
`READY`. Cada estado del catálogo tiene un significado estricto:

| Estado | Significado | Evidencia mínima |
| --- | --- | --- |
| 🟢 **Completamente y Correctamente** | La función original y sus resultados de referencia se reproducen en JCC-700. | Caso de entrada, salida esperada y prueba automatizada. |
| 🟡 **Parcialmente** | El archivo carga o alcanza su interfaz, pero no existe todavía una prueba de resultado que demuestre toda su función original. | `check_basic_compat.sh` y/o inicio controlado. |
| 🟠 **Parcialmente: módulo interno** | Rutina auxiliar; no tiene una interfaz independiente. Se valida únicamente desde su biblioteca llamadora. | Prueba integrada del llamador. |
| 🔴 **No funciona** | Depende de un periférico, una dirección de memoria o un servicio Casio que el navegador no puede recrear fielmente. | Limitación documentada y reproducible. |

Los iconos del catálogo son deliberadamente conservadores: hoy no se declara
ningún algoritmo como 🟢 sin una entrada y salida de referencia. Esto evita
confundir una carga sintáctica con una respuesta matemática correcta. Un
programa solo se asciende a 🟢 al añadir una prueba que compare un resultado
conocido y que pase en el intérprete.

### Progreso actual de portabilidad

La **Scientific Library 120 / JCC-120** presenta 120 programas científicos principales y conserva **142** ficheros `.bas` en total contando menús y auxiliares. La colección completa carga en el intérprete y supera la comprobación de carga. También se han incorporado compatibilidades de sintaxis Casio para `MODE` compacto, `INPUT$`, `DIM` sin argumentos, `DATA` textual sin comillas, `RESTORE n`, operadores sin espacio (`ANDa`, `ORFRACx`) y manejadores `ON ERROR GOTO` con `ERR`/`ERL`.

Este avance es de **compatibilidad de análisis y arranque**, no una promoción
automática a 🟢. La auditoría de agosto de 2026 aún encuentra líneas Casio que
el intérprete conserva como `compatSkipped` y flujos que requieren semántica de
ficheros, memoria o periféricos. Por ello, el catálogo sigue en 🟡/🟠/🔴 hasta
que cada biblioteca tenga el caso de referencia exigido en esta misma sección.
No cambie un `LIB*.bas` para reducir esa lista: la corrección debe hacerse en
el intérprete y en pruebas externas.

### 12.1 Comandos Casio implementados o adaptados

| Construcción Casio | Comportamiento en JCC-700 |
| --- | --- |
| `MODE 4`, `MODE 5`, `MODE 6` | Selecciona DEG, RAD o GRA para las funciones trigonométricas. |
| `DEFCHR$` | Define el glifo de 5×7 píxeles utilizado por la LCD. |
| `DEFSEG`, `PEEK`, `POKE` | Usa memoria emulada segmentada; no representa ROM ni E/S física real. |
| `INPUT@col;variable` | Conserva la lectura de `variable`; la columna es solo una instrucción de colocación visual. |
| `LPRINT` | Emite el texto en la salida de la JCC-700; no envía datos a una impresora física. |
| `OPEN`, `CLOSE`, `PRINT#`, `INPUT#` | Trabaja con el VFS de la sesión, no con COM, cinta ni tarjeta Casio. |
| `GOTO/GOSUB "LIB0:..."` | Resuelve módulos de biblioteca disponibles en el árbol mediante el cargador de la JCC-700. |
| `INPUT$` e `INKEY$` | Lee el búfer de teclado. En el modo de prueba se detiene como `INPUT REQUIRED`, sin fabricar pulsaciones. |
| `DATA` textual y `RESTORE n` | Conserva fórmulas/tablas sin comillas como texto y reposiciona `READ` por línea Casio. |

Los puertos serie, cinta, impresora, ROM real, mapa de memoria del FX-850P y
sus teclas físicas especiales no se pueden certificar como equivalentes en un
navegador. Esas dependencias mantienen la biblioteca en 🔴 o 🟡 aunque el
archivo cargue.

### 12.2 Verificación reproducible de las 142 bibliotecas

Ejecute desde la raíz del repositorio:

```bash
./scripts/check_basic_compat.sh
./scripts/run_casio_library_smoke.sh
```

El primer comando comprueba que están los 142 ficheros y que todos cargan sin
los errores de parseo detectados. El segundo inicia cada uno sin inyectar
teclas ni valores: `[INPUT REQUIRED]` es una parada controlada, no un éxito
funcional. Si muestra `ERROR BASIC`, anote el módulo y línea antes de ampliar
el intérprete; nunca modifique el `LIB*.bas` original para ocultar el error.

### 12.3 Cómo convertir una biblioteca en 🟢

1. Seleccione una biblioteca y copie su propósito desde el catálogo original.
2. Defina una entrada pequeña con resultado conocido (incluidas unidad angular
   y datos previos si el programa los necesita).
3. Ejecute el programa en un Casio compatible, emulador fiable o documentación
   primaria y registre exactamente la salida esperada.
4. Añada una prueba fuera de `MB-Casio-Basic-Library` que inyecte esas entradas
   al intérprete y compare salida/variables.
5. Si falla, implemente la semántica ausente en `V1.0.html`, repita todas las
   comprobaciones y actualice solo entonces su estado a 🟢.

---

## 13. Diagnóstico de bibliotecas y errores

| Mensaje | Qué significa | Acción correcta |
| --- | --- | --- |
| `?Syntax error in n` | La línea no se interpreta con la gramática actual. | Añada compatibilidad al intérprete, no edite el módulo Casio. |
| `?Undefined line in n` | Falta una línea local o un módulo llamado mediante `LIB0:`. | Compruebe que el módulo auxiliar existe y el cargador puede encontrarlo. |
| `?Subscript out of range in n` | El programa recibió una entrada o estado no válido. | No use entradas vacías en una prueba funcional; documente una secuencia válida. |
| `?Execution limit exceeded in n` | Hay bucle o espera no resuelta. | Use `--smoke`; después modele la entrada/tecla o el periférico necesario. |
| `[INPUT REQUIRED]` | El modo de prueba alcanzó entrada interactiva. | Estado de arranque válido, pero todavía no valida el cálculo. |

### Guía rápida por área

- **0400–1000:** memoria, transferencia, conversión y cálculo de memoria.
- **5010–5350:** álgebra, ecuaciones, matrices, cálculo numérico, Bessel,
  complejos y conversión de bases.
- **5510–5760:** geometría plana, áreas, superficies, volúmenes y poliedros.
- **5800–5980:** fórmulas, física, química, constantes y conversiones.
- **6210–6680:** distribuciones, probabilidad, regresión e intervalos.
- **6710–6772:** contrastes estadísticos bilateral, cola derecha y cola izquierda.
