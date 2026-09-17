import 'package:bondhon/features/notifications/data/notification_storage.dart';
import 'package:bondhon/features/notifications/domain/entities/app_notification.dart';
import 'package:flutter/foundation.dart';

class NotificationCenter extends ChangeNotifier {
  NotificationCenter({NotificationStorage? storage})
      : _storage = storage ?? NotificationStorage();

  final NotificationStorage _storage;
  List<AppNotification> _notifications = [];
  bool _loading = false;
  bool _initialized = false;

  List<AppNotification> get notifications => List.unmodifiable(_notifications);
  bool get loading => _loading;
  int get unreadCount => _notifications.where((item) => !item.isRead).length;

  Future<void> load({bool force = false}) async {
    if (_loading || (_initialized && !force)) return;
    _loading = true;
    notifyListeners();
    _notifications = await _storage.read();
    _initialized = true;
    _loading = false;
    notifyListeners();
  }

  Future<void> markRead(String id) async {
    final index = _notifications.indexWhere((item) => item.id == id);
    if (index < 0 || _notifications[index].isRead) return;
    _notifications[index] = _notifications[index].copyWith(isRead: true);
    await _save();
  }

  Future<void> markAllRead() async {
    if (unreadCount == 0) return;
    _notifications = _notifications
        .map((item) => item.copyWith(isRead: true))
        .toList(growable: false);
    await _save();
  }

  Future<void> delete(String id) async {
    _notifications.removeWhere((item) => item.id == id);
    await _save();
  }

  Future<void> clear() async {
    _notifications.clear();
    await _save();
  }

  Future<void> _save() async {
    await _storage.write(_notifications);
    notifyListeners();
  }

  @visibleForTesting
  void reset() {
    _notifications = [];
    _loading = false;
    _initialized = false;
  }
}

final notificationCenter = NotificationCenter();
