import 'package:flutter/material.dart';

class Conversation {
  const Conversation({
    required this.id,
    required this.displayName,
    required this.username,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
    required this.avatarColor,
  });

  final String id;
  final String displayName;
  final String username;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;
  final bool isOnline;
  final Color avatarColor;

  String get initials {
    final words = displayName.trim().split(RegExp(r'\s+'));
    return words.take(2).map((word) => word[0]).join().toUpperCase();
  }
}

class DirectMessage {
  const DirectMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.time,
    required this.isCurrentUser,
    this.isRead = true,
  });

  final String id;
  final String senderId;
  final String text;
  final String time;
  final bool isCurrentUser;
  final bool isRead;
}
