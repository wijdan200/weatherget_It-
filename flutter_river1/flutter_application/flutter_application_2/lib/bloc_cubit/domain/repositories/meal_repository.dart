import 'package:flutter_application_2/bloc_cubit/domain/entities/meal.dart';

abstract class MealRepository {
  Future<List<Meal>> getMeals(String query);
}
