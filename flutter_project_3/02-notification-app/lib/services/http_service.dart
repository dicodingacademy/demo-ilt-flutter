import 'package:http/http.dart' as http;

class HttpService {
  final http.Client _client;

  HttpService({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<String> getDataFromUrl(String url) async {
    final response = await _client.get(Uri.parse(url));
    return response.body;
  }
}
