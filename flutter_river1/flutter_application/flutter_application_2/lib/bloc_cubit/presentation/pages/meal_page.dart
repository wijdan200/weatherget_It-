import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/bloc_cubit/presentation/cubit/meal_cubit.dart';
import 'package:flutter_application_2/bloc_cubit/presentation/widgets/loading_shimmer.dart';

class MealPage extends StatelessWidget {
  const MealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search for a meal',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (query) {
                context.read<MealCubit>().searchMeals(query);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<MealCubit, MealState>(
              builder: (context, state) {
                if (state is MealLoading) {
                  return const LoadingShimmer();
                } else if (state is MealLoaded) {
                  if (state.meals.isEmpty) {
                    return const Center(child: Text('No meals found'));
                  }
                  return ListView.builder(
                    itemCount: state.meals.length,
                    itemBuilder: (context, index) {
                      final meal = state.meals[index];
                      return ListTile(
                        leading: Image.network(
                          meal.strMealThumb,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(meal.strMeal),
                        subtitle: Text(meal.strCategory),
                      );
                    },
                  );
                } else if (state is MealError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('Start searching for meals!'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
