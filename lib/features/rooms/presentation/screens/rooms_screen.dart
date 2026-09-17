import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_colors.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/rooms/data/room_repository.dart';
import 'package:bondhon/features/rooms/domain/entities/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key, this.repository = const RoomRepository()});

  final RoomRepository repository;

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  final _searchController = TextEditingController();
  RoomCategory _category = RoomCategory.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final rooms = widget.repository.search(
      query: _searchController.text,
      category: _category,
    );

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
                  Text(
                    strings.publicChatRooms,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    strings.publicChatRoomsDescription,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: strings.searchRooms,
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
                  const SizedBox(height: AppSpacing.md),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final category in RoomCategory.values) ...[
                          ChoiceChip(
                            label: Text(_categoryLabel(strings, category)),
                            selected: _category == category,
                            onSelected: (_) => setState(() => _category = category),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (rooms.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.search_off_rounded, size: 52),
                      const SizedBox(height: AppSpacing.sm),
                      Text(strings.noRoomsFound),
                    ],
                  ),
                ),
              ),
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
                itemCount: rooms.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 440,
                  mainAxisExtent: 228,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                ),
                itemBuilder: (context, index) => _RoomCard(room: rooms[index]),
              ),
            ),
        ],
      ),
    );
  }

  String _categoryLabel(AppLocalizations strings, RoomCategory category) {
    return switch (category) {
      RoomCategory.all => strings.all,
      RoomCategory.friendship => strings.friendship,
      RoomCategory.regional => strings.regional,
      RoomCategory.education => strings.education,
      RoomCategory.entertainment => strings.entertainment,
    };
  }
}

class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.room});

  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(AppRoutes.roomDetails(room.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.bondhonGreenSoft,
                    child: Icon(room.icon, color: AppColors.bondhonGreenDark),
                  ),
                  const Spacer(),
                  if (room.isLive)
                    Chip(
                      avatar: const Icon(
                        Icons.circle,
                        color: AppColors.bondhonRed,
                        size: 12,
                      ),
                      label: Text(strings.live),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(room.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.xs),
              Expanded(
                child: Text(
                  room.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.people_outline_rounded, size: 18),
                  const SizedBox(width: AppSpacing.xs),
                  Text(strings.memberCount(room.memberCount)),
                  const Spacer(),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.roomDetails(room.id)),
                    child: Text(strings.viewRoom),
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
