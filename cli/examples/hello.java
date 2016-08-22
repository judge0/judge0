import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class HelloWorld {
  public static void main(String[] args) throws IOException {
    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
    String name = reader.readLine();
    System.out.println("hello, " + name);
  }
}
