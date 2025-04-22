import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences_app/controller/shared_preference_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();

    final sp = context.read<SharedPreferenceController>();
    Future.microtask(() => sp.getValue());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Setting Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<SharedPreferenceController>(
              builder: (_, sp, _) {
                return switch (sp.state) {
                  NotificationLoaded(:var value) => SwitchListTile(
                    value: value,
                    onChanged: (value) {
                      sp.setValue(value);
                    },
                    title: Text("Notification"),
                    subtitle: Text("Aktifkan agar dapat info menarik."),
                  ),
                  NotificationError(:var message) => Text(message),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
