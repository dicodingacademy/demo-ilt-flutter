import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:networking_app/model/users.dart';
import 'package:networking_app/widget/user_list.dart';
import 'package:networking_app/widget/user_tile.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  late List<User> mockUsers = [
    User(
      id: 1,
      email: 'test1@example.com',
      firstName: 'Test',
      lastName: 'User1',
      avatar: 'https://example.com/avatar1.jpg',
    ),
    User(
      id: 2,
      email: 'test2@example.com',
      firstName: 'Test',
      lastName: 'User2',
      avatar: 'https://example.com/avatar2.jpg',
    ),
  ];

  testWidgets('UserList displays a list of UserTile widgets', (
    WidgetTester tester,
  ) async {
    // Define a mock onRefresh function
    Future<void> mockOnRefresh() async {
      return;
    }

    await mockNetworkImages(
      () => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserList(users: mockUsers, onRefresh: mockOnRefresh),
          ),
        ),
      ),
    );

    // Verify that the UserList displays the correct number of UserTile widgets
    expect(find.byType(UserTile), findsNWidgets(mockUsers.length));

    // Verify that the UserTile widgets display the correct information
    expect(find.text('Test User1'), findsOneWidget);
    expect(find.text('test1@example.com'), findsOneWidget);
    expect(find.text('Test User2'), findsOneWidget);
    expect(find.text('test2@example.com'), findsOneWidget);
  });

  testWidgets('UserList calls onRefresh when RefreshIndicator is pulled', (
    WidgetTester tester,
  ) async {
    // Define a mock onRefresh function
    bool refreshCalled = false;
    Future<void> mockOnRefresh() async {
      refreshCalled = true;
    }

    await mockNetworkImages(
      () => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserList(users: mockUsers, onRefresh: mockOnRefresh),
          ),
        ),
      ),
    );

    // Simulate pulling the RefreshIndicator
    await tester.fling(find.byType(ListView), const Offset(0.0, 500.0), 1000.0);
    await tester.pumpAndSettle();

    // Verify that the onRefresh function was called
    expect(refreshCalled, true);
  });
}
