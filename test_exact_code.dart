import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final url = 'https://wandbox.org/api/compile.json';
  
  // Test your exact code from screenshot
  print('=== Testing Your C++ Code ===');
  var response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'compiler': 'gcc-head',
      'code': '''#include <iostream>
using namespace std;

int main() {
  int num;
  cout << "Enter a number: ";
  cin >> num;

  if(num % 2 == 0)
    cout << "Even";
  else
    cout << "Odd";

  return 0;
}''',
      'stdin': '2\n',
    }),
  );
  
  print('Status: ${response.statusCode}');
  var data = jsonDecode(response.body);
  print('Status Code: ${data['status']}');
  print('Program Output: ${data['program_output']}');
  print('Program Error: ${data['program_error']}');
  print('Compiler Error: ${data['compiler_error']}');
  if(data['status'] != '0') {
    print('\nFull Response:');
    print(data);
  }
}
