import 'package:bondhon/features/discover/domain/entities/discover_user.dart';
import 'package:flutter/material.dart';

class DiscoverRepository {
  const DiscoverRepository();

  static const users = <DiscoverUser>[
    DiscoverUser(
      id: 'ayesha-khan',
      displayName: 'Ayesha Khan',
      username: 'ayesha_k',
      location: 'Dhaka',
      bio: 'Book lover, learner, and community volunteer.',
      interests: ['Books', 'Volunteering', 'Travel'],
      isOnline: true,
      isNearby: true,
      mutualFriends: 4,
      avatarColor: Color(0xFF7B1FA2),
    ),
    DiscoverUser(
      id: 'tanvir-ahmed',
      displayName: 'Tanvir Ahmed',
      username: 'tanvir_a',
      location: 'Chattogram',
      bio: 'Technology enthusiast and casual photographer.',
      interests: ['Technology', 'Photography', 'Music'],
      isOnline: false,
      isNearby: false,
      mutualFriends: 2,
      avatarColor: Color(0xFF1565C0),
      friendshipStatus: FriendshipStatus.pending,
    ),
    DiscoverUser(
      id: 'maliha-sultana',
      displayName: 'Maliha Sultana',
      username: 'maliha_s',
      location: 'Dhaka',
      bio: 'Studying business and building meaningful connections.',
      interests: ['Business', 'Study', 'Travel'],
      isOnline: true,
      isNearby: true,
      mutualFriends: 7,
      avatarColor: Color(0xFFC62828),
      friendshipStatus: FriendshipStatus.friends,
    ),
    DiscoverUser(
      id: 'shafin-rahman',
      displayName: 'Shafin Rahman',
      username: 'shafin_r',
      location: 'Rajshahi',
      bio: 'Music, sports, and friendly conversations.',
      interests: ['Music', 'Sports', 'Movies'],
      isOnline: true,
      isNearby: false,
      mutualFriends: 1,
      avatarColor: Color(0xFF2E7D32),
    ),
    DiscoverUser(
      id: 'rafi-hasan',
      displayName: 'Rafi Hasan',
      username: 'rafi_h',
      location: 'Dhaka',
      bio: 'Student, reader, and active member of study communities.',
      interests: ['Study', 'Books', 'Technology'],
      isOnline: false,
      isNearby: true,
      mutualFriends: 5,
      avatarColor: Color(0xFF1565C0),
      friendshipStatus: FriendshipStatus.friends,
    ),
  ];

  List<DiscoverUser> search({
    String query = '',
    DiscoverFilter filter = DiscoverFilter.all,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    return users.where((user) {
      final matchesFilter = switch (filter) {
        DiscoverFilter.all => true,
        DiscoverFilter.online => user.isOnline,
        DiscoverFilter.nearby => user.isNearby,
        DiscoverFilter.commonInterests => user.interests.any(
            (interest) => const {'Travel', 'Music', 'Study'}.contains(interest),
          ),
      };
      final matchesQuery = normalizedQuery.isEmpty ||
          user.displayName.toLowerCase().contains(normalizedQuery) ||
          user.username.toLowerCase().contains(normalizedQuery) ||
          user.location.toLowerCase().contains(normalizedQuery) ||
          user.interests.any(
            (interest) => interest.toLowerCase().contains(normalizedQuery),
          );
      return matchesFilter && matchesQuery;
    }).toList(growable: false);
  }

  DiscoverUser? findById(String id) {
    for (final user in users) {
      if (user.id == id) return user;
    }
    return null;
  }
}
