import 'package:declarative_navigation/model/get_user_result.dart';
import 'package:declarative_navigation/model/quote.dart';
import 'package:declarative_navigation/service/http_service.dart';
import 'package:flutter/widgets.dart';

class HttpController extends ChangeNotifier {
  final HttpServices client;
  HttpController(this.client);

  // TODO: add configuration for page and size to paginate
  // for example: page = 1, size = 10
  int? _page = 1;
  int? get page => _page;

  final int _size = 10;

  List<Quote> quotes = [];

  GetUsersResult _result = const GetUsersResult.nothing();
  GetUsersResult get result => _result;

  Future<void> getQuote() async {
    // check if the page is '1'.
    // if so, emit the loading state to show the loading indicator
    // if not, do not emit the loading state because the loading 
    // state is already shown when the page is '1'.
    if (_page == 1) {
      _emit(const GetUsersResult.loading());
    }

    try {
      // set the page using the [_page] variable
      // and set the size using the [_size] variable
      // to get the quote from the API
      final result = await client.getQuote(page: _page ?? 1, size: _size);

      // dont forget to check if the [result] is less than the [_size].
      // if so, set the [_page] to null because the pagination is finished
      // if not, set the [_page] to the next page
      // by adding 1 to the [_page] variable
      _page = result.length < _size ? null : _page! + 1;

      // add the result to the [quotes] list
      // to show the result in the UI
      quotes.addAll(result);

      // emit the loaded state to show the result
      // and pass the [quotes] list to the loaded state
      // to show the result in the UI
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
