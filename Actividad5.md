# Actividad. Matriz rellenada con triminós (teselas)
### Definiciones (main)
* Se declara la matriz que funcionará como tablero
  * su tamaño siempre debe ser cuadrado y una potencia de 2 (por ejemplo 2x2, 4x4, 8x8)
* Coordenadas:
  * La casilla vacía inicial (filaHueco, colHueco) -> puede ser cualquier posición elegida al azar (por ejemplo 2, 1)
  * Ese hueco se marca en el tablero con un -1 (que al imprimir se mostrará como una "X")
* Se invoca la función principal llenarMatriz, enviándole el tamaño total del tablero, la coordenada de origen (0,0) desde donde empieza a analizar y la posición del hueco

### Función llenarMatriz (resolver)
* **Caso base:** Si el tablero a revisar mide solo 2x2, como ya contiene un hueco, una única pieza en L encaja justo en las 3 casillas libres, así que se coloca y la función termina
* **División del tablero (divide y vencerás):** Si el tablero es grande, se parte por la mitad en forma de cruz, generando 4 cuadrantes más pequeños
* **El truco del centro:** Al dividir en 4, el hueco original queda dentro de un solo cuadrante, mientras que los otros 3 están completamente libres
  * Para resolverlo, se coloca una pieza central (en el ejemplo de arriba es la pieza 1) justo en el centro del tablero grande
  * Las 3 puntas de esa pieza caen en los 3 cuadrantes sin hueco, funcionando como un "hueco falso" para cada uno
* **Búsqueda por cuadrantes:** El código lo determina mediante if-else:
  * ¿El hueco original está arriba a la izquierda? Si no es así, ahí se coloca una punta de la pieza central
  * ¿Está arriba a la derecha? Si no es así, se coloca una punta, y se repite igual con los cuatro cuadrantes
* **Recursividad (la repetición del proceso):** Ahora que cada uno de los 4 cuadrantes tiene exactamente 1 hueco (uno real y tres falsos), la función se llama a sí misma 4 veces para resolver cada cuadrante como si fuera un rompecabezas nuevo

### Función imprimir (matriz)
* Recorre el tablero completo fila por fila y columna por columna mediante un doble ciclo (for)
  * Usa una condición: si encuentra el valor -1, imprime la letra "X" para representar el hueco inicial
  * Si encuentra cualquier otro número, imprime el identificador de la pieza, con formato para que se vea como una cuadrícula ordenada
  * Al terminar de imprimir una fila completa, da un salto de línea para continuar con la siguiente
---
```java
public class Tarea5Matriz {

    private static int[][] matriz;
    private static int idTesela = 1;

    public static void main(String[] args) {
        
        int dimension = 8; //siempre debe ser 2^n x 2^n
        matriz = new int[dimension][dimension];

        //hueco (fila, columna)
        int filaHueco = 4;
        int colHueco = 1;
        matriz[filaHueco][colHueco] = -1; //X

        //origen (0,0)
        llenarMatriz(dimension, 0, 0, filaHueco, colHueco);

        imprimirMatriz(dimension);
    }

    public static void llenarMatriz(int lado, int filaInicio, int colInicio, int filaHueco, int colHueco) {
        
        //CASO BASE, si es un tablero de 2x2
        if (lado == 2) {
            int teselaActual = idTesela++;
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < 2; j++) {
                    //ponemos la pieza en los 3 espacios que NO son el hueco
                    if (!(filaInicio + i == filaHueco && colInicio + j == colHueco)) {
                        matriz[filaInicio + i][colInicio + j] = teselaActual;
                    }
                }
            }
            return;
        }

        //calculamos donde esta la mitad del cuadrante actual
        int mitad = lado / 2;
        int filaCentro = filaInicio + mitad;
        int colCentro = colInicio + mitad;

        //la pieza que ira en el medio para unir los cuadrantes
        int teselaCentral = idTesela++;

        //hueco de cada uno de los 4 sub cuadrantes
        int huecoFilaSupIzq, huecoColSupIzq;
        int huecoFilaSupDer, huecoColSupDer;
        int huecoFilaInfIzq, huecoColInfIzq;
        int huecoFilaInfDer, huecoColInfDer;

        //============= Cuadrante Superior Izquierdo
        if (filaHueco < filaCentro && colHueco < colCentro) {
            huecoFilaSupIzq = filaHueco;
            huecoColSupIzq = colHueco; //el hueco original ya estaba aqui
        } else {
            matriz[filaCentro - 1][colCentro - 1] = teselaCentral; //ponemos punta de la L
            huecoFilaSupIzq = filaCentro - 1;
            huecoColSupIzq = colCentro - 1;    //este es su nuevo hueco
        }

        //============= Cuadrante Superior Derecho
        if (filaHueco < filaCentro && colHueco >= colCentro) {
            huecoFilaSupDer = filaHueco;
            huecoColSupDer = colHueco;
        } else {
            matriz[filaCentro - 1][colCentro] = teselaCentral;
            huecoFilaSupDer = filaCentro - 1;
            huecoColSupDer = colCentro;
        }

        //============= Cuadrante Inferior Izquierdo
        if (filaHueco >= filaCentro && colHueco < colCentro) {
            huecoFilaInfIzq = filaHueco;
            huecoColInfIzq = colHueco;
        } else {
            matriz[filaCentro][colCentro - 1] = teselaCentral;
            huecoFilaInfIzq = filaCentro;
            huecoColInfIzq = colCentro - 1;
        }

        //============= Cuadrante Inferior Derech
        if (filaHueco >= filaCentro && colHueco >= colCentro) {
            huecoFilaInfDer = filaHueco;
            huecoColInfDer = colHueco;
        } else {
            matriz[filaCentro][colCentro] = teselaCentral;
            huecoFilaInfDer = filaCentro;
            huecoColInfDer = colCentro;
        }

        //llamada para cada cuadrante
        llenarMatriz(mitad, filaInicio, colInicio, huecoFilaSupIzq, huecoColSupIzq);
        llenarMatriz(mitad, filaInicio, colCentro, huecoFilaSupDer, huecoColSupDer);
        llenarMatriz(mitad, filaCentro, colInicio, huecoFilaInfIzq, huecoColInfIzq);
        llenarMatriz(mitad, filaCentro, colCentro, huecoFilaInfDer, huecoColInfDer);
    }

    private static void imprimirMatriz(int n) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (matriz[i][j] == -1) {
                    System.out.printf("%4s", "X"); //el hueco inicial
                } else {
                    System.out.printf("%4d", matriz[i][j]); // imprimimos los id de cada tesela
                }
            }
            System.out.println();
        }
    }
}
```
---