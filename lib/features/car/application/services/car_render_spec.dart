import 'dart:ui';
import '../../../../core/constants/car_constants.dart';
import '../../../../core/utils/math_utils.dart';
import '../../data/catalogs/car_catalog.dart';
import '../../domain/entities/car_config.dart';

/// Rendering specification for a modular car
/// This is the single source of truth for how to render a car from its config
class CarRenderSpec {
  final CarConfig config;

  CarRenderSpec(this.config);

  /// Get the asset path for the car body
  String get bodyPath {
    return '${CarConstants.carsBasePath}/${config.carId}/${config.skinId}.png';
  }

  /// Get the asset path for the wheels
  String get wheelPath {
    return '${CarConstants.wheelsBasePath}/${config.wheelId}.png';
  }

  /// Get the asset path for the helmet (if present)
  String? get helmetPath {
    if (config.helmetId == null) return null;
    return '${CarConstants.helmetsBasePath}/${config.helmetId}.png';
  }

  /// Get normalized anchor points for this car
  /// Returns car-specific anchors if defined, otherwise default anchors
  Map<String, Offset> get anchorsNormalized {
    return CarCatalog.getAnchorsForCar(config.carId);
  }

  /// Get the rear wheel anchor (normalized)
  Offset get rearWheelAnchorNormalized {
    return anchorsNormalized['rearWheel'] ?? CarConstants.defaultAnchorsNormalized['rearWheel']!;
  }

  /// Get the front wheel anchor (normalized)
  Offset get frontWheelAnchorNormalized {
    return anchorsNormalized['frontWheel'] ?? CarConstants.defaultAnchorsNormalized['frontWheel']!;
  }

  /// Get the helmet anchor (normalized)
  Offset get helmetAnchorNormalized {
    return anchorsNormalized['helmet'] ?? CarConstants.defaultAnchorsNormalized['helmet']!;
  }

  /// Convert a normalized anchor to pixel offset for a given render size
  /// [normalizedAnchor] - Anchor in 0.0 to 1.0 coordinates
  /// [renderSize] - The actual size the car body will be rendered at
  /// Returns: Pixel offset relative to the top-left of the rendered car body
  Offset normalizedToPixelOffset(Offset normalizedAnchor, Size renderSize) {
    return MathUtils.normalizedToPixel(normalizedAnchor, renderSize);
  }

  /// Get rear wheel pixel offset for a given render size
  Offset rearWheelPixelOffset(Size renderSize) {
    return normalizedToPixelOffset(rearWheelAnchorNormalized, renderSize);
  }

  /// Get front wheel pixel offset for a given render size
  Offset frontWheelPixelOffset(Size renderSize) {
    return normalizedToPixelOffset(frontWheelAnchorNormalized, renderSize);
  }

  /// Get helmet pixel offset for a given render size
  Offset helmetPixelOffset(Size renderSize) {
    return normalizedToPixelOffset(helmetAnchorNormalized, renderSize);
  }

  /// Calculate wheel size based on render size
  /// Maintains aspect ratio and scales proportionally
  Size calculateWheelSize(Size renderSize) {
    // Wheel size is proportional to the car body size
    // Assuming wheels are roughly 1/4 the width of the car
    final wheelWidth = renderSize.width * 0.25;
    final wheelHeight = wheelWidth; // Wheels are square
    return Size(wheelWidth, wheelHeight);
  }

  /// Calculate helmet size based on render size (if helmet is present)
  Size calculateHelmetSize(Size renderSize) {
    // Helmet is smaller, roughly 1/8 the width of the car
    final helmetWidth = renderSize.width * 0.125;
    final helmetHeight = helmetWidth;
    return Size(helmetWidth, helmetHeight);
  }

  /// Get a complete rendering plan for the given render size
  /// Returns a map with all the information needed to render the car
  Map<String, dynamic> getRenderingPlan(Size renderSize) {
    final wheelSize = calculateWheelSize(renderSize);
    final helmetSize = calculateHelmetSize(renderSize);

    return {
      'bodyPath': bodyPath,
      'bodySize': renderSize,
      'rearWheel': {
        'path': wheelPath,
        'size': wheelSize,
        'offset': rearWheelPixelOffset(renderSize),
      },
      'frontWheel': {
        'path': wheelPath,
        'size': wheelSize,
        'offset': frontWheelPixelOffset(renderSize),
      },
      if (helmetPath != null)
        'helmet': {
          'path': helmetPath,
          'size': helmetSize,
          'offset': helmetPixelOffset(renderSize),
        },
    };
  }
}
