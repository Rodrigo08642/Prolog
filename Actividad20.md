# Actividad 20: Ampliación de templates para Eliza
## 1. Objetivo
Ampliar el chatbot Eliza hecho en Prolog agregando **20 templates** nuevos, para que pueda responder a más frases de conversación cotidiana.
## 2. ¿Qué es Eliza?
Eliza es un chatbot que funciona por **coincidencia de patrones** (*pattern matching*). Cada frase que el usuario escribe se compara contra una lista de templates. Cuando alguno coincide, Eliza imprime la respuesta que tiene guardada. Si ninguno coincide, responde con una frase por defecto.

Cada template se escribe con tres partes:

```prolog
template(Estimulo, Respuesta, Indices).
```

| Parte | Qué es |
|---|---|
| `Estimulo` | Lista de palabras que el usuario debe escribir. |
| `Respuesta` | Lista con lo que Eliza va a contestar. |
| `Indices` | Posiciones de palabras del usuario que se reutilizan en la respuesta. En esta tarea van vacíos (`[]`), porque las respuestas son fijas. |

### 3.2 Templates agregados

```prolog
% texto que agregue
template([quieres, ser, mi, amiga, '?'], ['Con gusto sere tu amiga'], []).
template([vamos, por, algo, de, comer, '?'], ['Claro, yo invito'], []).
template([que, te, parece, star, wars, '?'], ['Es de lo mejor que ha existido'], []).
template([como, me, encantaria, tener, un, carro], ['Sigue esforzandote, algun dia podras comprar uno'], []).
template([que, vamos, hacer, hoy, cerebro, '?'], ['Tratar de conquistar el mundo!'], []).
template([es, hora, de, aprender, programacion], ['Yuuuujuuuuu, mi actividad favorita'], []).
template([quieres, ser, mi, novia, '?'], ['Mejor empecemos siendo buenos amigos'], []).
template([cual, es, tu, color, favorito, '?'], ['El verde, como el de la pantalla de una terminal'], []).
template([que, te, parece, la, pizza, '?'], ['Es deliciosa, sobre todo con mucho queso'], []).
template([me, encanta, la, musica], ['La musica hace la vida mas bonita'], []).
template([tienes, hambre, '?'], ['Siempre, pero solo de datos y de buenas conversaciones'], []).
template([que, hora, es, '?'], ['La hora perfecta para seguir programando'], []).
template([cuentame, un, chiste], ['Por que los programadores prefieren el modo oscuro? Porque la luz atrae a los bugs'], []).
template([estoy, muy, cansado], ['Descansa un poco, un buen programador tambien duerme'], []).
template([tengo, mucha, tarea], ['Ve paso a paso, y si necesitas ayuda aqui estoy'], []).
template([quien, te, creo, '?'], ['Me creo un estudiante con mucha paciencia y muchas lineas de Prolog'], []).
template([crees, que, voy, a, pasar, el, examen, '?'], ['Si estudias y practicas, seguro que si'], []).
template([que, te, parece, el, futbol, '?'], ['Es emocionante, aunque yo siempre juego de portero virtual'], []).
template([vamos, al, cine, hoy, '?'], ['Excelente plan, yo pongo las palomitas'], []).
template([gracias, por, tu, ayuda], ['De nada, para eso estoy aqui'], []).
```