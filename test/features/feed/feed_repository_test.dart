import 'package:bondhon/features/feed/data/feed_repository.dart';
import 'package:bondhon/features/feed/domain/entities/feed_post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('creates a local guest post', () {
    final repository = FeedRepository(initialPosts: []);
    final post = repository.createPost(
      authorName: 'Guest User',
      authorId: 'guest',
      content: 'Hello Bondhon',
      privacy: FeedPrivacy.public,
    );
    expect(repository.posts.first.id, post.id);
    expect(post.content, 'Hello Bondhon');
    expect(post.likeCount, 0);
  });

  test('toggles like locally', () {
    final repository = FeedRepository(initialPosts: []);
    final post = repository.createPost(
      authorName: 'Guest User',
      authorId: 'guest',
      content: 'Like me',
      privacy: FeedPrivacy.friends,
    );
    repository.toggleLike(post.id);
    expect(repository.findById(post.id)!.isLiked, isTrue);
    expect(repository.findById(post.id)!.likeCount, 1);
    repository.toggleLike(post.id);
    expect(repository.findById(post.id)!.isLiked, isFalse);
    expect(repository.findById(post.id)!.likeCount, 0);
  });

  test('adds a local comment', () {
    final repository = FeedRepository(initialPosts: []);
    final post = repository.createPost(
      authorName: 'Guest User',
      authorId: 'guest',
      content: 'Comment me',
      privacy: FeedPrivacy.public,
    );
    repository.addComment(postId: post.id, authorName: 'Guest User', text: 'Nice post');
    expect(repository.findById(post.id)!.commentCount, 1);
  });
}
