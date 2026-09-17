import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_colors.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/chats/data/conversation_repository.dart';
import 'package:bondhon/features/chats/domain/entities/conversation.dart';
import 'package:bondhon/features/safety/domain/entities/safety_report.dart';
import 'package:bondhon/features/safety/presentation/widgets/safety_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DirectChatScreen extends StatefulWidget {
  const DirectChatScreen({
    required this.conversationId,
    super.key,
    this.repository = const ConversationRepository(),
  });

  final String conversationId;
  final ConversationRepository repository;

  @override
  State<DirectChatScreen> createState() => _DirectChatScreenState();
}

class _DirectChatScreenState extends State<DirectChatScreen> {
  final _messageController = TextEditingController();
  late final List<DirectMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = widget.repository.messagesFor(widget.conversationId);
  }

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
        DirectMessage(
          id: 'local-${DateTime.now().microsecondsSinceEpoch}',
          senderId: 'guest',
          text: text,
          time: now.format(context),
          isCurrentUser: true,
          isRead: false,
        ),
      );
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final conversation = widget.repository.findById(widget.conversationId);
    if (conversation == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(strings.conversationNotFound),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(
              onPressed: () => context.go(AppRoutes.chats),
              child: Text(strings.backToChats),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          _ChatHeader(
            conversation: conversation,
            onBack: () => context.go(AppRoutes.chats),
          ),
          Expanded(
            child: _messages.isEmpty
                ? Center(child: Text(strings.startConversation))
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: _messages.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) => _DirectMessageBubble(
                      message: _messages[index],
                      onReport: () {
                        showReportDialog(
                          context: context,
                          targetType: ReportTargetType.message,
                          targetId: _messages[index].id,
                        );
                      },
                    ),
                  ),
          ),
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
                      decoration: InputDecoration(hintText: strings.typeMessage),
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
          ),
        ],
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.conversation, required this.onBack});

  final Conversation conversation;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Material(
      color: AppColors.bondhonGreenSoft,
      child: ListTile(
        leading: IconButton(
          tooltip: strings.backToChats,
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(conversation.displayName),
        subtitle: Text(conversation.isOnline ? strings.online : strings.offline),
        trailing: IconButton(
          tooltip: strings.conversationInfo,
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(strings.profileComingSoon)),
          ),
          icon: const Icon(Icons.info_outline_rounded),
        ),
      ),
    );
  }
}

class _DirectMessageBubble extends StatelessWidget {
  const _DirectMessageBubble({required this.message, required this.onReport});

  final DirectMessage message;
  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Align(
      alignment: message.isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: message.isCurrentUser
                ? AppColors.bondhonGreenSoft
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(alignment: Alignment.centerLeft, child: Text(message.text)),
                const SizedBox(height: AppSpacing.xxs),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message.time, style: Theme.of(context).textTheme.labelSmall),
                    if (message.isCurrentUser) ...[
                      const SizedBox(width: AppSpacing.xxs),
                      Icon(
                        message.isRead ? Icons.done_all_rounded : Icons.done_rounded,
                        size: 16,
                        semanticLabel: message.isRead ? strings.read : strings.sent,
                      ),
                    ] else ...[
                      const SizedBox(width: AppSpacing.xs),
                      InkWell(
                        onTap: onReport,
                        child: Icon(
                          Icons.flag_outlined,
                          size: 17,
                          semanticLabel: strings.reportMessage,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
