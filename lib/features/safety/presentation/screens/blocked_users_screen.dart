import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/discover/data/discover_repository.dart';
import 'package:bondhon/features/discover/domain/entities/discover_user.dart';
import 'package:bondhon/features/safety/data/safety_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({
    super.key,
    this.storage,
    this.discoverRepository = const DiscoverRepository(),
  });

  final SafetyStorage? storage;
  final DiscoverRepository discoverRepository;

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  late final SafetyStorage _storage;
  Set<String> _blockedIds = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _storage = widget.storage ?? SafetyStorage();
    _load();
  }

  Future<void> _load() async {
    final blockedIds = await _storage.readBlockedUserIds();
    if (!mounted) return;
    setState(() {
      _blockedIds = blockedIds;
      _loading = false;
    });
  }

  Future<void> _unblock(DiscoverUser user) async {
    await _storage.unblockUser(user.id);
    if (!mounted) return;
    setState(() => _blockedIds.remove(user.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).userUnblocked)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final users = _blockedIds
        .map(widget.discoverRepository.findById)
        .whereType<DiscoverUser>()
        .toList(growable: false);

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: strings.back,
                      onPressed: () => context.go(AppRoutes.profile),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    Expanded(
                      child: Text(
                        strings.blockedUsers,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : users.isEmpty
                        ? Center(child: Text(strings.noBlockedUsers))
                        : ListView.separated(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            itemCount: users.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: AppSpacing.xs),
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: user.avatarColor,
                                    foregroundColor: Colors.white,
                                    child: Text(user.initials),
                                  ),
                                  title: Text(user.displayName),
                                  subtitle: Text('@${user.username}'),
                                  trailing: OutlinedButton(
                                    onPressed: () => _unblock(user),
                                    child: Text(strings.unblock),
                                  ),
                                ),
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
}
