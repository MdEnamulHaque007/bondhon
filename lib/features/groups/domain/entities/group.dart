import 'package:flutter/material.dart';

enum GroupVisibility { public, private }

enum GroupRole { owner, admin, member }

class GroupMember {
  const GroupMember({
    required this.id,
    required this.name,
    required this.role,
    this.isGuest = false,
  });

  final String id;
  final String name;
  final GroupRole role;
  final bool isGuest;
}

class GroupMessage {
  const GroupMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.sentAt,
  });

  final String id;
  final String senderId;
  final String senderName;
  final String text;
  final DateTime sentAt;
}

class Group {
  const Group({
    required this.id,
    required this.name,
    required this.description,
    required this.visibility,
    required this.memberCount,
    required this.lastActivity,
    required this.members,
    required this.messages,
    required this.ownerId,
    this.adminOnlyMessaging = false,
    this.logoColor = Colors.teal,
  });

  final String id;
  final String name;
  final String description;
  final GroupVisibility visibility;
  final int memberCount;
  final String lastActivity;
  final List<GroupMember> members;
  final List<GroupMessage> messages;
  final String ownerId;
  final bool adminOnlyMessaging;
  final Color logoColor;

  Group copyWith({
    String? name,
    String? description,
    GroupVisibility? visibility,
    int? memberCount,
    String? lastActivity,
    List<GroupMember>? members,
    List<GroupMessage>? messages,
    bool? adminOnlyMessaging,
  }) {
    return Group(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      visibility: visibility ?? this.visibility,
      memberCount: memberCount ?? this.memberCount,
      lastActivity: lastActivity ?? this.lastActivity,
      members: members ?? this.members,
      messages: messages ?? this.messages,
      ownerId: ownerId,
      adminOnlyMessaging: adminOnlyMessaging ?? this.adminOnlyMessaging,
      logoColor: logoColor,
    );
  }
}
