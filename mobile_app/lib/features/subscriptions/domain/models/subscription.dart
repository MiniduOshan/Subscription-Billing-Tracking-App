import 'package:flutter/material.dart';

enum SubscriptionCategory {
  entertainment,
  productivity,
  utilities,
  health,
  finance,
  other,
}

class Subscription {
  final String id;
  final String name;
  final String description;
  final double amount;
  final String currency;
  final DateTime nextBillingDate;
  final SubscriptionCategory category;
  final IconData icon;
  final Color color;
  final String billingCycle; // e.g., 'Monthly', 'Yearly'

  Subscription({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.currency,
    required this.nextBillingDate,
    required this.category,
    required this.icon,
    required this.color,
    required this.billingCycle,
  });
}
