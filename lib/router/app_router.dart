// =================================== Providers ===================================
// Provider for the router
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/features/auth/controller/auth_controller.dart';
import 'package:sewan/features/auth/repository/auth_repository.dart';
import 'package:sewan/features/auth/view/signin_screen.dart';
import 'package:sewan/features/auth/view/signup_screen.dart';
import 'package:sewan/features/flashcards/view/courses_screen.dart';
import 'package:sewan/features/flashcards/view/flashcard_learning_screen.dart';
import 'package:sewan/features/flashcards/view/lecture_screen.dart';
import 'package:sewan/features/flashcards/view/lectures_screen.dart';
import 'package:sewan/features/home/screens/home_screen.dart';
import 'package:sewan/features/leaderboard/view/leaderboard_screen.dart';
import 'package:sewan/features/pet/screens/pet_screen.dart';
import 'package:sewan/features/quiz/view/online_quiz_screen.dart';
import 'package:sewan/features/quiz/view/quiz_screen.dart';
import 'package:sewan/features/quiz/view/quiz_settings_screen.dart';
import 'package:sewan/features/quiz/view/results_screen.dart';
import 'package:sewan/features/quiz/view/room_screen.dart';
import 'package:sewan/router/app_routes.dart';
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
      final userIsLogging =
          path == AppRoutes.login.path || path == AppRoutes.signUp.path;
      final userIsLoggedIn =
          ref.read(authRepositoryProvider).currentUser != null;

      if (userIsLogging && userIsLoggedIn) {
        return AppRoutes.home.path;
      } else if (!userIsLogging && !userIsLoggedIn) {
        return AppRoutes.login.path;
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
                path: AppRoutes.home.path,
                name: AppRoutes.home.name,
                builder: (context, state) {
                  return const PetScreen();
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
                  return const CoursesScreen();
                },
                routes: [
                  GoRoute(
                    name: 'Flashcards session',
                    path: 'flashcards/:sessionId',
                    builder: (context, state) {
                      return const FlashCardLearning();
                    },
                  ),
                  GoRoute(
                    name: 'course screen',
                    path: 'course/:courseId',
                    builder: (context, state) {
                      final courseId = state.pathParameters['courseId'];
                      return LecturesScreen(
                        courseId: courseId!,
                      );
                    },
                    routes: [
                      GoRoute(
                          name: 'lecture screen',
                          path: ':lectureId',
                          builder: (context, state) {
                            final courseId = state.pathParameters['courseId'];
                            final lectureId = state.pathParameters['lectureId'];
                            return LectureScreen(
                              courseId: courseId!,
                              lectureId: lectureId!,
                            );
                          },
                          routes: [
                            GoRoute(
                              name: 'Quiz Settings',
                              path: 'quiz-settings',
                              builder: (context, state) {
                                final courseId = state.pathParameters['courseId'];
                              final lectureId = state.pathParameters['lectureId'];
                                return  QuizSettingsScreen(
                                  courseId: courseId!,
                                  lectureId: lectureId!,
                                );
                              },
                            ),
                          ]),
                    ],
                  ),
                ],
              ),
              
            ],
          ),
          StatefulShellBranch(
            navigatorKey: leaderboardKey,
            routes: [
              GoRoute(
                path: '/leaderboard',
                builder: (context, state) {
                  return LeaderboardScreen();
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
        path: '/room/:sessionId',
        name: 'room screen',
        builder: (context, state) =>  RoomScreen(
          sessionId: state.pathParameters['sessionId']!,
        ),
      ),
      GoRoute(
        path: '/online-quiz/:sessionId',
        name: 'online quiz screen',
        builder: (context, state) =>  OnlineQuizScreen (
          sessionId: state.pathParameters['sessionId']!,
        )
      ),
      GoRoute(
        path: '/quiz',
        name: 'quiz screen',
        builder: (context, state) => const QuizScreen(),
      ),
      GoRoute(
        // results
        path: '/results',
        name: 'results screen',
        builder: (context, state) => ResultScreen(),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp.path,
        name: AppRoutes.signUp.name,
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
});
