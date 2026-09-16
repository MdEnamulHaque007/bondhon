import 'package:bondhon/core/localization/language_controller.dart';
import 'package:flutter/widgets.dart';

class LanguageScope extends InheritedNotifier<LanguageController> {
  const LanguageScope({
    required LanguageController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static LanguageController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LanguageScope>();
    assert(scope != null, 'LanguageScope was not found above this context.');
    return scope!.notifier!;
  }
}
