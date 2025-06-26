class Product {
  final String? name;
  final String? imageUrl;
  final double? price;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  @override
  String toString() {
    return 'Product{name: $name, imageUrl: $imageUrl, price:$price}';
  }
}
