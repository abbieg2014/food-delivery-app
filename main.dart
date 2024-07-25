import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'auth_page.dart';
import 'home_page.dart';
import 'error_page.dart';
import 'password_reset_page.dart';
import 'splash_screen.dart';
import 'cart_provider.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // Wrap with ChangeNotifierProvider
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Food Delivery App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        routes: {
          '/auth': (context) => const AuthPage(),
          '/home': (context) => const HomePage(),
          '/error': (context) => const ErrorPage(),
          '/password_reset': (context) => const PasswordResetPage(),
        },
      ),
    );
  }
}
