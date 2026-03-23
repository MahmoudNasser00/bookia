class SliderModel {
  final int id;
  final String image;

  SliderModel({required this.id, required this.image});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(id: json["id"] ?? 0, image: json["image"] ?? "");
  }
}
