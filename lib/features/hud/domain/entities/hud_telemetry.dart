import 'package:equatable/equatable.dart';

/// Telemetry data for HUD gauges
class HudTelemetry extends Equatable {
  /// Current speed in km/h
  final double speedKmh;

  /// Current gear (1-5)
  final int gear;

  /// Maximum gears available
  final int maxGears;

  /// Current RPM (revolutions per minute)
  final double rpm;

  /// G-force (acceleration in G units)
  /// Positive = acceleration, Negative = braking
  final double accelG;

  const HudTelemetry({
    required this.speedKmh,
    required this.gear,
    required this.maxGears,
    required this.rpm,
    required this.accelG,
  });

  /// Create a default/zero telemetry
  factory HudTelemetry.zero() {
    return const HudTelemetry(
      speedKmh: 0,
      gear: 1,
      maxGears: 5,
      rpm: 800, // Idle RPM
      accelG: 0,
    );
  }

  /// Create a copy with some fields changed
  HudTelemetry copyWith({
    double? speedKmh,
    int? gear,
    int? maxGears,
    double? rpm,
    double? accelG,
  }) {
    return HudTelemetry(
      speedKmh: speedKmh ?? this.speedKmh,
      gear: gear ?? this.gear,
      maxGears: maxGears ?? this.maxGears,
      rpm: rpm ?? this.rpm,
      accelG: accelG ?? this.accelG,
    );
  }

  @override
  List<Object?> get props => [speedKmh, gear, maxGears, rpm, accelG];

  @override
  String toString() {
    return 'HudTelemetry(speed: ${speedKmh.toStringAsFixed(1)} km/h, '
        'gear: $gear/$maxGears, rpm: ${rpm.toStringAsFixed(0)}, '
        'accelG: ${accelG.toStringAsFixed(2)}G)';
  }
}
