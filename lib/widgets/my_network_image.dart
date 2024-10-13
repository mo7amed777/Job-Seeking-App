import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const MyImage({
    super.key, // Use the super parameter for key
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      height: height,
      width: width,
      fit: fit,
      // placeholder: (context, url) => const CupertinoActivityIndicator(),
      // errorWidget: (context, url, error) {
      //   debugPrint('Image load error: $error');
      //   return const Icon(Icons.hide_image_outlined);
      // },
    );
  }
}
