import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../models/car_model.dart';

class Car extends PositionComponent {
  final String carBodyPath;
  final String tirePath;
  final Color carColor;
  final CarModel? carModel; // Optional car model for stats

  SpriteComponent? carBody;
  SpriteComponent? frontTire;
  SpriteComponent? backTire;

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
  ]; // Speed multipliers per gear
  double baseMaxSpeed = 250; // Base speed for gear calculations

  // For tire animation
  double tireRotation = 0;

  // Track position for race
  double distanceTraveled = 0;

  Car({
    required this.carBodyPath,
    required this.tirePath,
    this.carColor = Colors.white,
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

    try {
      // Load car body sprite
      final bodySprite = await Sprite.load(carBodyPath);
      carBody = SpriteComponent(
        sprite: bodySprite,
        size: Vector2(size.x * 0.9, size.y * 0.6),
        position: Vector2(size.x * 0.05, size.y * 0.1),
      );

      // Load tire sprite
      final tireSprite = await Sprite.load(tirePath);
      final tireSize = Vector2(size.y * 0.35, size.y * 0.35);

      // Back tire position
      backTire = SpriteComponent(
        sprite: tireSprite,
        size: tireSize,
        position: Vector2(size.x * 0.12, size.y * 0.55),
        anchor: Anchor.center,
      );

      // Front tire position
      frontTire = SpriteComponent(
        sprite: tireSprite,
        size: tireSize,
        position: Vector2(size.x * 0.78, size.y * 0.55),
        anchor: Anchor.center,
      );

      if (carBody != null) add(carBody!);
      if (backTire != null) add(backTire!);
      if (frontTire != null) add(frontTire!);
    } catch (e) {
      // Fallback: draw a colored rectangle if sprites fail to load
      debugPrint('Error loading car sprites: $e');
      add(RectangleComponent(size: size, paint: Paint()..color = carColor));
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
      // Natural deceleration when neither gas nor brake is pressed
      speed -= deceleration * dt;
      if (speed < 0) speed = 0;
    }

    // Update distance traveled
    distanceTraveled += speed * dt;

    // Rotate tires based on speed
    tireRotation += speed * dt * 0.05;
    frontTire?.angle = tireRotation;
    backTire?.angle = tireRotation;
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

  // Gear shifting methods
  void shiftUp() {
    if (currentGear < maxGears) {
      currentGear++;
      // Slight speed reduction during shift for realism
      speed *= 0.95;
    }
  }

  void shiftDown() {
    if (currentGear > 1) {
      currentGear--;
      // Prevent over-revving by limiting speed to new gear's max
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
    tireRotation = 0;
    isAccelerating = false;
    isBraking = false;
    currentGear = 1; // Reset to first gear
  }
}
