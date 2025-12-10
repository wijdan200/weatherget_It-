import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/meal_remote_datasource.dart';
import 'data/repositories/meal_repository_impl.dart';
import 'domain/repositories/meal_repository.dart';
import 'domain/usecases/get_meals.dart';
import 'presentation/cubit/meal_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => MealCubit(getMeals: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetMeals(sl()));

  // Repository
  sl.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MealRemoteDataSource>(
    () => MealRemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
