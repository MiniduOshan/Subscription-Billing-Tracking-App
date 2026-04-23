import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF0F766E), Color(0xFF06B6D4)],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin Analytics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Realtime overview of users, billing activity and payment trends.',
                style: TextStyle(color: Color(0xFFE0F2FE)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _AdminMetric(
              label: 'Users',
              value: '1,284',
              color: Color(0xFF0E5AE8),
            ),
            _AdminMetric(
              label: 'Total Subscriptions',
              value: '6,492',
              color: Color(0xFF0F766E),
            ),
            _AdminMetric(
              label: 'Payment Volume',
              value: 'USD 87,322',
              color: Color(0xFFB45309),
            ),
            _AdminMetric(
              label: 'Overdue Rate',
              value: '7.2%',
              color: Color(0xFFBE123C),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Spend')),
              DataColumn(label: Text('Trend')),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('Software')),
                  DataCell(Text('USD 23,120')),
                  DataCell(Text('+5.2%')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('Utilities')),
                  DataCell(Text('USD 14,002')),
                  DataCell(Text('+1.1%')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('Hosting')),
                  DataCell(Text('USD 11,845')),
                  DataCell(Text('-0.4%')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AdminMetric extends StatelessWidget {
  const _AdminMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        child: ListTile(
          title: Text(label),
          leading: CircleAvatar(
            backgroundColor: color.withAlpha(28),
            child: Icon(Icons.insights, color: color),
          ),
          subtitle: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: color),
          ),
        ),
      ),
    );
  }
}
