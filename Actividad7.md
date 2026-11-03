# Funciones de Áreas y Volúmenes para Figuras Geométricas en Lisp

Este documento contiene la especificación, guía de ejecución e implementación en **Common Lisp** de 10 funciones de cálculo de área y 10 funciones de cálculo de volumen para diversas figuras geométricas.

---

## 1. Guía de Ejecución en Terminal (Cygwin)

Para probar e interactuar con las funciones desde la consola usando **CLISP** en un entorno Cygwin:

### Paso 1: Navegar al directorio del proyecto
```bash
cd "/cygdrive/c/Users/Rafa115/Downloads/carpeta de pruebas/Programacion Logica y Funcional/Programacion_Logica_y_Funcional_I/Trabajo7"
```

### Paso 2: Iniciar la REPL de CLISP cargando el archivo
```bash
clisp -i funciones.lsp
```

### Paso 3: Recargar cambios dentro de CLISP
Si realizas modificaciones en el archivo `funciones.lsp` mientras el intérprete sigue abierto, vuelve a cargarlo con:
```lisp
(load "funciones.lsp")
```

### Comandos de Utilidad y Control
* `clisp`: Inicia el entorno interactivo de Common Lisp.
* `(quit)` o `(exit)`: Cierra la sesión interactiva y retorna a la terminal de bash.
* `abort`: Permite salir del depurador si ocurre un error sintáctico o numérico y el entorno entra en modo de depuración (`Break 1 [X]>`).

---

## 2. Fundamentos de Implementación

1. **Definición de funciones:** Uso de la macro `defun` con la sintaxis `(defun nombre (parámetros) cuerpo)`.
2. **Notación Prefija:** Toda operación matemática coloca el operador antes de los operandos. Por ejemplo, el área del triángulo $\frac{b \cdot h}{2}$ se implementa como `(/ (* base altura) 2)`.
3. **Constantes:** Se utiliza la constante global `pi` integrada en Common Lisp.

---

## 3. Código Fuente (`funciones.lsp`)

### 3.1. Funciones de Áreas (2D)

```lisp
;; FUNCIONES DE ÁREA (2D)

;; 1. Cuadrado: A = lado^2
(defun area-cuadrado (lado)
  (* lado lado))

;; 2. Rectángulo: A = base * altura
(defun area-rectangulo (base altura)
  (* base altura))

;; 3. Círculo: A = pi * r^2
(defun area-circulo (radio)
  (* pi radio radio))

;; 4. Triángulo: A = (base * altura) / 2
(defun area-triangulo (base altura)
  (/ (* base altura) 2))

;; 5. Pentágono Regular: A = (perímetro * apotema) / 2
(defun area-pentagono (perimetro apotema)
  (/ (* perimetro apotema) 2))

;; 6. Romboide: A = base * altura
(defun area-romboide (base altura)
  (* base altura))

;; 7. Trapecio: A = ((base_mayor + base_menor) * altura) / 2
(defun area-trapecio (b-mayor b-menor altura)
  (/ (* (+ b-mayor b-menor) altura) 2))

;; 8. Rombo: A = (diagonal_mayor * diagonal_menor) / 2
(defun area-rombo (d-mayor d-menor)
  (/ (* d-mayor d-menor) 2))

;; 9. Polígono Regular (Hexágono, Heptágono, etc.): A = (perímetro * apotema) / 2
(defun area-poligono-regular (perimetro apotema)
  (/ (* perimetro apotema) 2))

;; 10. Elipse: A = pi * semieje_a * semieje_b
(defun area-elipse (semieje-a semieje-b)
  (* pi semieje-a semieje-b))
```

### 3.2. Funciones de Volúmenes (3D)

```lisp
;; FUNCIONES DE VOLUMEN (3D)

;; 1. Cubo: V = lado^3
(defun volumen-cubo (lado)
  (* lado lado lado))

;; 2. Cilindro: V = pi * r^2 * altura
(defun volumen-cilindro (radio altura)
  (* pi radio radio altura))

;; 3. Cono: V = (pi * r^2 * altura) / 3
(defun volumen-cono (radio altura)
  (/ (* pi radio radio altura) 3))

;; 4. Esfera: V = (4/3) * pi * r^3
(defun volumen-esfera (radio)
  (* 4/3 pi radio radio radio))

;; 5. Pirámide: V = (área_base * altura) / 3
(defun volumen-piramide (base altura)
  (/ (* base altura) 3))

;; 6. Paralelepípedo: V = largo * ancho * alto
(defun volumen-paralelepipedo (largo ancho alto)
  (* largo ancho alto))

;; 7. Tetraedro: V = (área_base * altura) / 3
(defun volumen-tetraedro (base altura)
  (/ (* base altura) 3))

;; 8. Prisma General: V = área_base * altura
(defun volumen-prisma (base altura)
  (* base altura))

;; 9. Prisma Triangular: V = área_base_triangular * altura
(defun volumen-prisma-triangular (base-triangulo altura-triangulo altura-prisma)
  (* (/ (* base-triangulo altura-triangulo) 2) altura-prisma))

;; 10. Toroide Normal: V = 2 * pi^2 * R * r^2
(defun volumen-toroide-normal (radio-mayor radio-menor)
  (* 2 pi pi radio-mayor radio-menor radio-menor))
```