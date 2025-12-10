import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterweather/features/presentation/pages/loginpage.dart';
import 'package:flutterweather/router/notfound.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweather/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutterweather/features/presentation/bloc/auth/auth_state.dart';
import 'package:flutterweather/features/presentation/pages/loginpage.dart';
import 'package:flutterweather/features/presentation/pages/dashboard_page.dart';
import 'package:flutterweather/features/presentation/pages/weather_page.dart';
import 'package:flutterweather/features/presentation/pages/notifypage.dart';
import 'package:flutterweather/features/presentation/pages/pagetwo.dart';
import 'package:flutterweather/features/presentation/pages/animated.dart';
import 'package:flutterweather/features/presentation/pages/deeplink_test_page.dart';

class AppRouter {
  static GoRouter? _router;

  // Expose router for external access (e.g., from notification handlers)
  static GoRouter? get router => _router;

  static GoRouter createRouter(BuildContext context) {
    if (_router != null) {
      return _router!;
    }

    final refreshNotifier = RouterRefreshStream(context: context);

    _router = GoRouter(
      initialLocation: '/splash',
      refreshListenable: refreshNotifier,
      redirect: (BuildContext context, GoRouterState state) {
        final authBloc = context.read<AuthBloc>();
        final authState = authBloc.state;
        final isGoingToLogin = state.matchedLocation == '/login';
        final isGoingToSplash = state.matchedLocation == '/splash';

        debugPrint(
          'Router Redirect: Location=${state.matchedLocation}, AuthState=$authState',
        );

        // If authenticated and trying to go to login, redirect to dashboard
        if (authState is AuthAuthenticated && isGoingToLogin) {
          debugPrint('Redirecting to /dashboard (Authenticated & Login)');
          return '/dashboard';
        }

        // If unauthenticated and trying to access protected routes, redirect to login
        if (authState is AuthUnauthenticated &&
            !isGoingToLogin &&
            !isGoingToSplash) {
          debugPrint('Redirecting to /login (Unauthenticated & Protected)');
          return '/login';
        }

        // If authenticated and going to splash, redirect to dashboard
        if (authState is AuthAuthenticated && isGoingToSplash) {
          debugPrint('Redirecting to /dashboard (Authenticated & Splash)');
          return '/dashboard';
        }

        // If loading or initial, stay on splash
        if (authState is AuthLoading || authState is AuthInitial) {
          if (!isGoingToSplash) {
            debugPrint('Redirecting to /login (Loading/Initial & !Splash)');
            return '/login';
          }
          debugPrint('Staying on /splash (Loading/Initial)');
        }

        // If unauthenticated and on splash, redirect to login
        if (authState is AuthUnauthenticated && isGoingToSplash) {
          debugPrint('Redirecting to /login (Unauthenticated & Splash)');
          return '/login';
        }

        return null; // No redirect needed
      },
      routes: [
        // GoRoute(
        //   path: '/',
        //   name: 'page not found ',
        //   builder: (context, state) => const Notfound(),
        // ),
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => const SplashAnimated(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),

        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardPage(),
        ),

        GoRoute(
          path: '/weather',
          name: 'weather',
          builder: (context, state) => const WeatherPage(),
        ),
        GoRoute(
          path: '/notify',
          name: 'notify',
          builder: (context, state) => const NotifyPage(),
        ),
        GoRoute(
          path: '/another',
          name: 'another',
          builder: (context, state) => const PageTwo(),
        ),
        // Alias for pagetwo (for backward compatibility)
        GoRoute(path: '/pagetwo', redirect: (context, state) => '/another'),
        GoRoute(
          path: '/deeplink-test',
          name: 'deeplink-test',
          builder: (context, state) => const DeepLinkTestPage(),
        ),
      ],
    );

    return _router!;
  }
}

// Helper class to listen to BLoC stream for router refresh
class RouterRefreshStream extends ChangeNotifier {
  RouterRefreshStream({required this.context}) {
    _subscription = context.read<AuthBloc>().stream.listen((_) {
      notifyListeners();
    });
  }

  final BuildContext context;
  StreamSubscription? _subscription;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
