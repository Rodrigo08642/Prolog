# Pasar de los Componentes Lógicos de Primer Orden a Prolog

Detectar y pasar del ejercicio de enunciado a prolog.

## Enunciado a Prolog

```prolog
% 1. La Tierra es un planeta.
planeta(tierra).

% 2. La Luna no es un planeta.
no_planeta(luna).
no_es_planeta(X) :- \+ planeta(X).

% 3. La Luna es un satélite.
satelite(luna).

% 4. La Tierra gira alrededor del Sol.
gira_alrededor(tierra, sol).

% 5. Todo planeta es un satélite.
satelite(X) :- planeta(X).

% 6. Todo planeta gira alrededor del Sol.
gira_alrededor(X, sol) :- planeta(X).

% 7. Algún planeta gira alrededor de la Luna.
algun_planeta_gira_alrededor_luna(X) :- planeta(X), gira_alrededor(X, luna).

% 8. Hay por lo menos un satélite.
hay_al_menos_un_satelite :- satelite(_).

% --------------------------------- VECINDARIO, PERROS Y CARTEROS
% 9. Todos los perros del vecindario muerden a algún cartero.
todos_perros_vecindario_muerden_algun_cartero :-
    forall((perro(X), en_vecindario(X)), (cartero(Y), muerde(X, Y))).

% 10. Hay un cartero al que lo muerden todos los perros.
cartero_mordido_por_todos_los_perros(X) :-
    cartero(X), forall(perro(Y), muerde(Y, X)).

% 11. Todos los carteros son mordidos por algún perro.
todos_los_carteros_son_mordidos :-
    forall(cartero(X), (perro(Y), muerde(Y, X))).

% 12. Hay un perro que muerde a todos los carteros.
perro_muerde_a_todos_los_carteros(X) :-
    perro(X), forall(cartero(Y), muerde(X, Y)).

% 13. Todos los perros que asustan a algún cartero, lo muerden.
muerde(X, Y) :- perro(X), cartero(Y), asusta(X, Y).

% 14. Hay un perro que muerde a todos los perros que muerden a algún cartero.
perro_muerde_a_perros_mordedores_de_carteros(X) :-
    perro(X),
    forall((perro(Y), cartero(Z), muerde(Y, Z)), muerde(X, Y)).

% 15. Hay un solo perro que se muerde a sí mismo.
unico_perro_se_muerde_a_si_mismo(X) :-
    perro(X), muerde(X, X), \+ (perro(Y), muerde(Y, Y), Y \= X).

% ----------------------------------------------- BIBLIOTECA, LIBROS, AUTORES Y USUARIOS
% 16. La Biblioteca Nacional tiene el libro "Don Quijote de la Mancha".
libro('Don Quijote de la Mancha').
tiene(biblioteca_nacional, 'Don Quijote de la Mancha').

% 17. Todos los libros en la Biblioteca Nacional están catalogados.
catalogado(X) :- libro(X), tiene(biblioteca_nacional, X).

% 18. Existen libros que están en más de una biblioteca.
en_mas_de_una_biblioteca(X) :-
    libro(X), tiene(B1, X), tiene(B2, X), B1 \= B2.

% 19. Si un libro es raro, entonces no se puede prestar.
no_prestable(X) :- libro(X), raro(X).
prestable(X) :- libro(X), \+ raro(X).

% 20. La Biblioteca Central tiene más de 10,000 libros.
tiene_mas_de_10000_libros(Bib) :- cantidad_libros(Bib, N), N > 10000.

% 21. Todos los autores tienen al menos un libro en una biblioteca.
todos_los_autores_tienen_libro_en_biblioteca :-
    forall(autor(A), (escribio(A, L), libro(L), tiene(_, L))).

% 22. Existe un autor que tiene más de 5 libros publicados.
autor_con_mas_de_5_libros(A) :-
    autor(A), findall(L, escribio(A, L), Libros), length(Libros, Total), Total > 5.

% 23. No todos los libros de la biblioteca están en buen estado.
no_todos_libros_en_buen_estado(Bib) :-
    tiene(Bib, L), libro(L), \+ buen_estado(L).

% 24. Si un libro está en buen estado, puede ser prestado.
prestable(X) :- libro(X), buen_estado(X).

% 25. Todos los usuarios registrados pueden tomar prestado un libro.
puede_tomar_prestado(U, L) :- usuario_registrado(U), libro(L), prestable(L).

% 26. Existen libros que solo se pueden consultar en la biblioteca.
solo_consulta_en_sala(X) :- libro(X), \+ prestable(X).

% 27. Todo libro prestado debe ser devuelto en 15 días.
plazo_devolucion_dias(X, 15) :- libro(X), prestado(X).

% 28. Hay un libro que nadie ha pedido en préstamo.
libro_nunca_pedido(X) :- libro(X), \+ pidio_prestado(_, X).

% 29. Si un usuario tiene una multa, no puede pedir un libro prestado.
puede_pedir_prestado(U, L) :- usuario(U), libro(L), prestable(L), \+ tiene_multa(U).

% 30. Todos los libros escritos por un mismo autor están en la misma sección.
misma_seccion(X, Y) :- en_seccion(X, S), en_seccion(Y, S).
todos_libros_mismo_autor_misma_seccion :-
    forall((escribio(A, L1), escribio(A, L2)), misma_seccion(L1, L2)).

% 31. Existe un libro que tiene más de un ejemplar en la biblioteca.
tiene_multiples_ejemplares(L) :-
    libro(L), ejemplar_de(E1, L), ejemplar_de(E2, L), E1 \= E2.

% 32. Todo usuario con más de tres préstamos debe devolver uno para pedir otro.
debe_devolver_para_prestar(U) :-
    usuario(U), findall(L, prestamo_activo(U, L), P), length(P, C), C > 3.

% 33. Hay una sección de la biblioteca donde todos los libros son de ciencias.
seccion_exclusiva_ciencias(S) :-
    seccion(S), en_seccion(_, S),
    forall((libro(L), en_seccion(L, S)), de_ciencias(L)).

% 34. No todos los libros en la biblioteca tienen más de 100 páginas.
libro_con_100_o_menos_paginas(L) :-
    libro(L), tiene(_, L), paginas(L, P), P =< 100.

% 35. Existe un usuario que ha tomado prestados todos los libros de la sección infantil.
usuario_tomo_todos_libros_seccion_infantil(U) :-
    usuario(U),
    forall((libro(L), en_seccion(L, infantil)), tomo_prestado(U, L)).
```


