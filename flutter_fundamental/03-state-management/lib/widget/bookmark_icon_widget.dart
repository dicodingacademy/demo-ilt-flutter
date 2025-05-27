import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_error_app/controller/database_controller.dart';
import 'package:ui_error_app/controller/bookmark_controller.dart';
import 'package:ui_error_app/model/tourism.dart';

class BookmarkIconWidget extends StatelessWidget {
  final Place place;
  const BookmarkIconWidget({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookmarkController(),
      child: _BookmarkIconWidget(place: place),
    );
  }
}

class _BookmarkIconWidget extends StatefulWidget {
  final Place place;

  const _BookmarkIconWidget({required this.place});

  @override
  State<_BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<_BookmarkIconWidget> {
  late final databaseController = context.read<DatabaseController>();

  @override
  void initState() {
    super.initState();

    loadBookmark();

    databaseController.addListener(listener);
  }

  @override
  void dispose() {
    databaseController.removeListener(listener);
    super.dispose();
  }

  @override
  void didUpdateWidget(_BookmarkIconWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.place.id != oldWidget.place.id) {
      // If the place represented by this icon changes, reload its bookmark status.
      loadBookmark();
    }
  }

  void loadBookmark() => Future.microtask(() async {
    await databaseController.getById(widget.place.id);
  });

  void listener() {
    final bookmarkController = context.read<BookmarkController>();
    final databaseState = databaseController.state;

    bool newBookmarkStatus = false;
    bool statusDetermined = false;

    if (databaseState is DatabaseSingleLoaded &&
        databaseState.place?.id == widget.place.id) {
      // Check if this state update is for the current widget's place
      newBookmarkStatus = databaseState.isFavorite;
      statusDetermined = true;
    } else if (databaseState is DatabaseLoaded) {
      // Check if the current widget's place is in the list of bookmarked places
      newBookmarkStatus = databaseState.places.any(
        (p) => p.id == widget.place.id,
      );
      statusDetermined = true;
    }

    if (statusDetermined) {
      bookmarkController.isBookmarked = newBookmarkStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkController>(
      builder: (_, controller, __) {
        final isFavorite = controller.isBookmarked;
        return IconButton(
          onPressed: () async {
            if (isFavorite) {
              databaseController.removeById(widget.place.id);
            } else {
              databaseController.save(widget.place);
            }
            controller.isBookmarked = !isFavorite;
          },
          icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_outline),
        );
      },
    );
  }
}
