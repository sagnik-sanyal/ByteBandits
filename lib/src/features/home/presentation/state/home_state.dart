import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/domain/models/user_model.dart';
import '../../domain/models/transaction_model.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const HomeState._();
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded({
    required CategoryList categorySpecificTransactions,
    required List<UserModel> friends,
    required List<TransactionModel> transactionList,
  }) = _Loaded;
  const factory HomeState.error({
    required Object error,
  }) = _Error;

  bool get isLoading => this is _Loading;

  HomeState copiedWithLoaded({
    CategoryList? categorySpecificTransactions,
    List<UserModel>? friends,
    List<TransactionModel>? transactionList,
  }) =>
      maybeWhen(
        loaded: (CategoryList c, List<UserModel> f, List<TransactionModel> t) {
          return HomeState.loaded(
            categorySpecificTransactions: categorySpecificTransactions ?? c,
            friends: friends ?? f,
            transactionList: transactionList ?? t,
          );
        },
        orElse: () => this,
      );
}
