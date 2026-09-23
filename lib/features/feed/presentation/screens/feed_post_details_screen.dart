import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/feed/data/feed_repository.dart';
import 'package:bondhon/features/feed/domain/entities/feed_post.dart';
import 'package:bondhon/features/safety/domain/entities/safety_report.dart';
import 'package:bondhon/features/safety/presentation/widgets/safety_dialogs.dart';
import 'package:flutter/material.dart';

class FeedPostDetailsScreen extends StatefulWidget {
  const FeedPostDetailsScreen({required this.postId, super.key});
  final String postId;

  @override
  State<FeedPostDetailsScreen> createState() => _FeedPostDetailsScreenState();
}

class _FeedPostDetailsScreenState extends State<FeedPostDetailsScreen> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: feedRepository,
      builder: (context, _) {
        final post = feedRepository.findById(widget.postId);
        if (post == null) {
          return Scaffold(
            appBar: AppBar(title: Text(strings.socialFeed)),
            body: Center(child: Text(strings.postNotFound)),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(strings.postDetails),
            actions: [
              IconButton(
                tooltip: strings.reportPost,
                onPressed: () => showReportDialog(
                  context: context,
                  targetType: ReportTargetType.message,
                  targetId: post.id,
                ),
                icon: const Icon(Icons.flag_outlined),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.authorName, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(_relativeTime(post.createdAt, strings)),
                      const SizedBox(height: AppSpacing.md),
                      Text(post.content, style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => feedRepository.toggleLike(post.id),
                            icon: Icon(post.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded),
                          ),
                          Text('${post.likeCount}'),
                          const SizedBox(width: AppSpacing.md),
                          Text('${post.commentCount} ${strings.comments}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(strings.comments, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              if (post.comments.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  child: Text(strings.noComments),
                ),
              for (final comment in post.comments)
                ListTile(
                  leading: CircleAvatar(child: Text(comment.authorName.characters.first)),
                  title: Text(comment.authorName),
                  subtitle: Text(comment.text),
                ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const Key('feed-comment-input'),
                      controller: _commentController,
                      decoration: InputDecoration(hintText: strings.writeComment),
                    ),
                  ),
                  IconButton(
                    key: const Key('send-feed-comment'),
                    tooltip: strings.send,
                    onPressed: () {
                      feedRepository.addComment(
                        postId: post.id,
                        authorName: 'Guest User',
                        text: _commentController.text,
                      );
                      _commentController.clear();
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

String _relativeTime(DateTime time, AppLocalizations strings) {
  final difference = DateTime.now().difference(time);
  if (difference.inMinutes < 1) return strings.justNow;
  if (difference.inMinutes < 60) return strings.minutesAgo(difference.inMinutes);
  if (difference.inHours < 24) return strings.hoursAgo(difference.inHours);
  return strings.daysAgo(difference.inDays);
}
