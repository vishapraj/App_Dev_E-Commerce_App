import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'E-Commerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductListScreen(),
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Product 1', image: 'images/product1.jpg', price: 19.99),
    Product(name: 'Product 2', image: 'images/product2.jpg', price: 19.99),
    Product(name: 'Product 3', image: 'images/product3.jpg', price: 19.99),
    Product(name: 'Product 4', image: 'images/product4.jpg', price: 19.99),
    Product(name: 'Product 5', image: 'images/product5.jpg', price: 19.99),
    Product(name: 'Product 6', image: 'images/product6.jpg', price: 19.99),
    Product(name: 'Product 7', image: 'images/product7.jpg', price: 19.99),
    Product(name: 'Product 8', image: 'images/product8.jpg', price: 19.99),
    Product(name: 'Product 9', image: 'images/product9.jpg', price: 19.99),
    Product(name: 'Product 10', image: 'images/product1.jpg', price: 19.99),
    Product(name: 'Product 11', image: 'images/product2.jpg', price: 19.99),
    Product(name: 'Product 12', image: 'images/product3.jpg', price: 19.99),
    Product(name: 'Product 13', image: 'images/product4.jpg', price: 19.99),
    Product(name: 'Product 14', image: 'images/product5.jpg', price: 19.99)

    // Add more products here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.asset(product.image, width: 50, height: 50),
            title: Text(product.name),
            subtitle: Text('\$${product.price.toString()}'),
            trailing: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                final isInCart = cartProvider.cartItems.contains(product);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: isInCart
                          ? Icon(Icons.check)
                          : Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        if (isInCart) {
                          cartProvider.removeFromCart(product);
                        } else {
                          cartProvider.addToCart(product);
                        }
                      },
                    ),
                    if (isInCart)
                      IconButton(
                        icon: Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          cartProvider.removeFromCart(product);
                        },
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return ListView.builder(
            itemCount: cartProvider.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartProvider.cartItems[index];
              return ListTile(
                leading: Image.asset(cartItem.image, width: 50, height: 50),
                title: Text(cartItem.name),
                subtitle: Text('\$${cartItem.price.toString()}'),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \$${cartProvider.total.toStringAsFixed(2)}'),
                ElevatedButton(
                  onPressed: () {
                    cartProvider.clearCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Thank you for your purchase!'),
                      ),
                    );
                  },
                  child: Text('BUY'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
