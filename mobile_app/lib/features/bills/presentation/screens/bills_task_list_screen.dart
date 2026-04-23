import 'package:flutter/material.dart';

class BillsTaskListScreen extends StatelessWidget {
  const BillsTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _FilterChip(label: 'All', color: Color(0xFF0E5AE8)),
            _FilterChip(label: 'Pending', color: Color(0xFFB45309)),
            _FilterChip(label: 'Paid', color: Color(0xFF047857)),
            _FilterChip(label: 'Overdue', color: Color(0xFFBE123C)),
            _FilterChip(label: 'Upcoming', color: Color(0xFF0369A1)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search bills',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.sort),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.filter_alt),
              label: const Text('Filter'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const _BillCard(
          title: 'Internet Bill',
          amount: 'USD 55.00',
          due: 'Due today',
          status: 'Pending',
          statusColor: Color(0xFFB45309),
        ),
        const _BillCard(
          title: 'Cloud Hosting',
          amount: 'USD 29.00',
          due: 'Overdue by 2 days',
          status: 'Overdue',
          statusColor: Color(0xFFBE123C),
        ),
      ],
    );
  }
}

class _BillCard extends StatelessWidget {
  const _BillCard({
    required this.title,
    required this.amount,
    required this.due,
    required this.status,
    required this.statusColor,
  });

  final String title;
  final String amount;
  final String due;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.receipt_long, color: statusColor),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Chip(
                  label: Text(status),
                  backgroundColor: statusColor.withAlpha(25),
                  labelStyle: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(amount, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(due),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: status == 'Overdue' ? 0.95 : 0.6,
              minHeight: 7,
              borderRadius: BorderRadius.circular(8),
              color: statusColor,
              backgroundColor: statusColor.withAlpha(38),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.snooze),
                  label: const Text('Snooze'),
                ),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                  label: const Text('Mark Paid'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: color.withAlpha(25),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w700),
    );
  }
}
