import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;

  const PhotoContainer({
    super.key,
    required this.snapshot,
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
      child: Image.network(snapshot.data!.photos[index]),
    );
  }
}
