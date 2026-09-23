import 'package:flutter/foundation.dart';
import 'package:bondhon/features/feed/domain/entities/feed_post.dart';

class FeedRepository extends ChangeNotifier {
  FeedRepository({List<FeedPost>? initialPosts})
      : _posts = List<FeedPost>.from(initialPosts ?? _mockPosts);

  List<FeedPost> get posts => List.unmodifiable(_posts);

  final List<FeedPost> _posts;

  FeedPost? findById(String id) {
    for (final post in _posts) {
      if (post.id == id) return post;
    }
    return null;
  }

  FeedPost createPost({
    required String authorName,
    required String authorId,
    required String content,
    required FeedPrivacy privacy,
    bool isPhotoPlaceholder = false,
  }) {
    final post = FeedPost(
      id: 'post-${DateTime.now().microsecondsSinceEpoch}',
      authorName: authorName.trim().isEmpty ? 'Guest User' : authorName.trim(),
      authorId: authorId,
      content: content.trim(),
      privacy: privacy,
      createdAt: DateTime.now(),
      likeCount: 0,
      commentCount: 0,
      comments: const [],
      isPhotoPlaceholder: isPhotoPlaceholder,
    );
    _posts.insert(0, post);
    notifyListeners();
    return post;
  }

  void toggleLike(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index < 0) return;
    final post = _posts[index];
    _posts[index] = post.copyWith(
      isLiked: !post.isLiked,
      likeCount: post.likeCount + (post.isLiked ? -1 : 1),
    );
    notifyListeners();
  }

  void addComment({
    required String postId,
    required String authorName,
    required String text,
  }) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index < 0 || text.trim().isEmpty) return;
    final post = _posts[index];
    final comment = FeedComment(
      id: 'comment-${DateTime.now().microsecondsSinceEpoch}',
      authorName: authorName.trim().isEmpty ? 'Guest User' : authorName.trim(),
      text: text.trim(),
      createdAt: DateTime.now(),
    );
    _posts[index] = post.copyWith(
      comments: [...post.comments, comment],
      commentCount: post.commentCount + 1,
    );
    notifyListeners();
  }

  static final _mockPosts = <FeedPost>[
    FeedPost(
      id: 'welcome-post',
      authorId: 'rahim',
      authorName: 'Rahim Ahmed',
      content: 'Welcome to Bondhon! Share something with your community.',
      privacy: FeedPrivacy.public,
      createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
      likeCount: 18,
      commentCount: 3,
      comments: [
        FeedComment(
          id: 'comment-1',
          authorName: 'Sadia Khan',
          text: 'Glad to be here!',
          createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
        ),
      ],
    ),
    FeedPost(
      id: 'photo-post',
      authorId: 'nabila',
      authorName: 'Nabila Hasan',
      content: 'A photo placeholder for the local MVP.',
      privacy: FeedPrivacy.friends,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      likeCount: 42,
      commentCount: 6,
      comments: const [],
      isPhotoPlaceholder: true,
    ),
    FeedPost(
      id: 'private-post',
      authorId: 'farhan',
      authorName: 'Farhan Karim',
      content: 'This local post is visible only to me in the mock model.',
      privacy: FeedPrivacy.onlyMe,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      likeCount: 0,
      commentCount: 0,
      comments: const [],
    ),
  ];
}

final feedRepository = FeedRepository();
