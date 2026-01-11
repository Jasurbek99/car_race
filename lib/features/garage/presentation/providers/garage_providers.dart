import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/garage_mock_datasource.dart';
import '../../data/repositories/garage_repository_impl.dart';
import '../../domain/repositories/garage_repository.dart';
import '../../domain/usecases/get_garage_cars.dart';
import '../state/garage_state.dart';

part 'garage_providers.g.dart';

@riverpod
GarageMockDataSource garageMockDataSource(
    // ignore: deprecated_member_use_from_same_package
    GarageMockDataSourceRef ref) {
  return GarageMockDataSourceImpl();
}

@riverpod
GarageRepository garageRepository(
    // ignore: deprecated_member_use_from_same_package
    GarageRepositoryRef ref) {
  final dataSource = ref.watch(garageMockDataSourceProvider);
  return GarageRepositoryImpl(dataSource);
}

@riverpod
GetGarageCars getGarageCars(
    // ignore: deprecated_member_use_from_same_package
    GetGarageCarsRef ref) {
  final repository = ref.watch(garageRepositoryProvider);
  return GetGarageCars(repository);
}

@riverpod
class GarageNotifier extends _$GarageNotifier {
  @override
  GarageState build() {
    loadCars();
    return const GarageState.initial();
  }

  Future<void> loadCars() async {
    state = const GarageState.loading();

    final useCase = ref.read(getGarageCarsProvider);
    final result = await useCase();

    result.when(
      success: (cars) {
        if (cars.isEmpty) {
          state = const GarageState.empty();
        } else {
          state = GarageState.loaded(cars);
        }
      },
      failure: (failure) {
        state = GarageState.error(failure.message);
      },
    );
  }

  Future<void> retry() async {
    await loadCars();
  }
}
