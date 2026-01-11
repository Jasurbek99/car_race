import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/account_mock_datasource.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/usecases/get_friends.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../state/account_state.dart';

part 'account_providers.g.dart';

@riverpod
AccountMockDataSource accountMockDataSource(
    // ignore: deprecated_member_use_from_same_package
    AccountMockDataSourceRef ref) {
  return AccountMockDataSourceImpl();
}

@riverpod
AccountRepository accountRepository(
    // ignore: deprecated_member_use_from_same_package
    AccountRepositoryRef ref) {
  final dataSource = ref.watch(accountMockDataSourceProvider);
  return AccountRepositoryImpl(dataSource);
}

@riverpod
GetUserProfile getUserProfile(
    // ignore: deprecated_member_use_from_same_package
    GetUserProfileRef ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return GetUserProfile(repository);
}

@riverpod
GetTransactions getTransactions(
    // ignore: deprecated_member_use_from_same_package
    GetTransactionsRef ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return GetTransactions(repository);
}

@riverpod
GetFriends getFriends(
    // ignore: deprecated_member_use_from_same_package
    GetFriendsRef ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return GetFriends(repository);
}

@riverpod
class AccountNotifier extends _$AccountNotifier {
  @override
  AccountState build() {
    loadAccountData();
    return const AccountState.initial();
  }

  Future<void> loadAccountData() async {
    state = const AccountState.loading();

    final profileUseCase = ref.read(getUserProfileProvider);
    final transactionsUseCase = ref.read(getTransactionsProvider);
    final friendsUseCase = ref.read(getFriendsProvider);

    final profileResult = await profileUseCase();
    final transactionsResult = await transactionsUseCase();
    final friendsResult = await friendsUseCase();

    // Check if any failed
    if (profileResult.isFailure) {
      profileResult.when(
        success: (_) {},
        failure: (failure) => state = AccountState.error(failure.message),
      );
      return;
    }

    if (transactionsResult.isFailure) {
      transactionsResult.when(
        success: (_) {},
        failure: (failure) => state = AccountState.error(failure.message),
      );
      return;
    }

    if (friendsResult.isFailure) {
      friendsResult.when(
        success: (_) {},
        failure: (failure) => state = AccountState.error(failure.message),
      );
      return;
    }

    // All succeeded
    profileResult.when(
      success: (profile) {
        transactionsResult.when(
          success: (transactions) {
            friendsResult.when(
              success: (friends) {
                state = AccountState.loaded(
                  profile: profile,
                  transactions: transactions,
                  friends: friends,
                );
              },
              failure: (_) {},
            );
          },
          failure: (_) {},
        );
      },
      failure: (_) {},
    );
  }

  Future<void> retry() async {
    await loadAccountData();
  }
}
