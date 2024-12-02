import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  final String imgSrc;

  const PhotoContainer({
    super.key,
    required this.imgSrc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      // child: Image.network(waifuModel.photos[index]),
      child: CachedNetworkImage(
        imageUrl: imgSrc,
        placeholder: (context, url) => Container(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
