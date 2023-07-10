import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/domain/models/user_model.dart';
import '../../domain/models/transaction_model.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const HomeState._();
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded({
    required List<TransactionModel> categorySpecificTransactions,
    required List<UserModel> friends,
  }) = _Loaded;
  const factory HomeState.error({
    required Object error,
  }) = _Error;

  bool get isLoading => this is _Loading;

  HomeState copiedWithLoaded({
    required List<TransactionModel> categorySpecificTransactions,
    required List<UserModel> friends,
  }) =>
      HomeState.loaded(
        categorySpecificTransactions: categorySpecificTransactions,
        friends: friends,
      );
}
