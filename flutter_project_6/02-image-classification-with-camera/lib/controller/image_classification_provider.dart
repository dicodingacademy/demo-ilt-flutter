import 'dart:io';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/widgets.dart';
import 'package:tflite_vision_app/services/image_classification_service.dart';

class ImageClassificationViewmodel extends ChangeNotifier {
  final ImageClassificationService _service;

  ImageClassificationViewmodel(this._service) {
    _service.initHelper();
  }

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

  Future<void> runClassificationViaCamera(CameraImage camera) async {
    _classifications = await _service.inferenceCameraFrame(camera);
    notifyListeners();
  }

  Future<void> runClassificationViaGallery(String imagePath) async {
    _imagePath = imagePath;

    final imageData = File(_imagePath).readAsBytesSync();

    final image = img.decodeImage(imageData);

    if (image != null) {
      _classifications = await _service.inferenceGalleryFrame(image);
      notifyListeners();
    }
  }

  Future<void> close() async {
    await _service.close();
  }
}
