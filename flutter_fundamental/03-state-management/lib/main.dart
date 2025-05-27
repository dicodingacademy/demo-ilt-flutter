import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_error_app/controller/database_controller.dart';
import 'package:ui_error_app/controller/http_controller.dart';
import 'package:ui_error_app/controller/setting_controller.dart';
import 'package:ui_error_app/screen/bookmark_screen.dart';
import 'package:ui_error_app/screen/home_screen.dart';
import 'package:ui_error_app/service/database_service.dart';
import 'package:ui_error_app/service/http_service.dart';
import 'package:ui_error_app/service/shared_preference_service.dart';
import 'package:ui_error_app/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferenceService.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => HttpServices()),
        ChangeNotifierProvider(
          create: (context) => HttpController(context.read()),
        ),
        // database
        Provider(create: (context) => DatabaseService()),
        ChangeNotifierProvider(
          create: (context) => DatabaseController(context.read()),
        ),
        // shared preferences
        Provider(create: (context) => pref),
        ChangeNotifierProvider(
          create: (context) => SettingController(context.read())..loadSetting(),
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
    final themeMode = context.select(
      (SettingController bloc) =>
          bloc.themeValue.isLight ? ThemeMode.light : ThemeMode.dark,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: gaaraTheme,
      darkTheme: gaaraDarkTheme,
      themeMode: themeMode,
      routes: {
        '/': (context) => HomeScreen(),
        '/bookmark': (context) => BookmarkScreen(),
      },
    );
  }
}
