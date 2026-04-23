import 'package:flutter/material.dart';

class EditSubscriptionScreen extends StatelessWidget {
  const EditSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Subscription')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextField(decoration: InputDecoration(labelText: 'Name')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Amount')),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: 'active',
            decoration: const InputDecoration(labelText: 'Status'),
            items: const [
              DropdownMenuItem(value: 'active', child: Text('Active')),
              DropdownMenuItem(value: 'paused', child: Text('Paused')),
              DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
            ],
            onChanged: (_) {},
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
