import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/safety/data/safety_storage.dart';
import 'package:bondhon/features/safety/domain/entities/safety_report.dart';
import 'package:flutter/material.dart';

Future<bool> showReportDialog({
  required BuildContext context,
  required ReportTargetType targetType,
  required String targetId,
  SafetyStorage? storage,
}) async {
  final strings = AppLocalizations.of(context);
  final reason = await showDialog<ReportReason>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(
        targetType == ReportTargetType.user
            ? strings.reportUser
            : strings.reportMessage,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.selectReportReason),
            const SizedBox(height: 12),
            for (final reason in ReportReason.values)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(_reasonLabel(strings, reason)),
                onTap: () => Navigator.of(dialogContext).pop(reason),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(strings.cancel),
        ),
      ],
    ),
  );
  if (reason == null || !context.mounted) return false;

  final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(strings.submitReport),
          content: Text(strings.reportConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(strings.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(strings.submit),
            ),
          ],
        ),
      ) ??
      false;
  if (!confirmed) return false;

  await (storage ?? SafetyStorage()).saveReport(
    SafetyReport(
      id: 'report-${DateTime.now().microsecondsSinceEpoch}',
      targetType: targetType,
      targetId: targetId,
      reason: reason,
      createdAt: DateTime.now(),
    ),
  );
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(strings.reportSubmitted)),
    );
  }
  return true;
}

Future<bool> confirmBlockUser({
  required BuildContext context,
  required String displayName,
}) async {
  final strings = AppLocalizations.of(context);
  return await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(strings.blockUser),
          content: Text(strings.blockUserConfirmation(displayName)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(strings.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(strings.block),
            ),
          ],
        ),
      ) ??
      false;
}

String _reasonLabel(AppLocalizations strings, ReportReason reason) {
  return switch (reason) {
    ReportReason.harassment => strings.harassment,
    ReportReason.spam => strings.spam,
    ReportReason.hateSpeech => strings.hateSpeech,
    ReportReason.inappropriateContent => strings.inappropriateContent,
    ReportReason.other => strings.other,
  };
}
