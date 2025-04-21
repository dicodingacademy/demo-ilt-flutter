import 'package:flutter/material.dart';
import 'package:myapp/controller/counter_controller.dart';
import 'package:myapp/screen/home_screen.dart';
import 'package:myapp/screen/list_screen.dart';
import 'package:provider/provider.dart';

// wrap with provider
void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => CounterController(),
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theming
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      // ),
      // darkTheme: ThemeData(/* ... */),
      // themeMode: ThemeMode.system,
      // Root widget
      home: HomeScreen(),
    );
  }
}