---


## Ejercicios

---

- **La Tierra es un planeta.**
  * **Variables de individuo:** Ninguna
  * **Constantes de individuo:** $t$ (la Tierra)
  * **Cuantificador:** Ninguno
  * **Propiedades:** $Planeta(x)$ [monario: $x$ es un planeta]
  * **Relaciones:** Ninguna
  * **Dominio del discurso:** Cuerpos celestes / Objetos astronómicos

---

- **La Luna no es un planeta.**
  * **Variables de individuo:** Ninguna
  * **Constantes de individuo:** $l$ (la Luna)
  * **Cuantificador:** Ninguno
  * **Propiedades:** $Planeta(x)$ [monario: $x$ es un planeta]
  * **Relaciones:** Ninguna
  * **Dominio del discurso:** Cuerpos celestes / Objetos astronómicos

---

- **La Luna es un satélite.**
  * **Variables de individuo:** Ninguna
  * **Constantes de individuo:** $l$ (la Luna)
  * **Cuantificador:** Ninguno
  * **Propiedades:** $Satelite(x)$ [monario: $x$ es un satélite]
  * **Relaciones:** Ninguna
  * **Dominio del discurso:** Cuerpos celestes / Objetos astronómicos

---

- **La Tierra gira alrededor del Sol.**
  * **Variables de individuo:** Ninguna
  * **Constantes de individuo:** $t$ (la Tierra), $s$ (el Sol)
  * **Cuantificador:** Ninguno
  * **Propiedades:** Ninguna
  * **Relaciones:** $GiraAlrededor(x, y)$ [binario: $x$ gira alrededor de $y$]
  * **Dominio del discurso:** Cuerpos celestes / Objetos astronómicos

