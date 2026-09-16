import 'package:shared_preferences/shared_preferences.dart';

class LanguageStorage {
  LanguageStorage({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  static const _languageCodeKey = 'bondhon_language_code';
  final SharedPreferencesAsync _preferences;

  Future<String?> readLanguageCode() {
    return _preferences.getString(_languageCodeKey);
  }

  Future<void> writeLanguageCode(String languageCode) {
    return _preferences.setString(_languageCodeKey, languageCode);
  }
}
