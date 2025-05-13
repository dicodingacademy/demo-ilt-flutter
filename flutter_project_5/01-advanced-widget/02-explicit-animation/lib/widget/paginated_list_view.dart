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
