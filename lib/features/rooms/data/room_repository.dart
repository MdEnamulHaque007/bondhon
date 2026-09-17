import 'package:bondhon/features/rooms/domain/entities/chat_room.dart';
import 'package:flutter/material.dart';

class RoomRepository {
  const RoomRepository();

  static const rooms = <ChatRoom>[
    ChatRoom(
      id: 'bondhutto-corner',
      name: 'Bondhutto Corner',
      description: 'Meet new people and start friendly conversations.',
      category: RoomCategory.friendship,
      memberCount: 128,
      isLive: true,
      icon: Icons.people_alt_outlined,
    ),
    ChatRoom(
      id: 'dhaka-community',
      name: 'Dhaka Community',
      description: 'Local conversations, events, and helpful city updates.',
      category: RoomCategory.regional,
      memberCount: 94,
      isLive: true,
      icon: Icons.location_city_outlined,
    ),
    ChatRoom(
      id: 'study-together',
      name: 'Study Together',
      description: 'Share study tips, skills, and learning resources.',
      category: RoomCategory.education,
      memberCount: 76,
      isLive: false,
      icon: Icons.school_outlined,
    ),
    ChatRoom(
      id: 'music-movies',
      name: 'Music & Movies',
      description: 'Talk about Bangla music, cinema, and entertainment.',
      category: RoomCategory.entertainment,
      memberCount: 63,
      isLive: true,
      icon: Icons.movie_filter_outlined,
    ),
  ];

  static const previewMessages = <RoomMessage>[
    RoomMessage(
      sender: 'Nadia',
      message: 'Welcome to the room! Please keep the conversation respectful.',
      time: '10:24',
    ),
    RoomMessage(
      sender: 'Rafi',
      message: 'Hello everyone! Nice to meet you.',
      time: '10:26',
    ),
  ];

  List<ChatRoom> search({
    String query = '',
    RoomCategory category = RoomCategory.all,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    return rooms.where((room) {
      final matchesCategory =
          category == RoomCategory.all || room.category == category;
      final matchesQuery = normalizedQuery.isEmpty ||
          room.name.toLowerCase().contains(normalizedQuery) ||
          room.description.toLowerCase().contains(normalizedQuery);
      return matchesCategory && matchesQuery;
    }).toList(growable: false);
  }

  ChatRoom? findById(String id) {
    for (final room in rooms) {
      if (room.id == id) return room;
    }
    return null;
  }
}
