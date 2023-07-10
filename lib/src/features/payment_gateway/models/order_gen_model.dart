import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_gen_model.freezed.dart';
part 'order_gen_model.g.dart';

@freezed
class OrderGenModel with _$OrderGenModel {
  const factory OrderGenModel({
    String? message,
    required TransactionData data,
    CfData? cfData,
  }) = _OrderGenModel;

  factory OrderGenModel.fromJson(Map<String, dynamic> json) =>
      _$OrderGenModelFromJson(json);
}

@freezed
class CfData with _$CfData {
  const factory CfData({
    int? cfOrderId,
    DateTime? createdAt,
    CustomerDetails? customerDetails,
    String? entity,
    int? orderAmount,
    String? orderCurrency,
    DateTime? orderExpiryTime,
    @JsonKey(name: 'order_id') String? orderId,
    OrderMeta? orderMeta,
    String? orderNote,
    List<dynamic>? orderSplits,
    String? orderStatus,
    dynamic orderTags,
    @JsonKey(name: 'payment_session_id') String? paymentSessionId,
    Payments? payments,
    Payments? refunds,
    Payments? settlements,
    dynamic terminalData,
  }) = _CfData;

  factory CfData.fromJson(Map<String, dynamic> json) => _$CfDataFromJson(json);
}

@freezed
abstract class CustomerDetails with _$CustomerDetails {
  const factory CustomerDetails({
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
  }) = _CustomerDetails;

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsFromJson(json);
}

@freezed
abstract class OrderMeta with _$OrderMeta {
  const factory OrderMeta({
    dynamic returnUrl,
    String? notifyUrl,
    dynamic paymentMethods,
  }) = _OrderMeta;

  factory OrderMeta.fromJson(Map<String, dynamic> json) =>
      _$OrderMetaFromJson(json);
}

@freezed
class Payments with _$Payments {
  const factory Payments({
    String? url,
  }) = _Payments;

  factory Payments.fromJson(Map<String, dynamic> json) =>
      _$PaymentsFromJson(json);
}

@freezed
class TransactionData with _$TransactionData {
  const factory TransactionData({
    String? userId,
    String? category,
    String? amount,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) = _TransactionData;

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataFromJson(json);
}
