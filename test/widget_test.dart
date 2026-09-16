import 'package:bondhon/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows Bondhon welcome screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: BondhonApp()));

    expect(find.text('Bondhon'), findsOneWidget);
    expect(find.text('কথায় কথায় গড়ে উঠুক বন্ধন'), findsOneWidget);
    expect(find.text('শুরু করুন'), findsOneWidget);
  });
}
