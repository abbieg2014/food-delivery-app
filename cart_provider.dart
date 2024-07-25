import 'package:flutter/foundation.dart';
import 'cart_screen.dart'; 

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItem(CartItem item) {
    _cartItems.add(item);
    notifyListeners(); 
  }
    void removeItem(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

}
