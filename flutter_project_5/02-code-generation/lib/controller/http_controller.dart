import 'package:declarative_navigation/model/get_user_result.dart';
import 'package:declarative_navigation/model/quote.dart';
import 'package:declarative_navigation/service/http_service.dart';
import 'package:flutter/widgets.dart';

class HttpController extends ChangeNotifier {
  final HttpServices client;
  HttpController(this.client);

  int? _page = 1;
  int? get page => _page;

  final int _size = 10;

  List<Quote> quotes = [];

  GetUsersResult _result = const GetUsersResult.nothing();
  GetUsersResult get result => _result;

  Future<void> getQuote() async {
    if (_page == 1) {
      _emit(const GetUsersResult.loading());
    }

    try {
      final result = await client.getQuote(page: _page ?? 1, size: _size);

      _page = result.length < _size ? null : _page! + 1;

      quotes.addAll(result);

      _emit(GetUsersResult.loaded(quotes));
    } catch (e) {
      _emit(GetUsersResult.error(e.toString()));
    }
  }

  void _emit(GetUsersResult state) {
    _result = state;
    notifyListeners();
  }
}
