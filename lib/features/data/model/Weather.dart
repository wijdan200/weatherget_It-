import 'package:flutterweather/features/data/model/Astronomy.dart';
import 'package:flutterweather/features/data/model/Hourly%20.dart';
import 'package:flutterweather/features/domain/entities/weather.dart';

class WeatherModel extends Weather {
 List<Astronomy>? astronomy;
  String? avgtempC;
  String? avgtempF;
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
        astronomy!.add(new Astronomy.fromJson(v));
      });
    }
    avgtempC = json['avgtempC'];
    avgtempF = json['avgtempF'];
    date = json['date'];
    if (json['hourly'] != null) {
      hourly = <Hourly>[];
      json['hourly'].forEach((v) {
        hourly!.add(new Hourly.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.astronomy != null) {
      data['astronomy'] = this.astronomy!.map((v) => v.toJson()).toList();
    }
    data['avgtempC'] = this.avgtempC;
    data['avgtempF'] = this.avgtempF;
    data['date'] = this.date;
    if (this.hourly != null) {
      data['hourly'] = this.hourly!.map((v) => v.toJson()).toList();
    }
    data['maxtempC'] = this.maxtempC;
    data['maxtempF'] = this.maxtempF;
    data['mintempC'] = this.mintempC;
    data['mintempF'] = this.mintempF;
    data['sunHour'] = this.sunHour;
    data['totalSnow_cm'] = this.totalSnowCm;
    data['uvIndex'] = this.uvIndex;
    return data;
  }
}