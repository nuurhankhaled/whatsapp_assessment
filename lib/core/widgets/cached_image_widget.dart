import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CachedNetworkImageWidget extends StatelessWidget {
  CachedNetworkImageWidget(
      {super.key, required this.imageUrl, this.fit, this.width, this.height});
  String imageUrl;
  BoxFit? fit;
  double? width;
  double? height;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: fit,
      imageUrl: imageUrl,
    );
  }
}
