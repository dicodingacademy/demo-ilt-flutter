
import 'package:flutter/material.dart';
import 'package:ui_error_app/model/tourism.dart';
import 'package:ui_error_app/widget/place_image.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.item,
  });

  final Place item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlaceImage(
              imageUrl: item.image,
              width: 150,
              height: 90,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                spacing: 4,
                children: [
                  Text(
                    item.name,
                    style:
                        Theme.of(
                          context,
                        ).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.description,
                    style:
                        Theme.of(
                          context,
                        ).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
