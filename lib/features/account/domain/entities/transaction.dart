import 'package:equatable/equatable.dart';

enum TransactionType { topUp, withdraw, race, purchase }

class Transaction extends Equatable {
  final String id;
  final TransactionType type;
  final double amount;
  final DateTime date;
  final String description;

  const Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
  });

  @override
  List<Object?> get props => [id, type, amount, date, description];
}
