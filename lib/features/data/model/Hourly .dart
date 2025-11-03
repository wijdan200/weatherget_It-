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
        weatherDesc!.add(new WeatherDesc.fromJson(v));
      });
    }
    if (json['weatherIconUrl'] != null) {
      weatherIconUrl = <WeatherIconUrl>[];
      json['weatherIconUrl'].forEach((v) {
        weatherIconUrl!.add(new WeatherIconUrl.fromJson(v));
      });
    }
    winddir16Point = json['winddir16Point'];
    winddirDegree = json['winddirDegree'];
    windspeedKmph = json['windspeedKmph'];
    windspeedMiles = json['windspeedMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DewPointC'] = this.dewPointC;
    data['DewPointF'] = this.dewPointF;
    data['FeelsLikeC'] = this.feelsLikeC;
    data['FeelsLikeF'] = this.feelsLikeF;
    data['HeatIndexC'] = this.heatIndexC;
    data['HeatIndexF'] = this.heatIndexF;
    data['WindChillC'] = this.windChillC;
    data['WindChillF'] = this.windChillF;
    data['WindGustKmph'] = this.windGustKmph;
    data['WindGustMiles'] = this.windGustMiles;
    data['chanceoffog'] = this.chanceoffog;
    data['chanceoffrost'] = this.chanceoffrost;
    data['chanceofhightemp'] = this.chanceofhightemp;
    data['chanceofovercast'] = this.chanceofovercast;
    data['chanceofrain'] = this.chanceofrain;
    data['chanceofremdry'] = this.chanceofremdry;
    data['chanceofsnow'] = this.chanceofsnow;
    data['chanceofsunshine'] = this.chanceofsunshine;
    data['chanceofthunder'] = this.chanceofthunder;
    data['chanceofwindy'] = this.chanceofwindy;
    data['cloudcover'] = this.cloudcover;
    data['diffRad'] = this.diffRad;
    data['humidity'] = this.humidity;
    data['precipInches'] = this.precipInches;
    data['precipMM'] = this.precipMM;
    data['pressure'] = this.pressure;
    data['pressureInches'] = this.pressureInches;
    data['shortRad'] = this.shortRad;
    data['tempC'] = this.tempC;
    data['tempF'] = this.tempF;
    data['time'] = this.time;
    data['uvIndex'] = this.uvIndex;
    data['visibility'] = this.visibility;
    data['visibilityMiles'] = this.visibilityMiles;
    data['weatherCode'] = this.weatherCode;
    if (this.weatherDesc != null) {
      data['weatherDesc'] = weatherDesc!.map((v) => v.toJson()).toList();
    }
    if (this.weatherIconUrl != null) {
      data['weatherIconUrl'] =
          this.weatherIconUrl!.map((v) => v.toJson()).toList();
    }
    data['winddir16Point'] = this.winddir16Point;
    data['winddirDegree'] = this.winddirDegree;
    data['windspeedKmph'] = this.windspeedKmph;
    data['windspeedMiles'] = this.windspeedMiles;
    return data;
  }
}