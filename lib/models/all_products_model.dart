class AllProductsModel {
  final int id;
  final String title;
  final String imageUrl;
  final double price;
  final String? shortDescription;

  AllProductsModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.shortDescription,
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) {
    return AllProductsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: (json['image_url'] ?? '').replaceFirst('127.0.0.1', '10.0.2.2'),
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      shortDescription: json['short_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'price': price,
      'short_description': shortDescription,
    };
  }
}