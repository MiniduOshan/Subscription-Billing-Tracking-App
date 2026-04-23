import 'package:flutter/material.dart';

class SubscriptionListScreen extends StatelessWidget {
  const SubscriptionListScreen({
    super.key,
    required this.onOpenDetails,
    required this.onOpenEdit,
  });

  final VoidCallback onOpenDetails;
  final VoidCallback onOpenEdit;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search subscriptions',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.music_note)),
            title: const Text('Music Pro'),
            subtitle: const Text('Monthly - USD 9.99 - Due 2026-05-01'),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'view') {
                  onOpenDetails();
                } else if (value == 'edit') {
                  onOpenEdit();
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'view', child: Text('View details')),
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
