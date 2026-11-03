# Actividad. 3 funciones recursivas + Prueba de escritorio.
# Factorial
El factorial de cualquier número entero se define como el producto acumulativo de ese valor y todos sus enteros positivos inferiores de forma descendente (por ejemplo, $5! = 5 \times 4 \times 3 \times 2 \times 1$). Su implementación computacional suele estructurarse en dos partes esenciales:

* **Lógica recursiva**: Mientras el número sea mayor a 1, la función pospone la operación multiplicando el valor actual por el resultado del factorial anterior ($n \times \text{factorial}(n - 1)$) a la espera de que se resuelva la cadena de llamadas.
* **Condición de parada**: Al alcanzar el 0 o el 1, las llamadas se detienen y se retorna un 1. Este punto final es crucial, ya que un retorno de 0 invalidaría toda la cadena, volviendo cero el resultado total de la multiplicación.

```java
public class Actividad3Factorial {

    public static void main(String[] args) {

        /*factorial: n! = (n-0)*(n - 1)*(n - 2)... */
        int numero = 5;

        int resultfact = factorial(numero);
        System.out.println("El factorial de " + numero + " es: " + resultfact);

    }

    public static int factorial(int n) {
        if (n == 0 || n == 1) {
            return 1;
        }
        return n * factorial(n - 1);
    }

}
```

# Fibonacci
En la secuencia de Fibonacci, cada elemento se obtiene sumando sus dos antecesores inmediatos (ej. 0, 1, 1, 2, 3, 5...). A diferencia de la implementación recursiva tradicional —que genera una costosa ramificación en árbol con múltiples llamadas repetidas—, esta alternativa emplea una estructura lineal y acumulativa semejante a un bucle:

* **Paso recursivo:** Se reduce $n$ en una unidad para contabilizar las iteraciones, actualizando los acumuladores de forma que el valor previo de $b$ pasa a ser el nuevo $a$, y el nuevo $b$ resulta de la suma de ambos ($a + b$).
* **Condición de parada:** Al evaluar el contador, si $n$ es igual a `0` se retorna $a$; si es igual a `1`, se devuelve $b$.

```java
public class Actividad3Fibonacci {

    public static void main(String[] args) {

        int cantidadN = 5;
        for (int i = 0; i < cantidadN; i++) {
            System.out.print(fibonacci(i, 0, 1) + ", ");
        }

    }

    public static int fibonacci(int n, int a, int b) {
        if (n == 0) { return a; }
        if (n == 1) { return b; }
        return fibonacci(n - 1, b, a + b);
        /*
        if (n <= 1) { //si n es 0 o 1 devuelve el mismo numero
            return n;
        }
        return fibonacci(n - 1) + fibonacci(n - 2);
        */
    }
}
```
# División mediante restas sucesivas
Conceptualizar la división implica calcular cuántas veces cabe un número en otro mediante sustracciones continuas (por ejemplo, en $14 / 3$ se resta el $3$ al $14$ de forma repetida mientras un contador registra cada operación). Su lógica se compone de dos fases:

* **Paso recursivo:** Se reduce el dividendo restándole el divisor ($dividendo - divisor$) y se incrementa en una unidad el contador del cociente ($cociente + 1$).
* **Condición de parada:** El proceso termina (`return`) cuando el dividendo restante es menor que el divisor, momento en el cual se despliegan el cociente final (total de restas) y el residuo (remanente).

```java
public class Actividad3DIvisionRestas {

    public static void main(String[] args) {
        int dividendo = 14;
        int divisor = 3;

        System.out.println("Division de "+dividendo+"/"+divisor+" = ");
        division(dividendo, divisor, 0);
    }

    public static void division(int dividendo, int divisor, int cociente) {
        if (dividendo < divisor) {//hasta que ya no se pueda restar mas
            System.out.println("Cociente: " + cociente);
            System.out.println("Resto:    " + dividendo);
            return;
        }

        division(dividendo - divisor, divisor, cociente + 1);
    }
}
