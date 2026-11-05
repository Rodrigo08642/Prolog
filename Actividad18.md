# Operación Residencial — Informe

**Agente:** [Rafael Piedra Sanchez - 23121141]


---
* Material interceptado — Las doce pistas
Hay cuatro casas numeradas 1 – 2 – 3 – 4 de izquierda a derecha.

| Atributo | Posiblres valores (Atomos) |
|----------|----------------------------|
| Persona  | ana, beto, carla, diego    |
| Color    | blanca, verde, roja, azul  |
| Bebida   | agua, cafe, leche, te      |
| Mascota  | gato, perro, pez, loro     |


* Pistas:
  * Ana vive en la casa 1.
  * Ana vive en la casa blanca.
  * Beto bebe café.
  * La casa verde está inmediatamente a la izquierda de la casa roja.
  * Quien vive en la casa verde bebe café.
  * Carla bebe leche.
  * Quien tiene el perro vive junto a quien bebe agua.
  * Quien tiene el gato bebe agua.
  * Diego vive en la casa azul.
  * Quien tiene el loro bebe té.
  * Carla tiene el pez.
  * Quien bebe té vive en la casa 4.

**Pregunta del mando**: ¿quién tiene el pez? (**La pista 11 lo dice… pero deben demostrarlo** armando el resto del expediente. Si solo copian la pista 11 sin deducir colores, bebidas y vecinos, la misión 4–5 no cuenta.)

---

### Misión 1 — El Dominio de la Calle

- **Hechos de dominio (sí/no cargan):** 
  Sí cargan correctamente sin errores en SWI-Prolog (`swipl -s residencial.pl`). Se definieron los predicados `persona/1`, `color/1`, `bebida/1` y `mascota/1`.

- **Tabla átomo/variable/hecho/regla:**

| Expresión | Tipo | Explicación |
| :--- | :--- | :--- |
| `ana` | Átomo | Constante simbólica; inicia con letra minúscula. |
| `P` | Variable | Identificador que inicia con letra mayúscula; representa una incógnita a ligar/unificar. |
| `persona(carla).` | Hecho | Cláusula unitaria incondicional que declara una verdad sobre el átomo `carla` (termina en punto). |
| `vive_en(ana, 1).` | Hecho | Predicado de aridad 2 que relaciona incondicionalmente dos constantes (`ana` y `1`). |
| `dueno(P) :- tiene(P, pez).` | Regla | Cláusula condicional compuesta por una cabeza (`dueno(P)`), el operador `:-` (cuello/implicación) y un cuerpo (`tiene(P, pez)`). |

- **Salidas de consultas:**

```prolog
?- persona(ana).
true.

?- persona(X).
X = ana ;
X = beto ;
X = carla ;
X = diego.

?- color(roja).
true.

?- bebida(jugo).
false.
```

- **¿Por qué Ana ≠ ana? (¿Qué hace Prolog con Ana?):**
  En Prolog, cualquier término que comience con letra **mayuscula** es interpretado como una **variable**, mientras que los terminos que inician con **minuscula** son **átomos** (constantes simbolicas).
  Al ejecutar `?- persona(Ana).`, no se esta buscando a la persona con nombre "ana", sino que Prolog trata a `Ana` como una variable libre y busca unificarla con cualquier hecho del predicado `persona/1`. Por ello, unifica sucesivamente con todas las personas registradas (`Ana = ana`, `Ana = beto`, etc.). Para consultar especificamente por la constante, debe escribirse en minúsculas: `?- persona(ana).`.


---

### Misión 2 — Pistas que ya son hechos

- **Pistas que sí son hechos directos:**
  De las doce pistas interceptadas, solamente cuatro relacionan directamente a una persona con su atributo o posición sin depender de inferencias o deducciones previas:
  * Pista 1: Ana vive en la casa 1 -> `vive_en(ana, 1).`
  * Pista 3: Beto bebe café -> `bebe(beto, cafe).`
  * Pista 6: Carla bebe leche -> `bebe(carla, leche).`
  * Pista 11: Carla tiene el pez -> `tiene(carla, pez).`

- **Hechos escritos:**

```prolog
vive_en(ana, 1).    % Pista 1
bebe(beto, cafe).   % Pista 3
bebe(carla, leche). % Pista 6
tiene(carla, pez).  % Pista 11
```

- **Por qué la pista 4 no es hecho aislado:**
  La pista 4 indica que la casa verde está inmediatamente a la izquierda de la casa roja. Esto no define un hecho directo porque no especifica qué número le corresponde a la casa verde ni a la roja. Se trata de una restricción de posición relativa entre dos casas adyacentes, lo que inicialmente deja abiertas varias posibilidades como (1, 2), (2, 3) o (3, 4). Por lo tanto, no se puede escribir como un hecho concreto hasta cruzarla con otras pistas.

- **Salidas:**

```prolog
?- vive_en(ana, N).
N = 1.

?- bebe(beto, B).
B = cafe.

?- tiene(carla, M).
M = pez.
```

