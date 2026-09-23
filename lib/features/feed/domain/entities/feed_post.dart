enum FeedPrivacy { public, friends, onlyMe }

class FeedComment {
  const FeedComment({
    required this.id,
    required this.authorName,
    required this.text,
    required this.createdAt,
  });

  final String id;
  final String authorName;
  final String text;
  final DateTime createdAt;
}

class FeedPost {
  const FeedPost({
    required this.id,
    required this.authorName,
    required this.authorId,
    required this.content,
    required this.privacy,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
    required this.comments,
    this.isPhotoPlaceholder = false,
    this.isLiked = false,
  });

  final String id;
  final String authorName;
  final String authorId;
  final String content;
  final FeedPrivacy privacy;
  final DateTime createdAt;
  final int likeCount;
  final int commentCount;
  final List<FeedComment> comments;
  final bool isPhotoPlaceholder;
  final bool isLiked;

  FeedPost copyWith({
    String? content,
    FeedPrivacy? privacy,
    int? likeCount,
    int? commentCount,
    List<FeedComment>? comments,
    bool? isPhotoPlaceholder,
    bool? isLiked,
  }) => FeedPost(
        id: id,
        authorName: authorName,
        authorId: authorId,
        content: content ?? this.content,
        privacy: privacy ?? this.privacy,
        createdAt: createdAt,
        likeCount: likeCount ?? this.likeCount,
        commentCount: commentCount ?? this.commentCount,
        comments: comments ?? this.comments,
        isPhotoPlaceholder: isPhotoPlaceholder ?? this.isPhotoPlaceholder,
        isLiked: isLiked ?? this.isLiked,
      );
}
