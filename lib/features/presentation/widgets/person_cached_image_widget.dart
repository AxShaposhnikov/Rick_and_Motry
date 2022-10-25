import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PersonCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width, height;

  const PersonCachedImage(
      {Key? key, required this.imageUrl, this.width, this.height})
      : super(key: key);

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => _imageWidget(imageProvider),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
          _imageWidget(const AssetImage('assets/images/noimage.jpg')),
    );
  }
}
