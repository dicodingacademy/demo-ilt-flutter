import 'package:flutter/widgets.dart';
import 'package:networking_app/model/users.dart';
import 'package:networking_app/service/http_service.dart';

class HttpController extends ChangeNotifier {
  final HttpServices client;
  HttpController(this.client);

  GetUsersResult _result = GetUsersNothing();
  GetUsersResult get result => _result;

  Future<void> getUsers() async {
    _emit(GetUsersLoading());

    try {
      final result = await client.getUsers();
      _emit(GetUsersLoaded(result));
    } catch (e) {
      _emit(GetUsersError(e.toString()));
    }
  }

  void _emit(GetUsersResult state) {
    _result = state;
    notifyListeners();
  }
}

sealed class GetUsersResult {}

final class GetUsersNothing extends GetUsersResult {}

final class GetUsersLoading extends GetUsersResult {}

final class GetUsersLoaded extends GetUsersResult {
  final List<User>? users;

  GetUsersLoaded(this.users);
}

final class GetUsersError extends GetUsersResult {
  final String message;

  GetUsersError(this.message);
}
