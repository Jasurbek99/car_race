# Modular Cars & HUD Gauges - Implementation Guide

## Overview

This document describes the modular car rendering system and HUD gauges implementation in the Car Race game.

## Quick Reference: Add a New Skin in 3 Steps

1. **Add the asset**: Place image at `assets/cars/{carId}/{skinId}.png`
2. **Update catalog**: Add skin to `availableSkins` in `lib/features/car/data/catalogs/car_catalog.dart`
3. **Use it**: Create `CarConfig(carId: 'car_01', skinId: 'new_skin')`

## Core Concepts

### What is a Modular Car?

A modular car is composed of separate visual parts:
- **Body**: Main car body with skins/colors (e.g., `car_01/base.png`)
- **Wheels**: Interchangeable designs (e.g., `wheels/type_1.png`)
- **Helmet**: Optional driver customization

### Key Terminology

- **CarConfig**: Describes which parts make up a car (carId, skinId, wheelId, helmetId)
- **CarRenderSpec**: Service that converts CarConfig into rendering instructions
- **Anchor Points**: Normalized coordinates (0.0-1.0) where parts attach to the car body

### Default Anchor Points

```dart
rearWheel: Offset(0.23, 0.72)
frontWheel: Offset(0.77, 0.72)
helmet: Offset(0.54, 0.28)
```

## Architecture

See full file structure in lib/features/car/ and lib/features/hud/

## Adding New Car Parts

### Add a New Car

1. Create directory: `assets/cars/car_06/`
2. Add body: `assets/cars/car_06/base.png`
3. Update `lib/features/car/data/catalogs/car_catalog.dart`
4. Update `pubspec.yaml`
5. Run `flutter pub get`

### Add a New Wheel

1. Add asset: `assets/wheels/type_6.png`
2. Update catalog in `car_catalog.dart`

### Add a New Helmet

1. Add asset: `assets/helmets/helmet_1.png`
2. Update catalog in `car_catalog.dart`

## Constants Reference

### Car Constants
- `bodyCanvasSize = Size(1024, 512)`
- `wheelCanvasSize = Size(256, 256)`

### HUD Constants
- `idleRpm = 800.0`
- `redlineRpm = 7000.0`
- `maxRpm = 8000.0`
- `minGForce = -1.5`
- `maxGForce = 1.5`

## Integration Examples

### Flutter UI
```dart
ModularCarPreview(
  config: CarConfig(carId: 'car_03', skinId: 'green', wheelId: 'type_3'),
  width: 300,
  height: 150,
)
```

### Flame Game
```dart
final car = ModularCarComponent(
  carConfig: CarConfig(carId: 'car_01', skinId: 'base', wheelId: 'type_1'),
  position: Vector2(100, 200),
  size: Vector2(200, 100),
);
```

### HUD Gauges
```dart
Tachometer(rpm: 5500, size: 120)
GMeter(gForce: 0.8, width: 200, height: 20)
```

## Testing Checklist

### Garage
- [ ] Navigate between cars
- [ ] Modular cars display correctly (IDs 1-5)
- [ ] Fallback images work (IDs 6-7)

### Race
- [ ] HUD gauges appear
- [ ] Tachometer responds to throttle
- [ ] G-meter shows braking/acceleration
- [ ] SHIFT hint appears near redline

## Troubleshooting

### Assets don't load
1. Check `pubspec.yaml` asset paths
2. Run `flutter pub get`
3. Verify files exist

### Wheels misaligned
1. Adjust anchor points in catalog
2. Values must be 0.0-1.0

### Build errors
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Summary

✅ Modular car system with clean architecture
✅ HUD gauges (tachometer + G-meter)
✅ Easy to extend with new parts
✅ Single source of truth (CarRenderSpec)
