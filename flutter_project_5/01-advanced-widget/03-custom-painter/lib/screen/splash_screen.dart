import 'package:declarative_navigation/animation/ripple_animation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Function() onSplash;
  const SplashScreen({Key? key, required this.onSplash}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// TODO: Add custom animation to the SplashScreen
class _SplashScreenState extends State<SplashScreen>
    // add the SingleTickerProviderStateMixin to the state
    // to use the AnimationController to animate the ripple effect
    with SingleTickerProviderStateMixin {
  
  // setup the AnimationController to animate the ripple effect
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // define the animation controller with the duration of 2 seconds,
    // set the vsync to the state and repeat the animation
    // to animate the ripple effect
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 1), widget.onSplash);
  }

  @override
  void dispose() {
    // dont forget to dispose the animation controller
    // to avoid memory leak
    // and to stop the animation when the widget is disposed
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
            // use the CustomPaint widget to draw the ripple effect
            CustomPaint(
              // set the RippleAnimation as the painter
              // to draw the ripple effect
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
