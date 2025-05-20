import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite_vision_app/controller/image_classification_provider.dart';
import 'package:tflite_vision_app/widget/classification_item.dart';

class ClassificationResult extends StatelessWidget {
  const ClassificationResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageClassificationViewmodel>(
      builder: (_, updateViewmodel, __) {
        final classifications = updateViewmodel.classificationList;

        return classifications.isEmpty
            ? const SizedBox.shrink()
            : Column(
              children: List.generate(
                3,
                (index) =>
                    index >= classifications.length
                        ? ClassificatioinItem(item: "", value: "")
                        : ClassificatioinItem(
                          item: classifications[index].$1,
                          value: classifications[index].$2,
                        ),
              ),
            );
      },
    );
  }
}
