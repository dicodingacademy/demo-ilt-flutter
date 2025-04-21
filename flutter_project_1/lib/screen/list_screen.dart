import 'package:flutter/material.dart';
import 'package:myapp/widget/my_counter.dart';
import 'package:myapp/widget/my_floating_action_button.dart';

class ListScreen extends StatelessWidget {
  final int itemCount;
  const ListScreen({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Screen')),
      body: MyQuantity(),
      // body: ListBodyScreen(itemCount: itemCount),
      floatingActionButton:
      // list_screen.dart
      MyFloatingActionButton(
        iconData: Icons.arrow_back,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ListBodyScreen extends StatelessWidget {
  final int itemCount;
  const ListBodyScreen({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ListTileItem(index: index);
      },
    );
  }
}

class ListTileItem extends StatelessWidget {
  final int index;
  const ListTileItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Title $index"),
      subtitle: Text("Subtitle $index"),
    );
  }
}
