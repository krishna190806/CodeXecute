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
      'compiler': 'cpython-head',
      'code': '''a = int(input())
if a % 2 == 0:
    print("Even")
else:
    print("Odd")''',
      'stdin': '4',
    }),
  );

  print('Status: ${response.statusCode}');
  print('Body: ${response.body}');
}
