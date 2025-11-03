class Astronomy {
  String? moonIllumination;
  String? moonPhase;
  String? moonrise;
  String? moonset;
  String? sunrise;
  String? sunset;

  Astronomy(
      {this.moonIllumination,
      this.moonPhase,
      this.moonrise,
      this.moonset,
      this.sunrise,
      this.sunset});

  Astronomy.fromJson(Map<String, dynamic> json) {
    moonIllumination = json['moon_illumination'];
    moonPhase = json['moon_phase'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moon_illumination'] = this.moonIllumination;
    data['moon_phase'] = this.moonPhase;
    data['moonrise'] = this.moonrise;
    data['moonset'] = this.moonset;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}
