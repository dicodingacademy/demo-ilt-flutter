import 'dart:convert';

import 'package:declarative_navigation/model/quote.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  final http.Client _client;

  HttpServices([http.Client? client]) : _client = client ?? http.Client();

  static const String _baseUrl = "quote-api.dicoding.dev";

  Future<List<Quote>> getQuote({int page = 1, int size = 5}) async {
    try {
      final uri = Uri.https(_baseUrl, "list", {
        "page": "$page",
        "size": "$size",
      });
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final quotes = jsonList.map((e) => Quote.fromJson(e)).toList();
        return quotes;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception("Caught an error: $e");
    }
  }
}
