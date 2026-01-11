import 'dart:ui';

/// Constants for modular car rendering system
class CarConstants {
  CarConstants._();

  // Canvas sizes for car parts (based on typical asset dimensions)
  static const Size bodyCanvasSize = Size(1024, 512);
  static const Size wheelCanvasSize = Size(256, 256);
  static const Size helmetCanvasSize = Size(256, 256);

  // Default normalized anchor points (0.0 to 1.0 coordinates)
  // These represent positions relative to the body canvas where other parts attach
  static const Map<String, Offset> defaultAnchorsNormalized = {
    'rearWheel': Offset(0.23, 0.72), // Rear wheel position
    'frontWheel': Offset(0.77, 0.72), // Front wheel position
    'helmet': Offset(0.54, 0.28), // Driver helmet position
  };

  // Rendering defaults
  static const double defaultRenderWidth = 200.0; // Default width for car preview
  static const double defaultRenderHeight = 100.0; // Default height for car preview

  // Wheel rotation
  static const double wheelRotationSpeed = 2.0; // Radians per second per speed unit
  static const double maxWheelRotation = 360.0; // Degrees

  // Physics clamps (used with car physics)
  static const double minSpeed = 0.0;
  static const double maxSpeed = 300.0; // km/h

  // Asset paths structure
  static const String carsBasePath = 'assets/cars';
  static const String wheelsBasePath = 'assets/cars/wheels';
  static const String helmetsBasePath = 'assets/helmets';

  // Fallback assets (when modular parts are missing)
  static const String fallbackCarBody = 'assets/images/mini/car-body.png';
  static const String fallbackWheel = 'assets/images/mini/tire.png';
}
