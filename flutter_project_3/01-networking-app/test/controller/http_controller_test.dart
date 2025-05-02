import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:networking_app/controller/http_controller.dart';
import 'package:networking_app/model/users.dart';
import 'package:networking_app/service/http_service.dart';

class MockHttpServices extends Mock implements HttpServices {}

void main() {
  late MockHttpServices mockHttpServices;
  late HttpController controller;

  setUp(() {
    mockHttpServices = MockHttpServices();
    controller = HttpController(mockHttpServices);
  });

  test('should emit loading and then loaded when getUsers success', () async {
    final fakeUsers = [
      User(
        id: 1,
        email: 'test@mail.com',
        firstName: 'Test',
        lastName: 'User',
        avatar: '',
      ),
    ];

    when(() => mockHttpServices.getUsers()).thenAnswer((_) async => fakeUsers);

    final future = controller.getUsers();
    expect(controller.result, isA<GetUsersLoading>());

    await future;
    expect(controller.result, isA<GetUsersLoaded>());
    expect((controller.result as GetUsersLoaded).users, equals(fakeUsers));
  });

  test('should emit error when getUsers throws', () async {
    when(
      () => mockHttpServices.getUsers(),
    ).thenThrow(Exception("Network error"));

    controller.getUsers();

    expect(controller.result, isA<GetUsersError>());
    expect((controller.result as GetUsersError).message, contains("Exception"));
  });
}
