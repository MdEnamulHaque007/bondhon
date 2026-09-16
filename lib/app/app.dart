import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_theme.dart';
import 'package:bondhon/core/config/app_environment.dart';
import 'package:flutter/material.dart';

class BondhonApp extends StatelessWidget {
  const BondhonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppEnvironment.appName,
      debugShowCheckedModeBanner: AppEnvironment.isDevelopment,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
