import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:bondhon/shared/widgets/bondhon_button.dart';
import 'package:bondhon/shared/widgets/bondhon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'নতুন অ্যাকাউন্ট',
      subtitle: 'Registration UI প্রস্তুত আছে, তবে account তৈরি এখন বন্ধ।',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BondhonTextField(
            label: 'পূর্ণ নাম',
            prefixIcon: Icons.person_outline_rounded,
            enabled: false,
          ),
          const SizedBox(height: AppSpacing.md),
          const BondhonTextField(
            label: 'ইমেইল',
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
          const SizedBox(height: AppSpacing.lg),
          BondhonButton(
            label: 'Registration শিগগিরই চালু হবে',
            onPressed: null,
          ),
          const SizedBox(height: AppSpacing.sm),
          BondhonButton(
            label: 'লগইন ছাড়াই প্রবেশ করুন',
            style: BondhonButtonStyle.secondary,
            onPressed: () => context.go(AppRoutes.home),
          ),
        ],
      ),
    );
  }
}
