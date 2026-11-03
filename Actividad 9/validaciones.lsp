; Ejercicio 1 — if / else: edad para cine
(defun validar-edad-cine (edad)
  (if (integerp edad)
      (if (< edad 0)
          (progn (print "Error: Edad negativa") nil)
          (if (> edad 120)
              (progn (print "Error: Edad no realista") nil)
              (if (< edad 13)
                  (progn (print "AA (infantil)") t)
                  (if (< edad 18)
                      (progn (print "B (adolescentes)") t)
                      (progn (print "B15/C (adultos)") t)))))
      (progn (print "Error: No es un numero entero (edad)") nil)))      



; Ejercicio 2 — when: avisos, no bloqueos
(defun avisar-password (clave)
  ;; Longitud menor a 8
  (when (< (length clave) 8)
    (progn (print "Aviso: Clave Corta (<8)") T))

  ;; Contraseñas comunes
  (when (or (string= clave "12345678") (string= clave "password"))
    (progn (print "Aviso: Clave demasiado común") T))

  ;; Minúsculas y no vacía
  (when (and (not (string= clave "")) (string= clave (string-downcase clave)))
    (progn (print "Aviso: no hay mayúsculas") t)))


; Ejercicio 3 — `unless`: no procesar si faltan datos
(defun procesar-solicitud (nombre correo edad acepta-terminos)
  (declare (ignore edad))

  (unless (and (stringp nombre) (> (length nombre) 0))
    (print "Falta Nombre")
    (return-from procesar-solicitud nil))

  (unless (and (stringp correo) (search "@" correo))
    (print "Correo inválido")
    (return-from procesar-solicitud nil))

  (unless acepta-terminos
    (print "Debe Aceptar Términos")
    (return-from procesar-solicitud nil))

  (format t "Solicitud Procesada de ~a~%" nombre) t)


  ; Ejercicio 4 — `case`: roles de un sistema escolar
  (defun permiso-por-rol (rol)
  (case rol
    (admin (print "Puede crear usuarios y materias") t)
    (docente (print "Puede calificar y pasar lista") t)
    (alumno (print "Puede consultar calificaciones") t)
    (padre (print "Puede ver boleta de sus hijos") t)
    (otherwise (print "Rol no reconocido") nil)))


  ; Ejercicio 5 — `cond`: semáforo de promedio
  (defun semaforo-promedio (p)
  (unless (numberp p)
    (print "Error: El valor ingresado no es un número")
    (return-from semaforo-promedio nil))
  
  (unless (and (>= p 0) (<= p 100))
    (print "Error: Promedio fuera de [0, 100]")
    (return-from semaforo-promedio nil))

  (cond ((< p 60) (print "ROJO --> Reprobado"))
        ((< p 80) (print "AMARILLO --> Regular"))
        ((< p 90) (print "VERDE --> Bien"))
        (t (print "ORO --> Excelencia"))))


  ; Ejercicio 6 — `and` / `or` / `not` + `if`: alta de usuario
  (defun alta-usuario (user pass edad pais bloqueado)
  (if (and (stringp user) (> (length user) 4)
           (stringp pass) (> (length pass) 8)
           (numberp edad) (> edad 13)
           (stringp pais) (or (string= pais "MX") (string= pais "US") (string= pais "CO") (string= pais "AR"))
           (not bloqueado))
      (progn (print "Usuario dado de alta") t)
      (progn (print "Alta rechazada") nil)))


  ; Ejercicio 7 — `typecase`: triage según el tipo del dato
  (defun clasificar-triage (dato)
  (typecase dato
    (number
     (cond ((< dato 35) 'Hipotermia)
           ((< dato 37.5) 'Normal)
           ((<= dato 39) 'Fiebre)
           (t 'Fiebre-Alta)))
    (string
     (cond ((string-equal dato "rojo") 'Rojo)
           ((string-equal dato "naranja") 'Naranja)
           ((string-equal dato "verde") 'Verde)
           (t (print "Color no reconocido") nil)))
    (list
     (let ((nombre (car dato)) (temp (cadr dato)))
       (list nombre (clasificar-triage temp))))
    (t (print "Tipo no soportado") nil)))


  ; Ejercicio 8 — `case` de códigos + `when` de recargo (paquetería)
  (defun cotizar-envio (codigo peso zona-riesgo)
  (let ((config (case codigo
                  (est '(80 20 "Estándar"))
                  (exp '(160 10 "Express"))
                  (noc '(220 5 "Nocturno"))
                  (int '(450 15 "Internacional"))
                  (otherwise nil))))
    (if (null config)
        (progn (print "Error: Código de servicio inválido") nil)
        (let ((costo-base (car config))
              (peso-max (cadr config))
              (nombre-serv (caddr config)))
          (unless (< peso peso-max)
            (print "Error: Excede peso máximo del servicio")
            (return-from cotizar-envio nil))
          (let ((costo-final costo-base))
            (when zona-riesgo
              (incf costo-final 40)
              (print "Aviso: Recargo zona de riesgo +40"))
            (format t "Servicio: ~a | Costo final: $~a~%" nombre-serv costo-final)
            t)))))


  ; Ejercicio 9 — formulario completo: mezclar `if`, `when`, `unless` y `case`
  (defun validar-registro (usuario correo edad rol plan password acepta-terminos)
  ;; [UNLESS] terminos
  (unless acepta-terminos
    (print "Rechazado: Términos no aceptados")
    (return-from validar-registro nil))

  ;; [IF] edad / plan
  (if (< edad 13)
      (progn (print "Rechazado: Menor de 13 años") (return-from validar-registro nil))
      (if (and (< edad 18) (not (eq plan 'campus)))
          (progn (print "Rechazado: Menor (13-17) requiere plan campus") (return-from validar-registro nil))
          nil))

  ;; [CASE] rol
  (let ((prefijo (case rol
                   (alumno "a/")
                   (docente "d/")
                   (admin "s/")
                   (otherwise nil))))
    (unless prefijo
      (print "Rechazado: Rol inválido")
      (return-from validar-registro nil))

    ;; [CASE] plan
    (let ((cuota (case plan
                   (libre 0)
                   (pro 99)
                   (campus 0)
                   (otherwise nil))))
      (unless cuota
        (print "Rechazado: Plan inválido")
        (return-from validar-registro nil))

      ;; [WHEN] admin
      (when (eq rol 'admin)
        (print "Aviso: Admin creado: revisa bitácora de auditoría"))

      ;; [WHEN] password
      (avisar-password password)

      ;; Salida feliz
      (format t "Cuenta generada: ~a~a | Cuota mensual: $~a~%" prefijo usuario cuota)
      t)))


  ; Ejercicio 10 — mini sistema: crédito escolar
  (defstruct solicitante
  nombre promedio materias-reprobadas beca monto historial semestre)

(defun validar-solicitante (s)
  (unless (and (numberp (solicitante-promedio s)) (<= 0 (solicitante-promedio s) 100))
    (return-from validar-solicitante nil))
  (unless (and (numberp (solicitante-monto s)) (> (solicitante-monto s) 0))
    (return-from validar-solicitante nil))
  (unless (and (integerp (solicitante-semestre s)) (<= 1 (solicitante-semestre s) 10))
    (return-from validar-solicitante nil))
  t)

(defun categoria-monto (monto)
  (cond ((< monto 2000) 'bajo)
        ((< monto 8000) 'medio)
        (t 'alto)))

(defun penalizacion-historial (historial)
  (case historial
    (limpio 0)
    (atrasos 2)
    (desconocido 1)
    (otherwise 99)))

(defun decidir-credito (s)
  (unless (validar-solicitante s)
    (format t "~a: RECHAZADO (Datos inválidos)~%" (solicitante-nombre s))
    (return-from decidir-credito 'rechazado))
  
  (let* ((penalizacion (penalizacion-historial (solicitante-historial s)))
         (cat-monto (categoria-monto (solicitante-monto s)))
         (prom (solicitante-promedio s))
         (reprobadas (solicitante-materias-reprobadas s))
         (beca (solicitante-beca s))
         (veredicto
          (cond
            ((or (> reprobadas 3) (< prom 70) (>= penalizacion 99))
             'rechazado)
            ((and (>= prom 85)
                  (eq (solicitante-historial s) 'limpio)
                  (or (eq cat-monto 'bajo) beca))
             'aprobado)
            (t 'revision))))

    (format t "Nombre: ~a | Decisión: ~:@(~a~)~%" (solicitante-nombre s) veredicto)
    (when (and beca (not (eq veredicto 'rechazado)))
      (print "Prioridad: solicitante becado"))
    veredicto))

(defun ronda-credito (lista)
  (dolist (s lista)
    (decidir-credito s)))
