import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
      appBar: AppBar(
        title: const Text('WAIFU.PICS'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 30),
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: waifuModels[index],
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return WaifuListContainer(waifuModel: snapshot.data!);
              }
              if (snapshot.hasError) {
                return _buildErrorWidget(index);
              }
              return _buildShimmerLoading(context);
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: waifuModels.length,
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                width: 120,
                height: 28,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 15),
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(int index) {
    return SizedBox(
      height: 250,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 8),
            Text(
              'Failed to load ${ApiService.sfwCategories[index]}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  waifuModels[index] = ApiService.getWaifuPicture(
                    'sfw',
                    ApiService.sfwCategories[index],
                  );
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
