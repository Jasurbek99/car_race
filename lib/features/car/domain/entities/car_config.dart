import 'package:equatable/equatable.dart';

/// Represents a complete modular car configuration
/// This is the domain entity that describes which parts make up a car
class CarConfig extends Equatable {
  /// Unique identifier for the base car model (e.g., "car_01", "car_02")
  final String carId;

  /// Skin/color variant for the car body (e.g., "base", "green", "pink")
  final String skinId;

  /// Wheel type identifier (e.g., "type_1", "type_2")
  final String wheelId;

  /// Optional helmet identifier for the driver (e.g., "helmet_1")
  final String? helmetId;

  const CarConfig({
    required this.carId,
    this.skinId = 'base',
    this.wheelId = 'type_1',
    this.helmetId,
  });

  /// Create a default car configuration
  factory CarConfig.defaultConfig() {
    return const CarConfig(
      carId: 'car_01',
      skinId: 'base',
      wheelId: 'type_1',
    );
  }

  /// Create a copy with some fields changed
  CarConfig copyWith({
    String? carId,
    String? skinId,
    String? wheelId,
    String? helmetId,
  }) {
    return CarConfig(
      carId: carId ?? this.carId,
      skinId: skinId ?? this.skinId,
      wheelId: wheelId ?? this.wheelId,
      helmetId: helmetId ?? this.helmetId,
    );
  }

  /// Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'skinId': skinId,
      'wheelId': wheelId,
      if (helmetId != null) 'helmetId': helmetId,
    };
  }

  /// Create from JSON
  factory CarConfig.fromJson(Map<String, dynamic> json) {
    return CarConfig(
      carId: json['carId'] as String,
      skinId: json['skinId'] as String? ?? 'base',
      wheelId: json['wheelId'] as String? ?? 'type_1',
      helmetId: json['helmetId'] as String?,
    );
  }

  @override
  List<Object?> get props => [carId, skinId, wheelId, helmetId];

  @override
  String toString() {
    return 'CarConfig(carId: $carId, skinId: $skinId, wheelId: $wheelId, helmetId: $helmetId)';
  }
}
