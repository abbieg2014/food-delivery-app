import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_screen.dart';

class TacoStoreHub extends StatelessWidget {
  const TacoStoreHub({super.key}); // Add a const constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taco Store'),
      ),
      body: ListView(
        children: <Widget>[
          _buildMenuItem(context, 'Beef Taco', 'Seasoned ground beef, lettuce, and cheese', 2.99),
          _buildMenuItem(context, 'Chicken Taco', 'Grilled chicken, salsa, and onions', 3.49),
          _buildMenuItem(context, 'Carnitas Taco', 'Slow-cooked pork, cilantro, and lime', 3.99),
          _buildMenuItem(context, 'Veggie Taco', 'Black beans, corn, peppers, and avocado', 3.29),
          // Add more taco items as needed
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String name, String description, double price) {
    return ListTile(
      title: Text(name),
      subtitle: Text(description),
      trailing: Text('\$${price.toStringAsFixed(2)}'),
      onTap: () {
        // Show the dialog when the item is tapped
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Add to Cart?"),
              content: Text("Do you want to add $name to your cart?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Dismiss the dialog (No)
                  },
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    final cartProvider = Provider.of<CartProvider>(context, listen: false); // Get the provider
                    cartProvider.addItem(CartItem(name: name, price: price)); // Add to cart
                    Navigator.push( 
                      context,
                      MaterialPageRoute(builder: (context) => const CartScreen()),
                    );
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}


