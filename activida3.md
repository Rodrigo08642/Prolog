# Actividad. 3 funciones recursivas + Prueba de escritorio.
# Factorial
El factorial de un número se obtiene multiplicándolo por cada uno de los enteros menores que él, hasta llegar a 1 (por ejemplo: 5! = 5 * 4 * 3 * 2 * 1).
* **Caso base:**
  - Cuando el número es 0 o 1, la función termina y devuelve un `1`.
  - Si devolviera `0`, todo el producto se anularía y el resultado final siempre sería cero.
* **Paso recursivo:** Si el número no es 0 ni 1, la función deja en espera la operación `n * factorial(n - 1)` hasta que la llamada siguiente le entregue su resultado.

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
En la sucesión de Fibonacci, cada término es el resultado de sumar los dos que lo preceden: 0, 1, 1, 2, 3, 5...
Por lo general, la versión recursiva de este código se ramifica como un árbol y repite muchísimas llamadas. Aquí se presenta una variante lineal y más eficiente, en la que cada llamada recibe los dos valores acumulados (a y b) y avanza paso a paso, de manera similar a un ciclo.

- **Caso base:** Si el contador n vale 0 se devuelve a, y si vale 1 se devuelve b
- **Paso recursivo:**
  - Se resta 1 a n para llevar la cuenta de las iteraciones
  - El valor actual de b se convierte en el nuevo a
  - El nuevo b será la suma de ambos (a + b)

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
El resultado de una división equivale a la cantidad de veces que un número cabe dentro de otro. Por ejemplo, en **14/3** se le resta 3 al 14 una y otra vez, y una variable va contando cuántas restas se lograron hacer.
- **Caso base:** Cuando el dividendo restante ya es menor que el divisor (no alcanza para otra resta):
  - Se muestra el cociente (la cantidad de restas realizadas) y el residuo (lo que sobró), y se termina con un return
- **Paso recursivo:** Se resta el divisor al dividendo (dividendo - divisor) y se incrementa en 1 el contador (cociente + 1)

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
