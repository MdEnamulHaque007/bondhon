import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/safety/data/privacy_storage.dart';
import 'package:bondhon/features/safety/domain/entities/privacy_settings.dart';
import 'package:bondhon/features/safety/presentation/screens/privacy_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakePrivacyStorage extends PrivacyStorage {
  _FakePrivacyStorage(this.value);

  PrivacySettings value;

  @override
  Future<PrivacySettings> read() async => value;

  @override
  Future<void> write(PrivacySettings settings) async {
    value = settings;
  }
}

void main() {
  testWidgets('privacy switches persist local changes', (tester) async {
    final storage = _FakePrivacyStorage(const PrivacySettings());

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: AppLocalizations.englishLocale,
        home: PrivacySettingsScreen(storage: storage),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Privacy & Safety'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsNWidgets(4));

    await tester.tap(find.byType(SwitchListTile).at(0));
    await tester.pumpAndSettle();

    expect(storage.value.lastSeenVisible, isFalse);
  });
}
