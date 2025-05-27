import 'package:flutter/material.dart';
import 'package:ui_error_app/model/tourism.dart';
import 'package:ui_error_app/widget/place_image.dart';

class PlaceView extends StatelessWidget {
  const PlaceView({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    // todo-overflow: fix this overflow error
    // wrap the Column with SingleChildScrollView
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          PlaceImage(imageUrl: place.image),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8,
            children: [
              Expanded(
                child:
                // todo-overflow: fix this overflow error
                // wrap the Column with Expanded or Flexible
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // todo-overflow: fix this overflow error
                    // and set Text with maxLines to 1
                    // and overflow to TextOverflow.ellipsis
                    Text(
                      place.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      place.address,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color: Colors.red),
                  Text(
                    place.like.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
          Text(
            place.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
