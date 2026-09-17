import 'package:flutter/material.dart';

enum FriendConnectionType { friend, incoming, outgoing }

class FriendConnection {
  const FriendConnection({
    required this.id,
    required this.displayName,
    required this.username,
    required this.location,
    required this.isOnline,
    required this.connectionType,
    required this.avatarColor,
    this.mutualFriends = 0,
  });

  final String id;
  final String displayName;
  final String username;
  final String location;
  final bool isOnline;
  final FriendConnectionType connectionType;
  final Color avatarColor;
  final int mutualFriends;

  String get initials {
    final words = displayName.trim().split(RegExp(r'\s+'));
    return words.take(2).map((word) => word[0]).join().toUpperCase();
  }

  FriendConnection copyWith({FriendConnectionType? connectionType}) {
    return FriendConnection(
      id: id,
      displayName: displayName,
      username: username,
      location: location,
      isOnline: isOnline,
      connectionType: connectionType ?? this.connectionType,
      avatarColor: avatarColor,
      mutualFriends: mutualFriends,
    );
  }
}
