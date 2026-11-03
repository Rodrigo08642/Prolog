# Ejercicio 2. Comprobación de paréntesis balanceados con pilas en Java

### Comprobar que los paréntesis de apertura "(" y de cierre ")" estén equilibrados y colocados en el orden correcto dentro de una expresión, utilizando una pila.

### - Ejemplo: "((()()))(())()" es válida, mientras que "(()))(()" no lo es

### Cómo funciona la comprobación
Para determinar si los paréntesis están bien colocados con ayuda de una pila, se recorre la expresión carácter por carácter:
1. **Cuando aparece un '(' de apertura;** se agrega a la pila (**push**)
2. **Cuando aparece un ')' de cierre;** se revisa lo siguiente:
   - **a.** si la pila no tiene elementos, quiere decir que ese ')' no tiene un '(' que lo anteceda, por lo que la expresión es inválida (**false**).
   - **b.** si la pila contiene elementos, se extrae el '(' que está en la cima, emparejándolo con el ')' actual para formar "()" (**pop**)
3. **Revisión final:** al terminar el recorrido, se observa el estado de la pila:
   - ¿Está vacía? **Sí** --> Válida (**true**), cada paréntesis se cerró de manera ordenada
   - ¿Está vacía? **No** --> Inválida (**false**), sobraron paréntesis abiertos sin su cierre

```java

package prolog;

import java.util.ArrayDeque;
import java.util.Deque;

public class Tarea2 {

    public static void main(String[] args) {

        String expresion = "((())()";
        char[] parentesis = expresion.toCharArray();

        if (validacion(parentesis) == true) {
            System.out.println("La expresion: " + expresion + " es correcta");
        } else {
            System.out.println("La expresion: " + expresion + " es incorrecta");
        }

    }

    public static boolean validacion(char[] parentesis) {
        Deque<Character> pila = new ArrayDeque<>();

        for (int i = 0; i < parentesis.length; i++) {
            if (parentesis[i] == '(') {
                pila.push(parentesis[i]);
            }
            if (parentesis[i] == ')') {
                if (pila.isEmpty() == true) {
                    return false; //parentesis de cierre sin parentesis de apertura, al inicio de la pila
                }
                pila.pop();
            }
        }

        boolean valida = pila.isEmpty();
        if (valida == true) { // si la pila esta vacia
            return true; //correcta
        } else {
            return false; //false, error
        }

    }

}

```