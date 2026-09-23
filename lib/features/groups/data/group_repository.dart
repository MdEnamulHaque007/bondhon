import 'package:flutter/foundation.dart';

import 'package:bondhon/features/groups/domain/entities/group.dart';

class GroupRepository extends ChangeNotifier {
  GroupRepository({List<Group>? initialGroups})
      : _groups = List<Group>.from(initialGroups ?? _mockGroups);

  final List<Group> _groups;

  List<Group> get groups => List.unmodifiable(_groups);

  List<Group> search(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return groups;
    return _groups.where((group) {
      return group.name.toLowerCase().contains(normalized) ||
          group.description.toLowerCase().contains(normalized);
    }).toList();
  }

  Group? findById(String id) {
    for (final group in _groups) {
      if (group.id == id) return group;
    }
    return null;
  }

  Group createGroup({
    required String name,
    required String description,
    required GroupVisibility visibility,
  }) {
    final now = DateTime.now();
    final id = 'local-\${now.microsecondsSinceEpoch}';
    final group = Group(
      id: id,
      name: name.trim(),
      description: description.trim(),
      visibility: visibility,
      memberCount: 1,
      lastActivity: 'Just now',
      ownerId: 'guest',
      members: const [
        GroupMember(
          id: 'guest',
          name: 'Guest User',
          role: GroupRole.owner,
          isGuest: true,
        ),
      ],
      messages: const [],
    );
    _groups.insert(0, group);
    notifyListeners();
    return group;
  }

  bool isMember(String groupId) {
    return findById(groupId)?.members.any((member) => member.id == 'guest') ??
        false;
  }

  void join(String groupId) {
    final group = findById(groupId);
    if (group == null || isMember(groupId)) return;
    final members = [
      ...group.members,
      const GroupMember(
        id: 'guest',
        name: 'Guest User',
        role: GroupRole.member,
        isGuest: true,
      ),
    ];
    _replace(group.copyWith(
      members: members,
      memberCount: group.memberCount + 1,
      lastActivity: 'Just now',
    ));
  }

  void leave(String groupId) {
    final group = findById(groupId);
    if (group == null || !isMember(groupId) || group.ownerId == 'guest') return;
    _replace(group.copyWith(
      members: group.members.where((member) => member.id != 'guest').toList(),
      memberCount: group.memberCount > 0 ? group.memberCount - 1 : 0,
    ));
  }

  void sendMessage(String groupId, String text) {
    final group = findById(groupId);
    final message = text.trim();
    if (group == null || message.isEmpty || !isMember(groupId)) return;
    final guest = group.members.firstWhere(
      (member) => member.id == 'guest',
      orElse: () => const GroupMember(
        id: 'guest',
        name: 'Guest User',
        role: GroupRole.member,
        isGuest: true,
      ),
    );
    if (group.adminOnlyMessaging &&
        guest.role != GroupRole.owner &&
        guest.role != GroupRole.admin) {
      return;
    }
    final next = GroupMessage(
      id: 'message-\${DateTime.now().microsecondsSinceEpoch}',
      senderId: 'guest',
      senderName: guest.name,
      text: message,
      sentAt: DateTime.now(),
    );
    _replace(group.copyWith(
      messages: [...group.messages, next],
      lastActivity: 'Just now',
    ));
  }

  void _replace(Group updated) {
    final index = _groups.indexWhere((group) => group.id == updated.id);
    if (index == -1) return;
    _groups[index] = updated;
    notifyListeners();
  }

  static final List<Group> _mockGroups = [
    Group(
      id: 'bangla-tech',
      name: 'Bangla Tech Community',
      description: 'Flutter, AI, gadgets and practical technology discussions.',
      visibility: GroupVisibility.public,
      memberCount: 1284,
      lastActivity: '2 min ago',
      ownerId: 'rahim',
      logoColor: Colors.blue,
      members: [
        const GroupMember(id: 'rahim', name: 'Rahim Ahmed', role: GroupRole.owner),
        const GroupMember(id: 'sadia', name: 'Sadia Islam', role: GroupRole.admin),
        const GroupMember(id: 'tanvir', name: 'Tanvir Hasan', role: GroupRole.member),
      ],
      messages: [
        GroupMessage(
          id: 'm1',
          senderId: 'rahim',
          senderName: 'Rahim Ahmed',
          text: 'Welcome everyone! Share what you are building.',
          sentAt: DateTime(2026, 9, 23, 13, 40),
        ),
        GroupMessage(
          id: 'm2',
          senderId: 'sadia',
          senderName: 'Sadia Islam',
          text: 'Today we are discussing Flutter architecture.',
          sentAt: DateTime(2026, 9, 23, 13, 44),
        ),
      ],
    ),
    Group(
      id: 'dhaka-foodies',
      name: 'Dhaka Foodies',
      description: 'Local food finds, reviews and friendly recommendations.',
      visibility: GroupVisibility.public,
      memberCount: 742,
      lastActivity: '18 min ago',
      ownerId: 'nabila',
      logoColor: Colors.orange,
      members: [
        const GroupMember(id: 'nabila', name: 'Nabila Chowdhury', role: GroupRole.owner),
        const GroupMember(id: 'arif', name: 'Arif Hossain', role: GroupRole.member),
      ],
      messages: [
        GroupMessage(
          id: 'm3',
          senderId: 'nabila',
          senderName: 'Nabila Chowdhury',
          text: 'Any good biryani place around Dhanmondi?',
          sentAt: DateTime(2026, 9, 23, 13, 25),
        ),
      ],
    ),
    Group(
      id: 'bondhon-team',
      name: 'Bondhon Builders',
      description: 'A private space for product builders and invited members.',
      visibility: GroupVisibility.private,
      memberCount: 37,
      lastActivity: '1 hr ago',
      ownerId: 'farhan',
      adminOnlyMessaging: true,
      logoColor: Colors.purple,
      members: [
        const GroupMember(id: 'farhan', name: 'Farhan Kabir', role: GroupRole.owner),
        const GroupMember(id: 'mim', name: 'Mim Akter', role: GroupRole.admin),
        const GroupMember(id: 'sabbir', name: 'Sabbir Rahman', role: GroupRole.member),
      ],
      messages: [
        GroupMessage(
          id: 'm4',
          senderId: 'farhan',
          senderName: 'Farhan Kabir',
          text: 'Admin-only messaging is enabled for this demo group.',
          sentAt: DateTime(2026, 9, 23, 12, 10),
        ),
      ],
    ),
  ];
}
