import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entitie/meal_entity.dart';
import '../repositry/meal_repo.dart';

final getMealByNameUseCaseProvider = Provider<GetMealByName>((ref) {
  final repo = ref.watch(mealRepoProvider);
  return GetMealByName(repo);
});

class GetMealByName {
  final MealRepo repository;

  GetMealByName(this.repository);

  Future<List<MealEntity>> call(String name) async {
    return await repository.getMealByName(name);
  }
}
