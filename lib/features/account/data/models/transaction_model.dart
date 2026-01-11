import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/transaction.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final String id;
  final String type;
  final double amount;
  final String date;
  final String description;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  Transaction toEntity() {
    return Transaction(
      id: id,
      type: _parseTransactionType(type),
      amount: amount,
      date: DateTime.parse(date),
      description: description,
    );
  }

  factory TransactionModel.fromEntity(Transaction entity) {
    return TransactionModel(
      id: entity.id,
      type: entity.type.name,
      amount: entity.amount,
      date: entity.date.toIso8601String(),
      description: entity.description,
    );
  }

  static TransactionType _parseTransactionType(String type) {
    switch (type) {
      case 'topUp':
        return TransactionType.topUp;
      case 'withdraw':
        return TransactionType.withdraw;
      case 'race':
        return TransactionType.race;
      case 'purchase':
        return TransactionType.purchase;
      default:
        return TransactionType.race;
    }
  }
}
