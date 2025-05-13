import 'package:flutter/material.dart';

import '../model/quote.dart';

class QuoteDetailsScreen extends StatelessWidget {
  final Quote quote;

  const QuoteDetailsScreen({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(quote.author)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(quote.author, style: Theme.of(context).textTheme.titleLarge),
            Text(quote.quote, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
