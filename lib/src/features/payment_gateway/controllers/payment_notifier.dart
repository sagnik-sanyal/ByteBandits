import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/services/rest_api.dart';

final StateNotifierProvider<PaymentNotifier, void> paymentNotifierProvider =
    StateNotifierProvider<PaymentNotifier, void>(
  (StateNotifierProviderRef<PaymentNotifier, void> ref) => PaymentNotifier(
    client: ref.watch(httpClientProvider),
  ),
);

class PaymentNotifier extends StateNotifier<void> {
  final HttpBaseClient client;
  PaymentNotifier({required this.client}) : super(null);

  Future<void> init() async {
    await client.get('https://fing-go.el.r.appspot.com/');
  }
}
