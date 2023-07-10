import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String userId,
    required String category,
    required String amount,
    String? note,
    DateTime? createdAt,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

@freezed
class CategoryList with _$CategoryList {
  const factory CategoryList({
    @Default(<CategoryTransaction>[]) List<CategoryTransaction> data,
    @Default(<TransactionModel>[]) List<TransactionModel> transactions,
  }) = _CategoryList;

  factory CategoryList.fromJson(Map<String, dynamic> json) =>
      _$CategoryListFromJson(json);
}

@freezed
class CategoryTransaction with _$CategoryTransaction {
  const factory CategoryTransaction({
    String? category,
    double? amount,
  }) = _CategoryTransaction;

  factory CategoryTransaction.fromJson(Map<String, dynamic> json) =>
      _$CategoryTransactionFromJson(json);
}