---

### Misión 3 — La Fábrica de Reglas

- **Reglas escritas:**

```prolog
% 1. dueno_del_pez(P) - determina quien tiene el pez
dueno_del_pez(P) :-
    tiene(P, pez).

% 2. color_de(Persona, Color) - relaciona a la persona con el color de su casa mediante la variable N
color_de(Persona, Color) :-
    vive_en(Persona, N),
    color_casa(N, Color).

% 3. vecinos(P1, P2) - determina si dos personas viven en casas contiguas
vecinos(P1, P2) :-
    vive_en(P1, N1),
    vive_en(P2, N2),
    abs(N1 - N2) =:= 1.

% 4. bebe_en_casa(N, B) - determina la bebida que se consume en la casa N
bebe_en_casa(N, B) :-
    vive_en(P, N),
    bebe(P, B).

% 5. perfil(P, N, Color, Bebida, Mascota) - expediente con todos los atributos de cada persona
perfil(P, N, Color, Bebida, Mascota) :-
    persona(P),
    vive_en(P, N),
    color_casa(N, Color),
    bebe(P, Bebida),
    tiene(P, Mascota).
```

- **Papel de N en color_de:**
  La variable N funciona como un puente de unificación lógica. En la primera meta `vive_en(Persona, N)`, N toma el valor del número de la casa en la que habita la persona consultada. Posteriormente, en `color_casa(N, Color)`, Prolog reutiliza ese mismo número de casa N para buscar su color correspondiente. De este modo se enlazan dos hechos distintos sin necesidad de haber registrado un hecho redundante que asocie directamente a la persona con el color.

---

## Misión 4 — El Tablero de Deducción

- **Tablero final:**

| Casa | Color | Persona | Bebida | Mascota |
|:---:|:---:|:---:|:---:|:---:|
| 1 | blanca | ana | agua | gato |
| 2 | verde | beto | cafe | perro |
| 3 | roja | carla | leche | pez |
| 4 | azul | diego | te | loro |

- **Cadena de deducción (paso → pistas → hecho):**

| Paso | Pistas utilizadas | Razonamiento deductivo | Hechos deducidos |
|:---:|:---|:---|:---|
| 1 | Pista 1 + Pista 2 | Ana vive en la casa 1 y vive en la casa blanca. Por tanto, la casa 1 es blanca. | `color_casa(1, blanca).`<br>`vive_en(ana, 1).` |
| 2 | Pista 3 + Pista 5 | Beto bebe café y quien vive en la casa verde bebe café. Se deduce que Beto vive en la casa verde. | `bebe(beto, cafe).`<br>(Beto habita la casa verde) |
| 3 | Pista 12 + Pista 10 | Quien bebe té vive en la casa 4 y quien tiene el loro bebe té. Por ende, en la casa 4 se bebe té y habita el loro. | (Casa 4 consume té y tiene loro) |
| 4 | Pistas 4, 9, 12 y paso 2 | La casa verde está a la izquierda de la roja (Pista 4). Las opciones de casas contiguas son (2, 3) o (3, 4). En la casa 4 se bebe té, así que no puede ser verde (donde se bebe café). Si la verde fuera la casa 3 y la roja la 4, la casa 2 tendría que ser azul para Diego (Pista 9), pero Beto o Carla tendrían que vivir en la 4, contradiciendo que allí se bebe té. En consecuencia, la casa 2 es verde, la casa 3 es roja, la casa 4 es azul y allí vive Diego. | `color_casa(2, verde).`<br>`color_casa(3, roja).`<br>`color_casa(4, azul).`<br>`vive_en(diego, 4).`<br>`bebe(diego, te).`<br>`tiene(diego, loro).` |
| 5 | Paso 4 + Paso 2 | Como la casa 2 es verde y Beto vive en la casa verde, Beto vive en la casa 2. | `vive_en(beto, 2).` |
| 6 | Pista 6 + Pista 11 + Descarte | Con las casas 1, 2 y 4 ocupadas, Carla vive en la casa 3. Por pistas 6 y 11, bebe leche y tiene el pez. | `vive_en(carla, 3).`<br>`bebe(carla, leche).`<br>`tiene(carla, pez).` |
| 7 | Pista 8 + Descarte de bebidas | Asignadas las bebidas café, leche y té, la única restante para Ana en la casa 1 es agua. Por la pista 8, quien bebe agua tiene el gato. | `bebe(ana, agua).`<br>`tiene(ana, gato).` |
| 8 | Pista 7 + Descarte de mascotas | La única mascota restante para Beto es el perro. Se comprueba con la pista 7, ya que Beto (casa 2 con perro) es vecino de Ana (casa 1 que bebe agua). | `tiene(beto, perro).` |

