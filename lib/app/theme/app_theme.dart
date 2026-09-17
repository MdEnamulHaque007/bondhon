import 'package:bondhon/app/theme/app_colors.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/app/theme/app_typography.dart';
import 'package:bondhon/app/theme/theme_controller.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData build(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.bondhon:
        return _build(Brightness.light, AppColors.bondhonGreen, AppColors.bondhonRed, AppColors.warmGold, AppColors.bondhonGreenSoft);
      case AppThemeVariant.blue:
        return _build(Brightness.light, AppColors.blue, AppColors.cyan, AppColors.purple, AppColors.blueSoft);
      case AppThemeVariant.orange:
        return _build(Brightness.light, AppColors.orange, AppColors.bondhonRed, AppColors.warmGold, AppColors.orangeSoft);
      case AppThemeVariant.dark:
        return _build(Brightness.dark, const Color(0xFF6EE7B7), const Color(0xFFFF6B81), const Color(0xFFFBBF24), const Color(0xFF16352C));
      case AppThemeVariant.multicolor:
        return _build(Brightness.light, AppColors.purple, AppColors.orange, AppColors.cyan, const Color(0xFFF1EAFE));
    }
  }

  static ThemeData _build(Brightness brightness, Color primary, Color secondary, Color tertiary, Color surfaceTint) {
    final dark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(seedColor: primary, brightness: brightness).copyWith(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surfaceTint: surfaceTint,
      surface: dark ? const Color(0xFF0B1210) : const Color(0xFFF8FAFC),
      surfaceContainerLowest: dark ? const Color(0xFF080D0C) : Colors.white,
      surfaceContainerLow: dark ? const Color(0xFF111B18) : const Color(0xFFF1F5F3),
      surfaceContainer: dark ? const Color(0xFF17221F) : const Color(0xFFEFF4F2),
      onSurface: dark ? const Color(0xFFE7F2EE) : AppColors.ink,
    );
    final base = ThemeData(brightness: brightness, colorScheme: scheme, useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: scheme.surface,
      textTheme: AppTypography.textTheme(base.textTheme),
      appBarTheme: AppBarTheme(centerTitle: false, backgroundColor: scheme.surface, foregroundColor: scheme.onSurface, elevation: 0, scrolledUnderElevation: 0),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primary.withValues(alpha: dark ? .24 : .12),
        labelTextStyle: WidgetStatePropertyAll(base.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
      ),
      navigationRailTheme: NavigationRailThemeData(backgroundColor: scheme.surface, indicatorColor: scheme.primary.withValues(alpha: dark ? .24 : .12)),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(minimumSize: const Size(48, 52), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)))),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? scheme.surfaceContainerLow : scheme.surfaceContainerLowest,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: .45))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: BorderSide(color: scheme.primary, width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surfaceContainerLow,
        surfaceTintColor: scheme.surfaceTint,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg), side: BorderSide(color: scheme.outlineVariant.withValues(alpha: .28))),
      ),
      chipTheme: base.chipTheme.copyWith(side: BorderSide(color: scheme.outlineVariant.withValues(alpha: .35)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md))),
      snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md))),
    );
  }
}
