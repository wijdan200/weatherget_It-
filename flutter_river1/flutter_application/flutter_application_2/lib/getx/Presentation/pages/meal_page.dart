import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/meal_controller.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  final MealController controller = Get.put(MealController());
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthController.instance.signOut();
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
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search for a meal (e.g., Arrabiata)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    controller.searchMeals(searchController.text);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              final isLoading = controller.isLoading.value;
              if (controller.errorMessage.isNotEmpty && !isLoading) {
                return Center(child: Text(controller.errorMessage.value));
              }

              if (controller.meals.isEmpty && !isLoading) {
                return const Center(child: Text('No meals found'));
              }

              return Skeletonizer(
                enabled: isLoading,
                child: ListView.builder(
                  itemCount: isLoading ? 6 : controller.meals.length,
                  itemBuilder: (context, index) {
                    if (isLoading) {
                      return const Card(
                        child: ListTile(
                          leading: Icon(Icons.image, size: 50),
                          title: Text('Meal Name Placeholder'),
                          subtitle: Text('Category - Area'),
                        ),
                      );
                    }
                    final meal = controller.meals[index];
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
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
