import '../../../../core/result/result.dart';
import '../entities/shop_package.dart';

abstract class ShopRepository {
  Future<Result<List<ShopPackage>>> getShopPackages();
  Future<Result<ShopPackage>> getPackageById(String id);
}
