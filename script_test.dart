import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

Future<void> main() async {
  final file = File('wandbox_java.txt');
  var out = '';
  final url = 'https://wandbox.org/api/list.json';
  final response = await http.get(Uri.parse(url));
  final List<dynamic> data = jsonDecode(response.body);
  
  for (var item in data) {
    if (item['name'].toString().toLowerCase().contains('jdk')) {
      out += '${item['name']}\n';
    }
  }
  await file.writeAsString(out);
}
