
class WeatherIconUrl {
  final String value;

  WeatherIconUrl({required this.value});

  factory WeatherIconUrl.fromJson(Map<String, dynamic> json) {
    return WeatherIconUrl(
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}
