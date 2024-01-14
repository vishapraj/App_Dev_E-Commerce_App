import 'package:flutter/material.dart';
import 'product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  double get total => _cartItems.fold(0.0, (sum, item) => sum + item.price);

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
