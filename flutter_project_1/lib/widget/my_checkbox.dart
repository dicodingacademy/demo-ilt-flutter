import 'package:flutter/material.dart';

class MyCheckbox extends StatelessWidget {
  const MyCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: false, onChanged: (value) {});
  }
}
