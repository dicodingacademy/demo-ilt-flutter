import 'package:flutter/material.dart';
import 'package:myapp/widget/my_checkbox.dart';
import 'package:myapp/widget/my_image.dart';

class RowView extends StatelessWidget {
  const RowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [MyImage(), Text("Owl"), MyCheckbox()],
    );
  }
}
