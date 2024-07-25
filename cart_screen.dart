import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'checkout_screen.dart';
import 'cart_provider.dart';

class CartItem {
  final String name;
  final double price;

  CartItem({required this.name, required this.price}); 
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key}); 
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
    double total = cartItems.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.lightBlue.shade200,
        child: cartItems.isEmpty
            ? const Center(child: Text('Your cart is empty'))
            : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Dismissible( 
                    key: Key(item.name), // Unique key for each item
                    onDismissed: (direction) {
                      cartProvider.removeItem(item); // Remove item from the cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item.name} removed from cart')),
                      );
                    },
                    child: ListTile(
                      title: Text(item.name),
                      trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,  // To avoid bottom overflow
          children: [
            Text('Total: \$${total.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: cartItems.isNotEmpty ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                );
              } : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                backgroundColor: Colors.orange,
              ),
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
