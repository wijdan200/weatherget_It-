import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../Domain/entitie/meal_entity.dart';
import '../../Domain/usecase/get_meal_by_name.dart';
import '../../Data/repos/meal_repo_impl.dart';
import '../../Domain/repositry/meal_repo.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final mealControllerProvider = FutureProvider<List<MealEntity>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  // if (query.isEmpty) {
  //   return [];
  // }
  // Override the interface provider with the implementation
  // Ideally this should be done in the main scope or by using the impl provider directly if not overriding.
  // For simplicity here, we assume mealRepoProvider is overridden or we use mealRepoImplProvider.
  // But wait, getMealByNameUseCaseProvider depends on mealRepoProvider.
  // So we need to ensure mealRepoProvider provides the implementation.

  final useCase = ref.watch(getMealByNameUseCaseProvider);
  return useCase(query);
});
