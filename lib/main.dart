import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'home_screen.dart';
import 'widgets/adaptive/adaptive_navigation.dart';
import 'core/responsive/scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://sbljtekgogrkelfhxtxq.supabase.co',
    anonKey: 'sb_publishable_eBqWZFYHuvRkCD92t8THLQ_oHFbG8U2',
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(
      child: Text('Schedule', style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text('Profile', style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text('Settings', style: TextStyle(color: Colors.white)),
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
          icon: Icons.home_outlined,
          activeIcon: Icons.home_filled,
        ),
        AdaptiveNavigationItem(
          label: 'Schedule',
          icon: Icons.calendar_month_outlined,
          activeIcon: Icons.calendar_month_rounded,
        ),
        AdaptiveNavigationItem(
          label: 'Profile',
          icon: Icons.person_outline_rounded,
          activeIcon: Icons.person_rounded,
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IRON PULSE',
      theme: AppTheme.darkTheme,
      scrollBehavior: AppScrollBehavior(),
      home: const MainNavigationWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
