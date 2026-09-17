import 'dart:convert';

import 'package:bondhon/features/safety/domain/entities/safety_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafetyStorage {
  SafetyStorage({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  static const blockedUsersKey = 'bondhon_blocked_users';
  static const reportsKey = 'bondhon_safety_reports';
  final SharedPreferencesAsync _preferences;

  Future<Set<String>> readBlockedUserIds() async {
    final encoded = await _preferences.getString(blockedUsersKey);
    if (encoded == null) return <String>{};
    try {
      final decoded = jsonDecode(encoded);
      return decoded is List
          ? decoded.whereType<String>().toSet()
          : <String>{};
    } on FormatException {
      return <String>{};
    }
  }

  Future<void> blockUser(String userId) async {
    final blockedIds = await readBlockedUserIds();
    blockedIds.add(userId);
    await _preferences.setString(blockedUsersKey, jsonEncode(blockedIds.toList()));
  }

  Future<void> unblockUser(String userId) async {
    final blockedIds = await readBlockedUserIds();
    blockedIds.remove(userId);
    await _preferences.setString(blockedUsersKey, jsonEncode(blockedIds.toList()));
  }

  Future<void> saveReport(SafetyReport report) async {
    final encoded = await _preferences.getString(reportsKey);
    final reports = <Object?>[];
    if (encoded != null) {
      try {
        final decoded = jsonDecode(encoded);
        if (decoded is List) reports.addAll(decoded);
      } on FormatException {
        // Ignore corrupted local demo data and start a clean report list.
      }
    }
    reports.add(report.toJson());
    await _preferences.setString(reportsKey, jsonEncode(reports));
  }
}
