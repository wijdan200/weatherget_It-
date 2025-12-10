import '../entities/meal_entity.dart';
import '../repositories/meal_repository.dart';

class GetMealByName {
  final MealRepository repository;

  GetMealByName(this.repository);

  Future<List<MealEntity>> call(String name) async {
    return await repository.getMealByName(name);
  }
}
