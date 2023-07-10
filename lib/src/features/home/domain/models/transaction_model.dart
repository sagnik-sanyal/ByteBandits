import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
final class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String userId,
    required String category,
    required double amount,
    String? note,
    DateTime? createdAt,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
