import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:flutter/material.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key, this.repository});

  final AdminRepository? repository;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final repo = repository ?? adminRepository;
    return AnimatedBuilder(
      animation: repo,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: Text(strings.adminReports)),
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              for (final report in repo.reports)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.flag_outlined),
                    title: Text(report.target),
                    subtitle: Text(report.kind),
                    trailing: report.status == AdminReportStatus.open
                        ? Wrap(
                            spacing: 4,
                            children: [
                              TextButton(
                                onPressed: () => repo.setReportStatus(
                                  report.id,
                                  AdminReportStatus.reviewed,
                                ),
                                child: Text(strings.adminMarkReviewed),
                              ),
                              TextButton(
                                onPressed: () => repo.setReportStatus(
                                  report.id,
                                  AdminReportStatus.dismissed,
                                ),
                                child: Text(strings.adminDismiss),
                              ),
                            ],
                          )
                        : Chip(
                            label: Text(_statusLabel(strings, report.status)),
                          ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _statusLabel(AppLocalizations strings, AdminReportStatus status) {
    switch (status) {
      case AdminReportStatus.open:
        return strings.adminOpen;
      case AdminReportStatus.reviewed:
        return strings.adminReviewed;
      case AdminReportStatus.dismissed:
        return strings.adminDismissed;
    }
  }
}
