import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/bloc_cubit/domain/entities/meal.dart';
import 'package:flutter_application_2/bloc_cubit/domain/usecases/get_meals.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  final GetMeals getMeals;

  MealCubit({required this.getMeals}) : super(MealInitial());

  Future<void> searchMeals(String query) async {
    emit(MealLoading());
    try {
      final meals = await getMeals(query);
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }
}
