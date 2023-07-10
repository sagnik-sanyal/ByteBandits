import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/providers/global_providers.dart';
import '../../../../core/services/rest_api.dart';
import '../../auth/presentation/controller/user_notifier.dart';
import '../../home/presentation/controllers/home_notifier.dart';
import '../models/order_gen_model.dart';

final AutoDisposeStateNotifierProvider<PaymentNotifier, AsyncValue<void>>
    paymentNotifierProvider =
    StateNotifierProvider.autoDispose<PaymentNotifier, AsyncValue<void>>(
  (StateNotifierProviderRef<PaymentNotifier, void> ref) {
    return PaymentNotifier(
      ref: ref,
      client: ref.watch(httpClientProvider),
      userNotifier: ref.watch(userProvider.notifier),
    );
  },
);

class PaymentNotifier extends StateNotifier<AsyncValue<void>> {
  final HttpBaseClient client;
  final Ref ref;
  final UserNotifier userNotifier;
  PaymentNotifier(
      {required this.client, required this.userNotifier, required this.ref})
      : super(const AsyncData<void>(null)) {
    cfGatewayService = CFPaymentGatewayService();
    cfGatewayService?.setCallback(
      (String v) => log(v.toString()),
      (CFErrorResponse p0, String p1) {},
    );
  }

  CFPaymentGatewayService? cfGatewayService;

  String? _amount;
  String? _notes;
  void setAmount(String amount) => _amount = amount;

  void setNotes(String notes) => _notes = notes;

  Future<void> createOrder(String mcc) async {
    state = const AsyncLoading<void>();
    if (_amount == null || _amount!.isEmpty) {
      state = const AsyncError<void>('Please enter amount', StackTrace.empty);
      return;
    }
    Either<Failure, String> res = await client.post(
        '${BASE_URL}api/transaction/create-transaction',
        body: <String, String?>{
          'mcc': mcc,
          if (_notes != null && _notes!.isNotEmpty) 'note': _notes,
          'amount': _amount,
          'email': userNotifier.state.email,
          'phone': '9999999999',
          'name': userNotifier.state.name,
        });
    res.fold(
        (Failure f) => state = AsyncError<void>(f.errorMsg, StackTrace.empty),
        (String a) async {
      try {
        OrderGenModel orderGenModel = OrderGenModel.fromJson(jsonDecode(a));
        await openCheckout(
          orderId: orderGenModel.cfData!.orderId!,
          paymentSessionId: orderGenModel.cfData!.paymentSessionId!,
        );
      } catch (_) {
        state =
            const AsyncError<void>('Something went wrong', StackTrace.empty);
      }
    });
  }

  CFSession? createSession({
    required String orderId,
    required String paymentSessionId,
  }) {
    try {
      CFSession session = CFSessionBuilder()
          .setEnvironment(CFEnvironment.SANDBOX)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
      return session;
    } on CFException {
      state = const AsyncError<void>('Something went wrong', StackTrace.empty);
      return null;
    }
  }

  Future<void> openCheckout({
    required String orderId,
    required String paymentSessionId,
  }) async {
    try {
      CFSession? session = createSession(
        orderId: orderId,
        paymentSessionId: paymentSessionId,
      );
      CFPaymentComponent paymentComponent =
          CFPaymentComponentBuilder().setComponents(<CFPaymentModes>[
        CFPaymentModes.UPI,
      ]).build();
      CFTheme theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor('#FF0000')
          .setPrimaryFont('Menlo')
          .setSecondaryFont('Futura')
          .build();

      CFDropCheckoutPayment cfDropCheckoutPayment =
          CFDropCheckoutPaymentBuilder()
              .setSession(session!)
              .setPaymentComponent(paymentComponent)
              .setTheme(theme)
              .build();
      await cfGatewayService?.doPayment(cfDropCheckoutPayment);
      ref.invalidate(homeNotifierProvider);
      ref.read(navigatorKeyProvider).currentState?.pop();
    } on CFException {
      state = const AsyncError<void>('Something went wrong', StackTrace.empty);
    }
  }

  @override
  set state(AsyncValue<void> value) {
    if (mounted) {
      super.state = value;
    }
  }

  @override
  void dispose() {
    cfGatewayService = null;
    super.dispose();
  }
}
