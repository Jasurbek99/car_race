import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/friend.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/user_profile.dart';

part 'account_state.freezed.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState.initial() = _Initial;
  const factory AccountState.loading() = _Loading;
  const factory AccountState.loaded({
    required UserProfile profile,
    required List<Transaction> transactions,
    required List<Friend> friends,
  }) = _Loaded;
  const factory AccountState.error(String message) = _Error;
}
