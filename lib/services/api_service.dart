import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waifupics/models/waifu_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.waifu.pics';

  static Future<WaifuModel> getWaifuPictures(
      String type, String category) async {
    final url = Uri.parse('$baseUrl/many/$type/$category');
    final response = await http.post(
      url,
      body: {'exculde': ''},
    );
    if (response.statusCode == 200) {
      final photos = jsonDecode(response.body);
      return WaifuModel.fromJson({
        'type': type,
        'category': category,
        'photos': photos['files'],
      });
    } else {
      throw Error();
    }
  }
}
