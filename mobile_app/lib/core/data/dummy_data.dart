import 'package:flutter/material.dart';
import '../../features/subscriptions/domain/models/subscription.dart';

class DummyData {
  static List<Subscription> subscriptions = [
    Subscription(
      id: '1',
      name: 'Netflix',
      description: 'Standard Plan - HD',
      amount: 15.49,
      currency: 'USD',
      nextBillingDate: DateTime.now().add(const Duration(days: 5)),
      category: SubscriptionCategory.entertainment,
      icon: Icons.movie_outlined,
      color: const Color(0xFFE50914),
      billingCycle: 'Monthly',
    ),
    Subscription(
      id: '2',
      name: 'Spotify',
      description: 'Premium Family',
      amount: 16.99,
      currency: 'USD',
      nextBillingDate: DateTime.now().add(const Duration(days: 12)),
      category: SubscriptionCategory.entertainment,
      icon: Icons.music_note_outlined,
      color: const Color(0xFF1DB954),
      billingCycle: 'Monthly',
    ),
    Subscription(
      id: '3',
      name: 'ChatGPT Plus',
      description: 'GPT-4 Access',
      amount: 20.00,
      currency: 'USD',
      nextBillingDate: DateTime.now().add(const Duration(days: 20)),
      category: SubscriptionCategory.productivity,
      icon: Icons.auto_awesome_outlined,
      color: const Color(0xFF10A37F),
      billingCycle: 'Monthly',
    ),
    Subscription(
      id: '4',
      name: 'Adobe Creative Cloud',
      description: 'All Apps Plan',
      amount: 54.99,
      currency: 'USD',
      nextBillingDate: DateTime.now().add(const Duration(days: 2)),
      category: SubscriptionCategory.productivity,
      icon: Icons.brush_outlined,
      color: const Color(0xFFFF0000),
      billingCycle: 'Monthly',
    ),
    Subscription(
      id: '5',
      name: 'Google One',
      description: '2TB Storage',
      amount: 9.99,
      currency: 'USD',
      nextBillingDate: DateTime.now().add(const Duration(days: 15)),
      category: SubscriptionCategory.utilities,
      icon: Icons.cloud_outlined,
      color: const Color(0xFF4285F4),
      billingCycle: 'Monthly',
    ),
    Subscription(
      id: '6',
      name: 'PlayStation Plus',
      description: 'Essential Annual',
      amount: 79.99,
      currency: 'USD',
      nextBillingDate: DateTime.now().add(const Duration(days: 45)),
      category: SubscriptionCategory.entertainment,
      icon: Icons.sports_esports_outlined,
      color: const Color(0xFF003087),
      billingCycle: 'Yearly',
    ),
  ];

  static double get totalMonthlySpend {
    return subscriptions
        .where((s) => s.billingCycle == 'Monthly')
        .fold(0, (sum, item) => sum + item.amount);
  }

  static double get upcomingPaymentsTotal {
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));
    return subscriptions
        .where((s) => s.nextBillingDate.isAfter(now) && s.nextBillingDate.isBefore(nextWeek))
        .fold(0, (sum, item) => sum + item.amount);
  }
}
