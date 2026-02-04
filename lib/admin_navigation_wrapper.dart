import 'package:flutter/material.dart';
import 'admin_dashboard_screen.dart';
import 'widgets/adaptive/adaptive_navigation.dart';

class AdminNavigationWrapper extends StatefulWidget {
  const AdminNavigationWrapper({super.key});

  @override
  State<AdminNavigationWrapper> createState() => _AdminNavigationWrapperState();
}

class _AdminNavigationWrapperState extends State<AdminNavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const AdminDashboardScreen(),
    const Center(
      child: Text('Classes Management', style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text('Users Management', style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text('Admin Settings', style: TextStyle(color: Colors.white)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigation(
      currentIndex: _currentIndex,
      onIndexChanged: (index) => setState(() => _currentIndex = index),
      items: const [
        AdaptiveNavigationItem(
          label: 'Home',
          icon: Icons.dashboard_outlined,
          activeIcon: Icons.dashboard_rounded,
        ),
        AdaptiveNavigationItem(
          label: 'Classes',
          icon: Icons.fitness_center_outlined,
          activeIcon: Icons.fitness_center_rounded,
        ),
        AdaptiveNavigationItem(
          label: 'Users',
          icon: Icons.people_outline_rounded,
          activeIcon: Icons.people_rounded,
        ),
        AdaptiveNavigationItem(
          label: 'Settings',
          icon: Icons.settings_outlined,
          activeIcon: Icons.settings_rounded,
        ),
      ],
      child: _screens[_currentIndex],
    );
  }
}
