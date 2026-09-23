import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/app/shell/app_shell.dart';
import 'package:bondhon/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:bondhon/features/auth/presentation/screens/login_screen.dart';
import 'package:bondhon/features/auth/presentation/screens/register_screen.dart';
import 'package:bondhon/features/chats/presentation/screens/chats_screen.dart';
import 'package:bondhon/features/chats/presentation/screens/direct_chat_screen.dart';
import 'package:bondhon/features/discover/presentation/screens/discover_profile_screen.dart';
import 'package:bondhon/features/discover/presentation/screens/discover_screen.dart';
import 'package:bondhon/features/friends/presentation/screens/friends_screen.dart';
import 'package:bondhon/features/feed/presentation/screens/feed_screen.dart';
import 'package:bondhon/features/groups/presentation/screens/group_details_screen.dart';
import 'package:bondhon/features/groups/presentation/screens/groups_screen.dart';
import 'package:bondhon/features/home/presentation/screens/home_screen.dart';
import 'package:bondhon/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:bondhon/features/profile/presentation/screens/profile_screen.dart';
import 'package:bondhon/features/rooms/presentation/screens/room_details_screen.dart';
import 'package:bondhon/features/rooms/presentation/screens/rooms_screen.dart';
import 'package:bondhon/features/safety/presentation/screens/blocked_users_screen.dart';
import 'package:bondhon/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const welcome = '/';
  static const home = '/home';
  static const feed = '/feed';
  static const chats = '/chats';
  static const chat = '/chats/:conversationId';
  static const rooms = '/rooms';
  static const room = '/rooms/:roomId';
  static const groups = '/groups';
  static const group = '/groups/:groupId';
  static const discover = '/discover';
  static const discoverUser = '/discover/:userId';
  static const friends = '/discover/friends';
  static const profile = '/profile';
  static const blockedUsers = '/profile/blocked-users';
  static const notifications = '/notifications';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';

  static String roomDetails(String roomId) => '/rooms/$roomId';
  static String groupDetails(String groupId) => '/groups/$groupId';
  static String chatDetails(String conversationId) => '/chats/$conversationId';
  static String discoverProfile(String userId) => '/discover/$userId';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => AppShell(
        location: state.uri.path,
        child: child,
      ),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.feed,
          name: 'feed',
          builder: (context, state) => const FeedScreen(),
        ),
        GoRoute(
          path: AppRoutes.notifications,
          name: 'notifications',
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: AppRoutes.chats,
          name: 'chats',
          builder: (context, state) => const ChatsScreen(),
          routes: [
            GoRoute(
              path: ':conversationId',
              name: 'chat-details',
              builder: (context, state) => DirectChatScreen(
                conversationId: state.pathParameters['conversationId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.rooms,
          name: 'rooms',
          builder: (context, state) => const RoomsScreen(),
          routes: [
            GoRoute(
              path: ':roomId',
              name: 'room-details',
              builder: (context, state) => RoomDetailsScreen(
                roomId: state.pathParameters['roomId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.groups,
          name: 'groups',
          builder: (context, state) => const GroupsScreen(),
          routes: [
            GoRoute(
              path: ':groupId',
              name: 'group-details',
              builder: (context, state) => GroupDetailsScreen(
                groupId: state.pathParameters['groupId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.discover,
          name: 'discover',
          builder: (context, state) => const DiscoverScreen(),
          routes: [
            GoRoute(
              path: 'friends',
              name: 'friends',
              builder: (context, state) => const FriendsScreen(),
            ),
            GoRoute(
              path: ':userId',
              name: 'discover-profile',
              builder: (context, state) => DiscoverProfileScreen(
                userId: state.pathParameters['userId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.profile,
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
          routes: [
            GoRoute(
              path: 'blocked-users',
              name: 'blocked-users',
              builder: (context, state) => const BlockedUsersScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Bondhon')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          AppLocalizations.of(context).pageNotFound,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ),
);
