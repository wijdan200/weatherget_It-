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

class AppPausedEvent extends WeatherEvent {}

class AppResumedEvent extends WeatherEvent {}

class SkeletonHoverEvent extends WeatherEvent {
  final int index;
  final bool isHovered;
  SkeletonHoverEvent(this.index, this.isHovered);
}
