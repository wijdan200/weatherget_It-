
import 'package:flutterweather/features/data/datasource/weather_remote.dart';
import 'package:flutterweather/features/data/repository/WeatherRepositoryImpl.dart';
import 'package:flutterweather/features/domain/repository/repo.dart';
import 'package:flutterweather/features/presentation/bloc/weatherbloc.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;
void setup(){
  getIt.registerFactory<WeatherRemoteDataSource>(
    ()=>WeatherRemoteDataSource(),
  );
  
 
  getIt.registerFactory<WeatherRepository>(
    ()=>WeatherRepositoryImpl(getIt<WeatherRemoteDataSource>()),
  );
  

  getIt.registerFactory<WeatherBloc>(
    ()=>WeatherBloc(getIt<WeatherRepository>()),
  );
}

