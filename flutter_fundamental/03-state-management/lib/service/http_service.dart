import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:ui_error_app/model/exceptions.dart';
import 'package:ui_error_app/model/tourism.dart';

class HttpServices {
  static const String _baseUrl = "tourism-api.dicoding.dev";

  Future<Place> getPlace() async {
    try {
      final randomNumber = _randomNumber();
      final uri = Uri.https(_baseUrl, "detail/$randomNumber");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final placeResponse = TourismResponse.fromJson(response.body);
        final place = placeResponse.place;
        return place;
      } else {
        throw AppException('Tourism detail is not found.');
      }
    } on http.ClientException {
      throw AppException('No internet connection.');
    } on SocketException {
      throw AppException('No internet connection.');
    } on FormatException {
      throw AppException('Bad response format.');
    } on TimeoutException {
      throw AppException('Connection timed out.');
    } catch (e) {
      throw AppException('Something went wrong.');
    }
  }

  num _randomNumber() {
    final random = Random();

    int next(int min, int max) => min + random.nextInt(max - min);

    return next(1, 12);
  }
}
