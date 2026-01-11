import '../../../../core/result/result.dart';
import '../entities/garage_car.dart';

abstract class GarageRepository {
  Future<Result<List<GarageCar>>> getGarageCars();
  Future<Result<GarageCar>> getCarById(String id);
}
