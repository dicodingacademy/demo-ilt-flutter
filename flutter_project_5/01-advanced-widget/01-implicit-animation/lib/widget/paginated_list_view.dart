import 'package:declarative_navigation/controller/http_controller.dart';
import 'package:declarative_navigation/model/get_user_result.dart';
import 'package:declarative_navigation/model/quote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginatedListView extends StatefulWidget {
  final Function(Quote) onTapped;
  const PaginatedListView({super.key, required this.onTapped});

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  late final HttpController apiController;

  @override
  void initState() {
    super.initState();

    apiController = context.read<HttpController>();
    Future.microtask(() async => apiController.getQuote());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HttpController>(
      builder: (_, value, _) {
        final state = value.result;

        return switch (state) {
          GetUsersNothing() => const SizedBox.shrink(),
          GetUsersLoading() => const Center(child: CircularProgressIndicator()),
          GetUsersLoaded(:var quotes) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              final quote = quotes[index];

              // TODO: Add implicit animation to the ListTile
              // Using TweenAnimationBuilder to animate the opacity and position
              // of the ListTile when it is built.
              // The animation will start from opacity 0 and move from the right
              // to its original position.
              return TweenAnimationBuilder<double>(
                // The tween will animate from 0 to 1.
                // The tween will be used to animate the opacity of the ListTile.
                // The tween will also be used to animate the position of the ListTile.
                tween: Tween<double>(begin: 0, end: 1),
                // The animation will last for 500 milliseconds.
                // You can adjust the duration to make it faster or slower.
                duration: const Duration(milliseconds: 500),
                // The animation will start when the ListTile is built.
                // The animation will be triggered when the ListTile is added to the tree.
                builder: (context, value, child) {
                  // The opacity of the ListTile will be animated from 0 to 1.
                  // The position will be animated from 100 pixels to 0 pixels.
                  return Opacity(
                    opacity: value,
                    // The ListTile will move from the right to its original position.
                    // The offset will be 100 pixels to the right when the animation starts.
                    // The offset will be 0 pixels when the animation ends.
                    // You can adjust the offset to make it move more or less.
                    child: Transform.translate(
                      offset: Offset(100 * (1 - value), 0),
                      child: child,
                    ),
                  );
                },
                // The child is the ListTile that will be animated.
                // The child is passed to the builder to avoid rebuilding it every time.
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  title: Text(quote.author),
                  subtitle: Text(quote.quote),
                  onTap: () => widget.onTapped(quote),
                ),
              );
            },
          ),
          GetUsersError(:var message) => Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(message),
            ),
          ),
        };
      },
    );
  }
}
