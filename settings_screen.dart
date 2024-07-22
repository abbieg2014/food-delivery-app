import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.lightBlue.shade200,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const Text(
              'Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Account Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Manage Account'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to account settings screen or handle account settings logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigate to Account Settings')),
                );
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Addresses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Manage Addresses'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to address management screen or handle address management logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigate to Manage Addresses')),
                );
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Payment Methods',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Manage Payment Methods'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to payment methods screen or handle payment methods logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigate to Manage Payment Methods')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
