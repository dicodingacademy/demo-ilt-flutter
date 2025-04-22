import 'package:flutter/material.dart';
import 'package:networking_app/controller/http_controller.dart';
import 'package:networking_app/widget/user_list.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Loading Screen'),
      ),
      body: ScaffoldView(),
    );
  }
}

class ScaffoldView extends StatelessWidget {
  const ScaffoldView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HttpController>(
      builder: (context, httpController, child) {
        return switch (httpController.result) {
          GetUsersNothing() => Center(
            child: FilledButton(
              onPressed: () => httpController.getUsers(),
              child: Text("Try to load!"),
            ),
          ),
          GetUsersLoading() => Center(child: CircularProgressIndicator()),
          GetUsersLoaded(:var users) =>
            (users != null && users.isNotEmpty)
                ? UserList(
                  users: users,
                  onRefresh: () async => httpController.getUsers(),
                )
                : Center(child: Text("Empty list.")),
          GetUsersError(:var message) => Center(child: Text(message)),
        };
      },
    );
  }
}
