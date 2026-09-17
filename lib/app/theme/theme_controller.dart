import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global visual themes available throughout Bondhon.
enum AppThemeVariant {
  bondhon,
  blue,
  orange,
  dark,
  multicolor,
}

class ThemeController extends ChangeNotifier {
  ThemeController({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  static const storageKey = 'bondhon_theme_variant';
  final SharedPreferencesAsync _preferences;
  AppThemeVariant _variant = AppThemeVariant.bondhon;

  AppThemeVariant get variant => _variant;

  Future<void> load() async {
    final value = await _preferences.getString(storageKey);
    if (value == null) return;
    _variant = AppThemeVariant.values.firstWhere(
      (item) => item.name == value,
      orElse: () => AppThemeVariant.bondhon,
    );
    notifyListeners();
  }

  Future<void> setVariant(AppThemeVariant variant) async {
    if (_variant == variant) return;
    _variant = variant;
    notifyListeners();
    await _preferences.setString(storageKey, variant.name);
  }
}