---

- **Todo planeta es un satélite.**
  * **Variables de individuo:** $x$
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Universal ($\forall x$)
  * **Propiedades:** $Planeta(x)$ [monario], $Satelite(x)$ [monario]
  * **Relaciones:** Ninguna
  * **Dominio del discurso:** Cuerpos celestes / Objetos astronómicos

---

- **Todo planeta gira alrededor del Sol.**
  * **Variables de individuo:** $x$
  * **Constantes de individuo:** $s$ (el Sol)
  * **Cuantificador:** Universal ($\forall x$)
  * **Propiedades:** $Planeta(x)$ [monario]
  * **Relaciones:** $GiraAlrededor(x, y)$ [binario: $x$ gira alrededor de $y$]
  * **Dominio del discurso:** Cuerpos celestes / Objetos astronómicos

---

- **Algún planeta gira alrededor de la Luna.**
  * **Variables de individuo:** $x$
  * **Constantes de individuo:** $l$ (la Luna)
  * **Cuantificador:** Existencial ($\exists x$)
  * **Propiedades:** $Planeta(x)$ [monario]
  * **Relaciones:** $GiraAlrededor(x, y)$ [binario: $x$ gira alrededor de $y$]
  * **Dominio del discurso:** Cuerpos celestes / Objetos astronómicos

---

- **Hay por lo menos un satélite.**
  * **Variables de individuo:** $x$
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Existencial ($\exists x$)
  * **Propiedades:** $Satelite(x)$ [monario]
  * **Relaciones:** Ninguna
  * **Dominio del discurso:** Cuerpos celestes / Objetos astronómicos

---

- **Todos los perros del vecindario muerden a algún cartero.**
  * **Variables de individuo:** $x$ (perro), $y$ (cartero)
  * **Constantes de individuo:** Ninguna (o $v$ si se modela "el vecindario" como constante)
  * **Cuantificador:** Universal ($\forall x$), Existencial ($\exists y$)
  * **Propiedades:** $Perro(x)$ [monario], $EnVecindario(x)$ [monario], $Cartero(y)$ [monario]
  * **Relaciones:** $Muerde(x, y)$ [binario: $x$ muerde a $y$]
  * **Dominio del discurso:** Seres vivos / Habitantes y animales del vecindario

---

- **Hay un cartero al que lo muerden todos los perros.**
  * **Variables de individuo:** $x$ (cartero), $y$ (perro)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Existencial ($\exists x$), Universal ($\forall y$)
  * **Propiedades:** $Cartero(x)$ [monario], $Perro(y)$ [monario]
  * **Relaciones:** $Muerde(y, x)$ [binario: $y$ muerde a $x$]
  * **Dominio del discurso:** Seres vivos / Habitantes y animales

---

- **Todos los carteros son mordidos por algún perro.**
  * **Variables de individuo:** $x$ (cartero), $y$ (perro)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Universal ($\forall x$), Existencial ($\exists y$)
  * **Propiedades:** $Cartero(x)$ [monario], $Perro(y)$ [monario]
  * **Relaciones:** $Muerde(y, x)$ [binario: $y$ muerde a $x$]
  * **Dominio del discurso:** Seres vivos / Habitantes y animales

---

- **Hay un perro que muerde a todos los carteros.**
  * **Variables de individuo:** $x$ (perro), $y$ (cartero)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Existencial ($\exists x$), Universal ($\forall y$)
  * **Propiedades:** $Perro(x)$ [monario], $Cartero(y)$ [monario]
  * **Relaciones:** $Muerde(x, y)$ [binario: $x$ muerde a $y$]
  * **Dominio del discurso:** Seres vivos / Habitantes y animales

---

- **Todos los perros que asustan a algún cartero, lo muerden.**
  * **Variables de individuo:** $x$ (perro), $y$ (cartero)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Universal ($\forall x, \forall y$)
  * **Propiedades:** $Perro(x)$ [monario], $Cartero(y)$ [monario]
  * **Relaciones:** $Asusta(x, y)$ [binario], $Muerde(x, y)$ [binario]
  * **Dominio del discurso:** Seres vivos / Habitantes y animales

