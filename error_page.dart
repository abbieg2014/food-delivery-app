import 'package:flutter/material.dart';
import 'auth_page.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AuthPage()),
            );
          },
        ),
      ),
      body: const Center(
        child: Text('Unsuccessful login.', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
