class Product {
  final String name;
  final String image;
  final double price;
  bool isInCart;

  Product(
      {required this.name,
      required this.image,
      required this.price,
      this.isInCart = false});
}
