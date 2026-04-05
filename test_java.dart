import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final url = 'https://wandbox.org/api/compile.json';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'compiler': 'openjdk-jdk-22+36',
      'code': '''import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int num = sc.nextInt();
        if (num % 2 == 0) System.out.println("Even");
        else System.out.println("Odd");
    }
}''',
      'stdin': '4',
    }),
  );

  print('Status: ${response.statusCode}');
  print('Body: ${response.body}');
}
