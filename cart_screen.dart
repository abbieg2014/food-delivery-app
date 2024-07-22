import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.blue, // Set the app bar color to blue
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.lightBlue.shade200,
        child: const Center(
          child: Text('Cart Screen'),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue, // Set the bottom container color to blue
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CheckoutScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0), backgroundColor: Colors.orange, // Set the button background color to orange
          ),
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}
