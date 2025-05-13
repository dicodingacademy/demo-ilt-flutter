import 'package:flutter/material.dart';

class DialogPage extends Page {
  final String title;
  final String message;
  final Function() onOk;

  const DialogPage({
    required this.title,
    required this.message,
    required this.onOk,
  });

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
      settings: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title),
          contentPadding: const EdgeInsets.all(16),
          children: [
            Text(message),
            const SizedBox(height: 16),
            TextButton(onPressed: onOk, child: const Text("OK")),
          ],
        );
      },
      context: context,
    );
  }
}
