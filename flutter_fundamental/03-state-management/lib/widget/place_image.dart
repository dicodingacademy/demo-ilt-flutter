import 'package:flutter/material.dart';

class PlaceImage extends StatelessWidget {
  const PlaceImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (_, _, _) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: width ?? 0,
            minHeight: height ?? 200,
            maxWidth: width ?? double.infinity,
            maxHeight: height ?? 200,
          ),
          child: const Center(child: Icon(Icons.error)),
        );
      },
    );
  }
}
