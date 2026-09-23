import 'package:bondhon/features/groups/data/group_repository.dart';
import 'package:bondhon/features/groups/domain/entities/group.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GroupRepository', () {
    test('creates a guest-owned local group', () {
      final repository = GroupRepository();

      final group = repository.createGroup(
        name: 'My Group',
        description: 'A local group',
        visibility: GroupVisibility.private,
      );

      expect(group.name, 'My Group');
      expect(group.visibility, GroupVisibility.private);
      expect(group.memberCount, 1);
      expect(repository.findById(group.id), isNotNull);
      expect(repository.isMember(group.id), isTrue);
    });

    test('guest can join and leave a non-owned group', () {
      final repository = GroupRepository();

      expect(repository.isMember('bangla-tech'), isFalse);
      repository.join('bangla-tech');
      expect(repository.isMember('bangla-tech'), isTrue);
      expect(repository.findById('bangla-tech')!.memberCount, 1285);

      repository.leave('bangla-tech');
      expect(repository.isMember('bangla-tech'), isFalse);
      expect(repository.findById('bangla-tech')!.memberCount, 1284);
    });

    test('guest can send a message after joining', () {
      final repository = GroupRepository();
      repository.join('dhaka-foodies');
      repository.sendMessage('dhaka-foodies', 'Hello everyone');

      expect(
        repository.findById('dhaka-foodies')!.messages.last.text,
        'Hello everyone',
      );
    });

    test('admin-only group blocks guest member messages', () {
      final repository = GroupRepository();
      repository.join('bondhon-team');
      final before = repository.findById('bondhon-team')!.messages.length;

      repository.sendMessage('bondhon-team', 'Guest message');

      expect(repository.findById('bondhon-team')!.messages.length, before);
    });
  });
}
