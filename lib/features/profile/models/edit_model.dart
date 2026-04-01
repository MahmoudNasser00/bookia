class EditModel {
  final String name;
  final String email;
  final String phone;
  final String address;

  EditModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory EditModel.fromJson(Map<String, dynamic> json) {
    return EditModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
    );
  }
}
