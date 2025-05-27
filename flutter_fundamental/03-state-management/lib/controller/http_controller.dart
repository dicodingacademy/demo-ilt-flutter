import 'package:flutter/widgets.dart';
import 'package:ui_error_app/model/exceptions.dart';
import 'package:ui_error_app/model/tourism.dart';
import 'package:ui_error_app/service/http_service.dart';

class HttpController extends ChangeNotifier {
  final HttpServices client;
  HttpController(this.client);

  GetPlaceResult _result = GetPlaceNothing();
  GetPlaceResult get result => _result;

  Future<void> getPlace() async {
    _emit(GetPlaceLoading());

    try {
      final result = await client.getPlace();
      _emit(GetPlaceLoaded(result));
    } on AppException catch (e) {
      _emit(GetPlaceError(e.message));
    }
  }

  void _emit(GetPlaceResult state) {
    _result = state;
    notifyListeners();
  }
}

sealed class GetPlaceResult {}

final class GetPlaceNothing extends GetPlaceResult {}

final class GetPlaceLoading extends GetPlaceResult {}

final class GetPlaceLoaded extends GetPlaceResult {
  final Place place;

  GetPlaceLoaded(this.place);
}

final class GetPlaceError extends GetPlaceResult {
  final String message;

  GetPlaceError(this.message);
}
