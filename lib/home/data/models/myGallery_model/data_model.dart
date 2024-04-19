class ProductData {
  final String title;
  final int id;
  final int accountID;
  final double price;
  final String image;

  ProductData({
    required this.title,
    required this.accountID,
    required this.id,
    required this.price,
    required this.image,
  });

  // Convert Product object to a Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'image': image,
      'id': id,
      'accountID': accountID,
    };
  }
}