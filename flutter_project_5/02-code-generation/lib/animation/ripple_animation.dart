import 'dart:math' as math;

import 'package:flutter/material.dart';

class RippleAnimation extends CustomPainter {
  final Color color;
  final Animation<double> _animation;

  RippleAnimation(this._animation, {required this.color})
    : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    final double size = rect.width;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);

    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color animateColor = color.withAlpha((opacity * 255).toInt());
    final Paint paint = Paint()..color = animateColor;

    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 0; wave <= 3; wave++) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(covariant RippleAnimation oldDelegate) {
    return true;
  }
}
