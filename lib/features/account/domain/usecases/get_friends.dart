import '../../../../core/result/result.dart';
import '../entities/friend.dart';
import '../repositories/account_repository.dart';

class GetFriends {
  final AccountRepository repository;

  const GetFriends(this.repository);

  Future<Result<List<Friend>>> call() async {
    return await repository.getFriends();
  }
}
