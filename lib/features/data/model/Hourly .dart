import 'package:flutterweather/features/data/model/weatherDes.dart';
import 'package:flutterweather/features/data/model/weathericon.dart';

class Hourly {
  String? dewPointC;
  String? dewPointF;
  String? feelsLikeC;
  String? feelsLikeF;
  String? heatIndexC;
  String? heatIndexF;
  String? windChillC;
  String? windChillF;
  String? windGustKmph;
  String? windGustMiles;
  String? chanceoffog;
  String? chanceoffrost;
  String? chanceofhightemp;
  String? chanceofovercast;
  String? chanceofrain;
  String? chanceofremdry;
  String? chanceofsnow;
  String? chanceofsunshine;
  String? chanceofthunder;
  String? chanceofwindy;
  String? cloudcover;
  String? diffRad;
  String? humidity;
  String? precipInches;
  String? precipMM;
  String? pressure;
  String? pressureInches;
  String? shortRad;
  String? tempC;
  String? tempF;
  String? time;
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

  Hourly(
      {this.dewPointC,
      this.dewPointF,
      this.feelsLikeC,
      this.feelsLikeF,
      this.heatIndexC,
      this.heatIndexF,
      this.windChillC,
      this.windChillF,
      this.windGustKmph,
      this.windGustMiles,
      this.chanceoffog,
      this.chanceoffrost,
      this.chanceofhightemp,
      this.chanceofovercast,
      this.chanceofrain,
      this.chanceofremdry,
      this.chanceofsnow,
      this.chanceofsunshine,
      this.chanceofthunder,
      this.chanceofwindy,
      this.cloudcover,
      this.diffRad,
      this.humidity,
      this.precipInches,
      this.precipMM,
      this.pressure,
      this.pressureInches,
      this.shortRad,
      this.tempC,
      this.tempF,
      this.time,
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

  Hourly.fromJson(Map<String, dynamic> json) {
    dewPointC = json['DewPointC'];
    dewPointF = json['DewPointF'];
    feelsLikeC = json['FeelsLikeC'];
    feelsLikeF = json['FeelsLikeF'];
    heatIndexC = json['HeatIndexC'];
    heatIndexF = json['HeatIndexF'];
    windChillC = json['WindChillC'];
    windChillF = json['WindChillF'];
    windGustKmph = json['WindGustKmph'];
    windGustMiles = json['WindGustMiles'];
    chanceoffog = json['chanceoffog'];
    chanceoffrost = json['chanceoffrost'];
    chanceofhightemp = json['chanceofhightemp'];
    chanceofovercast = json['chanceofovercast'];
    chanceofrain = json['chanceofrain'];
    chanceofremdry = json['chanceofremdry'];
    chanceofsnow = json['chanceofsnow'];
    chanceofsunshine = json['chanceofsunshine'];
    chanceofthunder = json['chanceofthunder'];
    chanceofwindy = json['chanceofwindy'];
    cloudcover = json['cloudcover'];
    diffRad = json['diffRad'];
    humidity = json['humidity'];
    precipInches = json['precipInches'];
    precipMM = json['precipMM'];
    pressure = json['pressure'];
    pressureInches = json['pressureInches'];
    shortRad = json['shortRad'];
    tempC = json['tempC'];
    tempF = json['tempF'];
    time = json['time'];
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
    data['DewPointC'] = dewPointC;
    data['DewPointF'] = dewPointF;
    data['FeelsLikeC'] = feelsLikeC;
    data['FeelsLikeF'] = feelsLikeF;
    data['HeatIndexC'] = heatIndexC;
    data['HeatIndexF'] = heatIndexF;
    data['WindChillC'] = windChillC;
    data['WindChillF'] = windChillF;
    data['WindGustKmph'] = windGustKmph;
    data['WindGustMiles'] = windGustMiles;
    data['chanceoffog'] = chanceoffog;
    data['chanceoffrost'] = chanceoffrost;
    data['chanceofhightemp'] = chanceofhightemp;
    data['chanceofovercast'] = chanceofovercast;
    data['chanceofrain'] = chanceofrain;
    data['chanceofremdry'] = chanceofremdry;
    data['chanceofsnow'] = chanceofsnow;
    data['chanceofsunshine'] = chanceofsunshine;
    data['chanceofthunder'] = chanceofthunder;
    data['chanceofwindy'] = chanceofwindy;
    data['cloudcover'] = cloudcover;
    data['diffRad'] = diffRad;
    data['humidity'] = humidity;
    data['precipInches'] = precipInches;
    data['precipMM'] = precipMM;
    data['pressure'] = pressure;
    data['pressureInches'] = pressureInches;
    data['shortRad'] = shortRad;
    data['tempC'] = tempC;
    data['tempF'] = tempF;
    data['time'] = time;
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