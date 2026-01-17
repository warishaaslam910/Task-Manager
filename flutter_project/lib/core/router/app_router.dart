import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/cubit/auth_state.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/tasks/presentation/task_screen.dart';

class AppRouter {
  final AuthCubit authCubit;

  AppRouter(this.authCubit);

  late final router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final loggedIn = authCubit.state is AuthLoggedIn;
      final loggingIn = state.matchedLocation
          == '/login';
      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/', builder: (_, __) => const TaskScreen()),
    ],
  );
}
