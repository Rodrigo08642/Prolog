# Cálculo de Áreas y Volúmenes Mediante Expresiones Lambda y Funciones de Orden Superior en CLISP

## 1. Objetivo
implementar fórmulas geométricas para el cálculo de áreas bidimensionales y volúmenes tridimensionales utilizando **funciones anónimas (`lambda`)** y la función de orden superior **`mapcar`** en Common Lisp.

---

## 2. Funciones y clasificación

1. **Funciones Anónimas (`lambda`)**:
   Son funciones sin un identificador o nombre asociado mediante `defun`. Se definen e invocan dinámicamente en el lugar exacto donde se requieren, facilitando el paso de lógica rápida a funciones de orden superior.

2. **Funciones de Orden Superior (`mapcar`)**:
   Es una función que recibe otra función como argumento junto con una o más listas. `mapcar` aplica dicha función sucesivamente a los elementos correspondientes de las listas suministradas.

3. **Clasificación por Aridad (Número de Parámetros)**:
   - **1 Parámetro:** Figuras definidas por una única dimensión (ej. Cubo, Esfera, Cuadrado, Círculo).
   - **2 Parámetros:** Figuras que requieren dos dimensiones (ej. Cilindro, Cono, Pirámide, Triángulo, Rectángulo, Polígono Regular).
   - **3 Parámetros:** Figuras que requieren tres dimensiones (ej. Paralelepípedo, Trapecio).

---

## 3. Estrategias para Procesamiento Múltiple de Datos

Para aplicar el cálculo a múltiples figuras de manera simultánea usando `mapcar`, se pueden emplear tres enfoques:

1. **Funciones unarias (1 parámetro) con una lista de valores:**
   ```lisp
   (calcular-figuras (lambda (x) (* x x x)) '(5 3 2))
   ```

2. **Funciones n-arias con múltiples listas mapeadas en paralelo:**
   ```lisp
   (mapcar (lambda (r h) (* pi (* r r) h)) '(3 4) '(10 5))  ; Cilindros: (r=3, h=10) y (r=4, h=5)
   ```

3. **Mapeo sobre sublistas compuestas mediante `apply`:**
   ```lisp
   (mapcar (lambda (pareja) (apply (lambda (r h) (* pi (* r r) h)) pareja)) '((3 10) (4 5)))
   ```

---

## 4. Implementación en Code Common Lisp

```lisp
;; Función auxiliar para mapear sobre una sola lista
(defun calcular-figuras (fn lista)
  (mapcar fn lista))


;; CÁLCULO DE VOLÚMENES (TRIDIMENSIONAL)
;; 1. Cubo (1 parámetro: lado = 5) -> V = l³
(calcular-figuras (lambda (x) (* x x x)) '(5))

;; 2. Esfera (1 parámetro: radio = 4) -> V = (4/3) * π * r³
(calcular-figuras (lambda (r) (* 4/3 pi r r r)) '(4))

;; 3. Cilindro (2 parámetros: radio = 3, altura = 10) -> V = π * r² * h
(mapcar (lambda (r h) (* pi (* r r) h)) '(3) '(10))

;; 4. Cono (2 parámetros: radio = 3, altura = 10) -> V = (π * r² * h) / 3
(mapcar (lambda (r h) (/ (* pi (* r r) h) 3)) '(3) '(10))

;; 5. Pirámide / Tetraedro (2 parámetros: área base = 15, altura = 10) -> V = (b * h) / 3
(mapcar (lambda (b h) (/ (* b h) 3)) '(15) '(10))

;; 6. Paralelepípedo (3 parámetros: largo = 2, ancho = 3, alto = 4) -> V = l * a * h
(mapcar (lambda (l a h) (* l a h)) '(2) '(3) '(4))


;; CÁLCULO DE ÁREAS (BIDIMENSIONAL)
;; 1. Cuadrado (1 parámetro: lado = 4) -> A = l²
(calcular-figuras (lambda (l) (* l l)) '(4))

;; 2. Círculo (1 parámetro: radio = 2) -> A = π * r²
(calcular-figuras (lambda (r) (* pi (* r r))) '(2))

;; 3. Rectángulo / Romboide (2 parámetros: base = 5, altura = 4) -> A = b * h
(mapcar (lambda (b h) (* b h)) '(5) '(4))

;; 4. Triángulo (2 parámetros: base = 10, altura = 5) -> A = (b * h) / 2
(mapcar (lambda (b h) (/ (* b h) 2)) '(10) '(5))

;; 5. Polígono Regular (2 parámetros: perímetro = 30, apotema = 4) -> A = (p * ap) / 2
(mapcar (lambda (p ap) (/ (* p ap) 2)) '(30) '(4))

;; 6. Trapecio (3 parámetros: base mayor = 10, base menor = 6, altura = 5) -> A = ((B + b) * h) / 2
(mapcar (lambda (b1 b2 h) (/ (* (+ b1 b2) h) 2)) '(10) '(6) '(5))
```