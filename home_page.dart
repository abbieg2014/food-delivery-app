import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_page.dart';
import 'cart_screen.dart';
import 'settings_screen.dart';
import 'burger_store_hub.dart';
import 'pizza_store_hub.dart';
import 'taco_store_hub.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; 

  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Search Page')),
    Center(child: Text('Home Page')),   
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
      } else {
        _selectedIndex = index;
      }
    });
  }

  void _navigateToStore(Widget storePage) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => storePage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue, 
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthPage()),
              );
            },
          ),
        ],
      ),
       body: Container(
        color: Colors.lightBlue.shade200,
        child: _selectedIndex == 2
            ? _widgetOptions.elementAt(_selectedIndex)
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
        
                    InkWell( 
                      onTap: () => _navigateToStore(const BurgerStoreHub()),
                      child: Image.asset(
                        'assets/images/burger.jpg', 
                        width: 150,
                        height: 150,
                      ),
                    ),
                    
                    InkWell(
                      onTap: () => _navigateToStore(const PizzaStoreHub()),
                      child: Image.asset(
                        'assets/images/pizza.jpg',  
                        width: 150,
                        height: 150,
                      ),
                    ),
                    
                    InkWell(
                      onTap: () => _navigateToStore(const TacoStoreHub()),
                      child: Image.asset(
                        'assets/images/taco.jpg', 
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),   
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),   
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        backgroundColor: Colors.blue, 
        onTap: _onItemTapped,
      ),
    );
  }
}

