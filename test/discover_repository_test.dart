import 'package:bondhon/features/discover/data/discover_repository.dart';
import 'package:bondhon/features/discover/domain/entities/discover_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const repository = DiscoverRepository();

  test('searches people across identity, location, and interests', () {
    expect(repository.search(query: 'AYESHA').single.id, 'ayesha-khan');
    expect(repository.search(query: 'Chattogram').single.id, 'tanvir-ahmed');
    expect(repository.search(query: 'Business').single.id, 'maliha-sultana');
    expect(repository.search(query: 'missing'), isEmpty);
  });

  test('filters online and nearby people', () {
    final online = repository.search(filter: DiscoverFilter.online);
    final nearby = repository.search(filter: DiscoverFilter.nearby);

    expect(online.every((user) => user.isOnline), isTrue);
    expect(nearby.every((user) => user.isNearby), isTrue);
    expect(repository.findById('shafin-rahman')?.mutualFriends, 1);
    expect(repository.findById('unknown'), isNull);
  });
}
