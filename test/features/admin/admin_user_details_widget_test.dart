import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:bondhon/features/admin/presentation/screens/admin_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){testWidgets('user details shows local moderation history after action',(tester)async{
  final r=AdminRepository();
  await tester.pumpWidget(MaterialApp(localizationsDelegates:const[AppLocalizations.delegate],supportedLocales:AppLocalizations.supportedLocales,locale:AppLocalizations.englishLocale,home:AdminUserDetailsScreen(userId:'u1',repository:r)));
  expect(find.text('User details'),findsOneWidget);
  expect(find.text('No moderation actions yet.'),findsOneWidget);
  await tester.tap(find.text('Banned'));
  await tester.pumpAndSettle();
  expect(find.text('Reason'),findsOneWidget);
  await tester.enterText(find.byType(TextField),'Repeated spam');
  await tester.tap(find.text('Confirm action'));
  await tester.pumpAndSettle();
  expect(find.text('Moderation history'),findsOneWidget);
  expect(find.text('Repeated spam'),findsOneWidget);
});}
