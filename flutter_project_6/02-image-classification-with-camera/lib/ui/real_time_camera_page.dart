import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite_vision_app/controller/image_classification_provider.dart';
import 'package:tflite_vision_app/widget/camera_view.dart';
import 'package:tflite_vision_app/widget/classification_result.dart';

class RealTimeCameraPage extends StatelessWidget {
  const RealTimeCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.read<ImageClassificationViewmodel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Real-time Camera'),
      ),
      body: ColoredBox(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              // todo: change this widget into a camera widget
              child: Center(
                child: CameraView(
                  onImage: (cameraImage) async {
                    await viewmodel.runClassificationViaCamera(cameraImage);
                  },
                ),
              ),
            ),
            ClassificationResult(),
          ],
        ),
      ),
    );
  }
}
