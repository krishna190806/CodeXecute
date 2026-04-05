import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final url = 'https://wandbox.org/api/compile.json';
  
  // Test 1: Simple C++ without input
  print('=== Test 1: Simple C++ (no input) ===');
  var response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'compiler': 'gcc-head',
      'code': '''#include <iostream>
using namespace std;
int main() {
  cout << "Hello World";
  return 0;
}''',
    }),
  );
  
  print('Status: ${response.statusCode}');
  var data = jsonDecode(response.body);
  print('Program Output: ${data['program_output']}');
  print('Program Error: ${data['program_error']}');
  print('Status code: ${data['status']}');
  print('');
  
  // Test 2: C++ with cin
  print('=== Test 2: C++ with cin ===');
  response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'compiler': 'gcc-head',
      'code': '''#include <iostream>
using namespace std;
int main() {
  int x;
  cin >> x;
  cout << "Got: " << x;
  return 0;
}''',
      'stdin': '42\n',
    }),
  );
  
  print('Status: ${response.statusCode}');
  data = jsonDecode(response.body);
  print('Program Output: ${data['program_output']}');
  print('Program Error: ${data['program_error']}');
  print('Status code: ${data['status']}');
}
