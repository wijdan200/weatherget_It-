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
        areaName!.add(new AreaName.fromJson(v));
      });
    }
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(new Country.fromJson(v));
      });
    }
    latitude = json['latitude'];
    longitude = json['longitude'];
    population = json['population'];
    if (json['region'] != null) {
      region = <Region>[];
      json['region'].forEach((v) {
        region!.add(new Region.fromJson(v));
      });
    }
    if (json['weatherUrl'] != null) {
      weatherUrl = <WeatherUrl>[];
      json['weatherUrl'].forEach((v) {
        weatherUrl!.add(new WeatherUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.areaName != null) {
      data['areaName'] = this.areaName!.map((v) => v.toJson()).toList();
    }
    if (this.country != null) {
      data['country'] = this.country!.map((v) => v.toJson()).toList();
    }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['population'] = this.population;
    if (this.region != null) {
      data['region'] = this.region!.map((v) => v.toJson()).toList();
    }
    if (this.weatherUrl != null) {
      data['weatherUrl'] = this.weatherUrl!.map((v) => v.toJson()).toList();
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
