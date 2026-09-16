import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:bondhon/shared/widgets/bondhon_button.dart';
import 'package:bondhon/shared/widgets/bondhon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'পাসওয়ার্ড পুনরুদ্ধার',
      subtitle: 'Firebase চালু হলে ইমেইলে reset link পাঠানো যাবে।',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BondhonTextField(
            label: 'ইমেইল',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            enabled: false,
          ),
          const SizedBox(height: AppSpacing.lg),
          BondhonButton(
            label: 'Reset সুবিধা শিগগিরই চালু হবে',
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
