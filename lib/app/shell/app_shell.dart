import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/shared/widgets/language_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.location,
    required this.child,
    super.key,
  });

  final String location;
  final Widget child;

  static const _paths = [
    AppRoutes.home,
    AppRoutes.chats,
    AppRoutes.rooms,
    AppRoutes.discover,
    AppRoutes.profile,
  ];

  int get _selectedIndex {
    final index = _paths.indexWhere((path) => location.startsWith(path));
    return index < 0 ? 0 : index;
  }

  void _goTo(BuildContext context, int index) {
    context.go(_paths[index]);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final destinations = [
      (icon: Icons.home_outlined, selectedIcon: Icons.home_rounded, label: strings.home),
      (icon: Icons.chat_bubble_outline_rounded, selectedIcon: Icons.chat_bubble_rounded, label: strings.chats),
      (icon: Icons.forum_outlined, selectedIcon: Icons.forum_rounded, label: strings.rooms),
      (icon: Icons.explore_outlined, selectedIcon: Icons.explore_rounded, label: strings.discover),
      (icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded, label: strings.profile),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 760;
        final appBar = AppBar(
          title: const Text('Bondhon'),
          actions: [
            LanguageSelector(compact: constraints.maxWidth < 520),
            IconButton(
              tooltip: strings.back,
              onPressed: () => context.go(AppRoutes.welcome),
              icon: const Icon(Icons.logout_rounded),
            ),
          ],
        );

        if (!useRail) {
          return Scaffold(
            appBar: appBar,
            body: child,
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) => _goTo(context, index),
              destinations: [
                for (final destination in destinations)
                  NavigationDestination(
                    icon: Icon(destination.icon),
                    selectedIcon: Icon(destination.selectedIcon),
                    label: destination.label,
                  ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: appBar,
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) => _goTo(context, index),
                labelType: NavigationRailLabelType.all,
                destinations: [
                  for (final destination in destinations)
                    NavigationRailDestination(
                      icon: Icon(destination.icon),
                      selectedIcon: Icon(destination.selectedIcon),
                      label: Text(destination.label),
                    ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
