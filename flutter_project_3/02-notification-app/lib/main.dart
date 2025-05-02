import 'package:flutter/material.dart';
import 'package:notification_app/providers/local_notification_provider.dart';
import 'package:notification_app/screens/home_screen.dart';
import 'package:notification_app/services/http_service.dart';
import 'package:notification_app/services/local_notification_service.dart';
import 'package:notification_app/services/workmanager_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => HttpService(),
        ),
        Provider(
          create: (context) => LocalNotificationService(
            context.read<HttpService>(),
          )..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermissions(),
        ),
        Provider(
          create: (context) => WorkmanagerService()..init(),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
}
