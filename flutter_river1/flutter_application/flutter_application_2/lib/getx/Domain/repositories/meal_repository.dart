import '../entities/meal_entity.dart';

abstract class MealRepository {
  Future<List<MealEntity>> getMealByName(String name);
}
