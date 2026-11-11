import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _loginKey = 'isLoggedIn';
  static const _usernameKey = 'username';

  static Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_loginKey) ?? false;
  }

  static Future<bool> saveLogin(String username) async {
    final preferences = await SharedPreferences.getInstance();
    final savedUsername = await preferences.setString(_usernameKey, username);
    if (!savedUsername) return false;
    return preferences.setBool(_loginKey, true);
  }

  static Future<String?> getUsername() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_usernameKey);
  }

  static Future<bool> clearLogin() async {
    final preferences = await SharedPreferences.getInstance();
    final clearedLogin = await preferences.remove(_loginKey);
    final clearedUsername = await preferences.remove(_usernameKey);
    return clearedLogin && clearedUsername;
  }
}
