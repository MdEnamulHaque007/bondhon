import 'package:bondhon/app/app.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/core/localization/language_controller.dart';
import 'package:bondhon/features/notifications/presentation/controllers/notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('uses English by default and supports Bangla', (tester) async {
    SharedPreferences.setMockInitialValues({});
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

    await tester.tap(find.text('Profile').last);
    await tester.pumpAndSettle();

    expect(find.text('Guest account'), findsOneWidget);
    expect(find.text('Personal information'), findsOneWidget);
    expect(find.text('Edit profile'), findsOneWidget);

    await tester.tap(find.text('Edit profile'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Enamul Haque');
    await tester.enterText(find.byType(TextFormField).at(1), 'enamul_007');
    await tester.tap(find.text('Save changes'));
    await tester.pumpAndSettle();

    expect(find.text('Profile saved on this device.'), findsOneWidget);

    await languageController.changeLanguage(AppLocalizations.banglaLocale);
    await tester.pumpAndSettle();

    expect(find.text('প্রোফাইল'), findsWidgets);
    expect(find.text('ব্যক্তিগত তথ্য'), findsOneWidget);
  });

  testWidgets('guest can browse and join a public room', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final languageController = LanguageController();
    await tester.pumpWidget(
      ProviderScope(
        child: BondhonApp(languageController: languageController),
      ),
    );

    await tester.tap(find.text('Enter now'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rooms').first);
    await tester.pumpAndSettle();

    expect(find.text('Public Chat Rooms'), findsOneWidget);
    expect(find.text('Bondhutto Corner'), findsOneWidget);

    await tester.tap(find.text('Bondhutto Corner'));
    await tester.pumpAndSettle();
    expect(find.text('Join as guest'), findsOneWidget);

    await tester.tap(find.text('Join as guest'));
    await tester.pumpAndSettle();
    expect(find.text('Joined'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('guest can open a private chat and send a local message', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final languageController = LanguageController();
    await tester.pumpWidget(
      ProviderScope(
        child: BondhonApp(languageController: languageController),
      ),
    );

    await tester.tap(find.text('Enter now'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Chats').first);
    await tester.pumpAndSettle();

    expect(find.text('Private Chats'), findsOneWidget);
    expect(find.text('Nadia Rahman'), findsOneWidget);

    await tester.tap(find.text('Nadia Rahman'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Hello Nadia');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Hello Nadia'), findsOneWidget);
  });

  testWidgets('guest can preview a profile and send a friend request', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final languageController = LanguageController();
    await tester.pumpWidget(
      ProviderScope(
        child: BondhonApp(languageController: languageController),
      ),
    );

    await tester.tap(find.text('Enter now'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discover').first);
    await tester.pumpAndSettle();

    expect(find.text('Discover People'), findsOneWidget);
    expect(find.text('Ayesha Khan'), findsOneWidget);

    await tester.tap(find.text('Ayesha Khan'));
    await tester.pumpAndSettle();
    expect(find.text('About'), findsOneWidget);

    await tester.tap(find.text('Add friend'));
    await tester.pumpAndSettle();
    expect(find.text('Request sent'), findsOneWidget);
  });

  testWidgets('guest can accept and cancel friend requests', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final languageController = LanguageController();
    await tester.pumpWidget(
      ProviderScope(
        child: BondhonApp(languageController: languageController),
      ),
    );

    await tester.tap(find.text('Enter now'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discover').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Friends & Requests'));
    await tester.pumpAndSettle();

    expect(find.text('Maliha Sultana'), findsOneWidget);
    await tester.tap(find.text('Incoming (2)'));
    await tester.pumpAndSettle();
    expect(find.text('Nusrat Jahan'), findsOneWidget);

    await tester.tap(find.text('Accept').first);
    await tester.pumpAndSettle();
    expect(find.text('Friend request accepted.'), findsOneWidget);

    await tester.tap(find.text('Outgoing'));
    await tester.pumpAndSettle();
    expect(find.text('Tanvir Ahmed'), findsOneWidget);
    await tester.tap(find.text('Cancel request'));
    await tester.pumpAndSettle();
    expect(find.text('Friend request cancelled.'), findsOneWidget);
  });

  testWidgets('guest can report and block a discovered user', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final languageController = LanguageController();
    await tester.pumpWidget(
      ProviderScope(
        child: BondhonApp(languageController: languageController),
      ),
    );

    await tester.tap(find.text('Enter now'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discover').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ayesha Khan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Report user'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Spam or misleading content'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    expect(find.text('Report submitted for review.'), findsOneWidget);

    await tester.tap(find.text('Block user'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Block'));
    await tester.pumpAndSettle();
    expect(find.text('Discover People'), findsOneWidget);
    expect(find.text('Ayesha Khan'), findsNothing);
  });

  testWidgets('guest can manage notification read state', (tester) async {
    SharedPreferences.setMockInitialValues({});
    notificationCenter.reset();
    final languageController = LanguageController();
    await tester.pumpWidget(
      ProviderScope(
        child: BondhonApp(languageController: languageController),
      ),
    );

    await tester.tap(find.text('Enter now'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.notifications_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Unread (2)'), findsOneWidget);
    expect(find.text('New friend request'), findsOneWidget);

    await tester.tap(find.text('Mark all as read'));
    await tester.pumpAndSettle();
    expect(find.text('Unread (0)'), findsOneWidget);

    await tester.tap(find.byTooltip('Delete notification').first);
    await tester.pumpAndSettle();
    expect(find.text('New friend request'), findsNothing);
  });
}
