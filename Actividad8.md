# Manipulación de Listas: `car`, `cdr` y Composiciones en Common Lisp

## 1. Conceptos Fundamentales

En Common Lisp, las listas están compuestas por nodos de pares (*cons cells*). Para descomponer y navegar por estas estructuras se utilizan dos funciones primarias:

* **`car`**: Extrae el **primer elemento** o la cabeza (*head*) de una lista o par.
* **`cdr`**: Extrae el **resto de la lista** o la cola (*tail*), descartando el primer elemento y devolviendo la sublista remanente.

### Ejemplos Básicos

```lisp
;; Extracción del primer elemento (CAR)
(car '(1 2 3 4 5))                    ; Retorna: 1
(car '(ia (ib (ic a b v (1 2 3 4))))) ; Retorna: IA

;; Extracción del resto (CDR)
(cdr '(1 2 3 4))                      ; Retorna: (2 3 4)
```

---

## 2. Combinaciones y Contracciones

Para evitar anidamientos profundos de paréntesis como `(car (cdr (cdr x)))`, Lisp proporciona funciones abreviadas de hasta cuatro niveles de profundidad combinando las letras **`a`** (`car`) y **`d`** (`cdr`).

### Regla de Evaluación
Las abreviaciones se leen y ejecutan de **derecha a izquierda** (comenzando por la letra más cercana a la `r` final y avanzando hacia la `c` inicial).

* **`a`**: Aplica un `car` (toma el contenido del primer elemento).
* **`d`**: Aplica un `cdr` (descarta el primer elemento y toma la cola).

$$\text{Ejemplo: } \texttt{(cadr X)} \equiv \texttt{(car (cdr X))}$$

### Referencia de Composiciones Frecuentes

```lisp
(cadr '(1 2 3 4))                  ; 2   (Segundo elemento)
(cddr '(1 2 3 4))                  ; (3 4) (Lista sin los dos primeros elementos)
(cdddr '(1 2 3 4))                 ; (4)
(cddddr '(1 2 3 4 (a b c)))        ; ((A B C))
(car (cddddr '(1 2 3 4 (a b c))))  ; (A B C)
(caar (cddddr '(1 2 3 4 (a b c)))) ; A
(cdar (cddddr '(1 2 3 4 (a b c)))) ; (B C)
(cadar (cddddr '(1 2 3 4 (a b c)))); B
(cddar (cddddr '(1 2 3 4 (a b c)))); (C)
```

---

## 3. Ejercicios Prácticos de Extracción

### Ejercicio A
**Lista de origen:** `'(1 2 3 4 5 6 7 8 9 10)`

```lisp
;; Extraer: 6
(cadr (cddddr '(1 2 3 4 5 6 7 8 9 10)))

;; Extraer: 8
(cadddr (cddddr '(1 2 3 4 5 6 7 8 9 10)))

;; Extraer: 10
(caddr (cdddr (cddddr '(1 2 3 4 5 6 7 8 9 10))))
```

### Ejercicio B
**Lista de origen:** `'(1 2 (3 4) (A B C D))`

```lisp
;; Extraer: D
(car (cdddr (car (cdddr '(1 2 (3 4) (A B C D))))))

;; Extraer: C
(car (cddr (car (cdr (cddr '(1 2 (3 4) (A B C D)))))))

;; Extraer: 4
(cadr (car (cddr '(1 2 (3 4) (A B C D)))))

;; Extraer: 2
(cadr '(1 2 (3 4) (A B C D)))

;; Extraer: A
(caar (cdr (cddr '(1 2 (3 4) (A B C D)))))
```

### Ejercicio C
**Lista de origen:** `'((A B C) (R (T X) (Z W)))`

```lisp
;; Extraer: A
(caar '((A B C) (R (T X) (Z W))))

;; Extraer: R
(caadr '((A B C) (R (T X) (Z W))))

;; Extraer: T
(caadr (cadr '((A B C) (R (T X) (Z W)))))

;; Extraer: X
(cadr (cadr (cadr '((A B C) (R (T X) (Z W))))))

;; Extraer: Z
(car (cadr (cdr (cadr '((A B C) (R (T X) (Z W)))))))

;; Extraer: W
(cadr (cadr (cdr (cadr '((A B C) (R (T X) (Z W)))))))
```

### Ejercicio D
**Lista de origen:** `'((((a b) (c d) (f g))))`

```lisp
;; Extraer: A
(caaaar '((((a b) (c d) (f g)))))

;; Extraer: B
(cadr (caaar '((((a b) (c d) (f g))))))

;; Extraer: C
(caadr (caar '((((a b) (c d) (f g))))))

;; Extraer: D
(cadr (cadr (caar '((((a b) (c d) (f g)))))))

;; Extraer: F
(caar (cddr (caar '((((a b) (c d) (f g)))))))

;; Extraer: G
(cadar (cddr (caar '((((a b) (c d) (f g)))))))
```