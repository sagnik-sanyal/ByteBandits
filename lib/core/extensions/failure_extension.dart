import 'package:firebase_auth/firebase_auth.dart';

import '../errors/failure.dart';

extension ExceptionToFailureMapper on Object {
  //Custom extension to map a series of failures
  Failure toFailure(StackTrace stackTrace) {
    if (this is Exception) {
      return switch (this) {
        FirebaseAuthException e => Failure.auth(
            message: e.message ?? 'Unable to authenticate user',
            stackTrace: stackTrace,
          ),
        _ => Failure.unkown(stackTrace: stackTrace),
      };
    }
    return Failure.unkown(stackTrace: stackTrace);
  }
}