---

- **Hay un perro que muerde a todos los perros que muerden a algún cartero.**
  * **Variables de individuo:** $x$ (perro mordedor), $y$ (perro intermedio), $z$ (cartero)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Existencial ($\exists x$), Universal ($\forall y$), Existencial ($\exists z$)
  * **Propiedades:** $Perro(x)$ [monario], $Perro(y)$ [monario], $Cartero(z)$ [monario]
  * **Relaciones:** $Muerde(x, y)$ [binario], $Muerde(y, z)$ [binario]
  * **Dominio del discurso:** Seres vivos / Habitantes y animales

---

- **Hay un solo perro que se muerde a sí mismo.**
  * **Variables de individuo:** $x$
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Existencial de unicidad ($\exists! x$)
  * **Propiedades:** $Perro(x)$ [monario]
  * **Relaciones:** $Muerde(x, x)$ [binario reflexivo: $x$ muerde a $x$]
  * **Dominio del discurso:** Animales / Perros

---

- **La Biblioteca Nacional tiene el libro "Don Quijote de la Mancha".**
  * **Variables de individuo:** Ninguna
  * **Constantes de individuo:** $bn$ (Biblioteca Nacional), $q$ ("Don Quijote de la Mancha")
  * **Cuantificador:** Ninguno
  * **Propiedades:** $Libro(q)$ [monario]
  * **Relaciones:** $Tiene(x, y)$ [binario: la biblioteca $x$ contiene el libro $y$]
  * **Dominio del discurso:** Instituciones bibliotecarias y obras literarias

---

- **Todos los libros en la Biblioteca Nacional están catalogados.**
  * **Variables de individuo:** $x$ (libro)
  * **Constantes de individuo:** $bn$ (Biblioteca Nacional)
  * **Cuantificador:** Universal ($\forall x$)
  * **Propiedades:** $Libro(x)$ [monario], $Catalogado(x)$ [monario]
  * **Relaciones:** $EnBiblioteca(x, y)$ [binario: el libro $x$ está en la biblioteca $y$]
  * **Dominio del discurso:** Libros e instituciones

---

- **Existen libros que están en más de una biblioteca.**
  * **Variables de individuo:** $x$ (libro), $y$ (biblioteca 1), $z$ (biblioteca 2)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Existencial ($\exists x, \exists y, \exists z$)
  * **Propiedades:** $Libro(x)$ [monario], $Biblioteca(y)$ [monario], $Biblioteca(z)$ [monario]
  * **Relaciones:** $EnBiblioteca(x, y)$ [binario], $EnBiblioteca(x, z)$ [binario], $y \neq z$ [relación de desigualdad/identidad binaria]
  * **Dominio del discurso:** Libros y bibliotecas

---

- **Si un libro es raro, entonces no se puede prestar.**
  * **Variables de individuo:** $x$
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Universal ($\forall x$)
  * **Propiedades:** $Libro(x)$ [monario], $Raro(x)$ [monario], $Prestable(x)$ [monario]
  * **Relaciones:** Ninguna
  * **Dominio del discurso:** Libros y material de biblioteca

---

- **La Biblioteca Central tiene más de 10,000 libros.**
  * **Variables de individuo:** Ninguna
  * **Constantes de individuo:** $bc$ (Biblioteca Central), $10000$ (número/cota)
  * **Cuantificador:** Cuantificador numérico / Predicado de cardinalidad
  * **Propiedades:** $Biblioteca(x)$ [monario]
  * **Relaciones:** $CantidadLibrosMayorQue(x, n)$ [binario: la biblioteca $x$ tiene más de $n$ libros]
  * **Dominio del discurso:** Bibliotecas y conjuntos de libros

---

