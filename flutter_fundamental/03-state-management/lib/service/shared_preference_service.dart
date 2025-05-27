import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_error_app/model/exceptions.dart';

class SharedPreferenceService {
  static SharedPreferenceService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferenceService._();

  static const String _settingKey = "SETTING_KEY";

  // Using a singleton pattern
  static Future<SharedPreferenceService> getInstance() async {
    _instance ??= SharedPreferenceService._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  Future<bool> saveSettingValue(bool setting) async {
    try {
      return await _preferences.setBool(_settingKey, setting);
    } catch (e) {
      throw AppException("Shared preferences cannot save the setting value.");
    }
  }

  bool getSettingValue() {
    try {
      return _preferences.getBool(_settingKey) ?? false;
    } catch (e) {
      throw AppException("Shared preferences cannot save the setting value.");
    }
  }
}
