
;; https://ealcaraz85.github.io/prolog.io/#org07b72e9

;; Posición	 Campo	  Ejemplo
;; 1	     nombre	  ana
;; 2	     edad	  28
;; 3	     nivel	  3 (1–5)
;; 4	     base	  morelia
;; 5	     puntos	  120

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



;; =============================> Misión 1 — El Expediente Desordenado

;; 1. Escribe cinco funciones de acceso usando solo car y cdr: nombre, edad, nivel, base, puntos. Cada una recibe un agente.

;; ANA
(defun agente-ana (agentes)
(progn
(format t "nombre : ~a~%" (car (car agentes)))
(format t "edad : ~a~%" (car (cdr (car agentes))))
(format t "nivel : ~a~%" (car (cddr (car agentes))))
(format t "base : ~a~%" (car (cddr (car agentes))))
(format t "puntos : ~a~%" (car (cdr (car agentes))))
)
  
)



(car (cdr '(ana)))

;; Funciones de acceso genericas para cualquier agente:
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

;; Puntos de Elena:
;; (puntos (car (cdr (cdr (cdr (cdr *agentes*))))))


;; =============================> Misión 2 — El Pase de Lista

(defun pase-de-lista (agentes)
  (mapcar #'nombre agentes))

(defun nombre-y-nivel (agentes)
  (mapcar (lambda (ag)
            (cons (nombre ag) (nivel ag)))
          agentes))

(defun cumpleanios (agentes)
  (mapcar (lambda (ag)
            (list (nombre ag) (+ (edad ag) 1)))
          agentes))

(defun aplicar-bonos (agentes bonos)
  (mapcar (lambda (ag b)
            (+ (puntos ag) b))
          agentes
          bonos))


;; =============================> Misión 3 — El Mensaje Interceptado

(defun descifrar-codigo (n)
  (nth (mod (- n 3) 26) *alfabeto*))

(defun descifrar-palabra (palabra)
  (mapcar #'descifrar-codigo palabra))

(defun descifrar-mensaje (mensaje)
  (mapcar #'descifrar-palabra mensaje))

(defun descifrar-mensaje-directo (mensaje)
  (mapcar (lambda (palabra)
            (mapcar (lambda (codigo)
                      (nth (mod (- codigo 3) 26) *alfabeto*))
                    palabra))
          mensaje))

;; Cifrado inverso para comprobacion
(defun cifrar-palabra (palabra)
  (mapcar (lambda (letra)
            (mod (+ (position letra *alfabeto*) 3) 26))
          palabra))


;; =============================> Misión 4 — El Traidor

(defun sospechosos (agentes)
  (mapcar #'nombre
          (remove-if-not (lambda (ag)
                           (and (= (nivel ag) 5)
                                (not (eq (base ag) 'morelia))))
                         agentes)))

(defun leales (agentes traidor)
  (remove-if (lambda (ag) (eq (nombre ag) traidor)) agentes))

(defun total-puntos (agentes)
  (reduce #'+ (mapcar #'puntos agentes)))

(defun promedio-edad (agentes)
  (/ (reduce #'+ (mapcar #'edad agentes))
     (length agentes)))


;; =============================> Misión 6 — La Fábrica de Filtros

(defun filtro-nivel (minimo)
  (lambda (ag) (>= (nivel ag) minimo)))

(defun filtro-base (ciudad)
  (lambda (ag) (eq (base ag) ciudad)))

(defun y-filtros (f1 f2)
  (lambda (ag) (and (funcall f1 ag) (funcall f2 ag))))

(defun aplicar-filtro (filtro agentes)
  (remove-if-not filtro agentes))

(defun informe (agentes)
  (mapc (lambda (ag)
          (format t "~a (~a) nivel ~a -> ~a pts~%"
                  (nombre ag) (base ag) (nivel ag) (puntos ag)))
        agentes)
  (length agentes))