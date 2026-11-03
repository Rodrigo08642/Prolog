# Guía de Referencia Práctica: Common Lisp

Common Lisp es un lenguaje de programación multiparadigma de alto nivel, perteneciente a la familia de **Lisp** (*LISt Processing*). Su vigencia y poder radican en características fundamentales como la **homoiconicidad** (tratar el código fuente como una estructura de datos editable) y un **sistema de macros** avanzado.

## 1. Fundamentos Sintácticos y Conceptos Clave

A diferencia de los lenguajes imperativos tradicionales, la sintaxis de Common Lisp es uniforme y se fundamenta en estructuras de listas llamadas **S-Expressions** (*Expresiones Simbólicas*).

### Notación Prefija

Cualquier bloque ejecutable en Lisp está delimitado por paréntesis. El evaluador interpreta el primer elemento dentro del paréntesis como una función o forma especial, y los elementos subsiguientes como sus argumentos.

* **Aritmética estándar:** $2 + 3$

  $$
  \text{Lisp: } \texttt{(+ 2 3)}
  $$

* **Operaciones compuestas:** $(5 \times 4) + (2 - 1)$

  $$
  \text{Lisp: } \texttt{(+ (* 5 4) (- 2 1))}
  $$

### Homoiconicidad y Evaluación Literal (`quote` / `'`)

Debido a que el código y los datos comparten el mismo formato de representación, el intérprete intentará evaluar toda lista como una llamada a función. Para tratar una expresión de forma literal sin ejecutarla, se antepone el operador `quote` o el apóstrofe `'`.

```lisp
(+ 1 2)   ;; Evalúa la función suma y retorna 3.
'(+ 1 2)  ;; Supedita la evaluación y retorna la lista literal (+ 1 2).
```

### Recursión frente a Iteración

Lisp privilegia el uso de la recursividad como mecanismo primario de repetición. Para optimizar el uso de memoria en llamadas recursivas profundas, las implementaciones utilizan **Tail-Call Optimization** (TCO), evitando la acumulación de marcos en la pila de llamadas.

### Convención de Orejeras (*Earmuffs*) `*...*`

Los asteriscos al principio y final del nombre de una variable (por ejemplo, `*tasa-de-interes*`) no indican punteros. Es una convención para identificar variables de **ámbito dinámico** (*estado global*), alertando sobre el riesgo de modificar un valor que afecta a múltiples módulos del sistema.

## 2. Gestión de Entornos y Variables

| Primitiva | Tipo de Ámbito | Comportamiento frente a reevaluación |
| :--- | :--- | :--- |
| `defparameter` | Global / Dinámico | Sobrescribe el valor existente. |
| `defvar` | Global / Dinámico | Conserva el valor previo si la variable ya existía. |
| `let` | Local (Paralelo) | No permite que una asignación dependa de otra dentro del mismo bloque. |
| `let*` | Local (Secuencial) | Permite referenciar variables declaradas previamente en el mismo bloque. |

### Ejemplos de Entorno y Asignación

```lisp
;; Declaración e incremento de variables globales
(defparameter *tasa-interes* 0.05)
(defparameter *tasa-interes* 0.10) ;; Asigna 0.10

(defvar *contador* 0)
(defvar *contador* 100)            ;; Mantiene el valor 0

;; Modificación directa de un lugar de almacenamiento (place)
(setf *contador* 1)                ;; *contador* pasa a ser 1

;; Asignaciones locales
(let ((x 10)
      (y 20))
  (+ x y))                         ;; Retorna 30

(let* ((x 10)
       (y (* x 2)))                ;; y depende de x
  (+ x y))                         ;; Retorna 30
```

## 3. Construcción de Funciones y Metaprogramación

### Abstracciones Procedimentales

* **`defun`**: Define funciones con nombre en el entorno global.
* **`lambda`**: Crea funciones anónimas de primer orden para pasar como parámetro.

```lisp
;; Función nombrada
(defun cuadrado (x)
  (* x x))

(cuadrado 6) ;; Retorna 36

;; Función anónima ejecutada en una secuencia
(mapcar (lambda (x) (* x x)) '(1 2 3)) ;; Retorna (1 4 9)
```

### Sistema de Macros (`defmacro`)

Permite la transformación semántica del código antes de ser compilado o evaluado.

