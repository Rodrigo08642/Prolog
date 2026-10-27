# Predicados predefinidos de Prolog

## 1. Control del flujo

| Predicado | Qué hace |
|---|---|
| `!` | **Corte**: una vez ejecutado, descarta los puntos de elección pendientes. Evita que Prolog pruebe otras cláusulas o soluciones al retroceder. |
| `A , B` | **Conjunción**: tiene éxito si A y B se cumplen. |
| `A ; B` | **Disyunción**: tiene éxito si se cumple A o B. |
| `Cond -> Entonces ; Si_no` | **Si-entonces-si no**: si `Cond` tiene éxito, ejecuta `Entonces`; si no, `Si_no`. |
| `\+ G` | **Negación por fallo**: tiene éxito si `G` *no se puede demostrar*. |
| `true` | Siempre tiene éxito. |
| `fail` | Siempre falla, forzando el retroceso. |
| `halt` | Termina el intérprete. |
| `repeat` | Siempre tiene éxito y se reintenta indefinidamente al retroceder. Sirve para bucles. |
| `call(G, Args...)` | Ejecuta `G` como objetivo, añadiéndole los argumentos extra. Permite pasar predicados como parámetros. |

```prolog
max(X, Y, X) :- X >= Y, !.
max(_, Y, Y).
```

---

## 2. Aritmética

- **`X is Expr`**: evalúa `Expr` y unifica el resultado con `X`. `X = 2+3` *no* calcula, pero `X is 2+3` sí (da 5).
- **`=:=`, `=\=`**: igualdad y desigualdad numérica (evalúan ambos lados).
- **`<`, `>`, `=<`, `>=`**: comparaciones numéricas. Ojo: se escribe `=<`, no `<=`.

### Funciones dentro de `is`

| Función | Descripción |
|---|---|
| `+ - *` | Operaciones básicas |
| `/` | División (en SWI da entero si es exacta, si no flotante) |
| `//` | División entera (`7 // 2 = 3`) |
| `mod` | Resto (`7 mod 3 = 1`) |
| `abs(X)` | Valor absoluto |
| `sqrt(X)` | Raíz cuadrada |
| `max(X,Y)`, `min(X,Y)` | Mayor y menor |
| `sin`, `cos`, `exp`, `log` | Trigonométricas, exponencial y logaritmo natural |
| `**`, `^` | Potencia |
| `truncate`, `round`, `ceiling`, `floor` | Convierten un flotante a entero (cortando, redondeando, hacia arriba o hacia abajo) |

```prolog
?- X is 7 mod 3 + sqrt(16).
X = 5.0.
```

---

## 3. Unificación y comparación de términos

| Predicado | Qué hace |
|---|---|
| `X = Y` | Intenta unificar. Si hace falta, liga variables. |
| `X \= Y` | Tiene éxito si *no* pueden unificarse. |
| `X == Y` | Son idénticos, sin ligar variables (`A == B` falla si son variables distintas). |
| `X \== Y` | No son idénticos. |
| `@<`, `@>`, `@=<`, `@>=` | Comparan según el orden estándar de términos (Variables < Números < Átomos < Términos compuestos). |
| `compare(Orden, X, Y)` | Unifica `Orden` con `<`, `=` o `>`. |

---

## 4. Verificación de tipos

| Predicado | Tiene éxito si... |
|---|---|
| `var(X)` | `X` es una variable sin ligar |
| `nonvar(X)` | `X` ya tiene valor |
| `atom(X)` | es un átomo (`hola`, `[]`) |
| `number(X)` | es entero o flotante |
| `integer(X)` / `float(X)` | es entero / flotante |
| `atomic(X)` | es átomo o número (no compuesto) |
| `compound(X)` | es un término compuesto (`f(a)`, `[1,2]`) |
| `callable(X)` | puede ejecutarse como objetivo |
| `is_list(X)` | es una lista bien formada |

---

## 5. Construcción y análisis de términos

| Predicado | Qué hace | Ejemplo |
|---|---|---|
| `functor(T, Nombre, Aridad)` | Extrae o construye un término a partir de su nombre y número de argumentos | `functor(f(a,b), N, A)` → `N=f, A=2` |
| `arg(N, T, A)` | Obtiene el argumento número N (desde 1) | `arg(2, f(a,b), X)` → `X=b` |
| `T =.. Lista` (univ) | Convierte entre término y lista `[nombre\|argumentos]` | `f(a,b) =.. L` → `L=[f,a,b]` |
| `copy_term(T, Copia)` | Crea una copia con variables nuevas | |

---

## 6. Átomos y cadenas

| Predicado | Qué hace |
|---|---|
| `atom_length(A, N)` | Longitud del átomo |
| `atom_concat(A, B, C)` | Concatena (también puede descomponer `C`) |
| `atom_chars(A, Lista)` | `hola` ↔ `[h,o,l,a]` |
| `atom_codes(A, Lista)` | Igual, pero con códigos ASCII |
| `atom_number(A, N)` | Convierte `'42'` ↔ `42` |
| `number_codes(N, Lista)` | Número ↔ lista de códigos |
| `sub_atom(A, Antes, Long, Despues, Sub)` | Extrae o busca subátomos |
| `upcase_atom(A, Mayus)` | Convierte a mayúsculas |
| `atomic_list_concat(Lista, Sep, Atomo)` | Une (o separa, si se da `Sep`) elementos. `atomic_list_concat([a,b,c], '-', R)` da `a-b-c` |
| `split_string(Cadena, Separadores, Relleno, Partes)` | Divide una cadena |

