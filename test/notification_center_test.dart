import 'package:bondhon/features/notifications/data/notification_storage.dart';
import 'package:bondhon/features/notifications/presentation/controllers/notification_center.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('persists notification read and delete actions', () async {
    SharedPreferences.setMockInitialValues({});
    final center = NotificationCenter(storage: NotificationStorage());

    await center.load();
    expect(center.notifications, hasLength(4));
    expect(center.unreadCount, 2);

    await center.markRead('friend-request-nusrat');
    expect(center.unreadCount, 1);

    await center.markAllRead();
    expect(center.unreadCount, 0);

    await center.delete('room-bondhutto');
    expect(center.notifications, hasLength(3));

    final reloaded = NotificationCenter(storage: NotificationStorage());
    await reloaded.load();
    expect(reloaded.notifications, hasLength(3));
    expect(reloaded.unreadCount, 0);
  });

  test('clears all notifications locally', () async {
    SharedPreferences.setMockInitialValues({});
    final center = NotificationCenter(storage: NotificationStorage());

    await center.load();
    await center.clear();

    expect(center.notifications, isEmpty);
    expect((await NotificationStorage().read()), isEmpty);
  });
}
