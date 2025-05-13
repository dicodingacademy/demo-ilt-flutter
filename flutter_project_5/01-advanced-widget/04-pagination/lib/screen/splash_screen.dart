import 'package:declarative_navigation/animation/ripple_animation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Function() onSplash;
  const SplashScreen({Key? key, required this.onSplash}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    Future.delayed(const Duration(seconds: 1), widget.onSplash);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: RippleAnimation(_controller, color: Colors.deepPurple),
              child: Text(
                'Loading Splash...',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
