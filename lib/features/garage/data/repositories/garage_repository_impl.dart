import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/garage_car.dart';
import '../../domain/repositories/garage_repository.dart';
import '../datasources/garage_mock_datasource.dart';

class GarageRepositoryImpl implements GarageRepository {
  final GarageMockDataSource dataSource;

  const GarageRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<GarageCar>>> getGarageCars() async {
    try {
      final carModels = await dataSource.getGarageCars();
      final cars = carModels.map((model) => model.toEntity()).toList();
      return Success(cars);
    } on Exception catch (e) {
      return ResultFailure(DataParsingFailure(e.toString()));
    } catch (e) {
      return ResultFailure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<GarageCar>> getCarById(String id) async {
    try {
      final carModel = await dataSource.getCarById(id);
      return Success(carModel.toEntity());
    } on Exception catch (e) {
      return ResultFailure(DataParsingFailure(e.toString()));
    } catch (e) {
      return ResultFailure(UnknownFailure(e.toString()));
    }
  }
}
