# Investigación: Funciones y Predicados en Prolog
---
# PARTE I — FUNCIONES EN PROLOG

En Prolog las funciones existen formalmente en el ámbito de la evaluación aritmética. No se ejecutan de manera aislada en el código fuente; se evalúan al lado derecho del operador infijo `is/2` o como argumentos de operadores de comparación numérica como `=:=` o `>`.

```prolog
% Regla de evaluacion:
Variable is Expresion_o_Funcion(Argumentos)
```

> **Regla fundamental de instanciación:** Todas las variables dentro de una función o expresión matemática deben tener un valor numérico concreto antes de ejecutarse. De no ser así, el motor interrumpe la consulta con el error `Arguments are not sufficiently instantiated`.

---

### 1.1 Operadores Aritméticos Básicos

| Operador | Operación | Ejemplo | Salida |
| :---: | :--- | :--- | :--- |
| `+` | Suma | `?- X is 15 + 8.` | `X = 23.` |
| `-` | Resta | `?- X is 20 - 7.` | `X = 13.` |
| `*` | Multiplicación | `?- X is 6 * 4.` | `X = 24.` |
| `/` | División en punto flotante | `?- X is 9 / 2.` | `X = 4.5.` |
| `//` | División entera (cociente sin decimales) | `?- X is 9 // 2.` | `X = 4.` |
| `mod` | Módulo (residuo de división entera) | `?- X is 14 mod 4.` | `X = 2.` |
| `rem` | Resto de la división | `?- X is rem(14, 4).` | `X = 2.` |
| `^` o `**` | Exponenciación / Potencia | `?- X is 2 ^ 5.` | `X = 32.` |
| `-` (unario) | Cambio de signo | `?- X is -(10).` | `X = -10.` |

---

### 1.2 Funciones Matemáticas Algebraicas

| Función | Descripción | Ejemplo de consulta | Salida |
| :--- | :--- | :--- | :--- |
| `abs(X)` | Valor absoluto de un número | `?- X is abs(-18.5).` | `X = 18.5.` |
| `sign(X)` | Signo del número (-1 si negativo, 0 si cero, 1 si positivo) | `?- X is sign(-35).` | `X = -1.` |
| `sqrt(X)` | Raíz cuadrada (retorna float) | `?- X is sqrt(64).` | `X = 8.0.` |
| `max(A, B)` | Devuelve el valor más alto entre A y B | `?- X is max(14, 29).` | `X = 29.` |
| `min(A, B)` | Devuelve el valor más bajo entre A y B | `?- X is min(14, 29).` | `X = 14.` |

---

### 1.3 Funciones de Redondeo y Conversión Numérica

| Función | Comportamiento | Ejemplo | Salida |
| :--- | :--- | :--- | :--- |
| `round(X)` | Redondea al entero más próximo | `?- X is round(7.6).` | `X = 8.` |
| `floor(X)` | Redondea hacia abajo (el mayor entero menor o igual a X) | `?- X is floor(7.9).` | `X = 7.` |
| `ceiling(X)` | Redondea hacia arriba (el menor entero mayor o igual a X) | `?- X is ceiling(7.1).` | `X = 8.` |
| `truncate(X)` | Elimina los decimales truncando hacia cero | `?- X is truncate(-7.8).` | `X = -7.` |
| `float(X)` | Convierte un número entero a número flotante | `?- X is float(12).` | `X = 12.0.` |

---

### 1.4 Funciones Trigonométricas y Logarítmicas

Los argumentos angulares se expresan en radianes:

| Función | Propósito | Ejemplo | Salida aproximada |
| :--- | :--- | :--- | :--- |
| `sin(X)` | Seno | `?- X is sin(0).` | `X = 0.0.` |
| `cos(X)` | Coseno | `?- X is cos(0).` | `X = 1.0.` |
| `tan(X)` | Tangente | `?- X is tan(0.785398).` | `X = 0.999999...` |
| `asin(X)` | Arco seno | `?- X is asin(1.0).` | `X = 1.570796...` *(pi/2)* |
| `acos(X)` | Arco coseno | `?- X is acos(1.0).` | `X = 0.0.` |
| `atan(X)` | Arco tangente | `?- X is atan(1.0).` | `X = 0.785398...` *(pi/4)* |
| `exp(X)` | Función exponencial (e elevado a la X) | `?- X is exp(1).` | `X = 2.718281...` |
| `log(X)` | Logaritmo natural en base e | `?- X is log(2.718281).` | `X = 0.999999...` |
| `log10(X)` | Logaritmo común en base 10 | `?- X is log10(1000).` | `X = 3.0.` |

