class AuthUser {
  const AuthUser({
    required this.id,
    required this.displayName,
    this.email,
    this.isGuest = false,
  });

  const AuthUser.guest()
      : id = 'guest',
        displayName = 'অতিথি ব্যবহারকারী',
        email = null,
        isGuest = true;

  final String id;
  final String displayName;
  final String? email;
  final bool isGuest;
}
