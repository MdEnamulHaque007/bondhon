import 'package:bondhon/features/auth/data/repositories/guest_auth_repository.dart';
import 'package:bondhon/features/auth/domain/entities/auth_user.dart';
import 'package:bondhon/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => const GuestAuthRepository(),
);

final currentUserProvider = Provider<AuthUser>(
  (ref) => ref.watch(authRepositoryProvider).currentUser,
);
