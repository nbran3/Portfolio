package calculator;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {


        System.out.println("Earned amount:");
        System.out.println("Bubblegum: $202");
        System.out.println("Toffee: $118");
        System.out.println("Ice cream: $2250");
        System.out.println("Milk chocolate: $1680");
        System.out.println("Doughnut: $1075");
        System.out.println("Pancake: $80");
        System.out.println();

        double totalIncome = 202.0 + 118.0 + 2250.0 + 1680.0 + 1075.0 + 80.0;
        System.out.printf("Income: $%.2f\n", totalIncome);

        Scanner scanner = new Scanner(System.in);
        System.out.println("Staff expenses: ");
        double staff = scanner.nextDouble();

        System.out.println("Other expenses: ");
        double other = scanner.nextDouble();

        double netIncome = totalIncome - staff - other;

        System.out.println("Net Income: $" + netIncome);

    }
}
