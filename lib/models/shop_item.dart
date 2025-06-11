class ShopItem {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;
  final String? shortDescription;

  ShopItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    this.shortDescription,
  });
}