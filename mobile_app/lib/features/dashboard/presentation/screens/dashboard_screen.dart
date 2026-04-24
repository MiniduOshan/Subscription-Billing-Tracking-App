import 'package:flutter/material.dart';
import '../../../../core/data/dummy_data.dart';
import '../../../subscriptions/domain/models/subscription.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalMonthly = DummyData.totalMonthlySpend;
    final upcomingTotal = DummyData.upcomingPaymentsTotal;
    final activeCount = DummyData.subscriptions.length;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        _buildHeader(context, totalMonthly),
        const SizedBox(height: 24),
        Text(
          'Overview',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _MetricCard(
              title: 'Active Subs',
              value: activeCount.toString(),
              color: theme.colorScheme.primary,
              icon: Icons.subscriptions_rounded,
            ),
            _MetricCard(
              title: 'Next 7 Days',
              value: '\$${upcomingTotal.toStringAsFixed(2)}',
              color: theme.colorScheme.tertiary,
              icon: Icons.event_repeat_rounded,
            ),
            _MetricCard(
              title: 'Categories',
              value: SubscriptionCategory.values.length.toString(),
              color: theme.colorScheme.secondary,
              icon: Icons.category_rounded,
            ),
            _MetricCard(
              title: 'Avg. Monthly',
              value: '\$${(totalMonthly / 12).toStringAsFixed(2)}',
              color: const Color(0xFF8B5CF6),
              icon: Icons.analytics_rounded,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Payments',
              style: theme.textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...DummyData.subscriptions.take(3).map((sub) => _UpcomingPaymentTile(sub: sub)),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, double total) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withAlpha(200),
            const Color(0xFF4F46E5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withAlpha(60),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Monthly Spend',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withAlpha(200),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.trending_down, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '12%',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: theme.textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _headerInfoItem('Bills', '24', Icons.receipt_long),
              const SizedBox(width: 24),
              _headerInfoItem('Subscriptions', '12', Icons.autorenew),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withAlpha(160), size: 18),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withAlpha(160),
                fontSize: 12,
              ),
            ),
          ],
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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withAlpha(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black.withAlpha(120),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UpcomingPaymentTile extends StatelessWidget {
  final Subscription sub;
  const _UpcomingPaymentTile({required this.sub});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysUntil = sub.nextBillingDate.difference(DateTime.now()).inDays;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withAlpha(10)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: sub.color.withAlpha(20),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(sub.icon, color: sub.color, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sub.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Due in $daysUntil days',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: daysUntil < 3 ? theme.colorScheme.error : Colors.black.withAlpha(120),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${sub.amount.toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                sub.billingCycle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black.withAlpha(100),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
