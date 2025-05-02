import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String email;
  final String? avatar;
  const UserTile({
    super.key,
    required this.name,
    required this.email,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(email),
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(avatar!),
      ),
    );
  }
}
