class PrivacySettings {
  const PrivacySettings({
    this.lastSeenVisible = true,
    this.profilePhotoVisible = true,
    this.allowMessages = true,
    this.allowGroupAdds = true,
  });

  final bool lastSeenVisible;
  final bool profilePhotoVisible;
  final bool allowMessages;
  final bool allowGroupAdds;

  PrivacySettings copyWith({
    bool? lastSeenVisible,
    bool? profilePhotoVisible,
    bool? allowMessages,
    bool? allowGroupAdds,
  }) {
    return PrivacySettings(
      lastSeenVisible: lastSeenVisible ?? this.lastSeenVisible,
      profilePhotoVisible: profilePhotoVisible ?? this.profilePhotoVisible,
      allowMessages: allowMessages ?? this.allowMessages,
      allowGroupAdds: allowGroupAdds ?? this.allowGroupAdds,
    );
  }

  Map<String, Object> toJson() => {
        'lastSeenVisible': lastSeenVisible,
        'profilePhotoVisible': profilePhotoVisible,
        'allowMessages': allowMessages,
        'allowGroupAdds': allowGroupAdds,
      };

  factory PrivacySettings.fromJson(Map<String, Object?> json) {
    bool value(String key, bool fallback) {
      final raw = json[key];
      return raw is bool ? raw : fallback;
    }

    return PrivacySettings(
      lastSeenVisible: value('lastSeenVisible', true),
      profilePhotoVisible: value('profilePhotoVisible', true),
      allowMessages: value('allowMessages', true),
      allowGroupAdds: value('allowGroupAdds', true),
    );
  }
}
