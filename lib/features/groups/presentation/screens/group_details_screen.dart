import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/groups/data/group_repository.dart';
import 'package:bondhon/features/groups/domain/entities/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({
    required this.groupId,
    super.key,
    this.repository = groupRepository,
  });

  final String groupId;
  final GroupRepository repository;

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.repository.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.repository.removeListener(_refresh);
    _messageController.dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final group = widget.repository.findById(widget.groupId);
    if (group == null) {
      return Center(child: Text(strings.groupNotFound));
    }

    final joined = widget.repository.isMember(group.id);
    final guest = group.members.where((member) => member.id == 'guest').firstOrNull;
    final canMessage = joined &&
        (!group.adminOnlyMessaging ||
            guest?.role == GroupRole.owner ||
            guest?.role == GroupRole.admin);

    return SafeArea(
      child: Column(
        children: [
          _GroupHeader(
            group: group,
            joined: joined,
            onJoin: () => widget.repository.join(group.id),
            onLeave: () => widget.repository.leave(group.id),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              itemCount: group.messages.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) =>
                  _MessageBubble(message: group.messages[index]),
            ),
          ),
          if (joined && group.adminOnlyMessaging && !canMessage)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Text(
                strings.adminOnlyMessaging,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          _Composer(
            controller: _messageController,
            enabled: canMessage,
            onSend: () {
              widget.repository.sendMessage(group.id, _messageController.text);
              _messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({
    required this.group,
    required this.joined,
    required this.onJoin,
    required this.onLeave,
  });

  final Group group;
  final bool joined;
  final VoidCallback onJoin;
  final VoidCallback onLeave;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    final inviteLink = 'https://bondhon.app/groups/${group.id}';
    final rolePreview = group.members.take(3).map((member) {
      final role = switch (member.role) {
        GroupRole.owner => strings.owner,
        GroupRole.admin => strings.admin,
        GroupRole.member => strings.member,
      };
      return '${member.name} • $role';
    }).join('  •  ');

    return Card(
      margin: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: group.logoColor,
                  child: Text(
                    group.name.isEmpty ? '?' : group.name[0].toUpperCase(),
                    style: TextStyle(color: colors.onPrimary, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(group.name, style: Theme.of(context).textTheme.titleLarge),
                      Text(
                        '${strings.memberCount(group.memberCount)} • '
                        '${group.visibility == GroupVisibility.public ? strings.publicGroup : strings.privateGroup}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (!joined)
                  FilledButton(onPressed: onJoin, child: Text(strings.joinAsGuest))
                else
                  Chip(
                    avatar: const Icon(Icons.check_circle_outline_rounded),
                    label: Text(strings.joined),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(group.description),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${strings.rolesPreview}: $rolePreview',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                OutlinedButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: inviteLink));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(strings.inviteLinkCopied)),
                      );
                    }
                  },
                  icon: const Icon(Icons.link_rounded),
                  label: Text(strings.copyInviteLink),
                ),
                if (joined && group.ownerId != 'guest')
                  OutlinedButton.icon(
                    onPressed: onLeave,
                    icon: const Icon(Icons.logout_rounded),
                    label: Text(strings.leaveGroup),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              title: Text(strings.memberPreview),
              children: [
                for (final member in group.members.take(5))
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 16,
                      child: Text(member.name[0].toUpperCase()),
                    ),
                    title: Text(member.name),
                    trailing: Text(
                      switch (member.role) {
                        GroupRole.owner => strings.owner,
                        GroupRole.admin => strings.admin,
                        GroupRole.member => strings.member,
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final GroupMessage message;

  @override
  Widget build(BuildContext context) {
    final isGuest = message.senderId == 'guest';
    final colors = Theme.of(context).colorScheme;
    return Align(
      alignment: isGuest ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 640),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isGuest ? colors.primaryContainer : colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.senderName, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: AppSpacing.xxs),
            Text(message.text),
          ],
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({required this.controller, required this.enabled, required this.onSend});

  final TextEditingController controller;
  final bool enabled;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                enabled: enabled,
                onSubmitted: enabled ? (_) => onSend() : null,
                decoration: InputDecoration(
                  hintText: enabled ? strings.typeMessage : strings.joinToSendMessages,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            IconButton.filled(
              tooltip: strings.send,
              onPressed: enabled ? onSend : null,
              icon: const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
