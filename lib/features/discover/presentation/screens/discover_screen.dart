import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/discover/data/discover_repository.dart';
import 'package:bondhon/features/discover/domain/entities/discover_user.dart';
import 'package:bondhon/features/safety/data/safety_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({
    super.key,
    this.repository = const DiscoverRepository(),
  });

  final DiscoverRepository repository;

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _searchController = TextEditingController();
  final _pendingRequests = <String>{};
  final _safetyStorage = SafetyStorage();
  Set<String> _blockedUserIds = const {};
  DiscoverFilter _filter = DiscoverFilter.all;

  @override
  void initState() {
    super.initState();
    _loadBlockedUsers();
  }

  Future<void> _loadBlockedUsers() async {
    final blockedUserIds = await _safetyStorage.readBlockedUserIds();
    if (!mounted) return;
    setState(() => _blockedUserIds = blockedUserIds);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final users = widget.repository
        .search(
          query: _searchController.text,
          filter: _filter,
        )
        .where((user) => !_blockedUserIds.contains(user.id))
        .toList(growable: false);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          strings.discoverPeople,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      FilledButton.tonalIcon(
                        onPressed: () => context.go(AppRoutes.friends),
                        icon: const Icon(Icons.people_outline_rounded),
                        label: Text(strings.friendsAndRequests),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    strings.discoverPeopleDescription,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: strings.searchPeople,
                      prefixIcon: const Icon(Icons.person_search_rounded),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: strings.clearSearch,
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              icon: const Icon(Icons.close_rounded),
                            ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final filter in DiscoverFilter.values) ...[
                          ChoiceChip(
                            label: Text(_filterLabel(strings, filter)),
                            selected: _filter == filter,
                            onSelected: (_) => setState(() => _filter = filter),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (users.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text(strings.noPeopleFound)),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              sliver: SliverGrid.builder(
                itemCount: users.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 430,
                  mainAxisExtent: 300,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                ),
                itemBuilder: (context, index) {
                  final user = users[index];
                  final pending = _pendingRequests.contains(user.id) ||
                      user.friendshipStatus == FriendshipStatus.pending;
                  return _DiscoverUserCard(
                    user: user,
                    isPending: pending,
                    onAddFriend: () => setState(() => _pendingRequests.add(user.id)),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  String _filterLabel(AppLocalizations strings, DiscoverFilter filter) {
    return switch (filter) {
      DiscoverFilter.all => strings.all,
      DiscoverFilter.online => strings.onlineNow,
      DiscoverFilter.nearby => strings.nearby,
      DiscoverFilter.commonInterests => strings.commonInterests,
    };
  }
}

class _DiscoverUserCard extends StatelessWidget {
  const _DiscoverUserCard({
    required this.user,
    required this.isPending,
    required this.onAddFriend,
  });

  final DiscoverUser user;
  final bool isPending;
  final VoidCallback onAddFriend;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(AppRoutes.discoverProfile(user.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: user.avatarColor,
                    foregroundColor: Colors.white,
                    child: Text(
                      user.initials,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: user.isOnline
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(user.displayName, style: Theme.of(context).textTheme.titleLarge),
              Text('@${user.username} · ${user.location}'),
              const SizedBox(height: AppSpacing.xs),
              Text(strings.mutualFriendCount(user.mutualFriends)),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xxs,
                alignment: WrapAlignment.center,
                children: [
                  for (final interest in user.interests.take(3))
                    Chip(label: Text(interest)),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.go(AppRoutes.discoverProfile(user.id)),
                      child: Text(strings.viewProfile),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: _FriendActionButton(
                      status: user.friendshipStatus,
                      isPending: isPending,
                      onAddFriend: onAddFriend,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FriendActionButton extends StatelessWidget {
  const _FriendActionButton({
    required this.status,
    required this.isPending,
    required this.onAddFriend,
  });

  final FriendshipStatus status;
  final bool isPending;
  final VoidCallback onAddFriend;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    if (status == FriendshipStatus.friends) {
      return FilledButton.tonalIcon(
        onPressed: () => context.go(AppRoutes.chats),
        icon: const Icon(Icons.chat_bubble_outline_rounded),
        label: Text(strings.message),
      );
    }
    if (isPending) {
      return FilledButton.tonalIcon(
        onPressed: null,
        icon: const Icon(Icons.schedule_rounded),
        label: Text(strings.requestSent),
      );
    }
    return FilledButton.icon(
      onPressed: onAddFriend,
      icon: const Icon(Icons.person_add_alt_1_rounded),
      label: Text(strings.addFriend),
    );
  }
}
