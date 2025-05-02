import 'package:flutter/material.dart';
import 'package:networking_app/model/users.dart';
import 'package:networking_app/widget/user_tile.dart';

class UserList extends StatelessWidget {
  final List<User> users;
  final Future<void> Function() onRefresh;
  const UserList({super.key, required this.users, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final item = users[index];
          return UserTile(
            name: "${item.firstName} ${item.lastName}",
            email: item.email,
            avatar: item.avatar,
          );
        },
      ),
    );
  }
}
