import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../app/constants/type_defs.dart';

abstract interface class IAuthRepository {
  ///Sign in user with email and password
  TaskEitherFailure<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  ///Register user in the app
  TaskEitherFailure<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  ///Sign in user with google
  TaskEitherFailure<UserCredential> signInWithGoogle();
}
