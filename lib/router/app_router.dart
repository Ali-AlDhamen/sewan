// =================================== Providers ===================================
// Provider for the router
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/features/auth/controller/auth_controller.dart';
import 'package:sewan/features/auth/repository/auth_repository.dart';
import 'package:sewan/features/auth/view/signin_screen.dart';
import 'package:sewan/features/auth/view/signup_screen.dart';
import 'package:sewan/features/home/screens/home_screen.dart';
import 'package:sewan/router/go_refresh_stream_provider.dart';

final goRouterProvider = Provider((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final homeKey = GlobalKey<NavigatorState>(debugLabel: 'Home');
  final learnKey = GlobalKey<NavigatorState>(debugLabel: 'Learn');
  final leaderboardKey = GlobalKey<NavigatorState>(debugLabel: 'Leaderboard');
  final profileKey = GlobalKey<NavigatorState>(debugLabel: 'Profile');

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: ref.read(authControllerProvider.notifier).initialPath(),
    navigatorKey: rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authRepositoryProvider).authStateChange,
    ),
    redirectLimit: 2,
    redirect: (context, state) {
      final path = state.uri.path;
      final userIsLogging = path == '/signin' || path == '/signup';
      final userIsLoggedIn =
          ref.read(authRepositoryProvider).currentUser != null;

      if (userIsLogging && userIsLoggedIn) {
        return '/home';
      } else if (!userIsLogging && !userIsLoggedIn) {
        return '/signin';
      } else {
        return null;
      }
    },
    routes: [
      // Home route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: homeKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) {
                  return Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text('home'),
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: learnKey,
            routes: [
              GoRoute(
                path: '/learn',
                builder: (context, state) {
                  return Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text('learn'),
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: leaderboardKey,
            routes: [
              GoRoute(
                path: '/leaderboard',
                builder: (context, state) {
                  return Container(
                    color: Colors.red,
                    child: const Center(
                      child: Text('leaderboard'),
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: profileKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) {
                  return Scaffold(
                      appBar: AppBar(
                        title: const Text('Profile'),
                      ),
                      body: Center(
                        child: Container(
                          color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.red,
                                child: Center(
                                  child: Text(
                                      ref.watch(userProvider)?.email ?? ''),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(authControllerProvider.notifier)
                                      .signOut();
                                },
                                child: const Text('Sign Out'),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
});
