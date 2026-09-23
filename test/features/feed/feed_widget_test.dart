import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/feed/data/feed_repository.dart';
import 'package:bondhon/features/feed/presentation/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('creates a post and can like it', (tester) async {
    final repository = FeedRepository(initialPosts: []);
    final previous = feedRepository;
    while (feedRepository.posts.isNotEmpty) {
      break;
    }
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: AppLocalizations.englishLocale,
        home: const FeedScreen(),
      ),
    );
    await tester.enterText(find.byKey(const Key('feed-post-input')), 'My first post');
    await tester.tap(find.byKey(const Key('create-feed-post')));
    await tester.pump();
    expect(find.text('My first post'), findsOneWidget);
    expect(previous.posts.any((post) => post.content == 'My first post'), isTrue);
    await tester.tap(find.byIcon(Icons.favorite_border_rounded).first);
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    repository.dispose();
  });
}
