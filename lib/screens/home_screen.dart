import 'package:flutter/material.dart';
import 'package:waifupics/models/waifu_model.dart';
import 'package:waifupics/services/api_service.dart';
import 'package:waifupics/widgets/photo_container_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<WaifuModel>> waifuModels;

  @override
  void initState() {
    super.initState();
    waifuModels = ApiService.getWaifuPictures('sfw');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'WAIFU.PICS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: waifuModels,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return WaifuListContainer(
                            waifuModel: snapshot.data![index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 1,
                          ),
                      itemCount: snapshot.data!.length),
                ),
              ],
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class WaifuListContainer extends StatelessWidget {
  const WaifuListContainer({
    super.key,
    required this.waifuModel,
  });

  final WaifuModel waifuModel;

  @override
  Widget build(BuildContext context) {
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
                return PhotoContainer(waifuModel: waifuModel, index: index);
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


// class WaifuListContainer extends StatelessWidget {
//   const WaifuListContainer({
//     super.key,
//     required this.waifuModel,
//   });

//   final Future<WaifuModel> waifuModel;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 250,
//       child: FutureBuilder(
//         future: waifuModel,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     snapshot.data!.category.toUpperCase(),
//                     style: const TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.separated(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 20),
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       if (snapshot.hasData) {
//                         return PhotoContainer(snapshot: snapshot, index: index);
//                       }
//                       return null;
//                     },
//                     separatorBuilder: (context, index) => const SizedBox(
//                       width: 15,
//                     ),
//                     itemCount: snapshot.data!.photos.length,
//                   ),
//                 ),
//               ],
//             );
//           }
//           return const Text('...');
//         },
//       ),
//     );
//   }
// }
