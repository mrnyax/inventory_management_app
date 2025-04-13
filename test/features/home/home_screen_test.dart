import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invento/features/home/home_screen.dart';
import 'package:invento/providers/auth_provider.dart';

void main() {
  testWidgets('Home screen renders and logs out', (WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [authProvider.overrideWith((ref) => true)],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.text('Welcome Home!'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pump();
    expect(container.read(authProvider), isFalse);
  });
}
