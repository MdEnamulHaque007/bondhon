import 'package:bondhon/features/rooms/data/room_repository.dart';
import 'package:bondhon/features/rooms/domain/entities/chat_room.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const repository = RoomRepository();

  test('filters rooms by category', () {
    final educationRooms = repository.search(
      category: RoomCategory.education,
    );

    expect(educationRooms, hasLength(1));
    expect(educationRooms.single.id, 'study-together');
  });

  test('searches room names and descriptions case-insensitively', () {
    expect(repository.search(query: 'DHAKA').single.id, 'dhaka-community');
    expect(repository.search(query: 'learning').single.id, 'study-together');
    expect(repository.search(query: 'missing'), isEmpty);
  });

  test('finds a room by id', () {
    expect(repository.findById('music-movies')?.name, 'Music & Movies');
    expect(repository.findById('unknown-room'), isNull);
  });
}
