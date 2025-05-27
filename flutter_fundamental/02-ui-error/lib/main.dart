import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_error_app/controller/http_controller.dart';
import 'package:ui_error_app/screen/home_screen.dart';
import 'package:ui_error_app/service/http_service.dart';
import 'package:ui_error_app/style/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => HttpServices()),
        ChangeNotifierProvider(
          create: (context) => HttpController(context.read()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: gaaraTheme,
      darkTheme: gaaraDarkTheme,
      themeMode: ThemeMode.light,
      routes: {'/': (context) => HomeScreen()},
    );
  }
}
