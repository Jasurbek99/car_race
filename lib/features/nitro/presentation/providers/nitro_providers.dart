import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/nitro_mock_datasource.dart';
import '../../data/repositories/nitro_repository_impl.dart';
import '../../domain/repositories/nitro_repository.dart';
import '../../domain/usecases/get_nitro_levels.dart';
import '../state/nitro_state.dart';

part 'nitro_providers.g.dart';

@riverpod
NitroMockDataSource nitroMockDataSource(
    // ignore: deprecated_member_use_from_same_package
    NitroMockDataSourceRef ref) {
  return NitroMockDataSourceImpl();
}

@riverpod
NitroRepository nitroRepository(
    // ignore: deprecated_member_use_from_same_package
    NitroRepositoryRef ref) {
  final dataSource = ref.watch(nitroMockDataSourceProvider);
  return NitroRepositoryImpl(dataSource);
}

@riverpod
GetNitroLevels getNitroLevels(
    // ignore: deprecated_member_use_from_same_package
    GetNitroLevelsRef ref) {
  final repository = ref.watch(nitroRepositoryProvider);
  return GetNitroLevels(repository);
}

@riverpod
class NitroNotifier extends _$NitroNotifier {
  @override
  NitroState build() {
    loadNitroLevels('1'); // Default car ID
    return const NitroState.initial();
  }

  Future<void> loadNitroLevels(String carId) async {
    state = const NitroState.loading();

    final useCase = ref.read(getNitroLevelsProvider);
    final result = await useCase(carId);

    result.when(
      success: (levels) {
        if (levels.isEmpty) {
          state = const NitroState.empty();
        } else {
          // Find the highest owned level as default selected
          final selectedIndex = levels.lastIndexWhere((l) => l.isOwned);
          state = NitroState.loaded(
            levels: levels,
            selectedLevelIndex: selectedIndex >= 0 ? selectedIndex : 0,
          );
        }
      },
      failure: (failure) {
        state = NitroState.error(failure.message);
      },
    );
  }

  void selectLevel(int index) {
    state.maybeWhen(
      loaded: (levels, _) {
        state = NitroState.loaded(levels: levels, selectedLevelIndex: index);
      },
      orElse: () {},
    );
  }

  Future<void> retry() async {
    await loadNitroLevels('1');
  }
}
