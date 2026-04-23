import 'package:flutter/material.dart';

class PlaceholderPanel extends StatelessWidget {
  const PlaceholderPanel({
    super.key,
    required this.title,
    required this.subtitle,
    this.ctaLabel,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String? ctaLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            if (ctaLabel != null && onTap != null) ...[
              const SizedBox(height: 14),
              FilledButton(onPressed: onTap, child: Text(ctaLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
