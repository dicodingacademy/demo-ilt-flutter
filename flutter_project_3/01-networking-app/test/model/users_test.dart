import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:networking_app/model/users.dart';

void main() {
  group('User Model Test', () {
    test('User.fromMap harus mengembalikan User yang benar', () {
      final userMap = {
        'id': 1,
        'email': 'test@example.com',
        'first_name': 'Test',
        'last_name': 'User',
        'avatar': 'https://example.com/avatar.png',
      };

      final user = User.fromMap(userMap);

      expect(user.id, 1);
      expect(user.email, 'test@example.com');
      expect(user.firstName, 'Test');
      expect(user.lastName, 'User');
      expect(user.avatar, 'https://example.com/avatar.png');
    });

    test('User.fromJson harus mengembalikan User yang benar', () {
      final jsonString = """{
        "id": 1,
        "email": "test@example.com",
        "first_name": "Test",
        "last_name": "User",
        "avatar": "https://example.com/avatar.png"
      }""";
      final user = User.fromJson(jsonString);

      expect(user.id, 1);
      expect(user.email, 'test@example.com');
      expect(user.firstName, 'Test');
      expect(user.lastName, 'User');
      expect(user.avatar, 'https://example.com/avatar.png');
    });
  });

  group('UsersResponse Model Test', () {
    test(
      'UsersResponse.fromMap harus mengembalikan UsersResponse yang benar',
      () {
        final responseMap = {
          'page': 1,
          'per_page': 6,
          'total': 12,
          'total_pages': 2,
          'data': [
            {
              'id': 1,
              'email': 'test@example.com',
              'first_name': 'Test',
              'last_name': 'User',
              'avatar': 'https://example.com/avatar.png',
            },
          ],
        };

        final usersResponse = UsersResponse.fromMap(responseMap);

        expect(usersResponse.page, 1);
        expect(usersResponse.perPage, 6);
        expect(usersResponse.total, 12);
        expect(usersResponse.totalPages, 2);
        expect(usersResponse.data.length, 1);
        expect(usersResponse.data.first.email, 'test@example.com');
      },
    );

    test(
      'UsersResponse.fromJson harus mengembalikan UsersResponse yang benar',
      () {
        final jsonString = json.encode({
          'page': 1,
          'per_page': 6,
          'total': 12,
          'total_pages': 2,
          'data': [
            {
              'id': 1,
              'email': 'test@example.com',
              'first_name': 'Test',
              'last_name': 'User',
              'avatar': 'https://example.com/avatar.png',
            },
          ],
        });

        final usersResponse = UsersResponse.fromJson(jsonString);

        expect(usersResponse.page, 1);
        expect(usersResponse.perPage, 6);
        expect(usersResponse.total, 12);
        expect(usersResponse.totalPages, 2);
        expect(usersResponse.data.length, 1);
        expect(usersResponse.data.first.firstName, 'Test');
      },
    );
  });
}
