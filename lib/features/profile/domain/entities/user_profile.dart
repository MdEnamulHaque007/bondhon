class UserProfile {
  const UserProfile({
    required this.displayName,
    required this.username,
    required this.gender,
    required this.country,
    required this.bio,
    this.photoUrl,
  });

  static const guest = UserProfile(
    displayName: 'Guest User',
    username: 'guest',
    gender: 'preferNotToSay',
    country: 'Bangladesh',
    bio: '',
  );

  final String displayName;
  final String username;
  final String gender;
  final String country;
  final String bio;
  final String? photoUrl;

  UserProfile copyWith({
    String? displayName,
    String? username,
    String? gender,
    String? country,
    String? bio,
    String? photoUrl,
  }) {
    return UserProfile(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, Object?> toJson() => {
        'displayName': displayName,
        'username': username,
        'gender': gender,
        'country': country,
        'bio': bio,
        'photoUrl': photoUrl,
      };

  factory UserProfile.fromJson(Map<String, Object?> json) {
    String value(String key, String fallback) {
      final rawValue = json[key];
      return rawValue is String && rawValue.trim().isNotEmpty
          ? rawValue
          : fallback;
    }

    return UserProfile(
      displayName: value('displayName', guest.displayName),
      username: value('username', guest.username),
      gender: value('gender', guest.gender),
      country: value('country', guest.country),
      bio: json['bio'] is String ? json['bio']! as String : guest.bio,
      photoUrl: json['photoUrl'] is String ? json['photoUrl']! as String : null,
    );
  }
}
