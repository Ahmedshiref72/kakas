class Product {
  final String title;
  final double price;
  final String image;

  Product({
    required this.title,
    required this.price,
    required this.image,
  });

  // Convert Product object to a Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'image': image,
    };
  }
}
