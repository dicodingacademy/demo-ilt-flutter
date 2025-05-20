import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite_vision_app/controller/image_classification_provider.dart';
import 'package:tflite_vision_app/widget/classification_result.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Image Picker'),
      ),
      body: ColoredBox(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer<ImageClassificationViewmodel>(
                builder: (_, viewmodel, __) {
                  final imagePath = viewmodel.imagePath;
                  return imagePath.isEmpty
                      ? Text("Empty")
                      : Image.file(File(imagePath), fit: BoxFit.contain);
                },
              ),
            ),
            ClassificationResult(),
          ],
        ),
      ),
    );
  }
}
