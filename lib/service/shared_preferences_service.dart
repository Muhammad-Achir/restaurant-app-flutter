import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String keyTheme = 'THEME';
  static const String keyLunchReminder = 'REMINDER_LUNCH';

  Future saveTheme(bool value) async {
    try {
      await _preferences.setBool(keyTheme, value);
    } catch (e) {
      throw Exception('Cannot save theme');
    }
  }

  bool getTheme() {
    return _preferences.getBool(keyTheme) ?? false;
  }

  Future saveLunchReminder(bool value) async {
    try {
      await _preferences.setBool(keyLunchReminder, value);
    } catch (e) {
      throw Exception('Cannot save theme');
    }
  }

  bool getLunchReminder() {
    return _preferences.getBool(keyLunchReminder) ?? false;
  }
}
