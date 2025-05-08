import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Function() onSplash;
  const SplashScreen({Key? key, required this.onSplash}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo: go to somewhere else after one second on splash
    Future.delayed(const Duration(seconds: 1), onSplash);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading Splash...',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
