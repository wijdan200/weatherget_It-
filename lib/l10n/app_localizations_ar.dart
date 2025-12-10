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

  @override
  String get enable_notifications => 'تفعيل الإشعارات';

  @override
  String get notifications_permission_message =>
      'ابق على اطلاع بتنبيهات الطقس والإشعارات المهمة. هل ترغب في تفعيل الإشعارات؟';

  @override
  String get not_now => 'ليس الآن';

  @override
  String get enable => 'تفعيل';

  @override
  String get notifications_enabled_success => 'تم تفعيل الإشعارات بنجاح!';

  @override
  String get notifications_permission_denied =>
      'تم رفض إذن الإشعارات. يمكنك تفعيله لاحقًا من الإعدادات.';

  @override
  String get weather => 'الطقس';

  @override
  String get back_to_dashboard => 'العودة للرئيسية';

  @override
  String get refresh => 'تحديث';

  @override
  String get clear_all_cities => 'مسح جميع المدن';

  @override
  String get sign_out => 'تسجيل الخروج';

  @override
  String get exit_app => 'خروج';

  @override
  String get enter_city_name => 'أدخل اسم المدينة (مثل عمان، لندن، باريس)...';

  @override
  String cities_found(Object citiesCount, Object locationsCount) {
    return 'تم العثور على $citiesCount مدن • $locationsCount مواقع';
  }

  @override
  String city_found(Object citiesCount, Object locationsCount) {
    return 'تم العثور على $citiesCount مدينة • $locationsCount موقع';
  }

  @override
  String get no_weather_data => 'لا توجد بيانات طقس متاحة';

  @override
  String get no_results_found => 'لا توجد نتائج';

  @override
  String get weather_app => 'تطبيق الطقس';

  @override
  String get add_cities_message => 'أضف مدنًا لرؤية معلومات الطقس';

  @override
  String get loading_location => 'جاري تحميل اسم الموقع...';

  @override
  String get loading_date => 'جاري تحميل التاريخ...';

  @override
  String get loading_desc => 'جاري تحميل وصف الطقس...';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get oops => '!عفواً';

  @override
  String get toggle_language => 'تغيير اللغة';

  @override
  String get dashboard_title => 'لوحة التحكم';

  @override
  String get latest_updates => 'آخر التحديثات';

  @override
  String get go_to_weather => 'الذهاب للطقس';

  @override
  String get error_loading_data => 'خطأ في تحميل البيانات';

  @override
  String get skip_to_weather => 'تخطي للطقس';

  @override
  String get user_label => 'مستخدم';

  @override
  String get post_label => 'منشور #';

  @override
  String get back_to_weather => 'العودة للطقس';
}
