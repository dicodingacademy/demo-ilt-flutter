import 'package:flutter/material.dart';

class MyQuantity extends StatelessWidget {
  const MyQuantity({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Quantity"), MyCounter()],
    );
  }
}

class MyCounter extends StatefulWidget {
  const MyCounter({super.key});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    if (counter == 0) return;
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyButton(
          iconData: Icons.remove,
          onPressed: () {
            decrement();
          },
        ),
        Text("$counter"),
        MyButton(
          iconData: Icons.add,
          onPressed: () {
            increment();
          },
        ),
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  final IconData iconData;
  final Function() onPressed;
  const MyButton({super.key, required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: Icon(iconData));
  }
}
