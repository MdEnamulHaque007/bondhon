import 'dart:async';
import 'dart:ui';

import 'package:bondhon/app/app.dart';
import 'package:bondhon/app/theme/theme_controller.dart';
import 'package:bondhon/core/errors/app_error_handler.dart';
import 'package:bondhon/core/localization/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = AppErrorHandler.recordFlutterError;
      PlatformDispatcher.instance.onError = AppErrorHandler.recordPlatformError;

      final languageController = LanguageController.persistent();
      await languageController.load();
      final themeController = ThemeController();
      await themeController.load();

      runApp(
        ProviderScope(
          child: BondhonApp(
            languageController: languageController,
            themeController: themeController,
          ),
        ),
      );
    },
    AppErrorHandler.recordZoneError,
  );
}
