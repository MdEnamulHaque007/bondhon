import 'dart:convert';

import 'package:bondhon/features/safety/domain/entities/privacy_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyStorage {
  PrivacyStorage({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  static const privacySettingsKey = 'bondhon_privacy_settings';
  final SharedPreferencesAsync _preferences;

  Future<PrivacySettings> read() async {
    final encoded = await _preferences.getString(privacySettingsKey);
    if (encoded == null) return const PrivacySettings();

    try {
      final decoded = jsonDecode(encoded);
      return decoded is Map
          ? PrivacySettings.fromJson(Map<String, Object?>.from(decoded))
          : const PrivacySettings();
    } on FormatException {
      return const PrivacySettings();
    }
  }

  Future<void> write(PrivacySettings settings) async {
    await _preferences.setString(
      privacySettingsKey,
      jsonEncode(settings.toJson()),
    );
  }
}
