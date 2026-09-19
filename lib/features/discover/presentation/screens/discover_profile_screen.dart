import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/discover/data/discover_repository.dart';
import 'package:bondhon/features/discover/domain/entities/discover_user.dart';
import 'package:bondhon/features/safety/data/safety_storage.dart';
import 'package:bondhon/features/safety/domain/entities/safety_report.dart';
import 'package:bondhon/features/safety/presentation/widgets/safety_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DiscoverProfileScreen extends StatefulWidget {
  const DiscoverProfileScreen({
    required this.userId,
    super.key,
    this.repository = const DiscoverRepository(),
  });

  final String userId;
  final DiscoverRepository repository;

  @override
  State<DiscoverProfileScreen> createState() => _DiscoverProfileScreenState();
}

class _DiscoverProfileScreenState extends State<DiscoverProfileScreen> {
  bool _requestSent = false;
  late final SafetyStorage _safetyStorage;

  @override
  void initState() {
    super.initState();
    _safetyStorage = SafetyStorage();
  }

  Future<void> _blockUser(DiscoverUser user) async {
    final confirmed = await confirmBlockUser(
      context: context,
      displayName: user.displayName,
    );
    if (!confirmed || !mounted) return;
    await _safetyStorage.blockUser(user.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).userBlocked)),
    );
    context.go(AppRoutes.discover);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final user = widget.repository.findById(widget.userId);
    if (user == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(strings.userNotFound),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(
              onPressed: () => context.go(AppRoutes.discover),
              child: Text(strings.backToDiscover),
            ),
          ],
        ),
      );
    }

    final pending = _requestSent ||
        user.friendshipStatus == FriendshipStatus.pending;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () => context.go(AppRoutes.discover),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: Text(strings.backToDiscover),
                    ),
                  ),
                  Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 56,
                                backgroundColor: user.avatarColor,
                                foregroundColor: Colors.white,
                                child: Text(
                                  user.initials,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                              Positioned(
                                right: 4,
                                bottom: 4,
                                child: Icon(
                                  Icons.circle,
                                  size: 20,
                                  color: user.isOnline
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            user.displayName,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text('@${user.username}'),
                          const SizedBox(height: AppSpacing.xs),
                          Text('${user.location} · ${user.isOnline ? strings.online : strings.offline}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(strings.about, style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: AppSpacing.sm),
                          Text(user.bio),
                          const SizedBox(height: AppSpacing.lg),
                          Text(strings.interests, style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: AppSpacing.xs),
                          Wrap(
                            spacing: AppSpacing.xs,
                            children: [
                              for (final interest in user.interests)
                                Chip(label: Text(interest)),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(strings.mutualFriendCount(user.mutualFriends)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => showReportDialog(
                            context: context,
                            targetType: ReportTargetType.user,
                            targetId: user.id,
                            storage: _safetyStorage,
                          ),
                          icon: const Icon(Icons.flag_outlined),
                          label: Text(strings.reportUser),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _blockUser(user),
                          icon: const Icon(Icons.block_rounded),
                          label: Text(strings.blockUser),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (user.friendshipStatus == FriendshipStatus.friends)
                    FilledButton.icon(
                      onPressed: () => context.go(AppRoutes.chats),
                      icon: const Icon(Icons.chat_bubble_outline_rounded),
                      label: Text(strings.message),
                    )
                  else
                    FilledButton.icon(
                      onPressed: pending
                          ? null
                          : () => setState(() => _requestSent = true),
                      icon: Icon(
                        pending
                            ? Icons.schedule_rounded
                            : Icons.person_add_alt_1_rounded,
                      ),
                      label: Text(pending ? strings.requestSent : strings.addFriend),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
