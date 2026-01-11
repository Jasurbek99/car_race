import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/nitro_level.dart';
import '../../domain/repositories/nitro_repository.dart';
import '../datasources/nitro_mock_datasource.dart';

class NitroRepositoryImpl implements NitroRepository {
  final NitroMockDataSource dataSource;

  const NitroRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<NitroLevel>>> getNitroLevels(String carId) async {
    try {
      final levelModels = await dataSource.getNitroLevels(carId);
      final levels = levelModels.map((model) => model.toEntity()).toList();
      return Success(levels);
    } catch (e) {
      return ResultFailure(DataParsingFailure(e.toString()));
    }
  }

  @override
  Future<Result<NitroLevel>> purchaseNitroLevel(String carId, int level) async {
    // Mock implementation - would call API in real app
    return ResultFailure(
      const ServerFailure('Purchase functionality not implemented'),
    );
  }

  @override
  Future<Result<void>> selectNitroLevel(String carId, int level) async {
    // Mock implementation - would call API in real app
    return const Success(null);
  }
}
