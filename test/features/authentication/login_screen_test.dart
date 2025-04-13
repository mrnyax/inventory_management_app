import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invento/features/authentication/login_screen.dart';
import 'package:invento/providers/auth_provider.dart';

void main() {
  testWidgets('Login screen displays fields and button', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: LoginScreen())));

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Tapping login button updates authProvider', (WidgetTester tester) async {
    final container = ProviderContainer();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(home: LoginScreen()),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(container.read(authProvider), isTrue);
  });
}