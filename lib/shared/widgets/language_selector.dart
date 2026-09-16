import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/core/localization/language_controller.dart';
import 'package:bondhon/core/localization/language_scope.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    super.key,
    this.controller,
    this.compact = false,
  });

  final LanguageController? controller;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final languageController = controller ?? LanguageScope.of(context);
    return PopupMenuButton<Locale>(
      tooltip: strings.language,
      initialValue: languageController.value,
      onSelected: languageController.changeLanguage,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: AppLocalizations.englishLocale,
          child: Text(strings.english),
        ),
        PopupMenuItem(
          value: AppLocalizations.banglaLocale,
          child: Text(strings.bangla),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language_rounded),
            if (!compact) ...[
              const SizedBox(width: 8),
              Text(
                languageController.value.languageCode == 'bn'
                    ? strings.bangla
                    : strings.english,
              ),
              const Icon(Icons.arrow_drop_down_rounded),
            ],
          ],
        ),
      ),
    );
  }
}
