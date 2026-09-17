import 'package:bondhon/features/chats/domain/entities/conversation.dart';
import 'package:flutter/material.dart';

class ConversationRepository {
  const ConversationRepository();

  static const conversations = <Conversation>[
    Conversation(
      id: 'nadia-rahman',
      displayName: 'Nadia Rahman',
      username: 'nadia',
      lastMessage: 'Welcome to Bondhon! How are you?',
      lastMessageTime: '10:42',
      unreadCount: 2,
      isOnline: true,
      avatarColor: Color(0xFF006A4E),
    ),
    Conversation(
      id: 'rafi-hasan',
      displayName: 'Rafi Hasan',
      username: 'rafi_h',
      lastMessage: 'See you in the Study Together room.',
      lastMessageTime: '09:18',
      unreadCount: 0,
      isOnline: false,
      avatarColor: Color(0xFF1565C0),
    ),
    Conversation(
      id: 'sadia-islam',
      displayName: 'Sadia Islam',
      username: 'sadia_i',
      lastMessage: 'Thanks for sharing the information.',
      lastMessageTime: 'Yesterday',
      unreadCount: 1,
      isOnline: true,
      avatarColor: Color(0xFF8E24AA),
    ),
  ];

  static const messages = <String, List<DirectMessage>>{
    'nadia-rahman': [
      DirectMessage(
        id: 'n1',
        senderId: 'nadia-rahman',
        text: 'Hi! I found you through Bondhutto Corner.',
        time: '10:40',
        isCurrentUser: false,
      ),
      DirectMessage(
        id: 'n2',
        senderId: 'nadia-rahman',
        text: 'Welcome to Bondhon! How are you?',
        time: '10:42',
        isCurrentUser: false,
      ),
    ],
    'rafi-hasan': [
      DirectMessage(
        id: 'r1',
        senderId: 'guest',
        text: 'That study room looks useful.',
        time: '09:15',
        isCurrentUser: true,
      ),
      DirectMessage(
        id: 'r2',
        senderId: 'rafi-hasan',
        text: 'See you in the Study Together room.',
        time: '09:18',
        isCurrentUser: false,
      ),
    ],
    'sadia-islam': [
      DirectMessage(
        id: 's1',
        senderId: 'sadia-islam',
        text: 'Thanks for sharing the information.',
        time: 'Yesterday',
        isCurrentUser: false,
      ),
    ],
  };

  List<Conversation> search(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return conversations;
    return conversations.where((conversation) {
      return conversation.displayName.toLowerCase().contains(normalizedQuery) ||
          conversation.username.toLowerCase().contains(normalizedQuery) ||
          conversation.lastMessage.toLowerCase().contains(normalizedQuery);
    }).toList(growable: false);
  }

  Conversation? findById(String id) {
    for (final conversation in conversations) {
      if (conversation.id == id) return conversation;
    }
    return null;
  }

  List<DirectMessage> messagesFor(String conversationId) {
    return List<DirectMessage>.of(messages[conversationId] ?? const []);
  }
}
