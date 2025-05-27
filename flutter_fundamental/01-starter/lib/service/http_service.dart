import 'dart:async';
import 'dart:math';

import 'package:http/http.dart' as http;
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
        // todo-exception: throw an [App Exception] that we created
        // before and change the message that we wanna inform to
        // the user so they can understand it more clearly.
        throw Exception('Tourism detail is not found.');
      }
    }
    // todo-exception: use specific Exception that we
    // wanna handle and define the message more clearly.
    catch (e) {
      throw Exception(e.toString());
    }
  }

  num _randomNumber() {
    final random = Random();

    int next(int min, int max) => min + random.nextInt(max - min);

    return next(1, 12);
  }
}