---

### 1.5 Operaciones a Nivel de Bits (Bitwise) y Constantes

| Operador / Función | Acción | Ejemplo | Salida |
| :--- | :--- | :--- | :--- |
| `/\` | AND a nivel de bits | `?- X is 12 /\ 10.` | `X = 8.` |
| `\/` | OR a nivel de bits | `?- X is 12 \/ 10.` | `X = 14.` |
| `xor` | XOR a nivel de bits | `?- X is 12 xor 10.` | `X = 6.` |
| `\` (unario) | NOT o complemento a nivel de bits | `?- X is \ 0.` | `X = -1.` |
| `<<` | Desplazamiento a la izquierda | `?- X is 3 << 2.` | `X = 12.` |
| `>>` | Desplazamiento a la derecha | `?- X is 12 >> 2.` | `X = 3.` |
| `pi` | Constante matemática pi | `?- X is pi.` | `X = 3.141592653589793.` |
| `e` | Constante base de logaritmos naturales | `?- X is e.` | `X = 2.718281828459045.` |

---

# PARTE II — PREDICADOS PROPIOS DE PROLOG

Los predicados predefinidos no devuelven un valor en el sentido convencional; se evalúan como metas que tienen éxito (`true`) o fallan (`false`), ligando variables en el proceso.

---

## 2.1 Unificación y Comparación

Prolog maneja tres tipos distintos de comparación: unificación simbólica, identidad estricta y comparación numérica.

| Operador | Tipo | Acción | Ejemplo | Salida |
| :---: | :--- | :--- | :--- | :--- |
| `=` | Unificación | Intenta ligar términos para volverlos idénticos | `?- X = casa(azul).` | `X = casa(azul).` |
| `\=` | No unificable | Verdadero si los dos términos no pueden coincidir | `?- ana \= beto.` | `true.` |
| `==` | Identidad estricta | Verdadero solo si son idénticos sin ligar variables | `?- X == Y.` | `false.` *(son variables libres distintas)* |
| `\==` | No idénticos | Verdadero si difieren formalmente en este momento | `?- X \== Y.` | `true.` |
| `=:=` | Igualdad numérica | Calcula ambos lados con `is` y compara el valor | `?- 10 =:= 4 + 6.` | `true.` |
| `=\=` | Desigualdad numérica | Compara si los resultados numéricos son distintos | `?- 10 =\= 3 + 6.` | `true.` |
| `<` | Menor que | Evaluación aritmética estricta | `?- 4 < 9.` | `true.` |
| `>` | Mayor que | Evaluación aritmética estricta | `?- 12 > 5.` | `true.` |
| `>=` | Mayor o igual que | Evaluación aritmética estricta | `?- 7 >= 7.` | `true.` |
| `=<` | Menor o igual que | Evaluación aritmética estricta | `?- 5 =< 5.` | `true.` *(sintaxis obligatoria =<)* |
| `@<` | Orden estándar menor | Compara términos alfabética y estructuralmente | `?- ana @< beto.` | `true.` |
| `@>` | Orden estándar mayor | Compara términos alfabética y estructuralmente | `?- beto @> ana.` | `true.` |

---

## 2.2 Inspección de Tipos de Datos

Permiten verificar la naturaleza de un término antes de procesarlo:

| Predicado | Condición de éxito | Ejemplo | Salida |
| :--- | :--- | :--- | :--- |
| `var(X)` | X es una variable libre (no ligada) | `?- var(A).` | `true.` |
| `nonvar(X)` | X ya tiene algún valor asignado | `?- nonvar(numero(4)).` | `true.` |
| `atom(X)` | X es un átomo simbólico (texto en minúsculas o entre comillas) | `?- atom(beto).` | `true.` |
| `number(X)` | X es cualquier número (entero o decimal) | `?- number(14.8).` | `true.` |
| `integer(X)` | X es un número entero | `?- integer(20).` | `true.` |
| `float(X)` | X es un número de punto flotante | `?- float(5.0).` | `true.` |
| `atomic(X)` | X es átomo, número o cadena simple | `?- atomic(hola).` | `true.` |
| `compound(X)` | X es un término compuesto con nombre y argumentos | `?- compound(padre(juan)).` | `true.` |
| `is_list(X)` | X es una lista bien formada | `?- is_list([1, 2, 3]).` | `true.` |
| `ground(X)` | X no contiene ninguna variable libre en su estructura | `?- ground(punto(3, 4)).` | `true.` |

---

## 2.3 Manejo de Listas

Predicados nativos para manipular colecciones de elementos.

### a) Búsqueda, longitud y partición
```prolog
% Longitud de una lista
?- length([a, b, c, d], N).
N = 4.

