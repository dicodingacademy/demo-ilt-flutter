import 'package:declarative_navigation/controller/auth_controller.dart';
import 'package:declarative_navigation/controller/http_controller.dart';
import 'package:declarative_navigation/model/quote.dart';
import 'package:declarative_navigation/routes/page/dialog_page.dart';
import 'package:declarative_navigation/screen/screen.dart';
import 'package:declarative_navigation/service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyRouterDelegate {
  final AuthController authController;
  MyRouterDelegate(this.authController) {
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  GoRouter get routerConfig => _routerConfig;

  late final _routerConfig = GoRouter(
    debugLogDiagnostics: true,

    initialLocation: '/splash',

    refreshListenable: authController,

    errorBuilder: (context, state) {
      final error = state.error.toString();
      return UnknownScreen(errorMessage: error);
    },

    redirect: (context, state) async {
      final loggedIn = await authController.checkIsLoggedIn();

      final pathIsLogin = state.matchedLocation == '/login';
      final pathIsRegister = state.matchedLocation == '/register';
      final pathIsDialog = state.matchedLocation.contains('/dialog');
      final pathIsSplash = state.matchedLocation == '/splash';

      if (pathIsSplash || pathIsRegister || pathIsDialog) {
        return null;
      }

      if (!loggedIn) {
        return '/login';
      }

      if (pathIsLogin) {
        return '/';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/',
        builder:
            (context, state) => MultiProvider(
              providers: [
                Provider(create: (_) => HttpServices()),
                ChangeNotifierProvider(
                  create: (context) => HttpController(context.read()),
                ),
              ],
              child: QuotesListScreen(
                onLogout: () => context.go('/login'),
                onShowDialog:
                    (title, message) =>
                        context.push('/dialog?title=$title&message=$message'),
                onTapped:
                    (Quote quote) =>
                        context.push('/quote/${quote.id}', extra: quote),
              ),
            ),
        routes: [
          GoRoute(
            path: 'quote/:quoteId',
            builder: (context, state) {
              final quote = state.extra;
              if (quote != null && quote is Quote) {
                return QuoteDetailsScreen(quote: quote);
              }
              context.go(
                '/error',
                extra: 'Missing required extra parameters: quote',
              );
              return const SizedBox.shrink();
            },
          ),
          dialogRoute,
        ],
      ),
      GoRoute(
        path: '/splash',
        builder:
            (context, state) => SplashScreen(onSplash: () => context.go('/')),
      ),
      GoRoute(
        path: '/login',
        builder:
            (context, state) => LoginScreen(
              onLogin: () => context.go('/'),
              onRegister: () => context.push('/register'),
              onShowDialog:
                  (title, message) => context.push(
                    '/login/dialog?title=$title&message=$message',
                  ),
            ),

        routes: [dialogRoute],
      ),
      GoRoute(
        path: '/register',
        builder:
            (context, state) => RegisterScreen(
              onLogin: () => context.pop(),
              onRegister: () => context.go('/login'),
            ),
      ),
      GoRoute(
        path: '/dialog',

        redirect: (context, state) {
          final isLoggedIn = authController.isLoggedIn;
          final sUri = state.uri.toString();
          return isLoggedIn ? sUri : '/login$sUri';
        },
      ),
      GoRoute(path: '/quote', redirect: (context, state) => '/'),
      GoRoute(
        path: '/error',
        builder: (context, state) {
          final errorMessage =
              state.extra as String? ?? 'An unknown error occurred';
          return UnknownScreen(errorMessage: errorMessage);
        },
      ),
    ],
  );

  final dialogRoute = GoRoute(
    path: 'dialog',
    pageBuilder: (context, state) {
      final dialogParam = state.uri.queryParameters['title'];
      final message = state.uri.queryParameters['message'];
      if (dialogParam == null || message == null) {
        context.go(
          '/error',
          extra: 'Missing required parameters: title or message',
        );
        return const NoTransitionPage(child: SizedBox.shrink());
      }
      return DialogPage(
        title: dialogParam,
        message: message,
        onOk: () => context.pop(),
      );
    },
  );
}
