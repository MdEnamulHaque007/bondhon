import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_theme.dart';
import 'package:bondhon/core/config/app_environment.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/core/localization/language_controller.dart';
import 'package:bondhon/core/localization/language_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class BondhonApp extends StatelessWidget {
  const BondhonApp({required this.languageController, super.key});

  final LanguageController languageController;

  @override
  Widget build(BuildContext context) {
    return LanguageScope(
      controller: languageController,
      child: ValueListenableBuilder<Locale>(
        valueListenable: languageController,
        builder: (context, locale, child) => MaterialApp.router(
          title: AppEnvironment.appName,
          debugShowCheckedModeBanner: AppEnvironment.isDevelopment,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
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
    );
  }
}
