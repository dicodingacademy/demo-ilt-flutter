import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:networking_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify loading screen and user list',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify that the "Try to load!" button is present.
      expect(find.text('Try to load!'), findsOneWidget);

      // Tap the "Try to load!" button.
      await tester.tap(find.text('Try to load!'));
      await tester.pump();

      // Verify that a CircularProgressIndicator is present while loading.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();

      // Verify that the UserList is displayed after loading. 
      expect(find.byType(ListView), findsOneWidget);

      // Verify that the "Michael Lawson" name is present while ListView is ready
      expect(find.text('Michael Lawson'), findsOneWidget);
    });
  });
}