- **Todos los autores tienen al menos un libro en una biblioteca.**
  * **Variables de individuo:** $x$ (autor), $y$ (libro), $z$ (biblioteca)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Universal ($\forall x$), Existencial ($\exists y, \exists z$)
  * **Propiedades:** $Autor(x)$ [monario], $Libro(y)$ [monario], $Biblioteca(z)$ [monario]
  * **Relaciones:** $Escribio(x, y)$ [binario], $EnBiblioteca(y, z)$ [binario]
  * **Dominio del discurso:** Personas, obras y bibliotecas

---

- **Existe un autor que tiene más de 5 libros publicados.**
  * **Variables de individuo:** $x$ (autor)
  * **Constantes de individuo:** $5$ (constante numérica)
  * **Cuantificador:** Existencial ($\exists x$)
  * **Propiedades:** $Autor(x)$ [monario]
  * **Relaciones:** $LibrosPublicadosMayorQue(x, n)$ [binario: el autor $x$ ha publicado más de $n$ libros]
  * **Dominio del discurso:** Autores y publicaciones

---

- **No todos los libros de la biblioteca están en buen estado.**
  * **Variables de individuo:** $x$
  * **Constantes de individuo:** $b$ (la biblioteca)
  * **Cuantificador:** Negación de universal ($\neg \forall x$) o Existencial ($\exists x$)
  * **Propiedades:** $Libro(x)$ [monario], $BuenEstado(x)$ [monario]
  * **Relaciones:** $EnBiblioteca(x, b)$ [binario]
  * **Dominio del discurso:** Libros de la biblioteca

---

- **Si un libro está en buen estado, puede ser prestado.**
  * **Variables de individuo:** $x$
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Universal ($\forall x$)
  * **Propiedades:** $Libro(x)$ [monario], $BuenEstado(x)$ [monario], $Prestable(x)$ [monario]
  * **Relaciones:** Ninguna
  * **Dominio del discurso:** Libros

---

- **Todos los usuarios registrados pueden tomar prestado un libro.**
  * **Variables de individuo:** $x$ (usuario), $y$ (libro)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Universal ($\forall x$), Existencial / Universal condicional ($\exists y$ / $\forall y$)
  * **Propiedades:** $UsuarioRegistrado(x)$ [monario], $Libro(y)$ [monario]
  * **Relaciones:** $PuedeTomarPrestado(x, y)$ [binario]
  * **Dominio del discurso:** Usuarios y libros

---

- **Existen libros que solo se pueden consultar en la biblioteca.**
  * **Variables de individuo:** $x$
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Existencial ($\exists x$)
  * **Propiedades:** $Libro(x)$ [monario], $SoloConsultaEnSala(x)$ [monario]
  * **Relaciones:** Ninguna (o $Prestable(x)$ negado)
  * **Dominio del discurso:** Libros de la biblioteca

---

- **Todo libro prestado debe ser devuelto en 15 días.**
  * **Variables de individuo:** $x$
  * **Constantes de individuo:** $15$ (días)
  * **Cuantificador:** Universal ($\forall x$)
  * **Propiedades:** $Libro(x)$ [monario], $Prestado(x)$ [monario], $PlazoMaximoDevolucion(x, 15)$ [binario / propiedad temporal]
  * **Relaciones:** $DebeSerDevueltoEn(x, d)$ [binario: el libro $x$ debe devolverse en $d$ días]
  * **Dominio del discurso:** Libros y periodos de tiempo

---

- **Hay un libro que nadie ha pedido en préstamo.**
  * **Variables de individuo:** $x$ (libro), $y$ (persona/usuario)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Existencial ($\exists x$), Universal negado ($\neg \exists y$ o $\forall y$)
  * **Propiedades:** $Libro(x)$ [monario], $Persona(y)$ [monario]
  * **Relaciones:** $PidioPrestado(y, x)$ [binario: la persona $y$ solicitó el libro $x$]
  * **Dominio del discurso:** Libros y personas

---

- **Si un usuario tiene una multa, no puede pedir un libro prestado.**
  * **Variables de individuo:** $x$ (usuario), $y$ (libro)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Universal ($\forall x, \forall y$)
  * **Propiedades:** $Usuario(x)$ [monario], $TieneMulta(x)$ [monario], $Libro(y)$ [monario]
  * **Relaciones:** $PuedePedirPrestado(x, y)$ [binario]
  * **Dominio del discurso:** Usuarios y libros de la biblioteca

