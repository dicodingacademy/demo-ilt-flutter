import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_error_app/controller/http_controller.dart';
import 'package:ui_error_app/widget/place_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final httpController = context.read<HttpController>();

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
              GetPlaceError(:var message) =>
              // todo-exception: we can customize the view, maybe
              // add the load button so user can reload
              Center(child: Text(message)),
              GetPlaceLoaded(:var place) => PlaceView(place: place),
            };
          },
        ),
      ),
    );
  }
}
