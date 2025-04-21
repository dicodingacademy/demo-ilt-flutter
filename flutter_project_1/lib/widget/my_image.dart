import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      width: 50,
      height: 50,
    );
  }
}
