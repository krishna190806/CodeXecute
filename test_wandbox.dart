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
      'compiler': 'gcc-head',
      'code': '''#include <iostream>
using namespace std;
int main() {
  int num = 99;
  cin >> num;
  cout << "Num is " << num;
  return 0;
}''',
      'stdin': '4',
    }),
  );

  print('Status: ${response.statusCode}');
  print('Body: ${response.body}');
}
