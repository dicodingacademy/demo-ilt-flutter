import 'package:declarative_navigation/db/auth_repository.dart';
import 'package:declarative_navigation/provider/auth_provider.dart';
import 'package:declarative_navigation/routes/route_information_parser.dart';
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
        Provider(create: (context) => MyRouteInformationParser()),
        ChangeNotifierProvider(create: (context) => MyRouterDelegate(context.read())),
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
    final myRouteInformationParser = context.read<MyRouteInformationParser>();

    return MaterialApp.router(
      title: 'Quotes App',
      routerDelegate: myRouterDelegate,
      routeInformationParser: myRouteInformationParser,
      backButtonDispatcher: RootBackButtonDispatcher(),
      debugShowCheckedModeBanner: false,
    );
  }
}
