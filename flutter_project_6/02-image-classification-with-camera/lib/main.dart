import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite_vision_app/controller/image_classification_provider.dart';
import 'package:tflite_vision_app/services/image_classification_service.dart';
import 'package:tflite_vision_app/ui/image_picker_page.dart';
import 'package:tflite_vision_app/ui/real_time_camera_page.dart';
import 'package:tflite_vision_app/ui/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ImageClassificationService()),
        ChangeNotifierProvider(
          create:
              (context) => ImageClassificationViewmodel(
                context.read<ImageClassificationService>(),
              ),
          lazy: false,
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
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (_) => HomePage(),
        "/real-time": (_) => RealTimeCameraPage(),
        "/image-picker": (_) => ImagePickerPage(),
      },
    );
  }
}
