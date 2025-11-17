class NearestArea {
  List<AreaName>? areaName;
  List<Country>? country;
  String? latitude;
  String? longitude;
  String? population;
  List<Region>? region;
  List<WeatherUrl>? weatherUrl;

  NearestArea(
      {this.areaName,
      this.country,
      this.latitude,
      this.longitude,
      this.population,
      this.region,
      this.weatherUrl});

  NearestArea.fromJson(Map<String, dynamic> json) {
    if (json['areaName'] != null) {
      areaName = <AreaName>[];
      json['areaName'].forEach((v) {
        areaName!.add(AreaName.fromJson(v));
      });
    }
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(Country.fromJson(v));
      });
    }
    latitude = json['latitude'];
    longitude = json['longitude'];
    population = json['population'];
    if (json['region'] != null) {
      region = <Region>[];
      json['region'].forEach((v) {
        region!.add(Region.fromJson(v));
      });
    }
    if (json['weatherUrl'] != null) {
      weatherUrl = <WeatherUrl>[];
      json['weatherUrl'].forEach((v) {
        weatherUrl!.add(WeatherUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (areaName != null) {
      data['areaName'] = areaName!.map((v) => v.toJson()).toList();
    }
    if (country != null) {
      data['country'] = country!.map((v) => v.toJson()).toList();
    }
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['population'] = population;
    if (region != null) {
      data['region'] = region!.map((v) => v.toJson()).toList();
    }
    if (weatherUrl != null) {
      data['weatherUrl'] = weatherUrl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class AreaName {
  final String? value;
  AreaName({this.value});

  factory AreaName.fromJson(Map<String, dynamic> json) =>
      AreaName(value: json['value']);

  Map<String, dynamic> toJson() => {'value': value};
}

class Country {
  final String? value;
  Country({this.value});

  factory Country.fromJson(Map<String, dynamic> json) =>
      Country(value: json['value']);

  Map<String, dynamic> toJson() => {'value': value};
}

class Region {
  final String? value;
  Region({this.value});

  factory Region.fromJson(Map<String, dynamic> json) =>
      Region(value: json['value']);

  Map<String, dynamic> toJson() => {'value': value};
}

class WeatherUrl {
  final String? value;
  WeatherUrl({this.value});

  factory WeatherUrl.fromJson(Map<String, dynamic> json) =>
      WeatherUrl(value: json['value']);

  Map<String, dynamic> toJson() => {'value': value};
}
