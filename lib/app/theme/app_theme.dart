import 'package:bondhon/app/theme/app_colors.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/app/theme/app_typography.dart';
import 'package:bondhon/app/theme/theme_controller.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData build(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.bondhon:
        return _build(
          Brightness.light,
          AppColors.bondhonGreen,
          AppColors.bondhonRed,
          AppColors.warmGold,
          AppColors.bondhonGreenSoft,
        );
      case AppThemeVariant.blue:
        return _build(
          Brightness.light,
          AppColors.blue,
          AppColors.cyan,
          AppColors.purple,
          AppColors.blueSoft,
        );
      case AppThemeVariant.orange:
        return _build(
          Brightness.light,
          AppColors.orange,
          AppColors.bondhonRed,
          AppColors.warmGold,
          AppColors.orangeSoft,
        );
      case AppThemeVariant.dark:
        return _build(
          Brightness.dark,
          const Color(0xFF6EE7B7),
          const Color(0xFFFF6B81),
          const Color(0xFFFBBF24),
          const Color(0xFF16352C),
        );
      case AppThemeVariant.multicolor:
        return _build(
          Brightness.light,
          AppColors.purple,
          AppColors.orange,
          AppColors.cyan,
          const Color(0xFFF1EAFE),
        );
    }
  }

  static ThemeData _build(
    Brightness brightness,
    Color primary,
    Color secondary,
    Color tertiary,
    Color surfaceTint,
  ) {
    final dark = brightness == Brightness.dark;

    // Keep surfaces derived from the selected accent so each theme changes
    // the overall visual language, not only buttons and selected states.
    final surface = dark
        ? Color.alphaBlend(primary.withValues(alpha: .08), const Color(0xFF0B1210))
        : Color.alphaBlend(primary.withValues(alpha: .035), Colors.white);
    final surfaceLow = dark
        ? Color.alphaBlend(primary.withValues(alpha: .12), const Color(0xFF111B18))
        : Color.alphaBlend(primary.withValues(alpha: .06), Colors.white);
    final surfaceContainer = dark
        ? Color.alphaBlend(secondary.withValues(alpha: .08), const Color(0xFF17221F))
        : Color.alphaBlend(secondary.withValues(alpha: .045), Colors.white);

    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
    ).copyWith(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surfaceTint: surfaceTint,
      surface: surface,
      surfaceContainerLowest: dark ? const Color(0xFF080D0C) : Colors.white,
      surfaceContainerLow: surfaceLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: dark ? const Color(0xFF1D2B27) : Color.alphaBlend(primary.withValues(alpha: .085), Colors.white),
      surfaceContainerHighest: dark ? const Color(0xFF253530) : Color.alphaBlend(tertiary.withValues(alpha: .075), Colors.white),
      onSurface: dark ? const Color(0xFFE7F2EE) : AppColors.ink,
      onSurfaceVariant: dark ? const Color(0xFFB8CBC3) : AppColors.muted,
    );

    final base = ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      useMaterial3: true,
    );

    return base.copyWith(
      scaffoldBackgroundColor: scheme.surface,
      textTheme: AppTypography.textTheme(base.textTheme),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: scheme.primary.withValues(alpha: dark ? .28 : .14),
        labelTextStyle: WidgetStatePropertyAll(
          base.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? scheme.onSecondaryContainer
                : scheme.onSurfaceVariant,
          );
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surface,
        indicatorColor: scheme.primary.withValues(alpha: dark ? .28 : .14),
        selectedIconTheme: IconThemeData(color: scheme.onPrimaryContainer),
        unselectedIconTheme: IconThemeData(color: scheme.onSurfaceVariant),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 52),
          elevation: 0,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary.withValues(alpha: .7)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: scheme.primary),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: scheme.primary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        circularTrackColor: scheme.primary.withValues(alpha: .14),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? scheme.surfaceContainerLow : scheme.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: .45),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surfaceContainerLow,
        surfaceTintColor: scheme.surfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: .28),
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        selectedColor: scheme.primaryContainer,
        labelStyle: base.textTheme.labelMedium?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(
          color: scheme.outlineVariant.withValues(alpha: .35),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return scheme.primary;
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(scheme.primary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return scheme.onPrimary;
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return scheme.primary;
          return null;
        }),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant.withValues(alpha: .45),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: base.textTheme.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }
}
