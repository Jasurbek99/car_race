import '../../../../core/result/result.dart';
import '../entities/nitro_level.dart';

abstract class NitroRepository {
  Future<Result<List<NitroLevel>>> getNitroLevels(String carId);
  Future<Result<NitroLevel>> purchaseNitroLevel(String carId, int level);
  Future<Result<void>> selectNitroLevel(String carId, int level);
}
