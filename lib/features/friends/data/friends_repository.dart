import 'package:bondhon/features/friends/domain/entities/friend_connection.dart';
import 'package:flutter/material.dart';

class FriendsRepository {
  const FriendsRepository();

  List<FriendConnection> initialConnections() => const [
        FriendConnection(
          id: 'maliha-sultana',
          displayName: 'Maliha Sultana',
          username: 'maliha_s',
          location: 'Dhaka',
          isOnline: true,
          connectionType: FriendConnectionType.friend,
          avatarColor: Color(0xFFC62828),
          mutualFriends: 7,
        ),
        FriendConnection(
          id: 'rafi-hasan',
          displayName: 'Rafi Hasan',
          username: 'rafi_h',
          location: 'Dhaka',
          isOnline: false,
          connectionType: FriendConnectionType.friend,
          avatarColor: Color(0xFF1565C0),
          mutualFriends: 5,
        ),
        FriendConnection(
          id: 'nusrat-jahan',
          displayName: 'Nusrat Jahan',
          username: 'nusrat_j',
          location: 'Sylhet',
          isOnline: true,
          connectionType: FriendConnectionType.incoming,
          avatarColor: Color(0xFF6A1B9A),
          mutualFriends: 3,
        ),
        FriendConnection(
          id: 'fahim-chowdhury',
          displayName: 'Fahim Chowdhury',
          username: 'fahim_c',
          location: 'Cumilla',
          isOnline: false,
          connectionType: FriendConnectionType.incoming,
          avatarColor: Color(0xFF2E7D32),
          mutualFriends: 1,
        ),
        FriendConnection(
          id: 'tanvir-ahmed',
          displayName: 'Tanvir Ahmed',
          username: 'tanvir_a',
          location: 'Chattogram',
          isOnline: false,
          connectionType: FriendConnectionType.outgoing,
          avatarColor: Color(0xFF00838F),
          mutualFriends: 2,
        ),
      ];

  List<FriendConnection> search(
    List<FriendConnection> connections, {
    required FriendConnectionType type,
    String query = '',
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    return connections.where((connection) {
      final matchesType = connection.connectionType == type;
      final matchesQuery = normalizedQuery.isEmpty ||
          connection.displayName.toLowerCase().contains(normalizedQuery) ||
          connection.username.toLowerCase().contains(normalizedQuery) ||
          connection.location.toLowerCase().contains(normalizedQuery);
      return matchesType && matchesQuery;
    }).toList(growable: false);
  }
}
