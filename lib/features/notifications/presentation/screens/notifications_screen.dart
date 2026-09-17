import 'package:bondhon/app/theme/app_colors.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/notifications/domain/entities/app_notification.dart';
import 'package:bondhon/features/notifications/presentation/controllers/notification_center.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _unreadOnly = false;

  @override
  void initState() {
    super.initState();
    notificationCenter.load();
  }

  Future<void> _open(AppNotification notification) async {
    await notificationCenter.markRead(notification.id);
    if (mounted && notification.targetRoute.isNotEmpty) {
      context.go(notification.targetRoute);
    }
  }

  Future<void> _confirmClear(AppLocalizations strings) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(strings.clearNotifications),
            content: Text(strings.clearNotificationsConfirmation),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(strings.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(strings.clearAll),
              ),
            ],
          ),
        ) ??
        false;
    if (confirmed) await notificationCenter.clear();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: notificationCenter,
      builder: (context, _) {
        final notifications = notificationCenter.notifications
            .where((item) => !_unreadOnly || !item.isRead)
            .toList(growable: false);
        return SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
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
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                strings.notifications,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            TextButton(
                              onPressed: notificationCenter.unreadCount == 0
                                  ? null
                                  : notificationCenter.markAllRead,
                              child: Text(strings.markAllAsRead),
                            ),
                            IconButton(
                              tooltip: strings.clearAll,
                              onPressed: notificationCenter.notifications.isEmpty
                                  ? null
                                  : () => _confirmClear(strings),
                              icon: const Icon(Icons.delete_sweep_outlined),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            FilterChip(
                              label: Text(strings.all),
                              selected: !_unreadOnly,
                              onSelected: (_) => setState(() => _unreadOnly = false),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            FilterChip(
                              label: Text(
                                '${strings.unread} (${notificationCenter.unreadCount})',
                              ),
                              selected: _unreadOnly,
                              onSelected: (_) => setState(() => _unreadOnly = true),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: notificationCenter.loading
                        ? const Center(child: CircularProgressIndicator())
                        : notifications.isEmpty
                            ? Center(
                                child: Text(
                                  _unreadOnly
                                      ? strings.noUnreadNotifications
                                      : strings.noNotifications,
                                ),
                              )
                            : ListView.separated(
                                padding: const EdgeInsets.fromLTRB(
                                  AppSpacing.lg,
                                  AppSpacing.sm,
                                  AppSpacing.lg,
                                  AppSpacing.lg,
                                ),
                                itemCount: notifications.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: AppSpacing.xs),
                                itemBuilder: (context, index) {
                                  final notification = notifications[index];
                                  return _NotificationTile(
                                    notification: notification,
                                    onOpen: () => _open(notification),
                                    onDelete: () =>
                                        notificationCenter.delete(notification.id),
                                  );
                                },
                              ),
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

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.onOpen,
    required this.onDelete,
  });

  final AppNotification notification;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      color: notification.isRead ? null : AppColors.bondhonGreenSoft,
      child: ListTile(
        onTap: onOpen,
        leading: CircleAvatar(
          child: Icon(_iconFor(notification.type)),
        ),
        title: Text(
          notification.title(strings.isBangla),
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w700,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xxs),
            Text(notification.body(strings.isBangla)),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              notification.timeLabel(strings.isBangla),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        trailing: IconButton(
          tooltip: strings.deleteNotification,
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline_rounded),
        ),
      ),
    );
  }

  IconData _iconFor(AppNotificationType type) => switch (type) {
        AppNotificationType.friendRequest => Icons.person_add_alt_1_rounded,
        AppNotificationType.friendAccepted => Icons.people_rounded,
        AppNotificationType.message => Icons.chat_bubble_rounded,
        AppNotificationType.roomActivity => Icons.forum_rounded,
      };
}
