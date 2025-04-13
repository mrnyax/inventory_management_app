import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management_app/providers/auth_provider.dart';

void main() {
  test("`authProvider` defaults to `false`", () {
    final container = ProviderContainer();
    final isLoggedIn = container.read(authProvider);
    expect(isLoggedIn, false);
  });

  test("`authProvider` updates to `true`", () {
    final container = ProviderContainer();
    container.read(authProvider.notifier).state = true;
    expect(container.read(authProvider), true);
  });
}
