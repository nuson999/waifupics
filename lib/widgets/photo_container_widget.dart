import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PhotoContainer extends StatelessWidget {
  final String imgSrc;

  const PhotoContainer({
    super.key,
    required this.imgSrc,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shadowColor = isDark
        ? Colors.black.withOpacity(0.6)
        : Colors.black.withOpacity(0.4);
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Container(
      constraints: const BoxConstraints(
        minWidth: 100,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: CachedNetworkImage(
        imageUrl: imgSrc,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            width: 140,
            color: baseColor,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: 140,
          color: isDark ? Colors.grey[900] : Colors.grey[200],
          child: Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
