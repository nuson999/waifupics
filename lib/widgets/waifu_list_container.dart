import 'package:flutter/material.dart';
import 'package:waifupics/models/waifu_model.dart';
import 'package:waifupics/screens/detail_screen.dart';
import 'package:waifupics/widgets/photo_container_widget.dart';

class WaifuListContainer extends StatelessWidget {
  const WaifuListContainer({
    super.key,
    required this.waifuModel,
  });

  final WaifuModel waifuModel;

  @override
  Widget build(BuildContext context) {
    print('waifuModel.photos.length: ${waifuModel.photos.length}');
    return SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              waifuModel.category.toUpperCase(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                print('${waifuModel.type}/${waifuModel.category}/$index');
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailScreen(
                              waifuModel: waifuModel, index: index);
                        },
                      ),
                    );
                  },
                  child: Hero(
                      tag: '${waifuModel.type}/${waifuModel.category}/$index',
                      child: PhotoContainer(imgSrc: waifuModel.photos[index])),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 15,
              ),
              itemCount: waifuModel.photos.length,
            ),
          ),
        ],
      ),
    );
  }
}
