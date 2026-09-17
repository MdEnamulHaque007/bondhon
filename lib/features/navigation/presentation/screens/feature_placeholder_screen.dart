import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

enum AppFeature { discover }

class FeaturePlaceholderScreen extends StatelessWidget {
  const FeaturePlaceholderScreen({required this.feature, super.key});

  final AppFeature feature;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final details = switch (feature) {
      AppFeature.discover => (
          icon: Icons.explore_outlined,
          title: strings.discover,
          description: strings.discoverDescription,
        ),
    };

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(details.icon, size: 56),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      details.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      details.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Chip(label: Text(strings.comingSoon)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
