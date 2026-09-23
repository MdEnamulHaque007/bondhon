import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/feed/data/feed_repository.dart';
import 'package:bondhon/features/feed/presentation/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('creates a post and can like it', (tester) async {
    final repository = FeedRepository(initialPosts: []);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: const [
          AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: AppLocalizations.englishLocale,
          home: FeedScreen(repository: repository),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('feed-post-input')), 'My first post');
    await tester.tap(find.byKey(const Key('create-feed-post')));
    await tester.pumpAndSettle();

    expect(find.text('My first post'), findsOneWidget);
    expect(repository.posts.first.content, 'My first post');

    await tester.tap(find.byIcon(Icons.favorite_border_rounded).first);
    await tester.pump();

    expect(repository.posts.first.isLiked, isTrue);
    expect(repository.posts.first.likeCount, 1);

    repository.dispose();
  });
}
