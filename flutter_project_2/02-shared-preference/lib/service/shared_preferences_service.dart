import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String _keyNotification = "MY_NOTIFICATION";

  Future<void> saveNotificationValue(bool value) async {
    try {
      await _preferences.setBool(_keyNotification, value);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  bool getNotificationValue() {
    return _preferences.getBool(_keyNotification) ?? false;
  }
}
