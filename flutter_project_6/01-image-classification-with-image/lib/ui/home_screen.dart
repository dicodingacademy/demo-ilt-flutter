import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tflite_vision_app/controller/image_classification_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            FilledButton(
              onPressed: () => pickImage(context, source: ImageSource.gallery),
              child: Text("Run Inference via Gallery."),
            ),
            FilledButton(
              onPressed: () => pickImage(context, source: ImageSource.camera),
              child: Text("Run Inference via Camera."),
            ),
          ],
        ),
      ),
    );
  }

  void pickImage(BuildContext context, {required ImageSource source}) async {
    final navigator = Navigator.of(context);
    final viewmodel = context.read<ImageClassificationViewmodel>();

    final imagePicker = ImagePicker();
    final result = await imagePicker.pickImage(source: source);

    if (result != null) {
      await viewmodel.runClassificationViaGallery(result.path);
      navigator.pushNamed("/image-picker");
    }
  }
}
