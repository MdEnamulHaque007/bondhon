import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

enum BondhonButtonStyle { primary, secondary, text }

class BondhonButton extends StatelessWidget {
  const BondhonButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.style = BondhonButtonStyle.primary,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final BondhonButtonStyle style;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final action = isLoading ? null : onPressed;
    final child = AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: isLoading
          ? const SizedBox.square(
              key: ValueKey('loading'),
              dimension: 22,
              child: CircularProgressIndicator(strokeWidth: 2.4),
            )
          : Row(
              key: const ValueKey('label'),
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: AppSpacing.xs),
                ],
                Text(label),
              ],
            ),
    );

    final button = switch (style) {
      BondhonButtonStyle.primary => FilledButton(
          onPressed: action,
          child: child,
        ),
      BondhonButtonStyle.secondary => OutlinedButton(
          onPressed: action,
          child: child,
        ),
      BondhonButtonStyle.text => TextButton(
          onPressed: action,
          child: child,
        ),
    };

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
