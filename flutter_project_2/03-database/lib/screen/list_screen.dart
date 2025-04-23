import 'package:database_app/controller/database_controller.dart';
import 'package:database_app/model/user.dart';
import 'package:database_app/screen/add_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late final DatabaseController dbController;
  @override
  void initState() {
    super.initState();
    dbController = context.read<DatabaseController>();
    Future.microtask(() => dbController.loadAllData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ListScreen'),
      ),
      body: Center(
        child: Consumer<DatabaseController>(
          builder: (_, controller, _) {
            return switch (controller.state) {
              DatabaseNone() || DatabaseSingleLoaded() => SizedBox(),
              DatabaseLoading() => CircularProgressIndicator(),
              DatabaseLoaded(:var value) =>
                value.isNotEmpty
                    ? UserListView(value: value)
                    : Text("Empty users"),
              DatabaseError(:var message) => Text(message),
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddUserScreen()),
            ),
        child: Icon(Icons.add),
      ),
    );
  }
}

class UserListView extends StatelessWidget {
  const UserListView({super.key, required this.value});

  final List<User> value;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: value.length,
      itemBuilder: (context, index) {
        final item = value[index];
        final id = item.id;
        final dbController = context.read<DatabaseController>();
        return ListTile(
          title: Text("${item.firstName} ${item.lastName}"),
          trailing: IconButton(
            onPressed: () {
              if (id != null) {
                dbController.removeById(id);
              }
            },
            icon: Icon(Icons.remove),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddUserScreen(id: id)),
            );
          },
        );
      },
    );
  }
}
