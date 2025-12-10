// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get app_title => 'الطقس ';

  @override
  String get welcome_message => 'مرحبا بك في تطبيق الطقس';

  @override
  String get change_language => 'تغيير اللغة';

  @override
  String get current_weather => 'الطقس الحالي';

  @override
  String get temperature => 'درجة الحرارة';

  @override
  String get humidity => 'رطوبة';

  @override
  String get wind_speed => 'سرعة الرياح';

  @override
  String get forecast => 'التنبؤ';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language_selection => 'اختيار اللغة';

  @override
  String get english => 'اللغة الإنجليزية';

  @override
  String get arabic => 'اللغة العربية';
}
