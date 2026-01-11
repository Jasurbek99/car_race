import 'package:flutter_test/flutter_test.dart';
import 'package:car_race/core/utils/math_utils.dart';
import 'dart:ui';

void main() {
  group('MathUtils', () {
    test('lerp interpolates correctly', () {
      expect(MathUtils.lerp(0, 100, 0.5), 50.0);
      expect(MathUtils.lerp(0, 100, 0.0), 0.0);
      expect(MathUtils.lerp(0, 100, 1.0), 100.0);
    });

    test('clamp restricts values', () {
      expect(MathUtils.clamp(50, 0, 100), 50.0);
      expect(MathUtils.clamp(-10, 0, 100), 0.0);
      expect(MathUtils.clamp(150, 0, 100), 100.0);
    });

    test('normalizedToPixel converts coordinates', () {
      final result = MathUtils.normalizedToPixel(
        const Offset(0.5, 0.5),
        const Size(100, 200),
      );
      expect(result.dx, 50.0);
      expect(result.dy, 100.0);
    });

    test('pixelToNormalized converts coordinates', () {
      final result = MathUtils.pixelToNormalized(
        const Offset(50, 100),
        const Size(100, 200),
      );
      expect(result.dx, 0.5);
      expect(result.dy, 0.5);
    });

    test('mapRange maps values correctly', () {
      expect(MathUtils.mapRange(50, 0, 100, 0, 1), 0.5);
      expect(MathUtils.mapRange(0, 0, 100, 0, 1), 0.0);
      expect(MathUtils.mapRange(100, 0, 100, 0, 1), 1.0);
    });
  });
}
