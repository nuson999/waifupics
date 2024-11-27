import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waifupics/models/waifu_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.waifu.pics';
  static const List<String> sfwCategories = [
    "waifu",
    "neko",
    "shinobu",
    "megumin",
    "bully",
    "cuddle",
    "cry",
    "hug",
    "awoo",
    "kiss",
    "lick",
    "pat",
    "smug",
    "bonk",
    "yeet",
    "blush",
    "smile",
    "wave",
    "highfive",
    "handhold",
    "nom",
    "bite",
    "glomp",
    "slap",
    "kill",
    "kick",
    "happy",
    "wink",
    "poke",
    "dance",
    "cringe",
  ];

  static const List<String> nsfwCategories = [
    "waifu",
    "neko",
    "trap",
    "blowjob",
  ];

  static Future<List<WaifuModel>> getWaifuPictures(String type) async {
    List<WaifuModel> waifuModels = [];
    List<String> categories = type == 'sfw' ? sfwCategories : nsfwCategories;

    for (var category in categories) {
      final url = Uri.parse('$baseUrl/many/$type/$category');
      final response = await http.post(
        url,
        body: {'exculde': ''},
      );
      if (response.statusCode == 200) {
        final photos = jsonDecode(response.body);
        waifuModels.add(
          WaifuModel.fromJson(
            {
              'type': type,
              'category': category,
              'photos': photos['files'],
            },
          ),
        );
      } else {
        throw Error();
      }
    }
    print(waifuModels);
    return waifuModels;
  }
}