---

- **Todos los libros escritos por un mismo autor están en la misma sección.**
  * **Variables de individuo:** $x$ (libro 1), $y$ (libro 2), $a$ (autor), $s_1$ (sección 1), $s_2$ (sección 2)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Universal ($\forall x, \forall y, \forall a$)
  * **Propiedades:** $Libro(x)$ [monario], $Libro(y)$ [monario], $Autor(a)$ [monario], $Seccion(s)$ [monario]
  * **Relaciones:** $EscritoPor(x, a)$ [binario], $EscritoPor(y, a)$ [binario], $EnSeccion(x, s)$ [binario], $MismaSeccion(x, y)$ [binario / equivalencia]
  * **Dominio del discurso:** Libros, autores y secciones de la biblioteca

---

- **Existe un libro que tiene más de un ejemplar en la biblioteca.**
  * **Variables de individuo:** $x$ (libro), $e_1$ (ejemplar 1), $e_2$ (ejemplar 2)
  * **Constantes de individuo:** $b$ (la biblioteca)
  * **Cuantificador:** Existencial ($\exists x, \exists e_1, \exists e_2$)
  * **Propiedades:** $Libro(x)$ [monario], $Ejemplar(e)$ [monario]
  * **Relaciones:** $EjemplarDe(e_1, x)$ [binario], $EjemplarDe(e_2, x)$ [binario], $EnBiblioteca(e, b)$ [binario], $e_1 \neq e_2$ [desigualdad binaria]
  * **Dominio del discurso:** Libros y ejemplares físicos de la biblioteca

---

- **Todo usuario con más de tres préstamos debe devolver uno para pedir otro.**
  * **Variables de individuo:** $x$ (usuario)
  * **Constantes de individuo:** $3$ (número límite)
  * **Cuantificador:** Universal ($\forall x$)
  * **Propiedades:** $Usuario(x)$ [monario]
  * **Relaciones:** $CantidadPrestamosMayorQue(x, 3)$ [binario], $DebeDevolverParaPrestar(x)$ [monario / binario condicional]
  * **Dominio del discurso:** Usuarios, préstamos y transacciones bibliotecarias

---

- **Hay una sección de la biblioteca donde todos los libros son de ciencias.**
  * **Variables de individuo:** $s$ (sección), $x$ (libro)
  * **Constantes de individuo:** Ninguna
  * **Cuantificador:** Existencial ($\exists s$), Universal ($\forall x$)
  * **Propiedades:** $Seccion(s)$ [monario], $Libro(x)$ [monario], $DeCiencias(x)$ [monario]
  * **Relaciones:** $EnSeccion(x, s)$ [binario: el libro $x$ está en la sección $s$]
  * **Dominio del discurso:** Secciones y libros de la biblioteca

---

- **No todos los libros en la biblioteca tienen más de 100 páginas.**
  * **Variables de individuo:** $x$ (libro)
  * **Constantes de individuo:** $100$ (número de páginas), $b$ (la biblioteca)
  * **Cuantificador:** Negación de universal ($\neg \forall x$) o Existencial ($\exists x$)
  * **Propiedades:** $Libro(x)$ [monario]
  * **Relaciones:** $EnBiblioteca(x, b)$ [binario], $PaginasMayorQue(x, 100)$ [binario]
  * **Dominio del discurso:** Libros de la biblioteca y números enteros

---

- **Existe un usuario que ha tomado prestados todos los libros de la sección infantil.**
  * **Variables de individuo:** $u$ (usuario), $x$ (libro)
  * **Constantes de individuo:** $si$ (sección infantil)
  * **Cuantificador:** Existencial ($\exists u$), Universal ($\forall x$)
  * **Propiedades:** $Usuario(u)$ [monario], $Libro(x)$ [monario]
  * **Relaciones:** $EnSeccion(x, si)$ [binario], $TomoPrestado(u, x)$ [binario]
  * **Dominio del discurso:** Usuarios, libros y secciones de la biblioteca

---
