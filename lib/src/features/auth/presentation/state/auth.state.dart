import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/errors/failure.dart';

part 'auth.state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.signedIn({
    required String email,
  }) = _SignedIn;

  const factory AuthState.failure({
    required Failure failure,
  }) = _Failure;

  const factory AuthState.signedOut() = _SignedOut;

  const factory AuthState.loading() = _Initial;
}
