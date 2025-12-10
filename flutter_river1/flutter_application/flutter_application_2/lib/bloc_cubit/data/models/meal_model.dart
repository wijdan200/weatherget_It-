import 'package:flutter_application_2/bloc_cubit/domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel({
    required String idMeal,
    required String strMeal,
    required String strCategory,
    required String strArea,
    required String strInstructions,
    required String strMealThumb,
  }) : super(
          idMeal: idMeal,
          strMeal: strMeal,
          strCategory: strCategory,
          strArea: strArea,
          strInstructions: strInstructions,
          strMealThumb: strMealThumb,
        );

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strCategory: json['strCategory'] ?? '',
      strArea: json['strArea'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
    );
  }
}
