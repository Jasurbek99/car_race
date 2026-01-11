import '../../../../core/result/result.dart';
import '../entities/nitro_level.dart';
import '../repositories/nitro_repository.dart';

class GetNitroLevels {
  final NitroRepository repository;

  const GetNitroLevels(this.repository);

  Future<Result<List<NitroLevel>>> call(String carId) async {
    return await repository.getNitroLevels(carId);
  }
}
