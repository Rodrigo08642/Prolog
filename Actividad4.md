# Actividad. Laberinto

//Laberinto
| 👤 | 1   |    |     |     |     |    |    |
|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
|    | 1    |    | 1  | 1  |    |     |    |
|    | 1    | 1  | 1  | 1  |    | 1   |    |
|    |      |    |    | 1  |    | 1   |    |
|    | 1    |    | 1  | 1  |    | 1   |    |
|    | 1    |    |    |    |    | 1   | 🚪 |

- 1; Pared/Obstáculo
- 0; Libre

### Definiciones (main)
- Se declara la matriz `laberinto`, que representa el mapa del juego
  - un 0 indica una casilla por la que se puede avanzar y un 1 señala una pared u obstáculo
- Coordenadas:
  - La meta `(destinoX, destinoY)` -> (n-1, n-1), donde n es el tamaño de la matriz
  - La posición de partida `(inicialX, inicialY)` -> (0, 0)
- Se invoca la función resolver enviándole el laberinto, el punto de partida (0, 0), la meta y una lista vacía donde se irá guardando la ruta que tenga éxito
  - si resolver devuelve true, se imprime la lista con el recorrido válido

### Función resolver
- **Caso base:** Si la posición actual queda fuera de los límites de la matriz o topa con una pared (1), la función descarta ese camino y devuelve false
- **Registro y meta:** Si la casilla es transitable
  - se agrega a la lista camino
  - enseguida comprueba si esa casilla es la meta
    - en caso afirmativo, devuelve true y la búsqueda termina con éxito
- **Marcado temporal:** Para evitar ciclos infinitos, el código aplica un truco: convierte la casilla actual en una pared provisional (`lab[y][x] = 1`)
- **Búsqueda en cada dirección (→, abajo, ←, arriba):** Con el operador || (O) se intenta avanzar hacia:
  - la derecha `(x+1, y)`
  - abajo `(x, y+1)`
  - la izquierda `(x-1, y)`
  - arriba `(x, y-1)`
  - Si alguna dirección llega a la salida, las restantes ya no se exploran
- **Backtracking (retroceso):** Si las cuatro direcciones devuelven false, el explorador se encuentra en un callejón sin salida
  - Entonces deshace su recorrido:
    - devuelve la casilla a su estado libre (0), elimina esa coordenada de la lista y regresa un paso atrás

### Función imprimir lista de caminos
- Mediante una condición se revisa si la función resolver devolvió true o false; si fue true, se imprime la lista de caminos con el formato (y,x)
  - recibe un índice i que arranca en 0
  - ese índice avanza desde 0 hasta el tamaño total de la lista de caminos
  - en cada paso se imprime la posición (i) de la lista
  - cuando el índice (i) alcanza el total de elementos de la lista, se muestra un mensaje de finalización

---
```java
import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Iterator;

public class Tarea4Laberinto {

    public static void main(String[] args) {
        int[][] laberinto = {
            {0, 1, 0, 0, 0, 0, 0, 0},
            {0, 1, 0, 1, 1, 0, 1, 0},
            {0, 1, 1, 1, 1, 0, 1, 0},
            {0, 0, 0, 0, 1, 0, 1, 0},
            {0, 1, 0, 1, 1, 0, 1, 0},
            {0, 1, 0, 0, 0, 0, 1, 0}
        };

        boolean[][] visitado = new boolean[laberinto.length][laberinto[0].length];
        Deque<int[]> ruta = new ArrayDeque<>();

        if (buscar(laberinto, visitado, 0, 0, ruta)) {
            // ArrayDeque con push() guarda al revés, por eso se usa descendingIterator
            mostrar(ruta.descendingIterator(), 0);
        } else {
            System.out.println("el laberinto no tiene solucion");
        }
    }

    static boolean buscar(int[][] lab, boolean[][] vis, int x, int y, Deque<int[]> ruta) {
        boolean fuera = x < 0 || y < 0 || y >= lab.length || x >= lab[0].length;
        if (fuera || lab[y][x] == 1 || vis[y][x]) {
            return false;
        }

        ruta.push(new int[]{x, y});
        vis[y][x] = true;

        if (x == lab[0].length - 1 && y == lab.length - 1) {
            return true;
        }

        boolean encontrado = buscar(lab, vis, x + 1, y, ruta)
                          || buscar(lab, vis, x, y + 1, ruta)
                          || buscar(lab, vis, x - 1, y, ruta)
                          || buscar(lab, vis, x, y - 1, ruta);

        if (!encontrado) {
            ruta.pop();
            vis[y][x] = false;
        }
        return encontrado;
    }

    static void mostrar(Iterator<int[]> it, int i) {
        if (!it.hasNext()) {
            System.out.println("fin del laberinto");
            return;
        }
        int[] p = it.next();
        System.out.println("Paso " + i + ": (" + p[0] + ", " + p[1] + ")");
        mostrar(it, i + 1);
    }
}

```
---