import 'package:flutter/material.dart';
import 'package:shared_preferences_app/controller/shared_preference_controller.dart';
import 'package:shared_preferences_app/screen/setting_screen.dart';
import 'package:shared_preferences_app/service/shared_preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => SharedPreferencesService(pref)),
        ChangeNotifierProvider(
          create: (context) => SharedPreferenceController(context.read()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SettingScreen(),
    );
  }
}
