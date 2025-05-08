import 'package:declarative_navigation/db/auth_repository.dart';
import 'package:declarative_navigation/provider/auth_provider.dart';
import 'package:declarative_navigation/routes/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AuthRepository()),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(context.read()),
        ),
        Provider(create: (context) => MyRouterDelegate(context.read())),
      ],
      child: const QuotesApp(),
    ),
  );
}

class QuotesApp extends StatelessWidget {
  const QuotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myRouterDelegate = context.read<MyRouterDelegate>();

    return MaterialApp.router(
      title: 'Quotes App',
      // todo: remove the routerDelegate, routeInformationParser, and backButtonDispatcher from here
      // and use the [routerConfig] instead.
      routerConfig: myRouterDelegate.routerConfig,
      // routerDelegate: myRouterDelegate.router.routerDelegate,
      // routeInformationParser: myRouterDelegate.router.routeInformationParser,
      // backButtonDispatcher: myRouterDelegate.router.backButtonDispatcher,
      debugShowCheckedModeBanner: false,
    );
  }
}
