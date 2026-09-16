import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/core/localization/language_storage.dart';
import 'package:flutter/material.dart';

class LanguageController extends ValueNotifier<Locale> {
  LanguageController({LanguageStorage? storage})
      : _storage = storage,
        super(AppLocalizations.englishLocale);

  factory LanguageController.persistent() {
    return LanguageController(storage: LanguageStorage());
  }

  final LanguageStorage? _storage;

  Future<void> load() async {
    final languageCode = await _storage?.readLanguageCode();
    if (AppLocalizations.isSupported(languageCode)) {
      value = Locale(languageCode!);
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    if (!AppLocalizations.isSupported(locale.languageCode)) return;
    value = Locale(locale.languageCode);
    await _storage?.writeLanguageCode(locale.languageCode);
  }
}
