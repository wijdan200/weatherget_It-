import 'package:get/get.dart';
import '../../Domain/entities/meal_entity.dart';
import '../../Domain/usecases/get_meal_by_name.dart';
import '../../Data/repos/meal_repository_impl.dart';
import '../../Data/datasource/apiservice.dart';

class MealController extends GetxController {
  final GetMealByName getMealByName;
  MealController()
      : getMealByName = GetMealByName(MealRepositoryImpl(ApiService()));

  var meals = <MealEntity>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    searchMeals('');
  }

  void searchMeals(String query) async {
    try {
      isLoading(true);
      errorMessage('');
      var result = await getMealByName(query);
      meals.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