% Pertenencia y generación
?- member(X, [rojo, verde, azul]).
X = rojo ;
X = verde ;
X = azul.

% Concatenación y división de listas
?- append([1, 2], [3, 4], Res).
Res = [1, 2, 3, 4].

?- append(Inicio, Fin, [a, b]).
Inicio = [], Fin = [a, b] ;
Inicio = [a], Fin = [b] ;
Inicio = [a, b], Fin = [].

% Inversión de orden
?- reverse([1, 2, 3], Inv).
Inv = [3, 2, 1].

% Extracción de un elemento
?- select(verde, [rojo, verde, azul], Resto).
Resto = [rojo, azul].

% Último elemento
?- last([gato, perro, loro], Ultimo).
Ultimo = loro.

% Obtención por índice (base 0 y base 1)
?- nth0(1, [manzana, pera, uva], Fruta).
Fruta = pera.

?- nth1(1, [manzana, pera, uva], Fruta).
Fruta = manzana.
```

### b) Listas numéricas
```prolog
% Generar rango numérico consecutivo
?- numlist(1, 5, Lista).
Lista = [1, 2, 3, 4, 5].

% Suma total de elementos
?- sum_list([10, 20, 30], Total).
Total = 60.

% Máximo y mínimo de la lista
?- max_list([4, 18, 9], Max).
Max = 18.

?- min_list([4, 18, 9], Min).
Min = 4.
```

### c) Ordenamiento
```prolog
% sort/2 ordena y descarta automáticamente duplicados:
?- sort([4, 1, 3, 1, 2], R).
R = [1, 2, 3, 4].

% msort/2 ordena conservando todos los duplicados:
?- msort([4, 1, 3, 1, 2], R).
R = [1, 1, 2, 3, 4].
```

---

## 2.4 Entrada y Salida (I/O)

Permiten enviar información a la consola o recibir datos del teclado.

### a) Salida en pantalla
* `write(Termino)`: Imprime el término sin salto de línea.
* `writeln(Termino)`: Imprime el término e inserta salto de línea al final.
* `nl`: Imprime únicamente un salto de línea.
* `tab(N)`: Imprime N espacios en blanco.
* `format(Formato, ListaArgumentos)`: Salida formateada con especificadores (`~w` para término, `~d` entero, `~n` salto de línea).

```prolog
?- format('Agente: ~w, Casa: ~d~n', [ana, 1]).
Agente: ana, Casa: 1
true.
```

### b) Entrada desde teclado
* `read(Variable)`: Lee un término completo desde el teclado. Requiere terminar la entrada con un punto (`.`).
* `get_char(Char)`: Lee un solo carácter en forma de átomo.
* `get_code(Codigo)`: Lee el código ASCII/Unicode del siguiente carácter.

```prolog
pedir_dato :-
    write('Introduce un valor (termina con punto): '),
    read(X),
    format('Recibido: ~w~n', [X]).
