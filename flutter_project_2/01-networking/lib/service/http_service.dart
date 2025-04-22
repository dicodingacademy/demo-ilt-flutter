import 'package:http/http.dart' as http;
import 'package:networking_app/model/users.dart';

class HttpServices {
  static const String _baseUrl = "reqres.in";

  Future<List<User>?> getUsers() async {
    try {
      final uri = Uri.https(_baseUrl, "api/users", {
        "page": "1",
        "per_page": "2",
      });
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final usersResponse = UsersResponse.fromJson(response.body);
        final users = usersResponse.data;
        return users;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception("Caught an error: $e");
    }
  }
}
