import 'package:flutter/material.dart';

class SubscriptionDetailsScreen extends StatelessWidget {
  const SubscriptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(title: Text('Name'), subtitle: Text('Music Pro')),
          ListTile(title: Text('Status'), subtitle: Text('Active')),
          ListTile(title: Text('Cycle'), subtitle: Text('Monthly')),
          ListTile(title: Text('Amount'), subtitle: Text('USD 9.99')),
          ListTile(title: Text('Due date'), subtitle: Text('2026-05-01')),
          ListTile(
            title: Text('Reminder'),
            subtitle: Text('3 days before due date'),
          ),
          ListTile(
            title: Text('Payment method'),
            subtitle: Text('Visa ending 2339'),
          ),
        ],
      ),
    );
  }
}
