import 'package:bondhon/features/friends/data/friends_repository.dart';
import 'package:bondhon/features/friends/domain/entities/friend_connection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const repository = FriendsRepository();

  test('filters connections by relationship type', () {
    final connections = repository.initialConnections();

    expect(
      repository.search(
        connections,
        type: FriendConnectionType.friend,
      ),
      hasLength(2),
    );
    expect(
      repository.search(
        connections,
        type: FriendConnectionType.incoming,
      ),
      hasLength(2),
    );
    expect(
      repository.search(
        connections,
        type: FriendConnectionType.outgoing,
      ),
      hasLength(1),
    );
  });

  test('searches within the selected relationship type', () {
    final results = repository.search(
      repository.initialConnections(),
      type: FriendConnectionType.friend,
      query: 'rafi_h',
    );

    expect(results.single.id, 'rafi-hasan');
  });
}
