import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:bondhon/features/admin/presentation/widgets/admin_demo_banner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key, this.repository});

  final AdminRepository? repository;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final repo = repository ?? adminRepository;
    return AnimatedBuilder(
      animation: repo,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: Text(strings.adminDashboard)),
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const AdminDemoBanner(),
              const SizedBox(height: AppSpacing.md),
              Text(
                strings.adminLastUpdated,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.md),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 760 ? 5 : 2;
                  final width =
                      (constraints.maxWidth - (columns - 1) * AppSpacing.md) /
                          columns;
                  return Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: [
                      _KpiCard(strings.totalUsers, repo.totalUsers, width),
                      _KpiCard(
                        strings.dailyActiveUsers,
                        repo.dailyActiveUsers,
                        width,
                      ),
                      _KpiCard(strings.messagesSent, repo.messagesSent, width),
                      _KpiCard(strings.activeRooms, repo.activeRooms, width),
                      _KpiCard(strings.openReports, repo.openReports, width),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.people_outline_rounded),
                      title: Text(strings.adminUsers),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => context.go(AppRoutes.adminUsers),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.flag_outlined),
                      title: Text(strings.adminReports),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => context.go(AppRoutes.adminReports),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.gavel_outlined),
                      title: Text(strings.adminContent),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => context.go(AppRoutes.adminContent),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard(this.label, this.value, this.width);

  final String label;
  final int value;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              const SizedBox(height: 8),
              Text(
                '$value',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
