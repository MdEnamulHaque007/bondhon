import 'package:bondhon/features/auth/domain/entities/auth_user.dart';

abstract interface class AuthRepository {
  AuthUser get currentUser;

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<AuthUser> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
}