```

---

## 2.5 Control de Flujo y Podas

Gobiernan cómo retrocede y ramifica el motor de inferencia:

### a) El Corte (`!`)
Elimina todos los puntos de elección generados desde la entrada a la cláusula actual, congelando las decisiones tomadas y descartando reglas posteriores del mismo predicado:
```prolog
clasificar(N, positivo) :- N > 0, !.
clasificar(N, cero)     :- N =:= 0, !.
clasificar(_, negativo).
```

### b) Fallo explícito (`fail/0`)
Obliga al motor a fracasar inmediatamente en el objetivo actual, provocando el retroceso a buscar otras soluciones:
```prolog
listar_personas :-
    persona(P),
    writeln(P),
    fail.
listar_personas.
```

### c) Negación por fallo (`\+/1`)
Tiene éxito si la meta indicada **no puede demostrarse** como verdadera en la base de conocimientos:
```prolog
es_par(N) :- 0 =:= N mod 2.

es_impar(N) :- \+ es_par(N).
```

### d) Bifurcación condicional (`(Condicion -> Entonces ; Sino)`)
Estructura condicional que evalúa la condición; si tiene éxito, ejecuta la rama `Entonces` cortando alternativas de la condición, de lo contrario ejecuta la rama `Sino`:
```prolog
evaluar(Calificacion) :-
    ( Calificacion >= 70 ->
        writeln(aprobado)
    ;
        writeln(reprobado)
    ).
```

### e) Generador infinito de retroceso (`repeat/0`)
Crea un punto de retorno infinito. Si el código posterior falla, vuelve a ejecutar desde `repeat`:
```prolog
menu :-
    repeat,
    write('Opcion (1: salir): '),
    read(Op),
    Op =:= 1,
    writeln(fin).
```

---

## 2.6 Metaprogramación I: Inspección y Construcción de Términos

Permiten examinar la estructura de las relaciones lógicas o construirlas dinámicamente.

### a) `functor(Termino, Nombre, Aridad)`
Extrae o asigna el nombre principal y la cantidad de argumentos de una estructura:
```prolog
% Inspeccionar:
?- functor(vive_en(ana, 1), Nombre, Aridad).
Nombre = vive_en,
Aridad = 2.

% Construir esqueleto con variables libres:
?- functor(T, persona, 3).
T = persona(_A, _B, _C).
```

### b) `arg(Posicion, Termino, Argumento)`
Obtiene el argumento en la posición numérica indicada (iniciando en 1):
```prolog
?- arg(1, vive_en(ana, 1), Sujeto).
Sujeto = ana.

?- arg(2, vive_en(ana, 1), Casa).
Casa = 1.
```

### c) Operador Univ (`=..`)
Transforma un predicado en una lista cuyo primer elemento es el functor y el resto son sus argumentos, o viceversa:
```prolog
% De término a lista:
?- color_casa(1, blanca) =.. Lista.
Lista = [color_casa, 1, blanca].

% De lista a término ejecutable:
?- Termino =.. [bebe, beto, cafe].
Termino = bebe(beto, cafe).
```

### d) `copy_term(Original, Copia)`
Crea una copia idéntica del término pero reemplazando todas sus variables libres por variables libres completamente nuevas e independientes:
```prolog
?- copy_term(f(A, A), Copia).
Copia = f(_B, _B).
```

---

## 2.7 Base de Conocimientos Dinámica

Permiten modificar los hechos y reglas de la memoria en caliente durante la ejecución del programa.

### Declaración obligatoria
Para que un predicado pueda modificarse en tiempo de ejecución, debe declararse dinámico al inicio del archivo:
```prolog
:- dynamic puntuacion/2.
```

### Predicados de actualización en memoria
* `asserta(Clausula)`: Agrega la cláusula al **inicio** de la base de datos en memoria.
* `assertz(Clausula)`: Agrega la cláusula al **final** de la base de datos en memoria.
* `retract(Clausula)`: Elimina la **primera** cláusula que unifique con el argumento.
* `retractall(Patron)`: Elimina **todas** las cláusulas que unifiquen con el patrón indicado.
* `abolish(Nombre/Aridad)`: Borra el predicado por completo de la memoria.
* `listing(Nombre)`: Muestra en pantalla el contenido actual del predicado en memoria.

```prolog
% Ejemplo de contador en memoria:
:- dynamic contador/1.
contador(0).

