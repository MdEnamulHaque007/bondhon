import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_colors.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/rooms/data/room_repository.dart';
import 'package:bondhon/features/rooms/domain/entities/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomDetailsScreen extends StatefulWidget {
  const RoomDetailsScreen({
    required this.roomId,
    super.key,
    this.repository = const RoomRepository(),
  });

  final String roomId;
  final RoomRepository repository;

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  final _messageController = TextEditingController();
  final _messages = <RoomMessage>[...RoomRepository.previewMessages];
  bool _joined = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    final now = TimeOfDay.now();
    setState(() {
      _messages.add(
        RoomMessage(
          sender: 'Guest User',
          message: text,
          time: now.format(context),
          isCurrentUser: true,
        ),
      );
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final room = widget.repository.findById(widget.roomId);
    if (room == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(strings.roomNotFound),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(
              onPressed: () => context.go(AppRoutes.rooms),
              child: Text(strings.backToRooms),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          _RoomHeader(
            room: room,
            joined: _joined,
            onBack: () => context.go(AppRoutes.rooms),
            onJoin: () => setState(() => _joined = true),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: _messages.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) => _MessageBubble(message: _messages[index]),
            ),
          ),
          if (_joined)
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        onSubmitted: (_) => _sendMessage(),
                        decoration: InputDecoration(
                          hintText: strings.typeMessage,
                          prefixIcon: const Icon(Icons.message_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    IconButton.filled(
                      tooltip: strings.send,
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(strings.joinToSendMessages),
            ),
        ],
      ),
    );
  }
}

class _RoomHeader extends StatelessWidget {
  const _RoomHeader({
    required this.room,
    required this.joined,
    required this.onBack,
    required this.onJoin,
  });

  final ChatRoom room;
  final bool joined;
  final VoidCallback onBack;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Material(
      color: AppColors.bondhonGreenSoft,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            IconButton(
              tooltip: strings.backToRooms,
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            CircleAvatar(child: Icon(room.icon)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(room.name, style: Theme.of(context).textTheme.titleLarge),
                  Text(strings.memberCount(room.memberCount)),
                ],
              ),
            ),
            if (joined)
              Chip(
                avatar: const Icon(Icons.check_circle_outline_rounded, size: 18),
                label: Text(strings.joined),
              )
            else
              FilledButton.icon(
                onPressed: onJoin,
                icon: const Icon(Icons.login_rounded),
                label: Text(strings.joinAsGuest),
              ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final RoomMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Card(
          color: message.isCurrentUser ? AppColors.bondhonGreenSoft : null,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message.sender, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: AppSpacing.xxs),
                Text(message.message),
                const SizedBox(height: AppSpacing.xxs),
                Text(message.time, style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
