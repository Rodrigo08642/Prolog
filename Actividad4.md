# Algoritmo de Resolución de Laberintos mediante Backtracking

El algoritmo utiliza una matriz bidimensional llamada `laberinto` donde `0` representa un camino transitable y `1` una pared u obstáculo. Las coordenadas del punto de inicio son `(0, 0)` y el destino final es `(n-1, n-1)`, siendo $n$ el tamaño de la matriz. Al invocar la función `resolver` pasándole el laberinto, el punto de partida, la meta y una lista vacía, si el resultado es exitoso (`true`), se procede a imprimir el camino encontrado.

La función `resolver` evalúa primero si la posición actual está fuera de los límites o choca con una pared (`1`), abortando el camino con `false`. Si la celda es válida, se guarda inmediatamente en la lista de caminos y se comprueba si es la meta final para retornar `true` en caso afirmativo. Para evitar ciclos infinitos, se aplica un marcaje temporal convirtiendo la celda en una pared (`lab[y][x] = 1`). Luego, utiliza el operador lógico de disyunción (`||`) para buscar una salida explorando secuencialmente a la derecha `(x+1, y)`, abajo `(x, y+1)`, izquierda `(x-1, y)` y arriba `(x, y-1)` (ignorando las direcciones restantes si una encuentra la salida). Si las cuatro direcciones fallan, se ejecuta el backtracking: se restaura la celda a `0`, se borra la coordenada de la lista y se retrocede.

Finalmente, tras verificar el resultado positivo de la búsqueda, se imprime la lista de caminos en formato `(y, x)` mediante un índice $i$ que recorre desde `0` hasta el tamaño total de la lista, mostrando cada posición de manera iterativa hasta finalizar el proceso con un mensaje de cierre.

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