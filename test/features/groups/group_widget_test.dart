import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/groups/data/group_repository.dart';
import 'package:bondhon/features/groups/presentation/screens/group_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('guest can join a group and send a local message', (tester) async {
    final repository = GroupRepository();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        home: GroupDetailsScreen(
          groupId: 'dhaka-foodies',
          repository: repository,
        ),
      ),
    );

    expect(find.text('Join as guest'), findsOneWidget);
    await tester.tap(find.text('Join as guest'));
    await tester.pumpAndSettle();

    expect(find.text('Joined'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Hello group');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Hello group'), findsOneWidget);
  });
}
