class RegistarModel {
  final String token;
  final String name;
  final String email;
  final String image;

  RegistarModel({
    required this.token,
    required this.name,
    required this.email,
    required this.image,
  });

  factory RegistarModel.fromJson(Map<String, dynamic> json) {
    return RegistarModel(
      token: json["data"]["token"],
      name: json["data"]["user"]["name"],
      email: json["data"]["user"]["email"],
      image: json["data"]["user"]["image"],
    );
  }
}
