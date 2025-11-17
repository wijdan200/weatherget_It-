
import 'package:flutterweather/features/data/model/weatherDes.dart';
import 'package:flutterweather/features/data/model/weathericon.dart';

class CurrentCondition {
  String? feelsLikeC;
  String? feelsLikeF;
  String? cloudcover;
  String? humidity;
  String? localObsDateTime;
  String? observationTime;
  String? precipInches;
  String? precipMM;
  String? pressure;
  String? pressureInches;
  String? tempC;
  String? tempF;
  String? uvIndex;
  String? visibility;
  String? visibilityMiles;
  String? weatherCode;
  List<WeatherDesc>? weatherDesc;
  List<WeatherIconUrl>? weatherIconUrl;
  String? winddir16Point;
  String? winddirDegree;
  String? windspeedKmph;
  String? windspeedMiles;

  CurrentCondition(
      {this.feelsLikeC,
      this.feelsLikeF,
      this.cloudcover,
      this.humidity,
      this.localObsDateTime,
      this.observationTime,
      this.precipInches,
      this.precipMM,
      this.pressure,
      this.pressureInches,
      this.tempC,
      this.tempF,
      this.uvIndex,
      this.visibility,
      this.visibilityMiles,
      this.weatherCode,
      this.weatherDesc,
      this.weatherIconUrl,
      this.winddir16Point,
      this.winddirDegree,
      this.windspeedKmph,
      this.windspeedMiles});

  CurrentCondition.fromJson(Map<String, dynamic> json) {
    feelsLikeC = json['FeelsLikeC'];
    feelsLikeF = json['FeelsLikeF'];
    cloudcover = json['cloudcover'];
    humidity = json['humidity'];
    localObsDateTime = json['localObsDateTime'];
    observationTime = json['observation_time'];
    precipInches = json['precipInches'];
    precipMM = json['precipMM'];
    pressure = json['pressure'];
    pressureInches = json['pressureInches'];
    tempC = json['temp_C'];
    tempF = json['temp_F'];
    uvIndex = json['uvIndex'];
    visibility = json['visibility'];
    visibilityMiles = json['visibilityMiles'];
    weatherCode = json['weatherCode'];
    if (json['weatherDesc'] != null) {
      weatherDesc = <WeatherDesc>[];
      json['weatherDesc'].forEach((v) {
        weatherDesc!.add(WeatherDesc.fromJson(v));
      });
    }
    if (json['weatherIconUrl'] != null) {
      weatherIconUrl = <WeatherIconUrl>[];
      json['weatherIconUrl'].forEach((v) {
        weatherIconUrl!.add(WeatherIconUrl.fromJson(v));
      });
    }
    winddir16Point = json['winddir16Point'];
    winddirDegree = json['winddirDegree'];
    windspeedKmph = json['windspeedKmph'];
    windspeedMiles = json['windspeedMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FeelsLikeC'] = feelsLikeC;
    data['FeelsLikeF'] = feelsLikeF;
    data['cloudcover'] = cloudcover;
    data['humidity'] = humidity;
    data['localObsDateTime'] = localObsDateTime;
    data['observation_time'] = observationTime;
    data['precipInches'] = precipInches;
    data['precipMM'] = precipMM;
    data['pressure'] = pressure;
    data['pressureInches'] = pressureInches;
    data['temp_C'] = tempC;
    data['temp_F'] = tempF;
    data['uvIndex'] = uvIndex;
    data['visibility'] = visibility;
    data['visibilityMiles'] = visibilityMiles;
    data['weatherCode'] = weatherCode;
    if (weatherDesc != null) {
      data['weatherDesc'] = weatherDesc!.map((v) => v.toJson()).toList();
    }
    if (weatherIconUrl != null) {
      data['weatherIconUrl'] =
          weatherIconUrl!.map((v) => v.toJson()).toList();
    }
    data['winddir16Point'] = winddir16Point;
    data['winddirDegree'] = winddirDegree;
    data['windspeedKmph'] = windspeedKmph;
    data['windspeedMiles'] = windspeedMiles;
    return data;
  }
}
