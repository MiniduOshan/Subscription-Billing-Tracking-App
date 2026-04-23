import 'package:flutter/material.dart';

class CalendarViewScreen extends StatelessWidget {
  const CalendarViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Calendar',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  height: 220,
                  child: Center(
                    child: Text(
                      'Calendar widget placeholder\n(table_calendar integration-ready)',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Bills due on selected date'),
                SizedBox(height: 8),
                ListTile(
                  title: Text('Gym Membership'),
                  subtitle: Text('USD 30.00'),
                ),
                ListTile(
                  title: Text('Software License'),
                  subtitle: Text('USD 19.00'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
