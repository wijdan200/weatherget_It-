import 'package:flutterweather/features/data/datasource/auth_service.dart';
import 'package:flutterweather/features/data/datasource/auth_preferences_service.dart';
import 'package:flutterweather/features/data/datasource/firebase_messaging_service.dart';
import 'package:flutterweather/features/data/datasource/weather_remote.dart';
import 'package:flutterweather/features/data/datasource/dashboard_remote.dart';
import 'package:flutterweather/features/data/repository/WeatherRepositoryImpl.dart';
import 'package:flutterweather/features/data/repository/DashboardRepositoryImpl.dart';
import 'package:flutterweather/features/domain/repository/repo.dart';
import 'package:flutterweather/features/domain/repository/dashboard_repo.dart';
import 'package:flutterweather/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutterweather/features/presentation/bloc/weatherbloc.dart';
import 'package:flutterweather/features/presentation/dashboard/dashboard_bloc.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;
void setup(){
 
  // Register AuthPreferencesService
  getIt.registerLazySingleton<AuthPreferencesService>(
    ()=>AuthPreferencesService(),
  );
 
  // Register AuthService with AuthPreferencesService dependency
  getIt.registerLazySingleton<AuthService>(
    ()=>AuthService(getIt<AuthPreferencesService>()),
  );

  // Register Firebase Messaging Service
  getIt.registerLazySingleton<FirebaseMessagingService>(
    ()=>FirebaseMessagingService(),
  );
 
  getIt.registerFactory<AuthBloc>(
    ()=>AuthBloc(getIt<AuthService>()),
  );
 
  getIt.registerFactory<WeatherRemoteDataSource>(
    ()=>WeatherRemoteDataSource(),
  );
 
  getIt.registerFactory<WeatherRepository>(
    ()=>WeatherRepositoryImpl(getIt<WeatherRemoteDataSource>()),
  );
 
  getIt.registerFactory<WeatherBloc>(
    ()=>WeatherBloc(getIt<WeatherRepository>()),
  );

  // Register Dashboard dependencies
  getIt.registerFactory<DashboardRemoteDataSource>(
    ()=>DashboardRemoteDataSource(),
  );

  getIt.registerFactory<DashboardRepository>(
    ()=>DashboardRepositoryImpl(getIt<DashboardRemoteDataSource>()),
  );

  getIt.registerFactory<DashboardBloc>(
    ()=>DashboardBloc(getIt<DashboardRepository>()),
  );

}

