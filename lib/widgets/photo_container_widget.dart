import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:waifupics/models/waifu_model.dart';

class PhotoContainer extends StatelessWidget {
  final WaifuModel waifuModel;
  final int index;

  const PhotoContainer({
    super.key,
    required this.waifuModel,
    required this.index,
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
        imageUrl: waifuModel.photos[index],
        placeholder: (context, url) => Container(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
