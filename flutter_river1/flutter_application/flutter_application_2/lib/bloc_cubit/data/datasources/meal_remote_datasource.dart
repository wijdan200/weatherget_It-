import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_2/bloc_cubit/data/models/meal_model.dart';

abstract class MealRemoteDataSource {
  Future<List<MealModel>> getMeals(String query);
}

class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  final http.Client client;

  MealRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MealModel>> getMeals(String query) async {
    final response = await client.get(
      Uri.https('www.themealdb.com', '/api/json/v1/1/search.php', {'s': query}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json['meals'] != null) {
        return (json['meals'] as List)
            .map((e) => MealModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
