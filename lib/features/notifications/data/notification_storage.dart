import 'dart:convert';

import 'package:bondhon/features/notifications/domain/entities/app_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationStorage {
  NotificationStorage({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  static const notificationsKey = 'bondhon_notifications';
  final SharedPreferencesAsync _preferences;

  Future<List<AppNotification>> read() async {
    final encoded = await _preferences.getString(notificationsKey);
    if (encoded == null) {
      final seeded = _seedNotifications();
      await write(seeded);
      return seeded;
    }
    try {
      final decoded = jsonDecode(encoded);
      if (decoded is! List) return [];
      return decoded
          .whereType<Map>()
          .map((item) => AppNotification.fromJson(
                item.map((key, value) => MapEntry(key.toString(), value)),
              ))
          .toList(growable: false);
    } on Object {
      return [];
    }
  }

  Future<void> write(List<AppNotification> notifications) async {
    await _preferences.setString(
      notificationsKey,
      jsonEncode(notifications.map((item) => item.toJson()).toList()),
    );
  }

  List<AppNotification> _seedNotifications() => [
        AppNotification(
          id: 'friend-request-nusrat',
          type: AppNotificationType.friendRequest,
          titleEn: 'New friend request',
          titleBn: 'নতুন বন্ধুত্বের অনুরোধ',
          bodyEn: 'Nusrat Jahan sent you a friend request.',
          bodyBn: 'নুসরাত জাহান আপনাকে বন্ধুত্বের অনুরোধ পাঠিয়েছেন।',
          timeEn: '5 minutes ago',
          timeBn: '৫ মিনিট আগে',
          targetRoute: '/discover/friends',
          createdAt: DateTime.utc(2026, 9, 17, 10, 30),
        ),
        AppNotification(
          id: 'message-nadia',
          type: AppNotificationType.message,
          titleEn: 'New message from Nadia',
          titleBn: 'নাদিয়ার নতুন মেসেজ',
          bodyEn: 'Nadia: Are you joining the room tonight?',
          bodyBn: 'নাদিয়া: আজ রাতে রুমে যোগ দিচ্ছেন?',
          timeEn: '20 minutes ago',
          timeBn: '২০ মিনিট আগে',
          targetRoute: '/chats/nadia-rahman',
          createdAt: DateTime.utc(2026, 9, 17, 10, 15),
        ),
        AppNotification(
          id: 'friend-accepted-maliha',
          type: AppNotificationType.friendAccepted,
          titleEn: 'Friend request accepted',
          titleBn: 'বন্ধুত্বের অনুরোধ গ্রহণ হয়েছে',
          bodyEn: 'Maliha Sultana accepted your friend request.',
          bodyBn: 'মালিহা সুলতানা আপনার বন্ধুত্বের অনুরোধ গ্রহণ করেছেন।',
          timeEn: '2 hours ago',
          timeBn: '২ ঘণ্টা আগে',
          targetRoute: '/discover/friends',
          createdAt: DateTime.utc(2026, 9, 17, 8, 35),
          isRead: true,
        ),
        AppNotification(
          id: 'room-bondhutto',
          type: AppNotificationType.roomActivity,
          titleEn: 'Bondhutto Corner is active',
          titleBn: 'বন্ধুত্ব কর্নার এখন সক্রিয়',
          bodyEn: '12 people are talking in Bondhutto Corner.',
          bodyBn: 'বন্ধুত্ব কর্নারে ১২ জন এখন কথা বলছেন।',
          timeEn: 'Yesterday',
          timeBn: 'গতকাল',
          targetRoute: '/rooms/bondhutto-corner',
          createdAt: DateTime.utc(2026, 9, 16, 18),
          isRead: true,
        ),
      ];
}
