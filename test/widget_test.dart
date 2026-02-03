import 'package:flutter_test/flutter_test.dart';
import 'package:iron_pulse/main.dart';
import 'package:iron_pulse/login_screen.dart';

void main() {
  testWidgets('App smoke test - Login screen displays', (
    WidgetTester tester,
  ) async {
    // Note: In a real scenario, we would mock Supabase.
    // For this basic smoke test, we just check if the app starts.
    await tester.pumpWidget(const MyApp());

    // Verify that LoginScreen is present
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('IRON PULSE'), findsOneWidget);
  });
}
