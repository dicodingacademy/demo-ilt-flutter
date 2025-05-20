import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:flutter/widgets.dart';
import 'package:tflite_vision_app/services/image_classification_service.dart';

// todo-04-viewmodel-01: create a viewmodel notifier
class ImageClassificationViewmodel extends ChangeNotifier {
  // todo-04-viewmodel-02: create a constructor
  final ImageClassificationService _service;

  ImageClassificationViewmodel(this._service) {
    _service.initHelper();
  }

  // todo-04-viewmodel-03: create a state and getter to get a top three on classification item
  Map<String, num> _classifications = {};

  Map<String, num> get classifications => Map.fromEntries(
    (_classifications.entries.toList()
          ..sort((a, b) => a.value.compareTo(b.value)))
        .reversed
        .take(3),
  );

  List<(String, String)> get classificationList =>
      classifications.entries
          .map((e) => (e.key, e.value.toStringAsFixed(2)))
          .toList();

  String _imagePath = "";

  String get imagePath => _imagePath;

  Future<void> runClassificationViaGallery(String imagePath) async {
    _imagePath = imagePath;

    final imageData = File(_imagePath).readAsBytesSync();

    final image = img.decodeImage(imageData);

    if (image != null) {
      _classifications = await _service.inferenceGalleryFrame(image);
      notifyListeners();
    }
  }

  // todo-04-viewmodel-05: close everything
  Future<void> close() async {
    await _service.close();
  }
}
