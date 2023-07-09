import 'package:fpdart/fpdart.dart';

import '../../core/errors/failure.dart';

//**Type definitions for commonly used types**//
typedef TaskEitherUnit = TaskEither<Failure, Unit>;
typedef TaskEitherFailure<T> = TaskEither<Failure, T>;
