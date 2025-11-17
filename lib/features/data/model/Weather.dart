import 'package:flutterweather/features/data/model/Astronomy.dart';
import 'package:flutterweather/features/data/model/Hourly%20.dart';
import 'package:flutterweather/features/domain/entities/weather.dart';

class WeatherModel extends Weather {
 List<Astronomy>? astronomy;
  @override
  String? avgtempC;
  String? avgtempF;
  @override
  String? date;
  List<Hourly>? hourly;
  String? maxtempC;
  String? maxtempF;
  String? mintempC;
  String? mintempF;
  String? sunHour;
  String? totalSnowCm;
  String? uvIndex;

  WeatherModel(
      {this.astronomy,
      this.avgtempC,
      this.avgtempF,
      this.date,
      this.hourly,
      this.maxtempC,
      this.maxtempF,
      this.mintempC,
      this.mintempF,
      this.sunHour,
      this.totalSnowCm,
      this.uvIndex});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['astronomy'] != null) {
      astronomy = <Astronomy>[];
      json['astronomy'].forEach((v) {
        astronomy!.add(Astronomy.fromJson(v));
      });
    }
    avgtempC = json['avgtempC'];
    avgtempF = json['avgtempF'];
    date = json['date'];
    if (json['hourly'] != null) {
      hourly = <Hourly>[];
      json['hourly'].forEach((v) {
        hourly!.add(Hourly.fromJson(v));
      });
    }
    maxtempC = json['maxtempC'];
    maxtempF = json['maxtempF'];
    mintempC = json['mintempC'];
    mintempF = json['mintempF'];
    sunHour = json['sunHour'];
    totalSnowCm = json['totalSnow_cm'];
    uvIndex = json['uvIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (astronomy != null) {
      data['astronomy'] = astronomy!.map((v) => v.toJson()).toList();
    }
    data['avgtempC'] = avgtempC;
    data['avgtempF'] = avgtempF;
    data['date'] = date;
    if (hourly != null) {
      data['hourly'] = hourly!.map((v) => v.toJson()).toList();
    }
    data['maxtempC'] = maxtempC;
    data['maxtempF'] = maxtempF;
    data['mintempC'] = mintempC;
    data['mintempF'] = mintempF;
    data['sunHour'] = sunHour;
    data['totalSnow_cm'] = totalSnowCm;
    data['uvIndex'] = uvIndex;
    return data;
  }
}