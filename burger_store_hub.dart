import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_screen.dart';

class BurgerStoreHub extends StatelessWidget {
  const BurgerStoreHub({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Burger Store'),
      ),
      body: ListView(
        children: <Widget>[
          _buildMenuItem(context, 'Classic Burger', 'Juicy beef patty with lettuce, tomato, and onion', 10.99),
          _buildMenuItem(context, 'Bacon Cheeseburger', 'Classic with crispy bacon and melted cheese', 12.99),
          _buildMenuItem(context, 'Veggie Burger', 'Plant-based patty with avocado and sprouts', 9.99),
          _buildMenuItem(context, 'Mushroom Swiss Burger', 'Topped with sautéed mushrooms and Swiss cheese', 11.99),
          // Add more burger items as needed
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

