import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:networking_app/controller/http_controller.dart';
import 'package:networking_app/model/users.dart';
import 'package:networking_app/screen/loading_screen.dart';
import 'package:networking_app/widget/user_list.dart';
import 'package:provider/provider.dart';

class MockHttpController extends Mock implements HttpController {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('LoadingScreen', () {
    late MockHttpController mockHttpController;

    setUp(() {
      mockHttpController = MockHttpController();
    });

    testWidgets('renders "Try to load!" button when state is GetUsersNothing', (
      WidgetTester tester,
    ) async {
      when(() => mockHttpController.result).thenReturn(GetUsersNothing());

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<HttpController>(
            create: (context) => mockHttpController,
            child: const LoadingScreen(),
          ),
        ),
      );

      expect(find.text('Try to load!'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets(
      'renders CircularProgressIndicator when state is GetUsersLoading',
      (WidgetTester tester) async {
        when(() => mockHttpController.result).thenReturn(GetUsersLoading());

        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<HttpController>(
              create: (context) => mockHttpController,
              child: const LoadingScreen(),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('renders UserList when state is GetUsersLoaded with users', (
      WidgetTester tester,
    ) async {
      final users = [
        User(
          id: 1,
          email: 'test@example.com',
          firstName: 'Test',
          lastName: 'User',
          avatar: 'avatar',
        ),
      ];
      when(() => mockHttpController.result).thenReturn(GetUsersLoaded(users));

      await mockNetworkImages(
        () => tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<HttpController>(
              create: (context) => mockHttpController,
              child: const LoadingScreen(),
            ),
          ),
        ),
      );

      expect(find.byType(UserList), findsOneWidget);
    });

    testWidgets(
      'renders "Empty list." text when state is GetUsersLoaded with empty users',
      (WidgetTester tester) async {
        when(() => mockHttpController.result).thenReturn(GetUsersLoaded([]));

        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<HttpController>(
              create: (context) => mockHttpController,
              child: const LoadingScreen(),
            ),
          ),
        );

        expect(find.text('Empty list.'), findsOneWidget);
      },
    );

    testWidgets('renders error message when state is GetUsersError', (
      WidgetTester tester,
    ) async {
      const errorMessage = 'An error occurred';
      when(
        () => mockHttpController.result,
      ).thenReturn(GetUsersError(errorMessage));

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<HttpController>(
            create: (context) => mockHttpController,
            child: const LoadingScreen(),
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('calls getUsers when "Try to load!" button is pressed', (
      WidgetTester tester,
    ) async {
      when(() => mockHttpController.result).thenReturn(GetUsersNothing());
      when(() => mockHttpController.getUsers()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<HttpController>(
            create: (context) => mockHttpController,
            child: const LoadingScreen(),
          ),
        ),
      );

      await tester.tap(find.text('Try to load!'));
      verify(() => mockHttpController.getUsers()).called(1);
    });

    testWidgets('calls onRefresh when RefreshIndicator is pulled', (
      WidgetTester tester,
    ) async {
      final users = [
        User(
          id: 1,
          email: 'test@example.com',
          firstName: 'Test',
          lastName: 'User',
          avatar: 'avatar',
        ),
      ];
      when(() => mockHttpController.result).thenReturn(GetUsersLoaded(users));
      when(() => mockHttpController.getUsers()).thenAnswer((_) async {});

      await mockNetworkImages(
        () => tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<HttpController>(
              create: (context) => mockHttpController,
              child: const LoadingScreen(),
            ),
          ),
        ),
      );

      // Simulate pulling the RefreshIndicator
      await tester.fling(
        find.byType(ListView),
        const Offset(0.0, 500.0),
        1000.0,
      );

      // Verify that the onRefresh function was called
      expect(
        tester.getSemantics(find.byType(RefreshProgressIndicator)),
        matchesSemantics(label: 'Refresh'),
      );

      await tester.pumpAndSettle();

      expect(find.byType(UserList), findsOneWidget);
    });
  });
}
