import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/errors/failure.dart';
import '../../data/auth_repository.dart';
import '../state/auth.state.dart';

final StateNotifierProvider<AuthNotifier, AuthState> authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
  (StateNotifierProviderRef<AuthNotifier, AuthState> ref) => AuthNotifier(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  AuthNotifier({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState.signedOut());

  Task<AuthState> signInUser() => Task<AuthState>(
        () async {
          final Either<Failure, UserCredential> res =
              await _authRepository.signInWithGoogle().run();
          return res.match(
            (Failure l) => state = AuthState.failure(failure: l),
            (UserCredential r) =>
                state = AuthState.signedIn(email: r.user!.email!),
          );
        },
      );
}
