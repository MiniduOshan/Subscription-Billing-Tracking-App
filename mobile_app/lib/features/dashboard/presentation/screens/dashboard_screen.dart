import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
              colors: [Color(0xFF0E5AE8), Color(0xFF20B5FF)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x332563EB),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Monthly Snapshot',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'You are 12% under your average monthly spend. Keep it going.',
                style: TextStyle(color: Color(0xFFE8F0FF)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _MetricCard(
              title: 'Active Subscriptions',
              value: '18',
              color: Color(0xFF0E5AE8),
              icon: Icons.subscriptions,
            ),
            _MetricCard(
              title: 'Unpaid Bills',
              value: '7',
              color: Color(0xFFB45309),
              icon: Icons.pending_actions,
            ),
            _MetricCard(
              title: 'Paid This Month',
              value: 'USD 489.99',
              color: Color(0xFF047857),
              icon: Icons.paid,
            ),
            _MetricCard(
              title: 'Overdue',
              value: '3',
              color: Color(0xFFBE123C),
              icon: Icons.warning_amber_rounded,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upcoming Due Payments',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0x1A0E5AE8),
                    child: Icon(Icons.receipt_long, color: Color(0xFF0E5AE8)),
                  ),
                  title: Text('Cloud Hosting - USD 29.00'),
                  subtitle: Text('Due tomorrow'),
                ),
                const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0x1A0EA5A5),
                    child: Icon(Icons.wifi, color: Color(0xFF0EA5A5)),
                  ),
                  title: Text('Internet Bill - USD 55.00'),
                  subtitle: Text('Due in 2 days'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String title;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: 10),
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
