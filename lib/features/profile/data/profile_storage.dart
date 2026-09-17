import 'dart:convert';

import 'package:bondhon/features/profile/domain/entities/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileStorage {
  ProfileStorage({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  static const profileKey = 'bondhon_guest_profile';
  final SharedPreferencesAsync _preferences;

  Future<UserProfile> read() async {
    final rawProfile = await _preferences.getString(profileKey);
    if (rawProfile == null) return UserProfile.guest;

    try {
      final json = jsonDecode(rawProfile);
      return json is Map<String, dynamic>
          ? UserProfile.fromJson(json)
          : UserProfile.guest;
    } on FormatException {
      return UserProfile.guest;
    }
  }

  Future<void> write(UserProfile profile) {
    return _preferences.setString(profileKey, jsonEncode(profile.toJson()));
  }
}
