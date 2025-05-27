import 'package:flutter/widgets.dart';
import 'package:ui_error_app/model/exceptions.dart';
import 'package:ui_error_app/model/tourism.dart';
import 'package:ui_error_app/service/database_service.dart';

class DatabaseController extends ChangeNotifier {
  final DatabaseService _service;

  DatabaseController(this._service);

  DatabaseState _state = DatabaseNone();

  DatabaseState get state => _state;

  void save(Place place) async {
    try {
      _emit(DatabaseLoading());

      await _service.insertItem(place);
      await loadAllData();
    } on AppException catch (e) {
      _emit(DatabaseError(e.message));
    }
  }

  void removeById(int id) async {
    try {
      _emit(DatabaseLoading());

      await _service.removeItem(id);
      await loadAllData();
    } on AppException catch (e) {
      _emit(DatabaseError(e.message));
    }
  }

  Future<void> getById(int id) async {
    try {
      _emit(DatabaseLoading());

      final result = await _service.getItemById(id);
      _emit(DatabaseSingleLoaded(result));
    } on AppException catch (e) {
      _emit(DatabaseError(e.message));
    }
  }

  Future<void> loadAllData() async {
    try {
      final result = await _service.getAllItems();
      _emit(DatabaseLoaded(result));
    } on AppException {
      rethrow;
    }
  }

  void _emit(DatabaseState value) {
    _state = value;
    notifyListeners();
  }
}

sealed class DatabaseState {}

class DatabaseNone extends DatabaseState {}

class DatabaseLoading implements DatabaseState {}

class DatabaseLoaded extends DatabaseState {
  final List<Place> places;

  DatabaseLoaded(this.places);
}

class DatabaseSingleLoaded extends DatabaseState {
  final Place? place;

  DatabaseSingleLoaded(this.place);

  bool get isFavorite => place != null;
}

class DatabaseError extends DatabaseState {
  final String message;

  DatabaseError(this.message);
}
