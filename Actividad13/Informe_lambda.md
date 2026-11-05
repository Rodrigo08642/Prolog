# Operación Lambda (CLISP: car, cdr, mapcar y lambdas) 

## Mapa de Misiones

|Nombre en clave|	Habilidad que evalúa|
|-----|-----|
|1|	El Expediente Desordenado|	Navegar registros con car / cdr y predecir salidas|
|2|	El Pase de Lista|	mapcar con #'función y con lambda (una y dos listas)|
|3|	El Mensaje Interceptado|	mapcar anidado + lambda para descifrar|
|4|	El Traidor|	Filtrar con mapcar + lambda, agregar con reduce|
|5|	Código Saboteado|	Diagnosticar errores típicos de mapcar y lambda|
|6|	La Fábrica de Filtros|	Lambdas que regresan lambdas, funcall, informe final|


* Cada agente es una lista de cinco campos:


|Posición|	 Campo|	  Ejemplo|
|-----|-----|-----|
|1|	     nombre	|  ana|
|2|	     edad	|  28|
|3|	     nivel	|  3 (1–5)|
|4|	     base	 | morelia|
|5|	     puntos	|  120|

```lisp
;;; (nombre edad nivel base puntos)
(setq *agentes*
      '((ana    28 3 morelia   120)
        (beto   35 5 uruapan   340)
        (carla  22 1 morelia    45)
        (diego  41 4 zamora    210)
        (elena  30 2 patzcuaro  90)
        (fausto 26 5 morelia   400)))

(setq *alfabeto* '(a b c d e f g h i j k l m n o p q r s t u v w x y z))

;;; mensaje cifrado: una sublista por palabra
(setq *interceptado*
      '((22 20 3 11 6 17 20)
        (16 11 24 7 14)
        (5 11 16 5 17)
        (8 23 7 20 3)
        (6 7)
        (15 17 20 7 14 11 3)))

(setq *bonos* '(10 0 5 20 15 0))
```

---

# Misión 1 — El Expediente Desordenado

## La Historia
El analista anterior dejó anotaciones de la forma (car (cdr (car ...))) sin decir qué devuelven. Antes de tocar el teclado deben predecir cada resultado; después lo comprueban en CLISP.

## Recordatorio
* `car` devuelve el primer elemento de una lista.
* `cdr` devuelve la lista sin el primer elemento.
* (`cadr` x) es (`car` (`cdr` x)); (`caddr` x) es (`car` (`cdr` (`cdr` x))).

## Tabla de predicción (llenar antes de ejecutar)

|Clave|	Expresión|	Predicción|	CLISP|
|-----|-----|-----|----|
|a    |	(car (cdr (car *agentes*)))	                            | 28  | 28 |
|b    |	(car (car (cdr *agentes*)))	 	                        | beto  | BETO |
|c    |	(cdr (car (cdr (cdr *agentes*))))                       | (22 1 morelia    45)	         | (22 1 MORELIA 45) |
|d    |	(car (cdr (cdr (cdr (car (cdr (cdr (cdr *agentes*))))))))| zamora   |ZAMORA|
|e    |	(caddr (cadr *agentes*))	                            |  5    | 5 |
|f    |	(car (cdr (cdr (car (cdr (cdr (cdr (cdr *agentes*))))))))|	2   | 2 |


