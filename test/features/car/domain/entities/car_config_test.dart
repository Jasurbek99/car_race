import 'package:flutter_test/flutter_test.dart';
import 'package:car_race/features/car/domain/entities/car_config.dart';

void main() {
  group('CarConfig', () {
    test('creates default config', () {
      final config = CarConfig.defaultConfig();
      expect(config.carId, 'car_01');
      expect(config.skinId, 'base');
      expect(config.wheelId, 'type_1');
      expect(config.helmetId, null);
    });

    test('toJson serializes correctly', () {
      final config = const CarConfig(
        carId: 'car_03',
        skinId: 'green',
        wheelId: 'type_2',
        helmetId: 'helmet_1',
      );
      final json = config.toJson();
      expect(json['carId'], 'car_03');
      expect(json['skinId'], 'green');
      expect(json['wheelId'], 'type_2');
      expect(json['helmetId'], 'helmet_1');
    });

    test('fromJson deserializes correctly', () {
      final json = {
        'carId': 'car_03',
        'skinId': 'green',
        'wheelId': 'type_2',
        'helmetId': 'helmet_1',
      };
      final config = CarConfig.fromJson(json);
      expect(config.carId, 'car_03');
      expect(config.skinId, 'green');
      expect(config.wheelId, 'type_2');
      expect(config.helmetId, 'helmet_1');
    });

    test('fromJson handles missing optional fields', () {
      final json = {
        'carId': 'car_01',
        'skinId': 'base',
        'wheelId': 'type_1',
      };
      final config = CarConfig.fromJson(json);
      expect(config.helmetId, null);
    });

    test('copyWith creates modified copy', () {
      final original = const CarConfig(
        carId: 'car_01',
        skinId: 'base',
        wheelId: 'type_1',
      );
      final modified = original.copyWith(skinId: 'green');
      expect(modified.carId, 'car_01');
      expect(modified.skinId, 'green');
      expect(modified.wheelId, 'type_1');
    });
  });
}
