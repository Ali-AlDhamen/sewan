// =================================== Providers ===================================
// Provider for the router
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/features/home/screens/home_screen.dart';

final goRouterProvider = Provider((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final homeKey = GlobalKey<NavigatorState>(debugLabel: 'Home');
  final learnKey = GlobalKey<NavigatorState>(debugLabel: 'Learn');
  final leaderboardKey = GlobalKey<NavigatorState>(debugLabel: 'Leaderboard');
  final profileKey = GlobalKey<NavigatorState>(debugLabel: 'Profile');

  return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: "/home", // auth.initialPath(),
      navigatorKey: rootNavigatorKey,
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
                    return Container(
                      color: Colors.red,
                      child: const Center(
                        child: Text('profile'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ]);
});
  // final auth = ref.watch(authRepositoryProvider);