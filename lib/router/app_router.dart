// =================================== Providers ===================================
// Provider for the router
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/features/home/screens/home_screen.dart';

final goRouterProvider = Provider((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final homeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
  final trackKey = GlobalKey<NavigatorState>(debugLabel: 'track');
  final giftsKey = GlobalKey<NavigatorState>(debugLabel: 'Gifts');
  final membershipKey = GlobalKey<NavigatorState>(debugLabel: 'Membership');
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
                      child: Center(
                        child: Text('home'),
                      ),
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: trackKey,
              routes: [
                GoRoute(
                  path: '/track',
                  builder: (context, state) {
                    return Container(
                      color: Colors.red,
                      child: Center(
                        child: Text('track'),
                      ),
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: giftsKey,
              routes: [
                GoRoute(
                  path: '/gifts',
                  builder: (context, state) {
                    return Container(
                      color: Colors.red,
                      child: Center(
                        child: Text('gifts'),
                      ),
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: membershipKey,
              routes: [
                GoRoute(
                  path: '/membership',
                  builder: (context, state) {
                    return Container(
                      color: Colors.red,
                      child: Center(
                        child: Text('membership'),
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
                      child: Center(
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