## Tu tarea
1. Llena la tabla. Por cada fallo, una línea explicando el error.
2. Escribe cinco funciones de acceso usando solo car y cdr: nombre, edad, nivel, base, puntos. Cada una recibe un agente.
3. Con esas funciones y car / cdr sobre *agentes*, obtén los puntos de Elena sin escribir el número 90 en ningún lado.
4. Pregunta: ¿qué devuelve (car (cdr '(ana)))? ¿Es un error? ¿Por qué eso es peligroso cuando un registro viene incompleto?

### 1. Funciones de acceso (usando solo car y cdr)

```lisp
(defun nombre (ag)
  (car ag))

(defun edad (ag)
  (car (cdr ag)))

(defun nivel (ag)
  (car (cdr (cdr ag))))

(defun base (ag)
  (car (cdr (cdr (cdr ag)))))

(defun puntos (ag)
  (car (cdr (cdr (cdr (cdr ag))))))
```

### 2. Puntos de Elena sin escribir el número 90
Para llegar al registro de Elena dentro de `*agentes*` se aplica `cdr` cuatro veces (avanzando por Ana, Beto, Carla y Diego) y se toma el primer elemento con `car`. Finalmente se pasa a la función de acceso `puntos`:

```lisp
(puntos (car (cdr (cdr (cdr (cdr *agentes*))))))
```
- **Salida:** `90`

### 3. Pregunta: ¿qué devuelve (car (cdr '(ana)))?
- **Resultado:** Devuelve `NIL`.
- **¿Es un error?:** No genera ningún error de ejecución en Common Lisp. La lista vacía `NIL` está definida de modo que `(car nil)` devuelve `NIL` y `(cdr nil)` devuelve `NIL`. Como `'(ana)` tiene un solo elemento, su `cdr` es `NIL`, y el `car` de eso simplemente regresa `NIL`.
- **¿Por qué es peligroso en un registro incompleto?:** Porque oculta la ausencia de datos en silencio. En lugar de detener el programa de inmediato con un error para avisar que falta un campo (por ejemplo la base o los puntos), propaga `NIL` como si fuera un valor normal. El error real detonará mucho después cuando otra función intente sumar puntos o comparar niveles numéricamente (como `(+ nil 10)`), dificultando rastrear el origen de la falla.

---

# Misión 2 — El Pase de Lista

## 1. Código de funciones requeridas

```lisp
;; Devuelve solo los nombres usando mapcar con una función existente
(defun pase-de-lista (agentes)
  (mapcar #'nombre agentes))

;; Devuelve pares punteados (nombre . nivel) usando cons
(defun nombre-y-nivel (agentes)
  (mapcar (lambda (ag)
            (cons (nombre ag) (nivel ag)))
          agentes))

;; Devuelve sublistas (nombre edad+1) sin alterar los datos originales
(defun cumpleanios (agentes)
  (mapcar (lambda (ag)
            (list (nombre ag) (+ (edad ag) 1)))
          agentes))

;; Aplica bonos combinando la lista de agentes con la lista de bonos
(defun aplicar-bonos (agentes bonos)
  (mapcar (lambda (ag b)
            (+ (puntos ag) b))
          agentes
          bonos))
```

## 2. Salidas obtenidas en consola

```lisp
CL-USER> (pase-de-lista *agentes*)
(ANA BETO CARLA DIEGO ELENA FAUSTO)

CL-USER> (nombre-y-nivel *agentes*)
((ANA . 3) (BETO . 5) (CARLA . 1) (DIEGO . 4) (ELENA . 2) (FAUSTO . 5))

CL-USER> (cumpleanios *agentes*)
((ANA 29) (BETO 36) (CARLA 23) (DIEGO 42) (ELENA 31) (FAUSTO 27))

CL-USER> (aplicar-bonos *agentes* *bonos*)
(130 340 50 230 105 400)
```

---

# Misión 3 — El Mensaje Interceptado

## 1. Lógica del descifrado (César -3 mod 26)
Cada letra fue codificada sumando 3 a su posición en el alfabeto (0 = a, 1 = b, ..., 25 = z). Para revertirlo, a cada número interceptado se le restan 3 unidades y se calcula el módulo 26, usando después `nth` sobre `*alfabeto*`.

```lisp
(defun descifrar-codigo (n)
  (nth (mod (- n 3) 26) *alfabeto*))

(defun descifrar-palabra (palabra)
  (mapcar #'descifrar-codigo palabra))

(defun descifrar-mensaje (mensaje)
  (mapcar #'descifrar-palabra mensaje))
```

## 2. Mensaje descifrado
- **Lista de símbolos devuelta por Lisp:**
```lisp
((T R A I D O R) (N I V E L) (C I N C O) (F U E R A) (D E) (M O R E L I A))
```
- **Texto traducido continuo:**
`traidor nivel cinco fuera de morelia`

## 3. Versión directa en una sola expresión (mapcar anidado)
```lisp
(mapcar (lambda (palabra)
          (mapcar (lambda (codigo)
                    (nth (mod (- codigo 3) 26) *alfabeto*))
                  palabra))
        *interceptado*)
```

## 4. Comprobación de reciprocidad (cifrado inverso)
```lisp
(defun cifrar-palabra (palabra)
  (mapcar (lambda (letra)
            (mod (+ (position letra *alfabeto*) 3) 26))
          palabra))

(equal (mapcar #'cifrar-palabra (descifrar-mensaje *interceptado*))
       *interceptado*)
;; => T
```

---

# Misión 4 — El Traidor

## 1. Identificación del sospechoso
El mensaje interceptado indica dos condiciones estrictas:
1. Nivel del agente: 5.
2. Ubicación: fuera de Morelia (`base /= morelia`).

```lisp
(defun sospechosos (agentes)
  (mapcar #'nombre
          (remove-if-not (lambda (ag)
                           (and (= (nivel ag) 5)
                                (not (eq (base ag) 'morelia))))
                         agentes)))
```

- **Consulta:**
```lisp
CL-USER> (sospechosos *agentes*)
(BETO)
```
- **Conclusión:** El traidor es **BETO**.

## 2. Total de puntos de los agentes leales
Filtrando al traidor Beto quedan Ana (120), Carla (45), Diego (210), Elena (90) y Fausto (400):

```lisp
(defun leales (agentes traidor)
  (remove-if (lambda (ag) (eq (nombre ag) traidor)) agentes))

(defun total-puntos (agentes)
  (reduce #'+ (mapcar #'puntos agentes)))
```

- **Consulta:**
```lisp
CL-USER> (total-puntos (leales *agentes* 'beto))
865
```

## 3. Promedio de edad de los agentes leales
Edades leales: 28 + 22 + 41 + 30 + 26 = 147 dividido entre 5 agentes.

```lisp
(defun promedio-edad (agentes)
  (/ (reduce #'+ (mapcar #'edad agentes))
     (length agentes)))
```

- **Resultado racional devuelto por Lisp:** `147/5`
- **Tipo de dato:** Es un número de tipo **RATIO** (racional exacto irreducible en Common Lisp).
- **Conversión a decimal:**
```lisp
CL-USER> (float (promedio-edad (leales *agentes* 'beto)))
29.4
```

## 4. Deducción sobre los dos agentes de nivel 5
En el expediente existen dos agentes con nivel 5: Beto (base Uruapan) y Fausto (base Morelia).
La clave descifrada indica que el traidor opera fuera de Morelia. Esto descarta automáticamente a Fausto. Por lo tanto, Beto es el único elemento que satisface ambas condiciones al mismo tiempo. Si no se considerara la base, el filtro señalaría a ambos elementos generando una falsa acusación contra Fausto.

---

# Misión 5 — Código Saboteado

| ID | Expresión Saboteada | ¿Truena? | Mensaje / Resultado | Causa | Corrección |
|:---:|:---|:---:|:---|:---|:---|
| **S1** | `(mapcar car *agentes*)` | **SÍ** | `variable CAR has no value` | En Common Lisp las funciones que se pasan como argumentos requieren el prefijo `#'`. Sin él, el intérprete busca una variable normal llamada car que no está definida. | `(mapcar #'car *agentes*)` |
| **S2** | `(mapcar (lambda ag (nombre ag)) *agentes*)` | **SÍ** | `ag is not a list` | La lista de parámetros de una función lambda debe estar encerrada obligatoriamente entre paréntesis `(ag)`. | `(mapcar (lambda (ag) (nombre ag)) *agentes*)` |
| **S3** | `(mapcar (lambda (ag) (puntos ag)) *agentes* *bonos*)` | **SÍ** | `execution requires 1 argument, not 2` | Al pasarle dos listas a `mapcar`, este envía dos elementos en cada ciclo, pero la función lambda solo declaró un parámetro `(ag)`. | `(mapcar (lambda (ag b) (+ (puntos ag) b)) *agentes* *bonos*)` o quitar `*bonos*` si solo se leen puntos. |
| **S4** | `(mapcar (lambda (ag b) (+ (puntos ag) b)) *agentes* '(10 0 5))` | **NO** | `(130 340 50)` | **Sabotaje silencioso.** La segunda lista solo tiene 3 elementos. `mapcar` se detiene silenciosamente en cuanto se agota la lista más corta, procesando solo la mitad de los agentes. | Pasar la lista completa con los 6 bonos: `*bonos*`. |
| **S5** | `(mapcar '(lambda (ag) (nombre ag)) *agentes*)` | **SÍ** | `(LAMBDA ...) is not a function name` | Se puso comilla simple antes de lambda. Una lista citada con `'` es solo un dato literal de símbolos y listas, no una función ejecutable. | `(mapcar (lambda (ag) (nombre ag)) *agentes*)` |

### Sabotaje más silencioso y peligroso
El caso **S4** es el más peligroso porque no produce ningún mensaje de error ni detiene la ejecución. Simplemente corta los datos a la mitad sin avisar. Esto ocurre debido a la regla de `mapcar`: cuando recibe varias listas, la longitud de la lista resultante está determinada por la lista más corta de todas.

---

# Misión 6 — La Fábrica de Filtros

## 1. Implementación de closures y combinadores

```lisp
;; Genera una función que prueba si un agente tiene al menos el nivel minimo
(defun filtro-nivel (minimo)
  (lambda (ag) (>= (nivel ag) minimo)))

;; Genera una función que prueba si el agente pertenece a la ciudad dada
(defun filtro-base (ciudad)
  (lambda (ag) (eq (base ag) ciudad)))

;; Combina dos filtros evaluando ambos con funcall
(defun y-filtros (f1 f2)
  (lambda (ag) (and (funcall f1 ag) (funcall f2 ag))))

;; Aplica un filtro a la lista de agentes
(defun aplicar-filtro (filtro agentes)
  (remove-if-not filtro agentes))
```

## 2. Salidas de las consultas

- **Agentes de nivel 4 o más:**
```lisp
CL-USER> (aplicar-filtro (filtro-nivel 4) *agentes*)
((BETO 35 5 URUAPAN 340) (DIEGO 41 4 ZAMORA 210) (FAUSTO 26 5 MORELIA 400))
```

- **Agentes con base Morelia:**
```lisp
CL-USER> (aplicar-filtro (filtro-base 'morelia) *agentes*)
((ANA 28 3 MORELIA 120) (CARLA 22 1 MORELIA 45) (FAUSTO 26 5 MORELIA 400))
```

- **Agentes de Morelia con nivel 3 o más:**
```lisp
CL-USER> (aplicar-filtro (y-filtros (filtro-base 'morelia) (filtro-nivel 3)) *agentes*)
((ANA 28 3 MORELIA 120) (FAUSTO 26 5 MORELIA 400))
```

## 3. Ensamble final e informe

```lisp
(defun informe (agentes)
  (mapc (lambda (ag)
          (format t "~a (~a) nivel ~a -> ~a pts~%"
                  (nombre ag) (base ag) (nivel ag) (puntos ag)))
        agentes)
  (length agentes))
```

- **Ejecución del ensamble (agentes leales con nivel 3 o superior):**
```lisp
CL-USER> (informe (aplicar-filtro (filtro-nivel 3)
                                  (leales *agentes* (car (sospechosos *agentes*)))))
ANA (MORELIA) nivel 3 -> 120 pts
DIEGO (ZAMORA) nivel 4 -> 210 pts
FAUSTO (MORELIA) nivel 5 -> 400 pts
3
```

## 4. Ventaja técnica de la fábrica de funciones
La ventaja de usar funciones generadoras como `filtro-nivel` o `filtro-base` radica en que crean clausuras léxicas (*closures*). En lugar de escribir a mano una función separada para cada nivel posible (`nivel-1`, `nivel-2`, `nivel-3`, etc.) o para cada ciudad, una sola función parametrizada genera al vuelo cualquier filtro requerido y permite combinarlos fácilmente con `y-filtros`. Esto reduce la repetición de código y hace que el sistema sea modular y flexible.