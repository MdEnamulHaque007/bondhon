import 'package:bondhon/core/config/app_environment.dart';
import 'package:bondhon/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:bondhon/features/auth/presentation/screens/login_screen.dart';
import 'package:bondhon/features/auth/presentation/screens/register_screen.dart';
import 'package:bondhon/features/home/presentation/screens/home_screen.dart';
import 'package:bondhon/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const welcome = '/';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      redirect: (context, state) =>
          AppEnvironment.authRequired ? AppRoutes.login : null,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Bondhon')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'পৃষ্ঠা খুঁজে পাওয়া যায়নি',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ),
);
