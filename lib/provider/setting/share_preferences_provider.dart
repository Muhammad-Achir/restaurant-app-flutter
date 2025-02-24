import 'package:flutter/foundation.dart';
import 'package:restaurant_app/service/shared_preferences_service.dart';

class SharePreferencesProvider extends ChangeNotifier{
  final SharedPreferencesService _service;

  SharePreferencesProvider(this._service);

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  bool _isLunchReminder = false;
  bool get isLunchReminder => _isLunchReminder;

  Future saveThemeValue(bool value)async{
    try {
      await _service.saveTheme(value);
      _isDarkMode = value;
    } catch (e) {
      throw Exception('Failed save theme $e');
    }
    notifyListeners();
  }

  getThemeValue(){
    try {
      _isDarkMode = _service.getTheme();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to get theme $e');
    }
  }

  Future saveLunchReminderValue(bool value)async{
    try {
      await _service.saveLunchReminder(value);
      _isLunchReminder = value;
    } catch (e) {
      throw Exception('Failed save theme $e');
    }
    notifyListeners();
  }

  getLunchReminder(){
    try {
      _isLunchReminder = _service.getLunchReminder();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to get theme $e');
    }
  }
}