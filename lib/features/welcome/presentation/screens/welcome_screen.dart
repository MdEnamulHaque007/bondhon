import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_colors.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/constants/app_constants.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/shared/widgets/bondhon_button.dart';
import 'package:bondhon/shared/widgets/brand_mark.dart';
import 'package:bondhon/shared/widgets/language_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors.surface,
              colors.primaryContainer.withValues(alpha: 0.48),
              colors.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 840;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? AppSpacing.section : AppSpacing.lg,
                  vertical: AppSpacing.lg,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - AppSpacing.xxl,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1120),
                      child: isWide
                          ? const Row(
                              children: [
                                Expanded(child: _WelcomeMessage()),
                                SizedBox(width: AppSpacing.section),
                                Expanded(child: _WelcomeActionCard()),
                              ],
                            )
                          : const _MobileWelcome(),
                    ),
                  ),
                ),
              );
                },
              ),
              const Positioned(
                top: AppSpacing.xs,
                right: AppSpacing.sm,
                child: LanguageSelector(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileWelcome extends StatelessWidget {
  const _MobileWelcome();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _WelcomeMessage(centered: true),
        SizedBox(height: AppSpacing.xl),
        _WelcomeActionCard(),
      ],
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  const _WelcomeMessage({this.centered = false});

  final bool centered;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final strings = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const BrandMark(),
        const SizedBox(height: AppSpacing.lg),
        Text(
          AppConstants.productName,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: colors.primary,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          strings.tagline,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          strings.welcomeDescription,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.65,
              ),
        ),
      ],
    );
  }
}

class _WelcomeActionCard extends StatelessWidget {
  const _WelcomeActionCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final strings = AppLocalizations.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: AppConstants.maxContentWidth,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bondhonGreenSoft,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      size: 18,
                      color: AppColors.bondhonGreenDark,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Flexible(
                      child: Text(
                        strings.safetyBadge,
                        style: const TextStyle(
                          color: AppColors.bondhonGreenDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                strings.journeyTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                strings.guestAccessDescription,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.55,
                    ),
              ),
              const SizedBox(height: AppSpacing.lg),
              BondhonButton(
                label: strings.enterNow,
                icon: Icons.arrow_forward_rounded,
                onPressed: () => context.go(AppRoutes.home),
              ),
              const SizedBox(height: AppSpacing.sm),
              BondhonButton(
                label: strings.viewLoginStructure,
                icon: Icons.account_circle_outlined,
                style: BondhonButtonStyle.secondary,
                onPressed: () => context.go(AppRoutes.login),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                strings.guestModeInfo,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
