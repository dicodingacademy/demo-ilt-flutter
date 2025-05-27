import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_error_app/controller/database_controller.dart';
import 'package:ui_error_app/controller/http_controller.dart';
import 'package:ui_error_app/controller/setting_controller.dart';
import 'package:ui_error_app/widget/bookmark_icon_widget.dart';
import 'package:ui_error_app/widget/place_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final httpController = context.read<HttpController>();
  late final databaseController = context.read<DatabaseController>();

  @override
  void initState() {
    super.initState();
    loadApi();
  }

  void loadApi() => Future.microtask(() async {
    await httpController.getPlace();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Overflow Error Page'),
        actions: [
          IconButton(
            onPressed: () => loadApi(),
            icon: const Icon(Icons.refresh),
          ),
          Consumer<HttpController>(
            builder: (_, value, _) {
              final state = value.result;
              return switch (state) {
                GetPlaceLoaded(:var place) => BookmarkIconWidget(place: place),
                _ => SizedBox.shrink(),
              };
            },
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/bookmark'),
            icon: const Icon(Icons.collections_bookmark_outlined),
          ),
          Consumer<SettingController>(
            builder: (_, controller, _) {
              final isLight = controller.themeValue.isLight;
              return IconButton(
                onPressed: () => controller.saveSetting(),
                icon: Icon(isLight ? Icons.dark_mode : Icons.light_mode),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HttpController>(
          builder: (context, value, child) {
            final result = httpController.result;
            return switch (result) {
              GetPlaceNothing() => const SizedBox(),
              GetPlaceLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              GetPlaceError(:var message) => Center(child: Text(message)),
              GetPlaceLoaded(:var place) => PlaceView(place: place),
            };
          },
        ),
      ),
    );
  }
}
