enum AppFlavor { development, staging, production }

abstract final class AppEnvironment {
  static const appName = 'Bondhon';
  static const flavorName = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static AppFlavor get flavor => switch (flavorName) {
        'production' => AppFlavor.production,
        'staging' => AppFlavor.staging,
        _ => AppFlavor.development,
      };

  static bool get isDevelopment => flavor == AppFlavor.development;
}
