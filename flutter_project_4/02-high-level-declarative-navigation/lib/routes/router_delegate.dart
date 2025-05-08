import 'package:declarative_navigation/model/quote.dart';
import 'package:declarative_navigation/provider/auth_provider.dart';
import 'package:declarative_navigation/routes/page/dialog_page.dart';
import 'package:declarative_navigation/screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// todo: remake the MyRouterDelegate class to use GoRouter
class MyRouterDelegate {
  final AuthProvider authProvider;
  MyRouterDelegate(this.authProvider) {
    // todo: GoRouter is not designed to be used with the imperative API
    // but we can use it with the declarative API
    // by setting the optionURLReflectsImperativeAPIs to true
    // this will allow us to use the imperative API
    // and the declarative API at the same time.
    // The URL will be updated to reflect the current state of the app
    // and the app will be able to navigate to the correct screen.
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  // get the router delegate
  // and use it in the main.dart file
  // to replace the routerDelegate, routeInformationParser, and backButtonDispatcher
  // in the MaterialApp.router widget
  GoRouter get routerConfig => _routerConfig;

  late final _routerConfig = GoRouter(
    // set debugLogDiagnostics to true
    // to see the debug logs in the console
    // and to see the current path
    debugLogDiagnostics: true,

    // set the initial location to the splash screen
    initialLocation: '/splash',

    // listen to the authProvider
    // and rebuild the widget tree when the authProvider changes
    refreshListenable: authProvider,

    // define the error page
    // when the user tries to access a page that doesn't exist
    errorBuilder: (context, state) {
      final error = state.error.toString();
      return UnknownScreen(errorMessage: error);
    },

    // define the redirect to the home page if the user is logged in
    // and redirect them to the login page if they are not
    redirect: (context, state) async {
      // check if the user is logged in
      final loggedIn = await authProvider.checkIsLoggedIn();

      // check the current path before redirecting
      final pathIsLogin = state.matchedLocation == '/login';
      final pathIsRegister = state.matchedLocation == '/register';
      final pathIsDialog = state.matchedLocation.contains('/dialog');
      final pathIsSplash = state.matchedLocation == '/splash';

      // redirect to specific page before user login
      if (pathIsSplash || pathIsRegister || pathIsDialog) {
        return null;
      }

      // if the user is not logged in and is trying to access a page
      // that requires authentication, redirect them to the login page
      if (!loggedIn) {
        return '/login';
      }

      // if the user is logged in but still on the login page,
      // send them to the home page
      if (pathIsLogin) {
        return '/';
      }

      // no need to redirect at all
      return null;
    },

    // define the possible routes
    // and the builder for each route.
    // the builder will return the screen to be displayed
    // when the user navigates to that route.
    routes: [
      GoRoute(
        path: '/',
        builder:
            (context, state) => QuotesListScreen(
              onLogout: () => context.go('/login'),
              onShowDialog:
                  (title, message) =>
                      context.push('/dialog?title=$title&message=$message'),
              onTapped: (quoteId) => context.push('/quote/$quoteId'),
              quotes: quotes,
            ),

        // nested routes
        // to show the details of a quote
        // when the user taps on a quote
        // and to show the dialog when the user taps on the dialog button
        routes: [
          GoRoute(
            path: 'quote/:quoteId',
            builder: (context, state) {
              final quoteId = state.pathParameters['quoteId'];
              if (quoteId == null) {
                context.go(
                  '/error',
                  extra: 'Missing required parameter: quoteId',
                );
                return const SizedBox.shrink();
              }

              final iQuoteId = int.tryParse(quoteId) ?? 0;
              if (iQuoteId > 5 || iQuoteId <= 0) {
                context.go('/error', extra: 'Invalid parameter: quoteId');
                return const SizedBox.shrink();
              }

              return QuoteDetailsScreen(quoteId: quoteId);
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

        // nested routes
        // to show the dialog when the user taps on the dialog button
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

      // if the user access the dialog page,
      // it will redirect to the login page - dialog page if the user is not logged in
      // and redirect to the home page - dialog page if the user is logged in
      GoRoute(
        path: '/dialog',
        // we don't need to define the builder here
        // because it's already defined in the dialogRoute.
        // it's only redirecting to the dialogRoute.
        redirect: (context, state) {
          final isLoggedIn = authProvider.isLoggedIn;
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

  // seperated route for dialog to avoid code duplication
  // and to make it easier to manage
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
