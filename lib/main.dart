import 'dart:async';
import 'dart:ui';

import 'package:bondhon/app/app.dart';
import 'package:bondhon/core/errors/app_error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = AppErrorHandler.recordFlutterError;
      PlatformDispatcher.instance.onError = AppErrorHandler.recordPlatformError;

      runApp(const ProviderScope(child: BondhonApp()));
    },
    AppErrorHandler.recordZoneError,
  );
}
