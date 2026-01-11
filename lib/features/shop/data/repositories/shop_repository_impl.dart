import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/shop_package.dart';
import '../../domain/repositories/shop_repository.dart';
import '../datasources/shop_mock_datasource.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopMockDataSource dataSource;

  const ShopRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<ShopPackage>>> getShopPackages() async {
    try {
      final packageModels = await dataSource.getShopPackages();
      final packages = packageModels.map((model) => model.toEntity()).toList();
      return Success(packages);
    } catch (e) {
      return ResultFailure(DataParsingFailure(e.toString()));
    }
  }

  @override
  Future<Result<ShopPackage>> getPackageById(String id) async {
    try {
      final packageModel = await dataSource.getPackageById(id);
      return Success(packageModel.toEntity());
    } catch (e) {
      return ResultFailure(DataParsingFailure(e.toString()));
    }
  }
}
