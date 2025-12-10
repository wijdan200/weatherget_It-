import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final uri = Uri.https(
      'www.themealdb.com', '/api/json/v1/1/search.php', {'s': 'chicken'});
  print('Requesting: $uri');
  try {
    final response = await http.get(uri);
    print('Status Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(
          'Response Body: ${json.toString().substring(0, 200)}...'); // Print first 200 chars
      if (json['meals'] != null) {
        print('Meals found: ${(json['meals'] as List).length}');
      } else {
        print('No meals found.');
      }
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}
