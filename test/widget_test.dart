import 'package:bondhon/app/app.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/core/localization/language_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('uses English by default and supports Bangla', (tester) async {
    final languageController = LanguageController();
    await tester.pumpWidget(
      ProviderScope(
        child: BondhonApp(languageController: languageController),
      ),
    );

    expect(find.text('Bondhon'), findsOneWidget);
    expect(find.text('Build bonds through every conversation'), findsOneWidget);
    expect(find.text('Enter now'), findsOneWidget);
    expect(find.text('View login structure'), findsOneWidget);

    await tester.tap(find.text('Enter now'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Guest User'), findsOneWidget);
    expect(find.textContaining('no login is required'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Chats'), findsWidgets);
    expect(find.text('Rooms'), findsWidgets);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Profile'), findsWidgets);

    await languageController.changeLanguage(AppLocalizations.banglaLocale);
    await tester.pumpAndSettle();

    expect(find.text('হোম'), findsOneWidget);
    expect(find.textContaining('অতিথি ব্যবহারকারী'), findsOneWidget);
  });
}
