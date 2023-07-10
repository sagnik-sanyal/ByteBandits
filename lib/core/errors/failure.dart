import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();
  const factory Failure.auth({
    required String message,
    required StackTrace stackTrace,
  }) = _AuthFailure;

  const factory Failure.unkown({
    @Default('Oops !! It seems something went wrong') String message,
    required StackTrace stackTrace,
  }) = _UnkownFailure;

  const factory Failure.http({
    required String message,
    required int code,
    required StackTrace stackTrace,
  }) = _HttpFailure;

  String get errorMsg => map(
        auth: (Failure f) => f.message,
        unkown: (Failure f) => f.message,
        http: (Failure f) => f.message,
      );
}
