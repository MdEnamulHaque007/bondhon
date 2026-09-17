import 'package:flutter/material.dart';

enum DiscoverFilter { all, online, nearby, commonInterests }

enum FriendshipStatus { none, pending, friends }

class DiscoverUser {
  const DiscoverUser({
    required this.id,
    required this.displayName,
    required this.username,
    required this.location,
    required this.bio,
    required this.interests,
    required this.isOnline,
    required this.isNearby,
    required this.mutualFriends,
    required this.avatarColor,
    this.friendshipStatus = FriendshipStatus.none,
  });

  final String id;
  final String displayName;
  final String username;
  final String location;
  final String bio;
  final List<String> interests;
  final bool isOnline;
  final bool isNearby;
  final int mutualFriends;
  final Color avatarColor;
  final FriendshipStatus friendshipStatus;

  String get initials {
    final words = displayName.trim().split(RegExp(r'\s+'));
    return words.take(2).map((word) => word[0]).join().toUpperCase();
  }
}
