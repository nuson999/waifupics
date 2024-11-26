import 'package:flutter/material.dart';
import 'package:waifupics/models/waifu_model.dart';
import 'package:waifupics/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<WaifuModel> waifuPhotos;

  @override
  void initState() {
    super.initState();
    waifuPhotos = ApiService.getWaifuPictures('sfw', 'waifu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WAIFU.PICS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder(
                future: waifuPhotos,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
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
                                child:
                                    Image.network(snapshot.data!.photos[index]),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 15,
                            ),
                            itemCount: snapshot.data!.photos.length,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text('...');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
