import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_error_app/controller/database_controller.dart';
import 'package:ui_error_app/widget/place_card.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late final databaseController = context.read<DatabaseController>();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await databaseController.loadAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bookmark Screen'),
      ),
      body: Consumer<DatabaseController>(
        builder: (context, value, child) {
          final state = value.state;
          return switch (state) {
            DatabaseNone() || DatabaseSingleLoaded() => SizedBox.shrink(),
            DatabaseLoading() => Center(child: CircularProgressIndicator()),
            DatabaseError(:var message) => Center(child: Text(message)),
            DatabaseLoaded(:var places) =>
              places.isEmpty
                  ? Center(child: Text("Empty list."))
                  : ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      final item = places[index];
                      return PlaceCard(item: item);
                    },
                  ),
          };
        },
      ),
    );
  }
}