incrementar :-
    retract(contador(ValorActual)),
    Nuevo is ValorActual + 1,
    assertz(contador(Nuevo)).
```

---

## 2.8 Predicados de Segundo Orden y Agregación

Recolectan todas las soluciones posibles que satisfacen un predicado dentro de una lista única.

### a) `findall(Plantilla, Meta, Lista)`
Encuentra todas las instancias de `Plantilla` que satisfacen `Meta`. Si ninguna satisface la meta, unifica con lista vacía `[]` y nunca falla:
```prolog
% Teniendo hechos: numero(10). numero(20). numero(30).
?- findall(X, numero(X), Resultados).
Resultados = [10, 20, 30].
```

### b) `bagof(Plantilla, Meta, Lista)`
Similar a `findall`, pero si existen variables libres no incluidas en la plantilla, agrupa las soluciones por cada variable libre diferente. Si no hay soluciones, falla (`false`):
```prolog
% Teniendo: nota(ana, 100). nota(beto, 80). nota(carla, 100).
?- bagof(Alumno, nota(Alumno, N), Lista).
N = 80, Lista = [beto] ;
N = 100, Lista = [ana, carla].
```

### c) `setof(Plantilla, Meta, Lista)`
Funciona como `bagof`, pero además **ordena el resultado y elimina cualquier elemento duplicado**:
```prolog
?- setof(N, Alumno^nota(Alumno, N), Calificaciones).
Calificaciones = [80, 100].
```

---

## 2.9 Metapredicados y Manejo de Errores

Permiten tratar metas lógicas como datos ejecutables y controlar fallos inesperados del sistema.

### a) `call(Meta)`
Ejecuta la meta contenida dentro de una variable o término:
```prolog
?- Meta = member(2, [1, 2, 3]), call(Meta).
Meta = member(2, [1, 2, 3]).
```

### b) `once(Meta)`
Ejecuta la meta solicitada pero solo extrae su **primera solución**, podando inmediatamente cualquier solución alternativa por retroceso:
```prolog
?- once(member(X, [a, b, c])).
X = a.
```

### c) `catch(Meta, Error, Manejador)` y `throw(Error)`
Mecanismo de captura y lanzamiento de excepciones:
```prolog
dividir(A, B, Res) :-
    ( B =:= 0 ->
        throw(error_division_cero)
    ;
        Res is A / B
    ).

division_segura(A, B, Res) :-
    catch(dividir(A, B, Res), error_division_cero, (writeln('Error: division entre cero'), Res = 0)).
