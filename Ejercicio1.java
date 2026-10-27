import java.util.Scanner;

public class Ejercicio1 {
    static final int[] Dinero = {100, 50, 20, 10, 5, 2, 1};

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("Ingresa la cantidad a dividir");
        int cantidad = sc.nextInt();

        if (cantidad < 0) {
            System.out.println("La cantidad no puede ser negativa");
        } else {
            System.out.println();
            mostrarDivisiones(cantidad, 0);
        }
        sc.close();
    }

    static void mostrarDivisiones(int cantidad, int index) {
        if (index >= Dinero.length) {
            return;
        }

        int denominacionActual = Dinero[index];
        if (denominacionActual != cantidad && cantidad % denominacionActual == 0) {
            int cuantos = cantidad / denominacionActual;
            System.out.println(cantidad + " = " + cuantos + " de " + denominacionActual);
        }

        mostrarDivisiones(cantidad, index + 1);
    }
}