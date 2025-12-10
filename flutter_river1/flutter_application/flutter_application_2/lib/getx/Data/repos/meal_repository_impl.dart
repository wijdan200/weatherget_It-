import '../../Domain/entities/meal_entity.dart';
import '../../Domain/repositories/meal_repository.dart';
import '../datasource/apiservice.dart';

class MealRepositoryImpl implements MealRepository {
  final ApiService apiService;

  MealRepositoryImpl(this.apiService);

  @override
  Future<List<MealEntity>> getMealByName(String name) async {
    try {
      final result = await apiService.fetchData(name);
      if (result.meals != null) {
        return result.meals!
            .map(
              (model) => MealEntity(
                idMeal: model.idMeal ?? '',
                strMeal: model.strMeal ?? '',
                strCategory: model.strCategory ?? '',
                strArea: model.strArea ?? '',
                strInstructions: model.strInstructions ?? '',
                strMealThumb: model.strMealThumb ?? '',
              ),
            )
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch meals: $e');
    }
  }
}
