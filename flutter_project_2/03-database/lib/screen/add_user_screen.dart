import 'package:database_app/controller/database_controller.dart';
import 'package:database_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatefulWidget {
  final int? id;
  const AddUserScreen({super.key, this.id});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late final DatabaseController databaseController;

  @override
  void initState() {
    super.initState();
    databaseController = context.read<DatabaseController>();

    databaseController.addListener(databaseListener);

    Future.microtask(() {
      final id = widget.id;
      if (id != null) {
        databaseController.getById(id);
      }
    });
  }

  @override
  void dispose() {
    databaseController.removeListener(databaseListener);
    super.dispose();
  }

  void databaseListener() {
    final state = databaseController.state;
    if (state is DatabaseLoaded) {
      Navigator.pop(context);
    } else if (state is DatabaseSingleLoaded) {
      final user = state.value;
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add User Screen'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: TextFormFieldWidget(
                        controller: firstNameController,
                        hintText: "Write your first name",
                        label: "First Name",
                      ),
                    ),
                    Expanded(
                      child: TextFormFieldWidget(
                        controller: lastNameController,
                        hintText: "Write your last name",
                        label: "Last Name",
                      ),
                    ),
                  ],
                ),
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final id = widget.id;
                      final firstName = firstNameController.text;
                      final lastName = lastNameController.text;
                      final user = User(
                        id: id,
                        firstName: firstName,
                        lastName: lastName,
                      );

                      if (id == null) {
                        context.read<DatabaseController>().save(user);
                      } else {
                        context.read<DatabaseController>().update(id, user);
                      }
                    }
                  },
                  child: Text("Save it!"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
  });

  final String hintText;
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: "Write your last name",
        label: Text("Last Name"),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }
}
