import 'dart:convert';
import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/services/rest_api.dart';
import '../../../auth/domain/models/user_model.dart';
import '../../../auth/presentation/controller/user_notifier.dart';
import '../../domain/models/transaction_model.dart';
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
        super(const HomeState.loading()) {
    refresh();
  }

  Future<void> refresh() {
    return Future.wait(<Future<void>>[
      getCategorySpending().run(),
      getAllTransactions().run(),
    ]);
  }

  List<PieChartSectionData>? pieCharts;

  Task<Unit> getAllTransactions() => Task<Unit>(() async {
        Either<Failure, String> res = await _http.post(
          '${BASE_URL}api/transaction/get-transaction',
          body: <String, String>{
            'email': _userNotifier.state.email,
          },
        );
        res.fold(
          (Failure failure) => state = HomeState.error(error: failure),
          (String response) {
            CategoryList c = CategoryList.fromJson(jsonDecode(response));
            state = state.copiedWithLoaded(transactionList: c.transactions);
          },
        );
        return unit;
      });

  Task<Unit> getCategorySpending() => Task<Unit>(
        () async {
          Either<Failure, String> res = await _http.post(
            '${BASE_URL}api/transaction/get-category-amounts',
            body: <String, String>{
              'email': _userNotifier.state.email,
            },
          );
          res.fold(
            (Failure failure) => state = HomeState.error(error: failure),
            (String response) {
              CategoryList categoryList =
                  CategoryList.fromJson(jsonDecode(response));
              double total = _calculateTotalExpense(categoryList);
              pieCharts = categoryList.data
                  .map(
                    (CategoryTransaction category) => PieChartSectionData(
                      color: _randomColor(),
                      value: (category.amount) ?? 0 / total,
                      title: (category.category) ?? 'Misc.',
                      titleStyle: TextStyle(
                        fontSize: 14.spMin,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffffffff),
                      ),
                      radius: 80.r,
                    ),
                  )
                  .toList();
              state = HomeState.loaded(
                categorySpecificTransactions: categoryList,
                // ignore: always_specify_types
                transactionList: [],
                friends: <UserModel>[],
              );
            },
          );
          return unit;
        },
      );

  double _calculateTotalExpense(CategoryList categoryList) => categoryList.data
      .where((CategoryTransaction element) => element.amount != null)
      .fold<double>(
        0,
        (double previousValue, CategoryTransaction element) =>
            previousValue + element.amount!,
      );

  MaterialColor _randomColor() =>
      Colors.primaries[(math.Random().nextInt(Colors.primaries.length))];

  @override
  void dispose() {
    pieCharts = null;
    super.dispose();
  }
}
