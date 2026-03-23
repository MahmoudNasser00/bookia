class BookModel {
  final int id;
  final String name;
  final String image;
  final double price;

  BookModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      price: double.parse(json["price"].toString()),
    );
  }
}