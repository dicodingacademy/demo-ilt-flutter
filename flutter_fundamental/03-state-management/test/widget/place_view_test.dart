import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_error_app/model/tourism.dart';
import 'package:ui_error_app/widget/place_image.dart';
import 'package:ui_error_app/widget/place_view.dart';

// your layout have all about the data to show
void main() {
  final mockPlace = Place(
    id: 1,
    name: 'Wonderful Place Name',
    description: 'This is a detailed description of the wonderful place.',
    address: '123 Main Street, Paradise City, Wonderland',
    like: 42,
    image: 'https://example.com/image.jpg',
  );

  testWidgets(
    "PlaceView must contain all Tourism Data, like name, description, address, likes, and image",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: PlaceView(place: mockPlace))),
      );

      // Verify that all expected data points are found.
      expect(find.text(mockPlace.name), findsOneWidget);
      expect(find.text(mockPlace.description), findsOneWidget);
      expect(find.text(mockPlace.address), findsOneWidget);
      expect(find.text(mockPlace.like.toString()), findsOneWidget);
      expect(find.byType(PlaceImage), findsOneWidget);

      // Optionally, verify the imageUrl passed to PlaceImage.
      final placeImageWidget = tester.widget<PlaceImage>(
        find.byType(PlaceImage),
      );
      expect(placeImageWidget.imageUrl, mockPlace.image);
    },
  );
}
