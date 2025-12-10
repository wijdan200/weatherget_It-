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
}
