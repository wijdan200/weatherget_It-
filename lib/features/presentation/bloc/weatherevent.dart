abstract class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {
  final String? location;
  FetchWeatherEvent({this.location});
}

class ClearCitiesEvent extends WeatherEvent {}

class SearchQueryChangedEvent extends WeatherEvent {
  final String query;
  SearchQueryChangedEvent(this.query);
}
