import '../entities/car_config.dart';

/// Abstract repository for car selection persistence
/// This follows the clean architecture pattern - domain layer defines the contract
abstract class CarSelectionRepository {
  /// Get the currently selected car configuration
  /// Returns null if no car has been selected yet
  Future<CarConfig?> getSelectedCar();

  /// Save the selected car configuration
  Future<void> saveSelectedCar(CarConfig config);

  /// Clear the selected car (reset to default)
  Future<void> clearSelectedCar();
}
