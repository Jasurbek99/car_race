import '../../../../core/result/result.dart';
import '../entities/transaction.dart';
import '../repositories/account_repository.dart';

class GetTransactions {
  final AccountRepository repository;

  const GetTransactions(this.repository);

  Future<Result<List<Transaction>>> call() async {
    return await repository.getTransactions();
  }
}
