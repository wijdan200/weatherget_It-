import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Flutter Weather'**
  String get app_title;

  /// No description provided for @welcome_message.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Flutter Weather App'**
  String get welcome_message;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language;

  /// No description provided for @current_weather.
  ///
  /// In en, this message translates to:
  /// **'Current Weather'**
  String get current_weather;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @wind_speed.
  ///
  /// In en, this message translates to:
  /// **'Wind Speed'**
  String get wind_speed;

  /// No description provided for @forecast.
  ///
  /// In en, this message translates to:
  /// **'Forecast'**
  String get forecast;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language_selection.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get language_selection;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @enable_notifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enable_notifications;

  /// No description provided for @notifications_permission_message.
  ///
  /// In en, this message translates to:
  /// **'Stay updated with weather alerts and important notifications. Would you like to enable notifications?'**
  String get notifications_permission_message;

  /// No description provided for @not_now.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get not_now;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @notifications_enabled_success.
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled successfully!'**
  String get notifications_enabled_success;

  /// No description provided for @notifications_permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission denied. You can enable it later in settings.'**
  String get notifications_permission_denied;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @back_to_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Back to Dashboard'**
  String get back_to_dashboard;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @clear_all_cities.
  ///
  /// In en, this message translates to:
  /// **'Clear all cities'**
  String get clear_all_cities;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out;

  /// No description provided for @exit_app.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exit_app;

  /// No description provided for @enter_city_name.
  ///
  /// In en, this message translates to:
  /// **'Enter city name (e.g., Amman, London, Paris)...'**
  String get enter_city_name;

  /// No description provided for @cities_found.
  ///
  /// In en, this message translates to:
  /// **'{citiesCount} cities • {locationsCount} locations found'**
  String cities_found(Object citiesCount, Object locationsCount);

  /// No description provided for @city_found.
  ///
  /// In en, this message translates to:
  /// **'{citiesCount} city • {locationsCount} location found'**
  String city_found(Object citiesCount, Object locationsCount);

  /// No description provided for @no_weather_data.
  ///
  /// In en, this message translates to:
  /// **'No weather data available'**
  String get no_weather_data;

  /// No description provided for @no_results_found.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get no_results_found;

  /// No description provided for @weather_app.
  ///
  /// In en, this message translates to:
  /// **'Weather App'**
  String get weather_app;

  /// No description provided for @add_cities_message.
  ///
  /// In en, this message translates to:
  /// **'Add cities to see weather information'**
  String get add_cities_message;

  /// No description provided for @loading_location.
  ///
  /// In en, this message translates to:
  /// **'Loading Location Name...'**
  String get loading_location;

  /// No description provided for @loading_date.
  ///
  /// In en, this message translates to:
  /// **'Loading Date...'**
  String get loading_date;

  /// No description provided for @loading_desc.
  ///
  /// In en, this message translates to:
  /// **'Loading Weather Description...'**
  String get loading_desc;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get oops;

  /// No description provided for @toggle_language.
  ///
  /// In en, this message translates to:
  /// **'Toggle Language'**
  String get toggle_language;

  /// No description provided for @dashboard_title.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard_title;

  /// No description provided for @latest_updates.
  ///
  /// In en, this message translates to:
  /// **'Latest Updates'**
  String get latest_updates;

  /// No description provided for @go_to_weather.
  ///
  /// In en, this message translates to:
  /// **'Go to Weather'**
  String get go_to_weather;

  /// No description provided for @error_loading_data.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Data'**
  String get error_loading_data;

  /// No description provided for @skip_to_weather.
  ///
  /// In en, this message translates to:
  /// **'Skip to Weather'**
  String get skip_to_weather;

  /// No description provided for @user_label.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user_label;

  /// No description provided for @post_label.
  ///
  /// In en, this message translates to:
  /// **'Post #'**
  String get post_label;

  /// No description provided for @back_to_weather.
  ///
  /// In en, this message translates to:
  /// **'Back to Weather'**
  String get back_to_weather;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
