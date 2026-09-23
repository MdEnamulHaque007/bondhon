import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:flutter/material.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key, this.repository});

  final AdminRepository? repository;

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  late final AdminRepository _repo;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _repo = widget.repository ?? adminRepository;
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: _repo,
      builder: (context, _) {
        final query = _search.text.trim().toLowerCase();
        final users = _repo.users.where((user) {
          return user.name.toLowerCase().contains(query) ||
              user.username.toLowerCase().contains(query);
        }).toList();

        return Scaffold(
          appBar: AppBar(title: Text(strings.adminUsers)),
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              TextField(
                controller: _search,
                decoration: InputDecoration(
                  labelText: strings.adminSearchUsers,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final user in users)
                Card(
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text('@${user.username}'),
                    trailing: Wrap(
                      spacing: 4,
                      children: [
                        _StatusBadge(
                          user.status,
                          _statusLabel(strings, user.status),
                        ),
                        PopupMenuButton<AdminUserStatus>(
                          onSelected: (value) =>
                              _repo.setUserStatus(user.id, value),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: AdminUserStatus.warned,
                              child: Text(strings.adminWarn),
                            ),
                            PopupMenuItem(
                              value: AdminUserStatus.suspended,
                              child: Text(strings.adminSuspend),
                            ),
                            PopupMenuItem(
                              value: AdminUserStatus.banned,
                              child: Text(strings.adminBan),
                            ),
                            PopupMenuItem(
                              value: AdminUserStatus.active,
                              child: Text(strings.adminUnban),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _statusLabel(AppLocalizations strings, AdminUserStatus status) {
    switch (status) {
      case AdminUserStatus.active:
        return strings.adminActive;
      case AdminUserStatus.warned:
        return strings.adminWarned;
      case AdminUserStatus.suspended:
        return strings.adminSuspended;
      case AdminUserStatus.banned:
        return strings.adminBanned;
    }
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.status, this.label);

  final AdminUserStatus status;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final active = status == AdminUserStatus.active;
    return Chip(
      label: Text(label),
      backgroundColor:
          active ? colors.primaryContainer : colors.errorContainer,
      labelStyle: TextStyle(
        color: active ? colors.onPrimaryContainer : colors.onErrorContainer,
      ),
    );
  }
}
