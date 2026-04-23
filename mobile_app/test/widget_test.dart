// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobile_app/app.dart';

void main() {
  testWidgets('App shows splash title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: SubscriptionBillingApp()),
    );

    expect(find.text('Subscription Billing Tracker'), findsOneWidget);

    // Allow splash timer to complete so no pending timers remain at teardown.
    await tester.pump(const Duration(milliseconds: 1600));
  });
}
