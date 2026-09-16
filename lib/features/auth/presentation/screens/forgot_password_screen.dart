import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:bondhon/shared/widgets/bondhon_button.dart';
import 'package:bondhon/shared/widgets/bondhon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return AuthScaffold(
      title: strings.passwordRecovery,
      subtitle: strings.passwordRecoverySubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BondhonTextField(
            label: strings.email,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            enabled: false,
          ),
          const SizedBox(height: AppSpacing.lg),
          BondhonButton(
            label: strings.resetComingSoon,
            onPressed: null,
          ),
          const SizedBox(height: AppSpacing.sm),
          BondhonButton(
            label: strings.continueWithoutLogin,
            style: BondhonButtonStyle.secondary,
            onPressed: () => context.go(AppRoutes.home),
          ),
        ],
      ),
    );
  }
}
