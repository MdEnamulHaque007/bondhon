import 'package:flutter/material.dart';

enum RoomCategory { all, friendship, regional, education, entertainment }

class ChatRoom {
  const ChatRoom({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.memberCount,
    required this.isLive,
    required this.icon,
  });

  final String id;
  final String name;
  final String description;
  final RoomCategory category;
  final int memberCount;
  final bool isLive;
  final IconData icon;
}

class RoomMessage {
  const RoomMessage({
    required this.sender,
    required this.message,
    required this.time,
    this.isCurrentUser = false,
  });

  final String sender;
  final String message;
  final String time;
  final bool isCurrentUser;
}
