import 'package:bondhon/features/chats/data/conversation_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const repository = ConversationRepository();

  test('searches conversations by name and username', () {
    expect(repository.search('NADIA').single.id, 'nadia-rahman');
    expect(repository.search('rafi_h').single.id, 'rafi-hasan');
    expect(repository.search('unknown'), isEmpty);
  });

  test('finds conversations and returns independent message lists', () {
    expect(repository.findById('sadia-islam')?.unreadCount, 1);
    expect(repository.findById('missing'), isNull);

    final firstRead = repository.messagesFor('nadia-rahman');
    final secondRead = repository.messagesFor('nadia-rahman');
    firstRead.clear();

    expect(secondRead, isNotEmpty);
  });
}
