import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/rest_api.dart';
import '../../data/auth_repository.dart';
import '../../domain/models/user_model.dart';
import '../state/auth.state.dart';
import 'user_notifier.dart';

final StateNotifierProvider<AuthNotifier, AuthState> authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
  (StateNotifierProviderRef<AuthNotifier, AuthState> ref) {
    return AuthNotifier(
      authRepository: ref.watch(authRepositoryProvider),
      http: ref.watch(httpClientProvider),
    );
  },
);

final StreamProvider<bool> isLoggedInProvider =
    StreamProvider<bool>((StreamProviderRef<bool> ref) {
  return FirebaseAuth.instance.authStateChanges().map((User? user) {
    if (user?.email != null && user?.displayName != null) {
      ref.read(userProvider.notifier).setUser(
          UserModel(id: '', email: user!.email!, name: user.displayName!));
    }
    return user != null;
  });
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final HttpBaseClient _http;
  AuthNotifier({
    required HttpBaseClient http,
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        _http = http,
        super(const AuthState.signedOut());

  Future<void> signInUser() async {
    final Either<Failure, UserCredential> res =
        await _authRepository.signInWithGoogle().run();
    return res.match(
      (Failure l) => state = AuthState.failure(failure: l),
      (UserCredential r) async {
        await _http
            .post('${BASE_URL}api/user/create-user', body: <String, dynamic>{
          'email': r.user!.email,
          'name': r.user!.displayName,
          'imageUrl': r.user!.photoURL,
        });
        state = const AuthState.signedIn();
      },
    );
  }
}
