import 'package:bondhon/features/auth/domain/entities/auth_user.dart';
import 'package:bondhon/features/auth/domain/repositories/auth_repository.dart';

class GuestAuthRepository implements AuthRepository {
  const GuestAuthRepository();

  @override
  AuthUser get currentUser => const AuthUser.guest();

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) {
    throw UnsupportedError('Firebase Authentication is not enabled yet.');
  }

  @override
  Future<AuthUser> register({
    required String name,
    required String email,
    required String password,
  }) {
    throw UnsupportedError('Firebase Authentication is not enabled yet.');
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    throw UnsupportedError('Firebase Authentication is not enabled yet.');
  }

  @override
  Future<void> signOut() async {}
}