---

## 7. Listas

| Predicado | Qué hace |
|---|---|
| `append(L1, L2, L3)` | `L3` es `L1` seguida de `L2`. También sirve para dividir listas |
| `member(X, L)` | `X` es elemento de `L` (genera todos al retroceder) |
| `length(L, N)` | Longitud de la lista |
| `reverse(L, R)` | Invierte la lista |
| `nth0(I, L, X)` / `nth1(I, L, X)` | Elemento en posición `I` (indexando desde 0 o desde 1) |
| `last(L, X)` | Último elemento |
| `msort(L, S)` | Ordena sin eliminar duplicados |
| `sort(L, S)` | Ordena y elimina duplicados |
| `sort(Clave, Orden, L, S)` | Ordena por argumento y con orden `@<`, `@>=`, etc. |
| `sum_list(L, S)`, `max_list(L, M)`, `min_list(L, M)` | Suma, máximo y mínimo |
| `delete(L, X, R)` | Elimina de `L` los elementos que unifican con `X` |
| `include(P, L, R)` | Conserva los elementos que cumplen `P` |
| `exclude(P, L, R)` | Conserva los que *no* cumplen `P` |
| `maplist(P, L1, L2...)` | Aplica `P` a cada elemento (equivalente a *map*) |
| `foldl(P, L, V0, V)` | Acumula un resultado recorriendo la lista (equivalente a *reduce*) |

```prolog
?- maplist([X,Y]>>(Y is X*2), [1,2,3], L).
L = [2,4,6].
```

---

## 8. Búsqueda de todas las soluciones

| Predicado | Qué hace |
|---|---|
| `findall(Plantilla, Meta, Lista)` | Reúne todas las soluciones de `Meta`. Si no hay ninguna, da `[]` |
| `bagof(Plantilla, Meta, Lista)` | Igual, pero *falla* si no hay soluciones y agrupa por variables libres |
| `setof(Plantilla, Meta, Lista)` | Como `bagof`, pero ordena y elimina duplicados |
| `aggregate_all(count/sum/max/bag, Meta, R)` | Cuenta, suma o calcula máximos sobre las soluciones |

```prolog
?- findall(X, member(X, [1,2,3]), L).
L = [1,2,3].
```

---

## 9. Base de datos dinámica

| Predicado | Qué hace |
|---|---|
| `assert(C)` / `assertz(C)` | Agrega una cláusula al final |
| `asserta(C)` | La agrega al principio |
| `retract(C)` | Elimina la primera cláusula que unifique |
| `retractall(C)` | Elimina todas las que unifiquen |
| `abolish(Nombre/Aridad)` | Elimina un predicado completo |
| `dynamic Nombre/Aridad` | Declara que un predicado puede modificarse en ejecución |
| `clause(Cabeza, Cuerpo)` | Consulta cómo está definida una cláusula |

```prolog
:- dynamic contador/1.
contador(0).
incrementa :- retract(contador(N)), N1 is N+1, assert(contador(N1)).
```

---

## 10. Entrada/salida

### Salida

| Predicado | Qué hace |
|---|---|
| `write(T)` | Escribe el término |
| `print(T)` | Escribe usando el formato de impresión del sistema |
| `writeq(T)` | Escribe con comillas cuando son necesarias (`'Hola mundo'`) |
| `nl` | Salto de línea |
| `tab(N)` | Escribe N espacios |
| `format(Formato, Args)` | Salida con formato |

Directivas comunes de `format`: `~w` (término), `~a` (átomo), `~d` (entero), `~n` (salto de línea), `~s` (cadena de códigos).

```prolog
?- format("Hola ~w, tienes ~d años~n", [ana, 20]).
```

### Entrada

| Predicado | Qué hace |
|---|---|
| `read(X)` | Lee un término de la entrada (debe terminar en punto) |
| `get_char(C)` | Lee un carácter |
| `peek_char(C)` | Mira el siguiente carácter sin consumirlo |

### Archivos

| Predicado | Qué hace |
|---|---|
| `open(Archivo, Modo, Flujo)` / `close(Flujo)` | Abre y cierra archivos (`read`, `write`, `append`) |
| `see(F)` / `tell(F)` | Redirigen la entrada/salida actual a un archivo (se restauran con `seen` / `told`) |
| `consult(Archivo)` | Carga un programa Prolog |

---

## 11. Excepciones

| Predicado | Qué hace |
|---|---|
| `throw(Error)` | Lanza una excepción |
| `catch(Meta, Patron, Recuperacion)` | Ejecuta `Meta`; si lanza una excepción que unifica con `Patron`, ejecuta `Recuperacion` |

```prolog
?- catch(X is 1/0, error(E, _), (write(E), nl)).
evaluation_error(zero_divisor)
```