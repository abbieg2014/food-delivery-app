import 'dart:async';
import 'package:flutter/material.dart';
import 'review_screen.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key}); 

  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  String _orderStatus = 'Preparing';
  String _estimatedDelivery = '30-45 minutes';
  double _progress = 0.0;
  Timer? _timer;


  @override
  void initState() {
    super.initState();

    _startTracking();
        
  }
    

  void _startTracking() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        if (_progress < 1.0) {
          _progress += 0.2; 

          // Update order status and delivery time based on progress
          if (_progress >= 0.2) _orderStatus = 'Cooking';
          if (_progress >= 0.6) _orderStatus = 'Out for Delivery';
          if (_progress >= 0.8) _estimatedDelivery = '5-10 minutes';
          if (_progress >= 1.0) {
            _orderStatus = 'Delivered';
            _timer?.cancel(); // Stop the timer when order is delivered
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer if the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Tracking'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.lightBlue.shade200,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Order Status: $_orderStatus', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text('Estimated Delivery: $_estimatedDelivery', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            LinearProgressIndicator(value: _progress), 
            const SizedBox(height: 20),
            Expanded(
                child: Image.asset(
                    'assets/images/map.jpg',
                    fit: BoxFit.cover,
                ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding( 
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const  ReviewScreen()),
            );
          },
          child: const Text('Leave a Review'),
        ),
      ),
    );
  }
}
