import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/auth/presentation/controllers/auth_providers.dart';
import 'package:bondhon/features/feed/data/feed_repository.dart';
import 'package:bondhon/features/feed/domain/entities/feed_post.dart';
import 'package:bondhon/features/feed/presentation/screens/feed_post_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({this.showAppBar = true, this.repository, super.key});

  final bool showAppBar;
  final FeedRepository? repository;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final feed = repository ?? feedRepository;
    return AnimatedBuilder(
      animation: feed,
      builder: (context, _) => Scaffold(
        appBar: showAppBar
            ? AppBar(
                title: Text(strings.socialFeed),
                actions: [
                  IconButton(
                    tooltip: strings.refreshFeed,
                    onPressed: () => feed.notifyListeners(),
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                ],
              )
            : null,
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _CreatePostCard(
              authorName: user.displayName,
              authorId: user.id,
              repository: feed,
            ),
            const SizedBox(height: AppSpacing.md),
            for (final post in feed.posts)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _PostCard(
                  post: post,
                  onLike: () => feed.toggleLike(post.id),
                  onOpen: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FeedPostDetailsScreen(postId: post.id),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CreatePostCard extends StatefulWidget {
  const _CreatePostCard({
    required this.authorName,
    required this.authorId,
    required this.repository,
  });
  final String authorName;
  final String authorId;
  final FeedRepository repository;

  @override
  State<_CreatePostCard> createState() => _CreatePostCardState();
}

class _CreatePostCardState extends State<_CreatePostCard> {
  final _controller = TextEditingController();
  FeedPrivacy _privacy = FeedPrivacy.public;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _createPost() {
    if (_controller.text.trim().isEmpty) return;
    widget.repository.createPost(
      authorName: widget.authorName,
      authorId: widget.authorId,
      content: _controller.text,
      privacy: _privacy,
    );
    _controller.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).postCreated)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.authorName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              key: const Key('feed-post-input'),
              controller: _controller,
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: strings.whatsOnYourMind,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                DropdownButton<FeedPrivacy>(
                  value: _privacy,
                  onChanged: (value) =>
                      setState(() => _privacy = value ?? _privacy),
                  items: [
                    DropdownMenuItem(
                      value: FeedPrivacy.public,
                      child: Text(strings.publicPrivacy),
                    ),
                    DropdownMenuItem(
                      value: FeedPrivacy.friends,
                      child: Text(strings.friendsPrivacy),
                    ),
                    DropdownMenuItem(
                      value: FeedPrivacy.onlyMe,
                      child: Text(strings.onlyMePrivacy),
                    ),
                  ],
                ),
                const Spacer(),
                FilledButton.icon(
                  key: const Key('create-feed-post'),
                  onPressed: _createPost,
                  icon: const Icon(Icons.send_rounded),
                  label: Text(strings.post),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.post,
    required this.onLike,
    required this.onOpen,
  });
  final FeedPost post;
  final VoidCallback onLike;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Text(post.authorName.characters.first),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.authorName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          _relativeTime(post.createdAt, strings),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    avatar: Icon(_privacyIcon(post.privacy), size: 16),
                    label: Text(_privacyLabel(strings, post.privacy)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              if (post.isPhotoPlaceholder)
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    size: 64,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              if (post.isPhotoPlaceholder) const SizedBox(height: AppSpacing.sm),
              Text(post.content, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  IconButton(
                    tooltip: strings.like,
                    onPressed: onLike,
                    icon: Icon(
                      post.isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                    ),
                    color: post.isLiked ? colors.error : colors.onSurfaceVariant,
                  ),
                  Text('${post.likeCount}'),
                  const SizedBox(width: AppSpacing.md),
                  const Icon(Icons.comment_outlined, size: 20),
                  const SizedBox(width: 4),
                  Text('${post.commentCount}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData _privacyIcon(FeedPrivacy privacy) => switch (privacy) {
      FeedPrivacy.public => Icons.public_rounded,
      FeedPrivacy.friends => Icons.people_alt_outlined,
      FeedPrivacy.onlyMe => Icons.lock_outline_rounded,
    };

String _privacyLabel(AppLocalizations strings, FeedPrivacy privacy) =>
    switch (privacy) {
      FeedPrivacy.public => strings.publicPrivacy,
      FeedPrivacy.friends => strings.friendsPrivacy,
      FeedPrivacy.onlyMe => strings.onlyMePrivacy,
    };

String _relativeTime(DateTime time, AppLocalizations strings) {
  final difference = DateTime.now().difference(time);
  if (difference.inMinutes < 1) return strings.justNow;
  if (difference.inMinutes < 60) {
    return strings.minutesAgo(difference.inMinutes);
  }
  if (difference.inHours < 24) return strings.hoursAgo(difference.inHours);
  return strings.daysAgo(difference.inDays);
}
