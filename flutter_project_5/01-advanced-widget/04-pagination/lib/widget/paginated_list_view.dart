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

// TODO: add configuration for pagination feature
class _PaginatedListViewState extends State<PaginatedListView> {
  // define the scroll controller to listen to the scroll event
  final ScrollController scrollController = ScrollController();

  late final HttpController apiController;

  @override
  void initState() {
    super.initState();

    apiController = context.read<HttpController>();
    Future.microtask(() async => apiController.getQuote());

    // add the scroll listener to the scroll controller
    // to listen to the scroll event
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // remove the scroll listener from the scroll controller
    // and dispose the scroll controller when the widget is disposed
    // to avoid memory leak
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  // set the scroll listener to listen to the scroll event
  // and check if the scroll position is at the end of the list.
  // if so, call the getQuote method to get the next page
  // of the quotes and add it to the list
  // to show the result in the UI
  void _scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        apiController.page != null) {
      apiController.getQuote();
    }
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
            // set the scroll controller to the list view
            controller: scrollController,
            // set the item count to the length of the quotes
            // and add 1 to the item count to show the loading indicator
            // when the page is not null
            itemCount: quotes.length + (value.page != null ? 1 : 0),
            itemBuilder: (context, index) {
              // check if the index is equal to the length of the quotes
              // and the page is not null.
              // if so, show the loading indicator.
              if (index == quotes.length && value.page != null) {
                return const SizedBox.shrink();
              }

              final quote = quotes[index];
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(100 * (1 - value), 0),
                      child: child,
                    ),
                  );
                },
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
