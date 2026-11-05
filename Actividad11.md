# Resolución de Problemas Prácticos en Common Lisp (`if`, `when`, `unless`, `cond`, `case`)

## 1. Cálculo de Salario Ajustado por Antigüedad

### Descripción del Problema
Se requiere determinar la retribución final de un empleado cuyo salario base inicial es de 40.000 euros al año. El monto se actualizará aplicando un porcentaje de incremento en función de los años que lleve trabajando dentro de la entidad:

- **10 años o más:** Incremento del 10%.
- **De 5 a 9 años:** Incremento del 7%.
- **De 3 a 4 años:** Incremento del 5%.
- **Menos de 3 años (0 a 2 años):** Incremento del 3%.
- **Valores negativos:** Se considera un error en la entrada.

### Implementación en Lisp
```lisp
(defun calcular-sueldo (sueldo anios)
  (if (>= anios 10)
      (progn 
        (print "Aumento de 10%, su sueldo es de:") 
        (+ sueldo (* sueldo 0.1)))
      (if (>= anios 5)
          (progn 
            (print "Aumento de 7%, su sueldo es de:") 
            (+ sueldo (* sueldo 0.07)))
          (if (> anios 3)
              (progn 
                (print "Aumento de 5%, su sueldo es de:") 
                (+ sueldo (* sueldo 0.05)))
              (if (>= anios 0)
                  (progn 
                    (print "Aumento de 3%, su sueldo es de:") 
                    (+ sueldo (* sueldo 0.03)))
                  (print "Error con año"))))))
```
---
## 2. Control de Carga y Consumo de Agua para Lavadora

### Descripción del Problema
Se solicita diseñar un sistema para determinar la categoría de carga de una lavadora según el peso de la ropa (expresado en libras), calculando de forma paralela la cantidad de agua requerida (a razón de 2 litros por cada libra de prenda).

Criterios de clasificación:
- **Mayor a 30 lbs:** Exceso de carga, el aparato no se activa.
- **De 22 a 30 lbs:** Carga Nivel Máximo.
- **De 15 a 21 lbs:** Carga Nivel Alto.
- **De 8 a 14 lbs:** Carga Nivel Medio.
- **De 1 a 7 lbs:** Carga Nivel Mínimo.
- **0 lbs o menos:** Entrada inválida.

### Implementación en Lisp
```lisp
(defun peso-lavadora (peso)
  ;; Validación de límite superior
  (when (> peso 30)
    (print "La lavadora no funcionara: demasiado peso")
    (return-from peso-lavadora nil))

  ;; Validación de límite inferior
  (unless (> peso 0)
    (print "Error: El peso debe ser mayor a 0 libras")
    (return-from peso-lavadora nil))

  ;; Evaluación de categoría y cálculo del agua
  (let ((nivel (cond 
                 ((>= peso 22) 'maximo)
                 ((>= peso 15) 'alto)
                 ((>= peso 8)  'medio)
                 (t 'minimo)))
        (litros (* peso 2)))

    (if (and nivel litros)
        (format t "Peso: ~a libras, Nivel: ~a, Litros de agua: ~a~%"
                peso nivel litros))))
```
---

## 3. Control de Acceso a Evento de Cumpleaños

### Descripción del Problema
Para la celebración de sus 15 años, Martha ha definido los siguientes criterios de admisión para los asistentes:

- **Mayores de 15 años:** Ingresan únicamente si presentan un obsequio.
- **Exactamente 15 años:** Ingreso libre sin condiciones.
- **Menores de 15 años:** Tienen restringido el acceso.

### Implementación en Lisp
```lisp
(defun fiesta-quince (edad regalo)
  (cond 
    ((< edad 15) 
     (print "No puedes entrar a la fiesta"))
    ((= edad 15) 
     (print "Entran totalmente gratis"))
    ((> edad 15)
     (if regalo
         (print "Puede entrar, ya que trae un regalo")
         (print "No puede entrar, ya que no trae un regalo")))
    (t 
     (print "Error de edad/regalo"))))
```