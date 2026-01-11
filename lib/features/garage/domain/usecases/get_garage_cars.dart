import '../../../../core/result/result.dart';
import '../entities/garage_car.dart';
import '../repositories/garage_repository.dart';

class GetGarageCars {
  final GarageRepository repository;

  const GetGarageCars(this.repository);

  Future<Result<List<GarageCar>>> call() async {
    return await repository.getGarageCars();
  }
}
