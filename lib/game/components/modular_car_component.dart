import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../features/car/domain/entities/car_config.dart';
import '../../features/car/application/services/car_render_spec.dart';
import '../../models/car_model.dart';

/// Modular car component for Flame engine
/// Uses CarRenderSpec to render car parts consistently with preview
class ModularCarComponent extends PositionComponent {
  final CarConfig carConfig;
  final Color fallbackColor;
  final CarModel? carModel;

  SpriteComponent? carBody;
  SpriteComponent? frontWheel;
  SpriteComponent? rearWheel;
  SpriteComponent? helmet;

  // Physics properties
  double speed = 0;
  double maxSpeed = 300;
  double acceleration = 150;
  double deceleration = 100;
  double brakeDeceleration = 250;
  bool isAccelerating = false;
  bool isBraking = false;

  // Gear system
  int currentGear = 1;
  int maxGears = 5;
  List<double> gearRatios = [
    0.4,
    0.6,
    0.8,
    1.0,
    1.2,
  ];
  double baseMaxSpeed = 250;

  // Animation
  double wheelRotation = 0;

  // Track position
  double distanceTraveled = 0;

  ModularCarComponent({
    required this.carConfig,
    this.fallbackColor = Colors.white,
    this.carModel,
    super.position,
    super.size,
  });

  @override
  Future<void> onLoad() async {
    // Apply car model stats if provided
    if (carModel != null) {
      acceleration = 150 * carModel!.stats.baseAcceleration;
      baseMaxSpeed = 250 * carModel!.stats.baseMaxSpeed;
      maxGears = carModel!.stats.gearCount;

      // Adjust gear ratios based on gear count
      if (maxGears == 4) {
        gearRatios = [0.5, 0.7, 0.9, 1.2];
      }
    }

    // Use CarRenderSpec to get rendering plan
    final spec = CarRenderSpec(carConfig);
    final plan = spec.getRenderingPlan(Size(size.x, size.y));

    try {
      // Load body sprite
      final bodyPath = (plan['bodyPath'] as String).replaceAll('assets/', '');
      final bodySprite = await Sprite.load(bodyPath);
      final bodySize = plan['bodySize'] as Size;

      carBody = SpriteComponent(
        sprite: bodySprite,
        size: Vector2(bodySize.width, bodySize.height),
        position: Vector2.zero(),
      );

      // Load wheel sprites
      final rearWheelData = plan['rearWheel'] as Map<String, dynamic>;
      final frontWheelData = plan['frontWheel'] as Map<String, dynamic>;

      final wheelPath =
          (rearWheelData['path'] as String).replaceAll('assets/', '');
      final wheelSprite = await Sprite.load(wheelPath);

      // Rear wheel
      final rearWheelSize = rearWheelData['size'] as Size;
      final rearWheelOffset = rearWheelData['offset'] as Offset;
      rearWheel = SpriteComponent(
        sprite: wheelSprite,
        size: Vector2(rearWheelSize.width, rearWheelSize.height),
        position: Vector2(rearWheelOffset.dx, rearWheelOffset.dy),
        anchor: Anchor.center,
      );

      // Front wheel
      final frontWheelSize = frontWheelData['size'] as Size;
      final frontWheelOffset = frontWheelData['offset'] as Offset;
      frontWheel = SpriteComponent(
        sprite: wheelSprite,
        size: Vector2(frontWheelSize.width, frontWheelSize.height),
        position: Vector2(frontWheelOffset.dx, frontWheelOffset.dy),
        anchor: Anchor.center,
      );

      // Load helmet if present
      if (plan.containsKey('helmet')) {
        final helmetData = plan['helmet'] as Map<String, dynamic>;
        final helmetPath =
            (helmetData['path'] as String).replaceAll('assets/', '');
        try {
          final helmetSprite = await Sprite.load(helmetPath);
          final helmetSize = helmetData['size'] as Size;
          final helmetOffset = helmetData['offset'] as Offset;

          helmet = SpriteComponent(
            sprite: helmetSprite,
            size: Vector2(helmetSize.width, helmetSize.height),
            position: Vector2(helmetOffset.dx, helmetOffset.dy),
            anchor: Anchor.center,
          );
        } catch (e) {
          debugPrint('Helmet failed to load (optional): $e');
        }
      }

      // Add components in correct layering order
      if (rearWheel != null) add(rearWheel!);
      if (frontWheel != null) add(frontWheel!);
      if (carBody != null) add(carBody!);
      if (helmet != null) add(helmet!);
    } catch (e) {
      // Fallback: draw a colored rectangle if sprites fail to load
      debugPrint('Error loading modular car sprites: $e');
      add(RectangleComponent(
        size: size,
        paint: Paint()..color = fallbackColor,
      ));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Calculate effective max speed based on current gear
    final effectiveMaxSpeed = baseMaxSpeed * gearRatios[currentGear - 1];

    // Update speed based on acceleration or braking
    if (isAccelerating) {
      speed += acceleration * dt;
      if (speed > effectiveMaxSpeed) speed = effectiveMaxSpeed;
    } else if (isBraking) {
      speed -= brakeDeceleration * dt;
      if (speed < 0) speed = 0;
    } else {
      // Natural deceleration
      speed -= deceleration * dt;
      if (speed < 0) speed = 0;
    }

    // Update distance traveled
    distanceTraveled += speed * dt;

    // Rotate wheels based on speed
    wheelRotation += speed * dt * 0.05;
    frontWheel?.angle = wheelRotation;
    rearWheel?.angle = wheelRotation;
  }

  void accelerate() {
    isAccelerating = true;
    isBraking = false;
  }

  void stopAccelerating() {
    isAccelerating = false;
  }

  void activeBrake() {
    isBraking = true;
    isAccelerating = false;
  }

  void stopBraking() {
    isBraking = false;
  }

  void brake() {
    isAccelerating = false;
    isBraking = false;
  }

  void shiftUp() {
    if (currentGear < maxGears) {
      currentGear++;
      speed *= 0.95;
    }
  }

  void shiftDown() {
    if (currentGear > 1) {
      currentGear--;
      final newMaxSpeed = baseMaxSpeed * gearRatios[currentGear - 1];
      if (speed > newMaxSpeed) {
        speed = newMaxSpeed;
      }
    }
  }

  int getCurrentGear() => currentGear;

  void reset() {
    speed = 0;
    distanceTraveled = 0;
    wheelRotation = 0;
    isAccelerating = false;
    isBraking = false;
    currentGear = 1;
  }
}
