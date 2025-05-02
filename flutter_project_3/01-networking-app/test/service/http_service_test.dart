import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:networking_app/model/users.dart';
import 'package:networking_app/service/http_service.dart';

import '../utils/utils.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockClient mockClient;
  late HttpServices service;
  
  setUp(() {
    mockClient = MockClient();
    service = HttpServices(mockClient);
  });

  group('HttpServices', () {
    test(
      'returns list of users when the http call completes successfully',
      () async {
        when(
          () => mockClient.get(Uri.parse("https://reqres.in/api/users?page=2")),
        ).thenAnswer(
          (_) async => http.Response(
            await loadJsonFromAssets("assets/json/users.json"),
            200,
          ),
        );

        final users = await service.getUsers();

        expect(users, isA<List<User>>());
        expect(users?.length, 6);
        expect(users?[0].firstName, "Michael");
      },
    );

    test(
      'throws an exception if the http call completes with an error',
      () async {
        when(
          () => mockClient.get(Uri.parse("https://reqres.in/api/users?page=2")),
        ).thenAnswer((_) async => http.Response("Error", 404));

        expect(() => service.getUsers(), throwsA(isA<Exception>()));
      },
    );

    test('throws an exception if json is malformed', () async {
      when(
        () => mockClient.get(Uri.parse("https://reqres.in/api/users?page=2")),
      ).thenAnswer((_) async => http.Response('Malformed JSON', 200));

      expect(() => service.getUsers(), throwsA(isA<Exception>()));
    });
  });
}
