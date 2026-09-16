import 'package:bondhon/app/theme/app_colors.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/constants/app_constants.dart';
import 'package:bondhon/shared/widgets/bondhon_button.dart';
import 'package:bondhon/shared/widgets/brand_mark.dart';
import 'package:flutter/material.dart';

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
          child: LayoutBuilder(
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
          AppConstants.tagline,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'নিরাপদে কথা বলুন, বন্ধু খুঁজুন এবং নিজের কমিউনিটি গড়ে তুলুন।',
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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      size: 18,
                      color: AppColors.bondhonGreenDark,
                    ),
                    SizedBox(width: AppSpacing.xs),
                    Flexible(
                      child: Text(
                        'বাংলাদেশের জন্য নিরাপদ সামাজিক প্ল্যাটফর্ম',
                        style: TextStyle(color: AppColors.bondhonGreenDark),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'আপনার বন্ধনের যাত্রা শুরু করুন',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'নতুন অ্যাকাউন্ট তৈরি করুন অথবা বিদ্যমান অ্যাকাউন্টে প্রবেশ করুন।',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.55,
                    ),
              ),
              const SizedBox(height: AppSpacing.lg),
              BondhonButton(
                label: 'নতুন অ্যাকাউন্ট তৈরি করুন',
                icon: Icons.person_add_alt_1_rounded,
                onPressed: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              BondhonButton(
                label: 'লগইন করুন',
                icon: Icons.login_rounded,
                style: BondhonButtonStyle.secondary,
                onPressed: () {},
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'চালিয়ে যাওয়ার মাধ্যমে আপনি আমাদের শর্তাবলি ও গোপনীয়তা নীতিতে সম্মতি দিচ্ছেন।',
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
