import 'package:flutter/widgets.dart';
import 'package:ui_error_app/model/exceptions.dart';
import 'package:ui_error_app/service/shared_preference_service.dart';

class SettingController extends ChangeNotifier {
  final SharedPreferenceService _sharedPreferenceService;

  SettingController(this._sharedPreferenceService);

  ThemeValue _themeValue = ThemeValue.light;

  ThemeValue get themeValue => _themeValue;

  void loadSetting() async {
    try {
      final result = _sharedPreferenceService.getSettingValue();
      _emit(result ? ThemeValue.light : ThemeValue.dark);
    } on AppException {
      //
    }
  }

  void saveSetting() async {
    try {
      final result = !_themeValue.isLight;
      await _sharedPreferenceService.saveSettingValue(result);
      _emit(result ? ThemeValue.light : ThemeValue.dark);
    } on AppException {
      //
    }
  }

  void _emit(ThemeValue state) {
    _themeValue = state;
    notifyListeners();
  }
}

enum ThemeValue {
  light,
  dark;

  bool get isLight => this == ThemeValue.light;
}
