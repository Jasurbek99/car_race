import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repositories/car_selection_repository_sp.dart';
import '../../domain/entities/car_config.dart';
import '../../domain/repositories/car_selection_repository.dart';

part 'car_selection_provider.g.dart';

/// Provider for SharedPreferences instance
@riverpod
Future<SharedPreferences> sharedPreferences(
    // ignore: deprecated_member_use_from_same_package
    SharedPreferencesRef ref) async {
  return await SharedPreferences.getInstance();
}

/// Provider for CarSelectionRepository
@riverpod
Future<CarSelectionRepository> carSelectionRepository(
    // ignore: deprecated_member_use_from_same_package
    CarSelectionRepositoryRef ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return CarSelectionRepositorySP(prefs);
}

/// Notifier for managing the selected car configuration
@riverpod
class CarSelection extends _$CarSelection {
  @override
  Future<CarConfig> build() async {
    // Load the selected car from repository
    final repository = await ref.watch(carSelectionRepositoryProvider.future);
    final savedConfig = await repository.getSelectedCar();

    // If no saved config, return default
    return savedConfig ?? CarConfig.defaultConfig();
  }

  /// Select a new car configuration
  Future<void> selectCar(CarConfig config) async {
    // Update the state optimistically
    state = AsyncData(config);

    // Persist to repository
    final repository = await ref.read(carSelectionRepositoryProvider.future);
    await repository.saveSelectedCar(config);
  }

  /// Update only the skin
  Future<void> updateSkin(String skinId) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    await selectCar(currentConfig.copyWith(skinId: skinId));
  }

  /// Update only the wheels
  Future<void> updateWheels(String wheelId) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    await selectCar(currentConfig.copyWith(wheelId: wheelId));
  }

  /// Update only the helmet
  Future<void> updateHelmet(String? helmetId) async {
    final currentConfig = state.value;
    if (currentConfig == null) return;

    await selectCar(currentConfig.copyWith(helmetId: helmetId));
  }

  /// Reset to default car
  Future<void> resetToDefault() async {
    await selectCar(CarConfig.defaultConfig());

    // Also clear from repository
    final repository = await ref.read(carSelectionRepositoryProvider.future);
    await repository.clearSelectedCar();
  }
}
