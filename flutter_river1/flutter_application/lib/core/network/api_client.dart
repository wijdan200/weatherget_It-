import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final http.Client client;
  final String baseUrl;

  ApiClient({
    required this.client,
    required this.baseUrl,
  });

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await client.get(Uri.parse('$baseUrl$endpoint'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> getList(String endpoint) async {
    final response = await client.get(Uri.parse('$baseUrl$endpoint'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}





