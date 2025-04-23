import 'package:database_app/model/user.dart';
import 'package:database_app/service/database_service.dart';
import 'package:flutter/widgets.dart';

class DatabaseController extends ChangeNotifier {
  final DatabaseService _service;

  DatabaseController(this._service);

  DatabaseState _state = DatabaseNone();

  DatabaseState get state => _state;

  void save(User user) async {
    try {
      _emit(DatabaseLoading());

      await _service.insertItem(user);
      await loadAllData();
    } catch (e) {
      _emit(DatabaseError(e.toString()));
    }
  }

  void removeById(int id) async {
    try {
      _emit(DatabaseLoading());

      await _service.removeItem(id);
      await loadAllData();
    } catch (e) {
      _emit(DatabaseError(e.toString()));
    }
  }

  void getById(int id) async {
    try {
      _emit(DatabaseLoading());

      final result = await _service.getItemById(id);
      _emit(DatabaseSingleLoaded(result));
    } catch (e) {
      _emit(DatabaseError(e.toString()));
    }
  }

  void update(int id, User user) async {
    try {
      _emit(DatabaseLoading());

      await _service.updateItem(id, user);
      await loadAllData();
    } catch (e) {
      _emit(DatabaseError(e.toString()));
    }
  }

  Future<void> loadAllData() async {
    try {
      final result = await _service.getAllItems();
      _emit(DatabaseLoaded(result));
    } catch (e) {
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
  final List<User> value;

  DatabaseLoaded(this.value);
}

class DatabaseSingleLoaded extends DatabaseState {
  final User value;

  DatabaseSingleLoaded(this.value);
}

class DatabaseError extends DatabaseState {
  final String message;

  DatabaseError(this.message);
}
