import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controller/meal_controller.dart';
import '../controller/auth_controller.dart';
import 'login_page.dart';

class MealPage extends ConsumerStatefulWidget {
  const MealPage({super.key});

  @override
  ConsumerState<MealPage> createState() => _MealPageState();
}

class _MealPageState extends ConsumerState<MealPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mealState = ref.watch(mealControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search for a meal (e.g., Arrabiata)',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      ref.read(searchQueryProvider.notifier).state = value;
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    ref.read(searchQueryProvider.notifier).state =
                        _searchController.text;
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: mealState.when(
              data: (meals) {
                if (meals.isEmpty) {
                  return const Center(child: Text('No meals found'));
                }
                return ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return Card(
                      child: ListTile(
                        leading: meal.strMealThumb.isNotEmpty
                            ? Image.network(
                                meal.strMealThumb,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 50),
                              )
                            : const Icon(Icons.image, size: 50),
                        title: Text(meal.strMeal),
                        subtitle: Text('${meal.strCategory} - ${meal.strArea}'),
                      ),
                    );
                  },
                );
              },
              error: (error, stack) => Center(child: Text('Error: $error')),
              loading: () => Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return const Card(
                      child: ListTile(
                        leading: Icon(Icons.image, size: 50),
                        title: Text('Meal Name Placeholder'),
                        subtitle: Text('Category - Area'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
