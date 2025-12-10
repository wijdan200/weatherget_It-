import 'package:flutter_application_2/bloc_cubit/domain/entities/meal.dart';
import 'package:flutter_application_2/bloc_cubit/domain/repositories/meal_repository.dart';

class GetMeals {
  final MealRepository repository;

  GetMeals(this.repository);

  Future<List<Meal>> call(String query) async {
    return await repository.getMeals(query);
  }
}
