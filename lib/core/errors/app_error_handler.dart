import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract final class AppErrorHandler {
  static void recordFlutterError(FlutterErrorDetails details) {
    FlutterError.presentError(details);
    _log(details.exception, details.stack);
  }

  static bool recordPlatformError(Object error, StackTrace stack) {
    _log(error, stack);
    return true;
  }

  static void recordZoneError(Object error, StackTrace stack) {
    _log(error, stack);
  }

  static void _log(Object error, StackTrace? stack) {
    if (kDebugMode) {
      debugPrint('Bondhon uncaught error: $error');
      if (stack != null) {
        debugPrintStack(stackTrace: stack);
      }
    }

    // TODO: Forward production errors to Crashlytics after Firebase setup.
  }
}
