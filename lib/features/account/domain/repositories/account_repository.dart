import '../../../../core/result/result.dart';
import '../entities/friend.dart';
import '../entities/transaction.dart';
import '../entities/user_profile.dart';

abstract class AccountRepository {
  Future<Result<UserProfile>> getUserProfile();
  Future<Result<UserProfile>> updateUserProfile(UserProfile profile);
  Future<Result<List<Transaction>>> getTransactions();
  Future<Result<List<Friend>>> getFriends();
  Future<Result<List<Friend>>> searchFriends(String query);
}
