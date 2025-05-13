import 'package:declarative_navigation/model/get_user_result.dart';
import 'package:declarative_navigation/model/quote.dart';
import 'package:declarative_navigation/service/http_service.dart';
import 'package:flutter/widgets.dart';

class HttpController extends ChangeNotifier {
  final HttpServices client;
  HttpController(this.client);

  List<Quote> quotes = [];

  GetUsersResult _result = const GetUsersResult.nothing();
  GetUsersResult get result => _result;

  Future<void> getQuote() async {
    _emit(const GetUsersResult.loading());

    try {
      final result = await client.getQuote(page: 1, size: 10);
      _emit(GetUsersResult.loaded(result));
    } catch (e) {
      _emit(GetUsersResult.error(e.toString()));
    }
  }

  void _emit(GetUsersResult state) {
    _result = state;
    notifyListeners();
  }
}
