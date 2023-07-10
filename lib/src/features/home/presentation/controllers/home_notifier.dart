import 'package:fpdart/src/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/rest_api.dart';
import '../../../auth/presentation/controller/user_notifier.dart';
import '../state/home_state.dart';

final StateNotifierProvider<HomeNotifier, HomeState> homeNotifierProvider =
    StateNotifierProvider<HomeNotifier, HomeState>(
  (StateNotifierProviderRef<HomeNotifier, HomeState> ref) {
    final HttpBaseClient httpBaseClient = ref.watch(httpClientProvider);
    return HomeNotifier(
      http: httpBaseClient,
      userNotifier: ref.watch(userProvider.notifier),
    );
  },
);

class HomeNotifier extends StateNotifier<HomeState> {
  final HttpBaseClient _http;
  final UserNotifier _userNotifier;
  HomeNotifier({
    required HttpBaseClient http,
    required UserNotifier userNotifier,
  })  : _http = http,
        _userNotifier = userNotifier,
        super(const HomeState.loading());

  Future<void> init() async {
    Either<Failure, String> res = await _http
        .post('/baseroute/api/transactions/get-category-amounts', body: {
      'email': _userNotifier.state.email,
    });
    res.fold(
      (Failure failure) => state = HomeState.error(error: failure),
      (String response) {
        state = const HomeState.loaded(
          categorySpecificTransactions: [],
          friends: [],
        );
      },
    );
  }

  // TaskEitherFailure<HomeState> init() {
  // return TaskEitherFailure<HomeState>(
  // (TaskEitherFailure<HomeState> taskEitherFailure) async {
  // final Either<Failure, String> response = await _restApi.get(
  //   'transactions',
  //   headers: {
  //     'Authorization': 'Bearer ${_authNotifier.state.token}',
  //   },
  // );
  // return response.fold(
  //   (Failure failure) => taskEitherFailure.left(failure),
  //   (String response) {
  //     final List<dynamic> json = jsonDecode(response);
  //     final List<TransactionModel> transactions = json
  //         .map((dynamic e) => TransactionModel.fromJson(e))
  //         .toList()
  //         .cast<TransactionModel>();
  //     return taskEitherFailure.right(
  //       _state.copyWithLoaded(
  //         categorySpecificTransactions: transactions,
  //       ),
  //     );
  //   },
  // );
  //   },
  // );
  // }
}
