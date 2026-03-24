class ProfileModel {
  final String name;
  final String email;
  final String image;
  final String address;
  final String phone;
  final String city;

  ProfileModel({
    required this.name,
    required this.email,
    required this.image,
    required this.address,
    required this.phone,
    required this.city,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      image: json["image"] ?? "",
      address: json["address"] ?? "",
      phone: json["phone"] ?? "",
      city: json["city"] ?? "",
    );
  }
}
