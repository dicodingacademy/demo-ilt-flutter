import 'dart:io';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as image_lib;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../utils/image_utils.dart';

class IsolateInference {
  static const String _debugName = "TFLITE_INFERENCE";
  final ReceivePort _receivePort = ReceivePort();
  late Isolate _isolate;
  late SendPort _sendPort;
  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: _debugName,
    );
    _sendPort = await _receivePort.first;
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final InferenceModel isolateModel in port) {
      final cameraImage = isolateModel.cameraImage;
      final image = isolateModel.image;
      final inputShape = isolateModel.inputShape;
      final imageMatrix = _imagePreProcessing(cameraImage, image, inputShape);

      final input = [imageMatrix];
      final output = [List<int>.filled(isolateModel.outputShape[1], 0)];
      final address = isolateModel.interpreterAddress;

      final result = _runInference(input, output, address);

      int maxScore = result.reduce((a, b) => a + b);
      final keys = isolateModel.labels;
      final values =
          result.map((e) => e.toDouble() / maxScore.toDouble()).toList();

      var classification = Map.fromIterables(keys, values);
      classification.removeWhere((key, value) => value == 0);

      isolateModel.responsePort.send(classification);
    }
  }

  Future<void> close() async {
    _isolate.kill();
    _receivePort.close();
  }

  static List<List<List<num>>> _imagePreProcessing(
    // todo: add CameraImage for camera feature
    CameraImage? cameraImage,
    image_lib.Image? image,
    List<int> inputShape,
  ) {
    image_lib.Image? img;
    // todo: get img from [image] if not null or using [cameraImage] if null.
    img = image ?? ImageUtils.convertCameraImage(cameraImage!);

    // resize original image to match model shape.
    image_lib.Image imageInput = image_lib.copyResize(
      img!,
      width: inputShape[1],
      height: inputShape[2],
    );

    // todo: if feature using camera, rotate the image about 90 degree.
    // the way to know the camera is active is by checking the image is null.
    if (Platform.isAndroid && image == null) {
      imageInput = image_lib.copyRotate(imageInput, angle: 90);
    }

    final imageMatrix = List.generate(
      imageInput.height,
      (y) => List.generate(imageInput.width, (x) {
        final pixel = imageInput.getPixel(x, y);
        return [pixel.r, pixel.g, pixel.b];
      }),
    );
    return imageMatrix;
  }

  static List<int> _runInference(
    List<List<List<List<num>>>> input,
    List<List<int>> output,
    int interpreterAddress,
  ) {
    Interpreter interpreter = Interpreter.fromAddress(interpreterAddress);
    interpreter.run(input, output);
    // Get first output tensor
    final result = output.first;
    return result;
  }
}

class InferenceModel {
  // todo: add CameraImage for camera feature
  CameraImage? cameraImage;
  image_lib.Image? image;
  int interpreterAddress;
  List<String> labels;
  List<int> inputShape;
  List<int> outputShape;
  late SendPort responsePort;

  InferenceModel(
    this.interpreterAddress,
    this.labels,
    this.inputShape,
    this.outputShape, {
    this.cameraImage,
    this.image,
  });
}
