import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Card(
          child: ListTile(
            leading: Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFB45309),
            ),
            title: Text('Internet bill is due tomorrow'),
            subtitle: Text('Reminder sent 2 hours ago'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.error_outline, color: Color(0xFFBE123C)),
            title: Text('Cloud Hosting is overdue'),
            subtitle: Text('Tap to open bill details'),
          ),
        ),
      ],
    );
  }
}
