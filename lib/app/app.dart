import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_theme.dart';
import 'package:bondhon/app/theme/theme_controller.dart';
import 'package:bondhon/core/config/app_environment.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/core/localization/language_controller.dart';
import 'package:bondhon/core/localization/language_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class BondhonApp extends StatelessWidget {
  const BondhonApp({required this.languageController, this.themeController, super.key});

  final LanguageController languageController;
  final ThemeController? themeController;

  @override
  Widget build(BuildContext context) {
    final themes = themeController ?? ThemeController();
    return LanguageScope(
      controller: languageController,
      child: AnimatedBuilder(
        animation: themes,
        builder: (context, _) => ValueListenableBuilder<Locale>(
          valueListenable: languageController,
          builder: (context, locale, child) => MaterialApp.router(
            title: AppEnvironment.appName,
            debugShowCheckedModeBanner: AppEnvironment.isDevelopment,
            theme: AppTheme.build(themes.variant),
            darkTheme: AppTheme.build(AppThemeVariant.dark),
            themeMode: themes.variant == AppThemeVariant.dark ? ThemeMode.dark : ThemeMode.light,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: appRouter,
          ),
        ),
      ),
    );
  }
}
