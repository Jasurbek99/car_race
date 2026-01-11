import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/friend.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_mock_datasource.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountMockDataSource dataSource;

  const AccountRepositoryImpl(this.dataSource);

  @override
  Future<Result<UserProfile>> getUserProfile() async {
    try {
      final profileModel = await dataSource.getUserProfile();
      return Success(profileModel.toEntity());
    } catch (e) {
      return ResultFailure(DataParsingFailure(e.toString()));
    }
  }

  @override
  Future<Result<UserProfile>> updateUserProfile(UserProfile profile) async {
    // Mock implementation - would call API in real app
    return Success(profile);
  }

  @override
  Future<Result<List<Transaction>>> getTransactions() async {
    try {
      final transactionModels = await dataSource.getTransactions();
      final transactions =
          transactionModels.map((model) => model.toEntity()).toList();
      return Success(transactions);
    } catch (e) {
      return ResultFailure(DataParsingFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Friend>>> getFriends() async {
    try {
      final friendModels = await dataSource.getFriends();
      final friends = friendModels.map((model) => model.toEntity()).toList();
      return Success(friends);
    } catch (e) {
      return ResultFailure(DataParsingFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Friend>>> searchFriends(String query) async {
    // Mock implementation - filter existing friends
    try {
      final allFriends = await getFriends();
      return allFriends.when(
        success: (friends) {
          final filtered = friends
              .where((f) => f.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return Success(filtered);
        },
        failure: (failure) => ResultFailure(failure),
      );
    } catch (e) {
      return ResultFailure(DataParsingFailure(e.toString()));
    }
  }
}
