part of 'meal_cubit.dart';

//
abstract class MealState extends Equatable {
  const MealState();

  @override
  List<Object> get props => [];
}

class MealInitial extends MealState {
  //debugPrint("MealInitial");
}

class MealLoading extends MealState {
  //debugPrint("MealLoading");
}

class MealLoaded extends MealState {
  final List<Meal> meals;

  const MealLoaded(this.meals);

  @override
  List<Object> get props => [meals];
}

class MealError extends MealState {
  final String message;

  const MealError(this.message);

  @override
  List<Object> get props => [message];
}
