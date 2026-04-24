import 'dart:async';

import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/bills/presentation/screens/bills_task_list_screen.dart';
import 'features/calendar/presentation/screens/calendar_view_screen.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';
import 'features/notifications/presentation/screens/notifications_screen.dart';
import 'features/payments/presentation/screens/payment_history_screen.dart';
import 'features/profile/presentation/screens/profile_settings_screen.dart';
import 'features/subscriptions/presentation/screens/add_subscription_screen.dart';
import 'features/subscriptions/presentation/screens/edit_subscription_screen.dart';
import 'features/subscriptions/presentation/screens/subscription_details_screen.dart';
import 'features/subscriptions/presentation/screens/subscription_list_screen.dart';

class SubscriptionBillingApp extends StatefulWidget {
  const SubscriptionBillingApp({super.key});

  @override
  State<SubscriptionBillingApp> createState() => _SubscriptionBillingAppState();
}

class _SubscriptionBillingAppState extends State<SubscriptionBillingApp> {
  bool _showSplash = true;
  bool _isAuthenticated = false;
  final bool _isAdmin = true;
  int _selectedIndex = 0;

  final List<_AppDestination> _destinations = const [
    _AppDestination('Dashboard', Icons.dashboard_outlined, Icons.dashboard),
    _AppDestination(
      'Subscriptions',
      Icons.subscriptions_outlined,
      Icons.subscriptions,
    ),
    _AppDestination('Bills', Icons.task_alt_outlined, Icons.task_alt),
    _AppDestination(
      'Calendar',
      Icons.calendar_month_outlined,
      Icons.calendar_month,
    ),
    _AppDestination('Payments', Icons.payments_outlined, Icons.payments),
    _AppDestination(
      'Notifications',
      Icons.notifications_outlined,
      Icons.notifications,
    ),
    _AppDestination('Profile', Icons.person_outline, Icons.person),
    _AppDestination(
      'Admin',
      Icons.admin_panel_settings_outlined,
      Icons.admin_panel_settings,
    ),
  ];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1400), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subscription Billing Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: _buildRootView(),
    );
  }

  Widget _buildRootView() {
    if (_showSplash) {
      return const SplashScreen();
    }

    if (!_isAuthenticated) {
      return LoginScreen(
        onLoginSuccess: () {
          setState(() {
            _isAuthenticated = true;
          });
        },
        onRegisterTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RegisterScreen(
                onRegisterSuccess: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isAuthenticated = true;
                  });
                },
              ),
            ),
          );
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1000;
        final page = _buildPage(_selectedIndex);

        return Scaffold(
          appBar: AppBar(
            title: Text(_destinations[_selectedIndex].label),
            actions: [
              IconButton(
                tooltip: 'Logout',
                onPressed: () {
                  setState(() {
                    _isAuthenticated = false;
                    _selectedIndex = 0;
                  });
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          drawer: isDesktop
              ? null
              : Drawer(
                  child: ListView.builder(
                    itemCount: _destinations.length,
                    itemBuilder: (context, index) {
                      if (!_isAdmin && _destinations[index].label == 'Admin') {
                        return const SizedBox.shrink();
                      }
                      return ListTile(
                        leading: Icon(_destinations[index].selectedIcon),
                        title: Text(_destinations[index].label),
                        selected: index == _selectedIndex,
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),
          body: Row(
            children: [
              if (isDesktop)
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    if (!_isAdmin && _destinations[index].label == 'Admin') {
                      return;
                    }
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  extended: constraints.maxWidth > 1300,
                  destinations: _destinations
                      .map(
                        (d) => NavigationRailDestination(
                          icon: Icon(d.icon),
                          selectedIcon: Icon(d.selectedIcon),
                          label: Text(d.label),
                        ),
                      )
                      .toList(),
                ),
              Expanded(child: page),
            ],
          ),
          bottomNavigationBar: isDesktop
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex > 3 ? 0 : _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  destinations: _destinations
                      .take(4)
                      .map(
                        (d) => NavigationDestination(
                          icon: Icon(d.icon),
                          selectedIcon: Icon(d.selectedIcon),
                          label: d.label,
                        ),
                      )
                      .toList(),
                ),
          floatingActionButton: _selectedIndex == 1
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AddSubscriptionScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Subscription'),
                )
              : null,
        );
      },
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const DashboardScreen();
      case 1:
        return SubscriptionListScreen(
          onOpenDetails: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SubscriptionDetailsScreen(),
              ),
            );
          },
          onOpenEdit: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const EditSubscriptionScreen()),
            );
          },
        );
      case 2:
        return const BillsTaskListScreen();
      case 3:
        return const CalendarViewScreen();
      case 4:
        return const PaymentHistoryScreen();
      case 5:
        return const NotificationsScreen();
      case 6:
        return const ProfileSettingsScreen();
      case 7:
        return _isAdmin
            ? const AdminDashboardScreen()
            : const Center(child: Text('Admin access required'));
      default:
        return const SizedBox.shrink();
    }
  }
}

class _AppDestination {
  const _AppDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
