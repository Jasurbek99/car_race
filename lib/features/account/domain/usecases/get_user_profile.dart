import '../../../../core/result/result.dart';
import '../entities/user_profile.dart';
import '../repositories/account_repository.dart';

class GetUserProfile {
  final AccountRepository repository;

  const GetUserProfile(this.repository);

  Future<Result<UserProfile>> call() async {
    return await repository.getUserProfile();
  }
}
