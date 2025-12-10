import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entitie/meal_entity.dart';

final mealRepoProvider = Provider<MealRepo>((ref) {
  throw UnimplementedError('mealRepoProvider must be overridden');
});

abstract class MealRepo {
  Future<List<MealEntity>> getMealByName(String name);
}
