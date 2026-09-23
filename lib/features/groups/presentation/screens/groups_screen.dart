import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/groups/data/group_repository.dart';
import 'package:bondhon/features/groups/domain/entities/group.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key, this.repository = groupRepository});

  final GroupRepository repository;

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.repository.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.repository.removeListener(_refresh);
    _searchController.dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final groups = widget.repository.search(_searchController.text);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          strings.groups,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () => _showCreateGroup(context),
                        icon: const Icon(Icons.add_rounded),
                        label: Text(strings.createGroup),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    strings.groupsDescription,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: strings.searchGroups,
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: strings.clearSearch,
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              icon: const Icon(Icons.close_rounded),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (groups.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text(strings.noGroupsFound)),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              sliver: SliverGrid.builder(
                itemCount: groups.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 480,
                  mainAxisExtent: 238,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                ),
                itemBuilder: (context, index) => _GroupCard(group: groups[index]),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showCreateGroup(BuildContext context) async {
    final strings = AppLocalizations.of(context);
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    var visibility = GroupVisibility.public;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(strings.createGroup, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => setModalState(() {}),
                      decoration: InputDecoration(labelText: strings.groupName),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(labelText: strings.groupDescription),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: visibility == GroupVisibility.public,
                      onChanged: (value) => setModalState(
                        () => visibility = value
                            ? GroupVisibility.public
                            : GroupVisibility.private,
                      ),
                      title: Text(strings.publicGroup),
                      subtitle: Text(
                        visibility == GroupVisibility.public
                            ? strings.publicGroupInfo
                            : strings.privateGroupInfo,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: nameController.text.trim().isEmpty
                            ? null
                            : () {
                                final group = widget.repository.createGroup(
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  visibility: visibility,
                                );
                                Navigator.of(sheetContext).pop();
                                context.go(AppRoutes.groupDetails(group.id));
                              },
                        child: Text(strings.createGroup),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    nameController.dispose();
    descriptionController.dispose();
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(AppRoutes.groupDetails(group.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: group.logoColor,
                    child: Text(
                      group.name.isEmpty ? '?' : group.name[0].toUpperCase(),
                      style: TextStyle(color: colors.onPrimary, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      group.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Icon(
                    group.visibility == GroupVisibility.public
                        ? Icons.public_rounded
                        : Icons.lock_outline_rounded,
                    color: colors.primary,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: Text(
                  group.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.people_outline_rounded, size: 18, color: colors.onSurfaceVariant),
                  const SizedBox(width: AppSpacing.xs),
                  Text(strings.memberCount(group.memberCount)),
                  const Spacer(),
                  Text(
                    group.lastActivity,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
