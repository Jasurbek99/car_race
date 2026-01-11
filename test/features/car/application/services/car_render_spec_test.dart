import 'package:flutter_test/flutter_test.dart';
import 'package:car_race/features/car/application/services/car_render_spec.dart';
import 'package:car_race/features/car/domain/entities/car_config.dart';
import 'dart:ui';

void main() {
  group('CarRenderSpec', () {
    test('generates correct body path', () {
      final config = const CarConfig(
        carId: 'car_03',
        skinId: 'green',
        wheelId: 'type_2',
      );
      final spec = CarRenderSpec(config);
      expect(spec.bodyPath, 'assets/cars/car_03/green.png');
    });

    test('generates correct wheel path', () {
      final config = const CarConfig(
        carId: 'car_01',
        skinId: 'base',
        wheelId: 'type_5',
      );
      final spec = CarRenderSpec(config);
      expect(spec.wheelPath, 'assets/wheels/type_5.png');
    });

    test('generates helmet path when present', () {
      final config = const CarConfig(
        carId: 'car_01',
        skinId: 'base',
        wheelId: 'type_1',
        helmetId: 'helmet_1',
      );
      final spec = CarRenderSpec(config);
      expect(spec.helmetPath, 'assets/helmets/helmet_1.png');
    });

    test('returns null for helmet path when not present', () {
      final config = const CarConfig(
        carId: 'car_01',
        skinId: 'base',
        wheelId: 'type_1',
      );
      final spec = CarRenderSpec(config);
      expect(spec.helmetPath, null);
    });

    test('calculates wheel pixel offset correctly', () {
      final config = CarConfig.defaultConfig();
      final spec = CarRenderSpec(config);
      final renderSize = const Size(200, 100);

      final rearOffset = spec.rearWheelPixelOffset(renderSize);
      final frontOffset = spec.frontWheelPixelOffset(renderSize);

      expect(rearOffset.dx, closeTo(46.0, 0.1));  // 0.23 * 200
      expect(rearOffset.dy, closeTo(72.0, 0.1));  // 0.72 * 100
      expect(frontOffset.dx, closeTo(154.0, 0.1)); // 0.77 * 200
      expect(frontOffset.dy, closeTo(72.0, 0.1));  // 0.72 * 100
    });

    test('calculates wheel size proportionally', () {
      final config = CarConfig.defaultConfig();
      final spec = CarRenderSpec(config);
      final renderSize = const Size(200, 100);

      final wheelSize = spec.calculateWheelSize(renderSize);

      expect(wheelSize.width, 50.0);  // 200 * 0.25
      expect(wheelSize.height, 50.0);
    });

    test('rendering plan includes all required parts', () {
      final config = const CarConfig(
        carId: 'car_01',
        skinId: 'base',
        wheelId: 'type_1',
      );
      final spec = CarRenderSpec(config);
      final plan = spec.getRenderingPlan(const Size(200, 100));

      expect(plan['bodyPath'], isNotNull);
      expect(plan['bodySize'], isNotNull);
      expect(plan['rearWheel'], isNotNull);
      expect(plan['frontWheel'], isNotNull);
    });
  });
}
