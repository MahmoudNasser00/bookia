class LoginModel {
  final String token;
  final String name;
  final String email;
  final String image;

  LoginModel({
    required this.token,
    required this.name,
    required this.email,
    required this.image,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json["data"]["token"],
      name: json["data"]["user"]["name"],
      email: json["data"]["user"]["email"],
      image: json["data"]["user"]["image"],
    );
  }
}
