import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  static const _loginKey = 'isLoggedIn';

  static Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_loginKey) ?? false;
  }

  static Future<bool> saveLogin() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(_loginKey, true);
  }

  static Future<bool> clearLogin() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.remove(_loginKey);
  }
}
