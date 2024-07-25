import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_screen.dart';

class PizzaStoreHub extends StatelessWidget {
  const PizzaStoreHub({super.key}); // Add a const constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Store'),
      ),
      body: ListView(
        children: <Widget>[
          _buildMenuItem(context, 'Pepperoni Pizza', 'Classic pepperoni with mozzarella cheese', 14.99),
          _buildMenuItem(context, 'Margherita Pizza', 'Fresh basil, tomatoes, and mozzarella', 13.99),
          _buildMenuItem(context, 'Supreme Pizza', 'Pepperoni, sausage, peppers, onions, mushrooms', 16.99),
          _buildMenuItem(context, 'Hawaiian Pizza', 'Ham and pineapple with mozzarella cheese', 15.99),
          // Add more pizza items as needed
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


