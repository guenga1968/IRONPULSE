import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'login_screen.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IRON PULSE',
      theme: AppTheme.darkTheme,
      scrollBehavior: AppScrollBehavior(),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