```lisp
(defmacro mi-si (condicion entonces sino)
  `(cond (,condicion ,entonces)
         (t ,sino)))

(mi-si (> 5 3) "sí" "no") ;; Retorna "sí"
```

## 4. Control de Flujo y Estructuras Repetitivas

```lisp
;; Condicional binario (if)
(if (> 5 3)
    "Mayor"
    "Menor") ;; Retorna "Mayor"

;; Evaluación multi-rama (cond)
(cond ((> *contador* 0) "Positivo")
      ((< *contador* 0) "Negativo")
      (t "Cero"))

;; Evaluación unilateral (when / unless)
(when (> 5 3)
  (format t "Mensaje ejecutable~%")
  "Completado")

(unless (< 5 3)
  (format t "Condición falsa confirmada~%"))

;; Secuenciación de instrucciones (progn)
(progn
  (format t "Paso 1~%")
  (format t "Paso 2~%")
  "Finalizado")

;; Iteradores de secuencia (dolist / dotimes)
(dolist (item '(manzana pera uva))
  (format t "Elemento: ~A~%" item))

(dotimes (i 3)
  (format t "Índice: ~A~%" i))
```

## 5. Estructuras de Datos: Listas y Pares Punteados

### Construcción y Extracción

```lisp
;; Enlazado (cons) y Construcción (list)
(cons 'fresa '(manzana pera)) ;; Retorna (FRESA MANZANA PERA)
(list 1 'dos "tres" 4.0)       ;; Retorna (1 DOS "tres" 4.0)

;; Acceso a la Cabeza (car / first) y Cola (cdr)
(car '(manzana pera plátano))   ;; Retorna MANZANA
(first '(manzana pera plátano)) ;; Retorna MANZANA (Equivalente semántico)
(cdr '(manzana pera plátano))   ;; Retorna (PERA PLÁTANO)

;; Operaciones avanzadas de consulta
(nth 2 '(cero uno dos tres))     ;; Retorna DOS (índice base 0)
(last '(a b c d))               ;; Retorna la última celda: (D)
(subseq '(a b c d e) 1 4)       ;; Retorna (B C D)
(length '(a b c d e))           ;; Retorna 5
(append '(1 2) '(3 4))          ;; Retorna (1 2 3 4)
```

### Mutación de Estructuras del Tipo Pila (*Stack*)

```lisp
(defparameter *pila* '(2 3 4))

(push 1 *pila*) ;; Inserta al inicio -> *pila* es ahora (1 2 3 4)
(pop *pila*)    ;; Extrae y retorna 1 -> *pila* vuelve a ser (2 3 4)
```

## 6. Lógica, Comparaciones y Predicados

Los predicados son funciones que evalúan un estado y devuelven `T` (Verdadero) o `NIL` (Falso/Lista vacía).

```lisp
;; Predicados de tipo y vacíos
(atom 45)        ;; T
(atom '(1 2 3))  ;; NIL
(listp '(1 2 3)) ;; T
(null '())       ;; T (NIL y la lista vacía son idénticos)

;; Identidad en Memoria vs. Igualdad Estructural
(eq 'a 'a)     ;; T (Mismo símbolo)
(eq 3.0 3.0)   ;; NIL (Punteros a memoria distintos en algunas implementaciones)

(equal "hola" "hola")         ;; T (Igualdad de contenido)
(equal (list 1 2) (list 1 2)) ;; T (Estructuras idénticas)
```

## 7. Búsqueda, Filtrado y Manipulación de Colecciones

```lisp
;; Búsqueda de elementos
(member 3 '(1 2 3 4 5)) ;; Retorna la sublista desde la coincidencia: (3 4 5)
(find 3 '(1 2 3 4 5))   ;; Retorna el valor encontrado: 3
(assoc 'b '((a . 1) (b . 2))) ;; Búsqueda en clave-valor: (B . 2)

;; Transformación de listas
(remove 'x '(x a b x c))        ;; Retorna (A B C) - No destructivo
(remove-if #'evenp '(1 2 3 4))  ;; Retorna (1 3)   - Elimina pares
(reverse '(1 2 3))              ;; Retorna (3 2 1) - Inversión no destructiva

;; Ordenamiento (Operación destructiva)
(sort (list 4 1 5 2) #'<)       ;; Retorna (1 2 4 5) y modifica la