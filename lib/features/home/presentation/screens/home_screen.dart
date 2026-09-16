import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/features/auth/presentation/controllers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final items = <({IconData icon, String title, String subtitle})>[
      (
        icon: Icons.chat_bubble_outline_rounded,
        title: 'চ্যাট',
        subtitle: 'শিগগিরই আসছে',
      ),
      (
        icon: Icons.groups_outlined,
        title: 'গ্রুপ',
        subtitle: 'শিগগিরই আসছে',
      ),
      (
        icon: Icons.forum_outlined,
        title: 'চ্যাট রুম',
        subtitle: 'শিগগিরই আসছে',
      ),
      (
        icon: Icons.person_outline_rounded,
        title: 'প্রোফাইল',
        subtitle: 'শিগগিরই আসছে',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bondhon'),
        actions: [
          IconButton(
            tooltip: 'Welcome screen',
            onPressed: () => context.go(AppRoutes.welcome),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              'স্বাগতম, ${user.displayName}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'বর্তমানে Guest Mode চালু আছে—কোনো লগইন প্রয়োজন নেই।',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: AppSpacing.xl),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 900
                    ? 4
                    : constraints.maxWidth >= 560
                        ? 2
                        : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    childAspectRatio: columns == 1 ? 1.7 : 1.4,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, size: 34),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              item.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(item.subtitle),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
