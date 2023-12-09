import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_journal_v2/models/workout/workout.dart';
import 'package:workout_journal_v2/pages/dashboard/create_workout/create_workout.dart';
import 'package:workout_journal_v2/pages/dashboard/dashboard.dart';
import 'package:workout_journal_v2/pages/dashboard/workout_details/create_exericse/create_exercise.dart';
import 'package:workout_journal_v2/pages/dashboard/workout_details/workout_details.dart';
import 'package:workout_journal_v2/pages/login/login_check.dart';
import 'package:workout_journal_v2/widgets/navigation/go_router_nav.dart';

class Routes {
  // MAIN ROUTES
  static const String login = '/login';

  static const String dashboard = '/';

  // SUBROUTES
  static const String workoutDetails = 'workout_details';
  static const String createWorkout = 'create_workout';
  static const String createExercise = 'create_exercise';
}

class NavigationRouter {
  static final key = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.login,
    navigatorKey: key,
    routes: [
      // Login Page
      GoRoute(
        name: Routes.login,
        path: Routes.login,
        builder: (context, state) => const LoginCheck(),
      ),

      // Main Shell
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          // Return the widget that implements the custom shell (in this case
          // using a BottomNavigationBar). The StatefulNavigationShell is passed
          // to be able access the state of the shell and to navigate to other
          // branches in a stateful way.
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Dashboard Page
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.dashboard,
                path: Routes.dashboard,
                pageBuilder: (context, state) {
                  return buildFadeTransition(const Dashboard(), state.pageKey);
                },
                routes: [
                  GoRoute(
                      name: Routes.workoutDetails,
                      path: Routes.workoutDetails,
                      pageBuilder: (context, state) {
                        return buildSlideTransition(
                            const WorkoutDetails(), state.pageKey);
                      },
                      routes: [
                        GoRoute(
                          name: Routes.createExercise,
                          path: Routes.createExercise,
                          pageBuilder: (context, state) {
                            final Workout workout = state.extra as Workout;

                            return buildSlideTransition(
                                CreateExercise(workout: workout),
                                state.pageKey);
                          },
                        ),
                      ]),
                  GoRoute(
                    name: Routes.createWorkout,
                    path: Routes.createWorkout,
                    pageBuilder: (context, state) {
                      return buildSlideTransition(
                          const CreateWorkout(), state.pageKey);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  // PAGE TRANSITIONS

  // Fade
  static CustomTransitionPage buildFadeTransition(
          Widget child, LocalKey? key) =>
      CustomTransitionPage(
        key: key,
        child: child,
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      );

  // Slide
  static CustomTransitionPage buildSlideTransition(
          Widget child, LocalKey? key) =>
      CustomTransitionPage(
        key: key,
        child: child,
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      );
}
