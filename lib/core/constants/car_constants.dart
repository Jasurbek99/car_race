import 'dart:ui';

/// Constants for modular car rendering system
class CarConstants {
  CarConstants._();

  // Default selection identifiers
  static const String defaultCarId = 'car_01';
  static const String defaultSkinId = 'base';
  static const String defaultWheelId = 'type_1';

  // Canvas sizes for car parts (based on typical asset dimensions)
  static const Size bodyCanvasSize = Size(1024, 512);
  static const Size wheelCanvasSize = Size(142, 142);
  static const Size helmetCanvasSize = Size(256, 256);

  // Default normalized anchor points (0.0 to 1.0 coordinates)
  // These represent positions relative to the body canvas where other parts attach
  static const Map<String, Offset> defaultAnchorsNormalized = {
    'rearWheel': Offset(
      0.26,
      0.72,
    ), // Rear wheel position (X: 0=left, 1=right | Y: 0=top, 1=bottom)
    'frontWheel': Offset(0.74, 0.72), // Front wheel position
    'helmet': Offset(0.56, 0.28), // Driver helmet position
  };

  // Wheel adjustment settings - CUSTOMIZE THESE TO FIX POSITIONING
  // Separate controls for rear (left) and front (right) wheels:
  static const double rearWheelSizeScale =
      0.6; // Rear wheel size (1.0 = 100%, 0.7 = 70%)
  static const double rearWheelTopAdjust =
      25.0; // Rear wheel vertical offset (+ down, - up)

  static const double frontWheelSizeScale = 0.6; // Front wheel size
  static const double frontWheelTopAdjust = 25.0; // Front wheel vertical offset

  static const double wheelSizeRatio =
      0.25; // Base wheel size as ratio of car width

  // Car body vertical offset - ADJUST THIS TO MOVE ENTIRE CAR UP/DOWN
  static const double carBodyVerticalOffset =
      -25; // + moves down, - moves up (in pixels)

  // Rendering defaults
  static const double defaultRenderWidth =
      600.0; // Default width for car preview
  static const double defaultRenderHeight =
      400.0; // Default height for car preview

  // Wheel rotation
  static const double wheelRotationSpeed =
      2.0; // Radians per second per speed unit
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
