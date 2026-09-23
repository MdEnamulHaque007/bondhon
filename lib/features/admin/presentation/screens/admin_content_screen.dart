import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/admin/data/admin_repository.dart';
import 'package:flutter/material.dart';

class AdminContentScreen extends StatelessWidget {
  const AdminContentScreen({super.key, this.repository});

  final AdminRepository? repository;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final repo = repository ?? adminRepository;
    return AnimatedBuilder(
      animation: repo,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: Text(strings.adminContent)),
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              for (final item in repo.content)
                Card(
                  child: ListTile(
                    leading: Icon(
                      item.removed
                          ? Icons.delete_outline
                          : Icons.flag_outlined,
                    ),
                    title: Text(item.title),
                    subtitle: Text(item.kind),
                    trailing: Wrap(
                      spacing: 4,
                      children: [
                        TextButton(
                          onPressed: () =>
                              repo.setContentRemoved(item.id, true),
                          child: Text(strings.adminRemove),
                        ),
                        TextButton(
                          onPressed: () =>
                              repo.setContentRemoved(item.id, false),
                          child: Text(strings.adminKeep),
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
}
