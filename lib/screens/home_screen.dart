import 'package:flutter/material.dart';
import 'package:waifupics/models/waifu_model.dart';
import 'package:waifupics/services/api_service.dart';
import 'package:waifupics/widgets/waifu_list_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Future<WaifuModel>> waifuModels = [];

  @override
  void initState() {
    super.initState();
    for (var category in ApiService.sfwCategories) {
      waifuModels.add(ApiService.getWaifuPicture('sfw', category));
    }
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
      body: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
          ),
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: waifuModels[index],
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return WaifuListContainer(waifuModel: snapshot.data!);
                }
                return const SizedBox(
                  height: 250,
                );
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemCount: waifuModels.length),
    );
  }
}
