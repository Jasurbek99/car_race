import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/entities/car_config.dart';
import '../../domain/repositories/car_selection_repository.dart';

/// SharedPreferences implementation of CarSelectionRepository
class CarSelectionRepositorySP implements CarSelectionRepository {
  static const String _keySelectedCar = 'selected_car_config';

  final SharedPreferences _prefs;

  CarSelectionRepositorySP(this._prefs);

  @override
  Future<CarConfig?> getSelectedCar() async {
    try {
      final jsonString = _prefs.getString(_keySelectedCar);
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return CarConfig.fromJson(json);
    } catch (e) {
      // If there's any error parsing, return null
      return null;
    }
  }

  @override
  Future<void> saveSelectedCar(CarConfig config) async {
    final jsonString = jsonEncode(config.toJson());
    await _prefs.setString(_keySelectedCar, jsonString);
  }

  @override
  Future<void> clearSelectedCar() async {
    await _prefs.remove(_keySelectedCar);
  }
}
