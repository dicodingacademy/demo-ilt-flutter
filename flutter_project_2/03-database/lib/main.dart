import 'package:database_app/controller/database_controller.dart';
import 'package:database_app/screen/list_screen.dart';
import 'package:database_app/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => DatabaseService()),
        ChangeNotifierProvider(
          create: (context) => DatabaseController(context.read()),
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
      home: ListScreen(),
    );
  }
}
