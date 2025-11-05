import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferencesService {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserId = 'user_id';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserName = 'user_name';
  static const String _keyUserPhotoUrl = 'user_photo_url';
  static const String _keyAuthProvider = 'auth_provider';
  static const String _keyLastLoginTime = 'last_login_time';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  // Save authentication state
  Future<void> saveAuthState({
    required String userId,
    required String email,
    String? name,
    String? photoUrl,
    String? authProvider,
  }) async {
    final prefs = await _prefs;
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyUserEmail, email);
    if (name != null) await prefs.setString(_keyUserName, name);
    if (photoUrl != null) await prefs.setString(_keyUserPhotoUrl, photoUrl);
    if (authProvider != null) await prefs.setString(_keyAuthProvider, authProvider);
    await prefs.setString(_keyLastLoginTime, DateTime.now().toIso8601String());
  }

  // Clear authentication state
  Future<void> clearAuthState() async {
    final prefs = await _prefs;
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserPhotoUrl);
    await prefs.remove(_keyAuthProvider);
    await prefs.remove(_keyLastLoginTime);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await _prefs;
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Get user ID
  Future<String?> getUserId() async {
    final prefs = await _prefs;
    return prefs.getString(_keyUserId);
  }

  // Get user email
  Future<String?> getUserEmail() async {
    final prefs = await _prefs;
    return prefs.getString(_keyUserEmail);
  }

  // Get user name
  Future<String?> getUserName() async {
    final prefs = await _prefs;
    return prefs.getString(_keyUserName);
  }

  // Get user photo URL
  Future<String?> getUserPhotoUrl() async {
    final prefs = await _prefs;
    return prefs.getString(_keyUserPhotoUrl);
  }

  // Get auth provider
  Future<String?> getAuthProvider() async {
    final prefs = await _prefs;
    return prefs.getString(_keyAuthProvider);
  }

  // Get last login time
  Future<DateTime?> getLastLoginTime() async {
    final prefs = await _prefs;
    final timeString = prefs.getString(_keyLastLoginTime);
    if (timeString != null) {
      return DateTime.parse(timeString);
    }
    return null;
  }

  // Get all auth data
  Future<Map<String, dynamic>> getAuthData() async {
    final prefs = await _prefs;
    return {
      'isLoggedIn': prefs.getBool(_keyIsLoggedIn) ?? false,
      'userId': prefs.getString(_keyUserId),
      'email': prefs.getString(_keyUserEmail),
      'name': prefs.getString(_keyUserName),
      'photoUrl': prefs.getString(_keyUserPhotoUrl),
      'authProvider': prefs.getString(_keyAuthProvider),
      'lastLoginTime': prefs.getString(_keyLastLoginTime),
    };
  }
}

