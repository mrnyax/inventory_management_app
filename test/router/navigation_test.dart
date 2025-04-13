import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management_app/providers/auth_provider.dart';
import 'package:inventory_management_app/router/app_router.dart';

void main() {
  testWidgets('Navigates to login if not authenticated', (
    WidgetTester tester,
  ) async {
    final container = ProviderContainer(
      overrides: [authProvider.overrideWith((ref) => false)],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: container.read(routerProvider)),
      ),
    );

    await tester.pumpAndSettle(); // Wait for redirects
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Navigates to home if authenticated', (
    WidgetTester tester,
  ) async {
    final container = ProviderContainer(
      overrides: [authProvider.overrideWith((ref) => true)],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: container.read(routerProvider)),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Welcome Home!'), findsOneWidget);
  });
}
