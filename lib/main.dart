import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'theme.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://sbljtekgogrkelfhxtxq.supabase.co',
    anonKey: 'sb_publishable_eBqWZFYHuvRkCD92t8THLQ_oHFbG8U2',
  );

  runApp(const IronPulseApp());
}

class IronPulseApp extends StatelessWidget {
  const IronPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iron Pulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
