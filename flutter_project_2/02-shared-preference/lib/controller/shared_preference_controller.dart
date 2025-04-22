import 'package:flutter/widgets.dart';
import 'package:shared_preferences_app/service/shared_preferences_service.dart';

class SharedPreferenceController extends ChangeNotifier {
  final SharedPreferencesService _service;
  SharedPreferenceController(this._service);

  NotificationState _state = NotificationLoaded(false);
  NotificationState get state => _state;

  void setValue(bool value) async {
    try {
      _emit(NotificationLoaded(value));
      await _service.saveNotificationValue(value);
    } catch (e) {
      _emit(NotificationError(e.toString()));
    }
  }

  void getValue() {
    try {
      final result = _service.getNotificationValue();
      _emit(NotificationLoaded(result));
    } catch (e) {
      _emit(NotificationError(e.toString()));
    }
  }

  void _emit(NotificationState value) {
    _state = value;
    notifyListeners();
  }
}

sealed class NotificationState {}

class NotificationLoaded extends NotificationState {
  final bool value;

  NotificationLoaded(this.value);
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}
