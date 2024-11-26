class WaifuModel {
  late final String type, category;
  late final List<dynamic> photos;

  WaifuModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        category = json['category'],
        photos = json['photos'];
}
