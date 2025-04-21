import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final IconData iconData;
  final Function() onPressed;

  const MyFloatingActionButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onPressed, child: Icon(iconData));
  }
}
