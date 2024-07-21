import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.lightBlue.shade200,
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
        color: Colors.lightBlue.shade200,
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            print('Checkout button tapped!');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0), backgroundColor: Colors.orange.shade400,
          ),
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}
