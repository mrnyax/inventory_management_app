import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app/providers/auth_provider.dart';

import '../features/authentication/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/splash/splash_screen.dart';

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this.ref) {
    // Listen for changes in authProvider
    ref.listen<bool>(authProvider, (previous, next) => notifyListeners());
  }

  final Ref ref;
}

final goRouterNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(goRouterNotifierProvider);
  final isLoggedIn = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    // for debugging route issues
    refreshListenable: notifier,
    redirect: (context, state) {
      final location = state.uri.toString();
      final goingToLogin = location == '/login';
      final goingToSplash = location == '/splash';

      if (!isLoggedIn && !goingToLogin) return '/login';
      if (isLoggedIn && (goingToLogin || goingToSplash)) return '/home';

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    ],
  );
});
