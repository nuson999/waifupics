import 'package:flutter/material.dart';
import 'package:waifupics/models/waifu_model.dart';
import 'package:waifupics/widgets/photo_container_widget.dart';

class DetailScreen extends StatelessWidget {
  final WaifuModel waifuModel;
  final int index;

  const DetailScreen({
    super.key,
    required this.waifuModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          waifuModel.category,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Hero(
          tag: '${waifuModel.type}/${waifuModel.category}/$index',
          child: PhotoContainer(waifuModel: waifuModel, index: index),
        ),
      ),
    );
  }
}
