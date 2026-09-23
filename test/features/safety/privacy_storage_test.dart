import 'package:bondhon/features/safety/data/privacy_storage.dart';
import 'package:bondhon/features/safety/domain/entities/privacy_settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('persists and restores privacy settings', () async {
    final preferences = SharedPreferencesAsync();
    await preferences.remove(PrivacyStorage.privacySettingsKey);
    final storage = PrivacyStorage(preferences: preferences);
    const settings = PrivacySettings(
      lastSeenVisible: false,
      profilePhotoVisible: false,
      allowMessages: false,
      allowGroupAdds: true,
    );

    await storage.write(settings);
    final restored = await storage.read();

    expect(restored.lastSeenVisible, isFalse);
    expect(restored.profilePhotoVisible, isFalse);
    expect(restored.allowMessages, isFalse);
    expect(restored.allowGroupAdds, isTrue);

    await preferences.remove(PrivacyStorage.privacySettingsKey);
  });
}
