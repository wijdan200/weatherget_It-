// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Flutter Weather';

  @override
  String get welcome_message => 'Welcome to Flutter Weather App';

  @override
  String get change_language => 'Change Language';

  @override
  String get current_weather => 'Current Weather';

  @override
  String get temperature => 'Temperature';

  @override
  String get humidity => 'Humidity';

  @override
  String get wind_speed => 'Wind Speed';

  @override
  String get forecast => 'Forecast';

  @override
  String get settings => 'Settings';

  @override
  String get language_selection => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get enable_notifications => 'Enable Notifications';

  @override
  String get notifications_permission_message =>
      'Stay updated with weather alerts and important notifications. Would you like to enable notifications?';

  @override
  String get not_now => 'Not Now';

  @override
  String get enable => 'Enable';

  @override
  String get notifications_enabled_success =>
      'Notifications enabled successfully!';

  @override
  String get notifications_permission_denied =>
      'Notification permission denied. You can enable it later in settings.';

  @override
  String get weather => 'Weather';

  @override
  String get back_to_dashboard => 'Back to Dashboard';

  @override
  String get refresh => 'Refresh';

  @override
  String get clear_all_cities => 'Clear all cities';

  @override
  String get sign_out => 'Sign Out';

  @override
  String get exit_app => 'Exit App';

  @override
  String get enter_city_name =>
      'Enter city name (e.g., Amman, London, Paris)...';

  @override
  String cities_found(Object citiesCount, Object locationsCount) {
    return '$citiesCount cities • $locationsCount locations found';
  }

  @override
  String city_found(Object citiesCount, Object locationsCount) {
    return '$citiesCount city • $locationsCount location found';
  }

  @override
  String get no_weather_data => 'No weather data available';

  @override
  String get no_results_found => 'No results found';

  @override
  String get weather_app => 'Weather App';

  @override
  String get add_cities_message => 'Add cities to see weather information';

  @override
  String get loading_location => 'Loading Location Name...';

  @override
  String get loading_date => 'Loading Date...';

  @override
  String get loading_desc => 'Loading Weather Description...';

  @override
  String get retry => 'Retry';

  @override
  String get oops => 'Oops!';

  @override
  String get toggle_language => 'Toggle Language';

  @override
  String get dashboard_title => 'Dashboard';

  @override
  String get latest_updates => 'Latest Updates';

  @override
  String get go_to_weather => 'Go to Weather';

  @override
  String get error_loading_data => 'Error Loading Data';

  @override
  String get skip_to_weather => 'Skip to Weather';

  @override
  String get user_label => 'User';

  @override
  String get post_label => 'Post #';

  @override
  String get back_to_weather => 'Back to Weather';
}
