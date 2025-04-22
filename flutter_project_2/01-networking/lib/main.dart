import 'package:flutter/material.dart';
import 'package:networking_app/controller/http_controller.dart';
import 'package:networking_app/screen/loading_screen.dart';
import 'package:networking_app/service/http_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => HttpServices()),
        ChangeNotifierProvider(
          create: (context) => HttpController(context.read()),
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
      home: LoadingScreen(),
    );
  }
}
