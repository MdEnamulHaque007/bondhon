import 'package:bondhon/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows Bondhon welcome screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: BondhonApp()));

    expect(find.text('Bondhon'), findsOneWidget);
    expect(find.text('কথায় কথায় গড়ে উঠুক বন্ধন'), findsOneWidget);
    expect(find.text('এখনই প্রবেশ করুন'), findsOneWidget);
    expect(find.text('Login structure দেখুন'), findsOneWidget);
    expect(find.textContaining('নিরাপদে কথা বলুন'), findsOneWidget);

    await tester.tap(find.text('এখনই প্রবেশ করুন'));
    await tester.pumpAndSettle();

    expect(find.textContaining('অতিথি ব্যবহারকারী'), findsOneWidget);
    expect(find.textContaining('কোনো লগইন প্রয়োজন নেই'), findsOneWidget);
  });
}