- **Trampa de la casa 3:**
  No es coherente que Beto viva en la casa 3. Si Beto viviera en la casa 3, como bebe café y quien vive en la casa verde bebe café, la casa 3 tendría que ser verde. Por la pista 4, la casa roja tendría que ser la casa 4. La casa 1 ya es blanca por Ana, de modo que la casa 2 tendría que ser azul para Diego. Esto forzaría a que en la casa 4 viva Carla, pero en la casa 4 se bebe té según la pista 12 y Carla bebe leche según la pista 6. Esto genera una contradicción directa e irresoluble.

---

### Misión 5 — El Expediente Completo

- **Salida de dueno_del_pez / perfil / resumen_pez:**

```prolog
?- dueno_del_pez(P).
P = carla.

?- perfil(P, N, Color, Bebida, Mascota).
P = ana, N = 1, Color = blanca, Bebida = agua, Mascota = gato ;
P = beto, N = 2, Color = verde, Bebida = cafe, Mascota = perro ;
P = carla, N = 3, Color = roja, Bebida = leche, Mascota = pez ;
P = diego, N = 4, Color = azul, Bebida = te, Mascota = loro.

?- resumen_pez(P, N, Color, Bebida).
P = carla,
N = 3,
Color = roja,
Bebida = leche.
```

- **Respuesta al mando:**
  Carla es quien tiene el pez. Vive en la casa número 3 de color roja y toma leche.

- **Hecho vs regla:**
  Un hecho almacena un dato atómico directo en la base de conocimientos sin verificar su coherencia con el entorno. En cambio, una regla modela una inferencia lógica a través de condiciones y variables compartidas. Registrar únicamente que Carla tiene el pez como hecho aislado responde la pregunta de forma estática, pero deducir y consultar mediante reglas demuestra que toda la configuración residencial es consistente y lógica en su totalidad.

---

### Misión 6 — Código Saboteado

| ID | Código saboteado | Efecto | Causa | Corrección |
|:---:|:---|:---|:---|:---|
| **S1** | `vive_en(Ana, 1).` | Funciona con error lógico y muestra advertencia de variable solitaria al cargar | Ana al iniciar con mayúscula se interpreta como variable libre, indicando falsamente que cualquier individuo habita la casa 1 | Escribir con minúscula: `vive_en(ana, 1).` |
| **S2** | `color_casa(2, Verde).` | Funciona con error lógico y advertencia de variable solitaria | Verde es interpretada como variable, provocando que la casa 2 unifique con cualquier color que se consulte | Escribir con minúscula: `color_casa(2, verde).` |
| **S3** | `bebe(beto, cafe)` | Error de sintaxis que impide cargar el archivo en Prolog | Toda cláusula o hecho en Prolog debe concluir obligatoriamente con un punto final | Agregar el punto final: `bebe(beto, cafe).` |
| **S4** | `vecinos(P1, P2) :- vive_en(P1, N), vive_en(P2, N).` | Comportamiento lógico incorrecto | Emplea la misma variable N para ambas personas, por lo que evalúa que son vecinas si comparten la misma casa en vez de casas contiguas | Usar variables distintas y calcular diferencia absoluta: `vecinos(P1, P2) :- vive_en(P1, N1), vive_en(P2, N2), abs(N1 - N2) =:= 1.` |
| **S5** | `tiene(carla, pez).` y además `tiene(diego, pez).` | Respuestas falsas sin error sintáctico | Rompe la unicidad del dominio asignando el pez a dos personas distintas a la vez | Eliminar el hecho duplicado y dejar únicamente `tiene(carla, pez).` |

- **Sabotaje más peligroso:**
  El sabotaje más peligroso es S5. A diferencia de S3 que detiene la carga con un error sintáctico, o de S1 y S2 que generan advertencias de variables solitarias, S5 posee una sintaxis válida para Prolog. Pasa desapercibido al compilarse y adultera silenciosamente las consultas lógicas, haciendo que el sistema entregue información contradictoria sin alertar al programador.

---

### Extra (si aplica)
- **¿Una sola solución?:**
  Sí, existe una única solución para el acertijo. Al ejecutar el buscador con restricciones y comprobar la longitud de resultados con `findall/3`, el motor de Prolog demuestra que solamente una combinación de asignaciones satisface las doce pistas simultáneamente.

```prolog
?- findall(Casas, buscar(Casas), Soluciones), length(Soluciones, Total).
Soluciones = [[casa(1, blanca, ana, agua, gato), casa(2, verde, beto, cafe, perro), casa(3, roja, carla, leche, pez), casa(4, azul, diego, te, loro)]],
Total = 1.
```

- **Comparación buscador vs hechos:**
  * Enfoque con hechos deducidos y reglas: Permite consultar de forma ágil, puntual y directa cualquier dato particular (como el color de una casa o los vecinos) sin tener que reconstruir o iterar sobre toda la lista del vecindario en cada pregunta.
  * Enfoque con buscador (`member/2` y listas): Permite delegar la resolución combinatoria directamente al motor de unificación y retroceso de Prolog a partir de las restricciones del problema, facilitando además la comprobación automática de que no existan soluciones alternas.