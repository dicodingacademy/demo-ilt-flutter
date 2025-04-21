import 'package:flutter/material.dart';
import 'package:myapp/screen/list_screen.dart';
import 'package:myapp/widget/my_bottom_navigation_bar.dart';
import 'package:myapp/widget/my_floating_action_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: ScaffoldView(),
      floatingActionButton:
      // home_screen.dart
      MyFloatingActionButton(
        iconData: Icons.arrow_forward,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListScreen(itemCount: 4)),
          );
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}

class ScaffoldView extends StatelessWidget {
  const ScaffoldView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Hello, World!', style: TextStyle(fontSize: 28)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print('Click!');
            },
            child: const Text('A button'),
          ),
        ],
      ),
    );
  }
}
