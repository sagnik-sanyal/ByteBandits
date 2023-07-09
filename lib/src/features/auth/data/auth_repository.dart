import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/constants/type_defs.dart';
import '../../../../core/extensions/failure_extension.dart';
import '../domain/repository_interface/auth_repository_interface.dart';

/// Auth Repository Provider
final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>(
  name: 'AuthRepository',
  (ProviderRef<AuthRepository> ref) {
    return AuthRepository(firebaseAuth: FirebaseAuth.instance);
  },
);

class AuthRepository implements IAuthRepository {
  late final FirebaseAuth _auth;
  AuthRepository({
    required FirebaseAuth firebaseAuth,
  }) : _auth = firebaseAuth;

  @override
  TaskEitherFailure<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) =>
      TaskEitherFailure<UserCredential>.tryCatch(
        () async {
          final UserCredential res = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          return res;
        },
        (Object e, StackTrace s) => e.toFailure(s),
      );

  @override
  TaskEitherFailure<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      TaskEitherFailure<User>.tryCatch(
        () async {
          final UserCredential res = await _auth.signInWithEmailAndPassword(
              email: email, password: password);
          return res.user!;
        },
        (Object e, StackTrace s) => e.toFailure(s),
      );

  @override
  TaskEitherFailure<UserCredential> signInWithGoogle() =>
      TaskEitherFailure<UserCredential>.tryCatch(
        () async {
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          final GoogleSignInAuthentication googleAuth =
              await googleUser!.authentication;
          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final UserCredential res =
              await _auth.signInWithCredential(credential);
          return res;
        },
        (Object e, StackTrace s) => e.toFailure(s),
      );
}
