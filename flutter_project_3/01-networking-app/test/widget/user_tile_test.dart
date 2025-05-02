import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:networking_app/widget/user_tile.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  testWidgets('UserTile displays correct information', (
    WidgetTester tester,
  ) async {
    const name = 'John Doe';
    const email = 'john.doe@example.com';
    const avatar = 'https://reqres.in/img/faces/7-image.jpg';

    await mockNetworkImages(
      () => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserTile(name: name, email: email, avatar: avatar),
          ),
        ),
      ),
    );

    expect(find.text(name), findsOneWidget);
    expect(find.text(email), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