```

---

## 2.10 Manipulación de Átomos y Texto

Predicados para inspeccionar, partir o ensamblar constantes textuales:

| Predicado | Descripción | Ejemplo | Salida |
| :--- | :--- | :--- | :--- |
| `atom_length(Atom, N)` | Longitud en caracteres de un átomo | `?- atom_length(prolog, N).` | `N = 6.` |
| `atom_concat(A, B, C)` | Une dos átomos A y B para formar C | `?- atom_concat(casa, roja, R).` | `R = casaroja.` |
| `atom_chars(Atom, Lista)` | Convierte entre un átomo y una lista de caracteres | `?- atom_chars(sol, L).` | `L = [s, o, l].` |
| `atom_codes(Atom, Lista)` | Convierte entre un átomo y la lista de sus códigos ASCII | `?- atom_codes(ab, L).` | `L = [97, 98].` |
| `sub_atom(Atom, Ant, Long, Desp, Sub)` | Extrae una subcadena especificando posiciones | `?- sub_atom(prolog, 0, 3, _, Sub).` | `Sub = pro.` |

---

# PARTE III — TABLA DE CONSULTA RÁPIDA

| Elemento | Tipo | Sintaxis / Aridad | Categoría | Acción principal |
| :--- | :---: | :---: | :--- | :--- |
| `+`, `-`, `*`, `/` | Función | Operador infijo | Aritmética | Operaciones numéricas en punto flotante y enteras con `is`. |
| `//`, `mod` | Función | Operador infijo | Aritmética | División entera y residuo con `is`. |
| `abs/1`, `sqrt/1` | Función | Prefija | Aritmética | Valor absoluto y raíz cuadrada evaluados con `is`. |
| `round/1`, `floor/1` | Función | Prefija | Aritmética | Redondeo al entero más cercano y redondeo hacia abajo. |
| `min/2`, `max/2` | Función | Prefija | Aritmética | Obtención de mínimo y máximo numérico. |
| `=`, `\=` | Predicado | `=/2`, `\=/2` | Comparación | Unificación sintáctica y no unificable. |
| `==`, `\==` | Predicado | `==/2`, `\==/2` | Comparación | Identidad estricta y diferencia estricta de términos. |
| `=:=`, `=\=` | Predicado | `=:=/2`, `=\=/2` | Comparación | Igualdad y desigualdad numérica evaluada. |
| `<`, `>`, `>=`, `=<` | Predicado | Relacional `/2` | Comparación | Comparación numérica estricta (menor o igual es `=<`). |
| `var/1`, `nonvar/1` | Predicado | `var/1`, `nonvar/1` | Tipos | Prueba si un término es variable libre o está instanciado. |
| `atom/1`, `number/1` | Predicado | `atom/1`, `number/1` | Tipos | Valida si un término es átomo textual o número. |
| `compound/1` | Predicado | `compound/1` | Tipos | Valida si un término es estructurado con functor. |
| `length/2` | Predicado | `length/2` | Listas | Longitud de lista o generación por tamaño. |
| `member/2` | Predicado | `member/2` | Listas | Pertenencia y extracción por retroceso. |
| `append/3` | Predicado | `append/3` | Listas | Concatenación o partición de listas. |
| `select/3` | Predicado | `select/3` | Listas | Extracción de un elemento de una lista. |
| `sort/2`, `msort/2` | Predicado | `sort/2`, `msort/2` | Listas | Ordenamiento de lista (sin duplicados con sort, con duplicados con msort). |
| `write/1`, `writeln/1` | Predicado | `write/1`, `writeln/1`| I/O | Salida de términos en consola con y sin salto de línea. |
| `read/1` | Predicado | `read/1` | I/O | Lectura de término por teclado terminado con punto. |
| `!` | Predicado | `!/0` | Control | Corte de puntos de retroceso en el árbol de búsqueda. |
| `fail/0` | Predicado | `fail/0` | Control | Provoca fallo inmediato para forzar retroceso. |
| `\+/1` | Predicado | `\+/1` | Control | Negación por fallo (hipótesis del mundo cerrado). |
| `( -> ; )` | Predicado | Operador | Control | Estructura condicional if-then-else. |
| `repeat/0` | Predicado | `repeat/0` | Control | Generador infinito de puntos de retorno para ciclos. |
| `functor/3`, `arg/3` | Predicado | `functor/3`, `arg/3` | Metaprogramación | Descomposición y armado de términos estructurados. |
| `=..` *(Univ)* | Predicado | `=../2` | Metaprogramación | Conversión bidireccional entre término y lista. |
| `asserta/1`, `assertz/1`| Predicado | `asserta/1`, `assertz/1`| Memoria | Inserción de hechos al inicio o al final de la base en caliente. |
| `retract/1`, `retractall/1`| Predicado | `retract/1`, `retractall/1`| Memoria | Eliminación de uno o todos los hechos que unifican en memoria. |
| `findall/3` | Predicado | `findall/3` | Segundo Orden | Recolecta todas las soluciones en una lista sin fallar. |
| `bagof/3`, `setof/3` | Predicado | `bagof/3`, `setof/3` | Segundo Orden | Agrupación de soluciones (setof ordena y elimina duplicados). |
| `call/1`, `once/1` | Predicado | `call/1`, `once/1` | Metaprogramación | Ejecución dinámica de metas y obtención de primera solución. |
| `catch/3`, `throw/1` | Predicado | `catch/3`, `throw/1`| Excepciones | Lanzamiento y captura controlada de errores. |
| `atom_chars/2` | Predicado | `atom_chars/2` | Texto | Conversión entre átomo textual y lista de caracteres. |