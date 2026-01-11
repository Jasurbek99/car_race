import 'dart:ui';
import '../../../../core/constants/car_constants.dart';

/// Catalog entry for a modular car
class CarCatalogEntry {
  final String id;
  final String name;
  final List<String> availableSkins;

  /// Optional custom anchor overrides for this specific car
  /// If null, uses default anchors from CarConstants
  final Map<String, Offset>? customAnchors;

  const CarCatalogEntry({
    required this.id,
    required this.name,
    required this.availableSkins,
    this.customAnchors,
  });
}

/// Catalog entry for wheels
class WheelCatalogEntry {
  final String id;
  final String name;

  const WheelCatalogEntry({
    required this.id,
    required this.name,
  });
}

/// Catalog entry for helmets
class HelmetCatalogEntry {
  final String id;
  final String name;

  const HelmetCatalogEntry({
    required this.id,
    required this.name,
  });
}

/// Master catalog of all available car parts
class CarCatalog {
  CarCatalog._();

  /// Available car models
  static const List<CarCatalogEntry> cars = [
    CarCatalogEntry(
      id: 'car_01',
      name: 'Classic Racer',
      availableSkins: ['base'],
    ),
    CarCatalogEntry(
      id: 'car_02',
      name: 'Street Machine',
      availableSkins: ['base'],
    ),
    CarCatalogEntry(
      id: 'car_03',
      name: 'Speed Demon',
      availableSkins: ['base', 'green', 'pink', 'yellow'],
    ),
    CarCatalogEntry(
      id: 'car_04',
      name: 'Road Warrior',
      availableSkins: ['base', 'blue'],
    ),
    CarCatalogEntry(
      id: 'car_05',
      name: 'Thunder Bolt',
      availableSkins: ['base'],
    ),
  ];

  /// Available wheel types
  static const List<WheelCatalogEntry> wheels = [
    WheelCatalogEntry(id: 'type_1', name: 'Standard'),
    WheelCatalogEntry(id: 'type_2', name: 'Sport'),
    WheelCatalogEntry(id: 'type_3', name: 'Racing'),
    WheelCatalogEntry(id: 'type_4', name: 'Off-Road'),
    WheelCatalogEntry(id: 'type_5', name: 'Chrome'),
  ];

  /// Available helmets (optional cosmetic)
  static const List<HelmetCatalogEntry> helmets = [
    // Add helmet entries when helmet assets are available
  ];

  /// Get anchors for a specific car (with fallback to defaults)
  static Map<String, Offset> getAnchorsForCar(String carId) {
    final car = cars.firstWhere(
      (c) => c.id == carId,
      orElse: () => cars.first,
    );
    return car.customAnchors ?? CarConstants.defaultAnchorsNormalized;
  }

  /// Get available skins for a car
  static List<String> getSkinsForCar(String carId) {
    final car = cars.firstWhere(
      (c) => c.id == carId,
      orElse: () => cars.first,
    );
    return car.availableSkins;
  }

  /// Validate if a car exists
  static bool isValidCar(String carId) {
    return cars.any((c) => c.id == carId);
  }

  /// Validate if a skin exists for a car
  static bool isValidSkin(String carId, String skinId) {
    final skins = getSkinsForCar(carId);
    return skins.contains(skinId);
  }

  /// Validate if a wheel exists
  static bool isValidWheel(String wheelId) {
    return wheels.any((w) => w.id == wheelId);
  }

  /// Validate if a helmet exists
  static bool isValidHelmet(String helmetId) {
    return helmets.any((h) => h.id == helmetId);
  }
}
