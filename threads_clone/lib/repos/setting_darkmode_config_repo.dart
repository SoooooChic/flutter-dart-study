import 'package:shared_preferences/shared_preferences.dart';

class SettingDarkmodeConfigRepo {
  static const String _darkMode = "darkmode";

  final SharedPreferences _preferences;

  SettingDarkmodeConfigRepo(this._preferences);

  Future<void> setDarkMode(bool value) async {
    _preferences.setBool(_darkMode, value);
  }

  bool isDarkMode() {
    return _preferences.getBool(_darkMode) ?? false;
  }
}
