import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/friend_model.dart';
import '../models/transaction_model.dart';
import '../models/user_profile_model.dart';

abstract class AccountMockDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<List<TransactionModel>> getTransactions();
  Future<List<FriendModel>> getFriends();
}

class AccountMockDataSourceImpl implements AccountMockDataSource {
  static const String _userProfilePath =
      'assets/mock_data/user_profile.json';
  static const String _transactionsPath =
      'assets/mock_data/transactions.json';
  static const String _friendsPath = 'assets/mock_data/friends.json';

  @override
  Future<UserProfileModel> getUserProfile() async {
    final jsonString = await rootBundle.loadString(_userProfilePath);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    return UserProfileModel.fromJson(jsonData);
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final jsonString = await rootBundle.loadString(_transactionsPath);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final transactionsJson = jsonData['transactions'] as List<dynamic>;

    return transactionsJson
        .map((txJson) =>
            TransactionModel.fromJson(txJson as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<FriendModel>> getFriends() async {
    final jsonString = await rootBundle.loadString(_friendsPath);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final friendsJson = jsonData['friends'] as List<dynamic>;

    return friendsJson
        .map(
            (friendJson) => FriendModel.fromJson(friendJson as Map<String, dynamic>))
        .toList();
  }
}
