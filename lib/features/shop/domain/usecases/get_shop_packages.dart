import '../../../../core/result/result.dart';
import '../entities/shop_package.dart';
import '../repositories/shop_repository.dart';

class GetShopPackages {
  final ShopRepository repository;

  const GetShopPackages(this.repository);

  Future<Result<List<ShopPackage>>> call() async {
    return await repository.getShopPackages();
  }
}
