import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:bondhon/shared/widgets/bondhon_button.dart';
import 'package:bondhon/shared/widgets/bondhon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'লগইন',
      subtitle: 'এই সুবিধাটি ভবিষ্যতে Firebase-এর সঙ্গে সক্রিয় হবে।',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BondhonTextField(
            label: 'ইমেইল',
            hint: 'name@example.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            enabled: false,
          ),
          const SizedBox(height: AppSpacing.md),
          const BondhonTextField(
            label: 'পাসওয়ার্ড',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: true,
            enabled: false,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.go(AppRoutes.forgotPassword),
              child: const Text('পাসওয়ার্ড ভুলে গেছেন?'),
            ),
          ),
          BondhonButton(
            label: 'লগইন শিগগিরই চালু হবে',
            onPressed: null,
          ),
          const SizedBox(height: AppSpacing.sm),
          BondhonButton(
            label: 'লগইন ছাড়াই প্রবেশ করুন',
            icon: Icons.arrow_forward_rounded,
            style: BondhonButtonStyle.secondary,
            onPressed: () => context.go(AppRoutes.home),
          ),
          const SizedBox(height: AppSpacing.sm),
          BondhonButton(
            label: 'নতুন অ্যাকাউন্টের কাঠামো দেখুন',
            style: BondhonButtonStyle.text,
            onPressed: () => context.go(AppRoutes.register),
          ),
        ],
      ),
    );
  }
}
