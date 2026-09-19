import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/friends/data/friends_repository.dart';
import 'package:bondhon/features/friends/domain/entities/friend_connection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({
    super.key,
    this.repository = const FriendsRepository(),
  });

  final FriendsRepository repository;

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  late final TabController _tabController;
  late final List<FriendConnection> _connections;

  @override
  void initState() {
    super.initState();
    _connections = widget.repository.initialConnections();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging) setState(() {});
      });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  FriendConnectionType get _selectedType => switch (_tabController.index) {
        1 => FriendConnectionType.incoming,
        2 => FriendConnectionType.outgoing,
        _ => FriendConnectionType.friend,
      };

  void _accept(FriendConnection connection) {
    _replace(connection, FriendConnectionType.friend);
    _showMessage(AppLocalizations.of(context).friendRequestAccepted);
  }

  void _reject(FriendConnection connection) {
    setState(() => _connections.removeWhere((item) => item.id == connection.id));
    _showMessage(AppLocalizations.of(context).friendRequestRejected);
  }

  void _cancel(FriendConnection connection) {
    setState(() => _connections.removeWhere((item) => item.id == connection.id));
    _showMessage(AppLocalizations.of(context).friendRequestCancelled);
  }

  void _replace(FriendConnection connection, FriendConnectionType type) {
    final index = _connections.indexWhere((item) => item.id == connection.id);
    if (index < 0) return;
    setState(() => _connections[index] = connection.copyWith(connectionType: type));
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final visibleConnections = widget.repository.search(
      _connections,
      type: _selectedType,
      query: _searchController.text,
    );
    final incomingCount = _connections
        .where((item) => item.connectionType == FriendConnectionType.incoming)
        .length;

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          tooltip: strings.backToDiscover,
                          onPressed: () => context.go(AppRoutes.discover),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        Expanded(
                          child: Text(
                            strings.friendsAndRequests,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        labelText: strings.searchFriends,
                        prefixIcon: const Icon(Icons.search_rounded),
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
                    TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: strings.friends),
                        Tab(text: '${strings.incoming} ($incomingCount)'),
                        Tab(text: strings.outgoing),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: visibleConnections.isEmpty
                    ? Center(child: Text(_emptyLabel(strings)))
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          AppSpacing.sm,
                          AppSpacing.lg,
                          AppSpacing.lg,
                        ),
                        itemCount: visibleConnections.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppSpacing.xs),
                        itemBuilder: (context, index) {
                          final connection = visibleConnections[index];
                          return _FriendConnectionTile(
                            connection: connection,
                            onAccept: () => _accept(connection),
                            onReject: () => _reject(connection),
                            onCancel: () => _cancel(connection),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _emptyLabel(AppLocalizations strings) {
    return switch (_selectedType) {
      FriendConnectionType.friend => strings.noFriendsFound,
      FriendConnectionType.incoming => strings.noIncomingRequests,
      FriendConnectionType.outgoing => strings.noOutgoingRequests,
    };
  }
}

class _FriendConnectionTile extends StatelessWidget {
  const _FriendConnectionTile({
    required this.connection,
    required this.onAccept,
    required this.onReject,
    required this.onCancel,
  });

  final FriendConnection connection;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: connection.avatarColor,
                  foregroundColor: Colors.white,
                  child: Text(connection.initials),
                ),
                Positioned(
                  right: -1,
                  bottom: -1,
                  child: Icon(
                    Icons.circle,
                    size: 16,
                    color: connection.isOnline
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    connection.displayName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('@${connection.username} · ${connection.location}'),
                  Text(strings.mutualFriendCount(connection.mutualFriends)),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(child: _actions(context, strings)),
          ],
        ),
      ),
    );
  }

  Widget _actions(BuildContext context, AppLocalizations strings) {
    return switch (connection.connectionType) {
      FriendConnectionType.friend => Wrap(
          spacing: AppSpacing.xs,
          children: [
            IconButton.filledTonal(
              tooltip: strings.viewProfile,
              onPressed: () => context.go(
                AppRoutes.discoverProfile(connection.id),
              ),
              icon: const Icon(Icons.person_outline_rounded),
            ),
            IconButton.filled(
              tooltip: strings.message,
              onPressed: () => context.go(AppRoutes.chats),
              icon: const Icon(Icons.chat_bubble_outline_rounded),
            ),
          ],
        ),
      FriendConnectionType.incoming => Wrap(
          spacing: AppSpacing.xs,
          children: [
            OutlinedButton(onPressed: onReject, child: Text(strings.reject)),
            FilledButton(onPressed: onAccept, child: Text(strings.accept)),
          ],
        ),
      FriendConnectionType.outgoing => OutlinedButton.icon(
          onPressed: onCancel,
          icon: const Icon(Icons.close_rounded),
          label: Text(strings.cancelRequest),
        ),
    };
  }
}
