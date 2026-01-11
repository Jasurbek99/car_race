import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/garage_car_model.dart';

abstract class GarageMockDataSource {
  Future<List<GarageCarModel>> getGarageCars();
  Future<GarageCarModel> getCarById(String id);
}

class GarageMockDataSourceImpl implements GarageMockDataSource {
  static const String _mockDataPath = 'assets/mock_data/garage_cars.json';

  @override
  Future<List<GarageCarModel>> getGarageCars() async {
    try {
      final jsonString = await rootBundle.loadString(_mockDataPath);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final carsJson = jsonData['cars'] as List<dynamic>;

      return carsJson
          .map((carJson) =>
              GarageCarModel.fromJson(carJson as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load garage cars: $e');
    }
  }

  @override
  Future<GarageCarModel> getCarById(String id) async {
    final cars = await getGarageCars();
    return cars.firstWhere(
      (car) => car.id == id,
      orElse: () => throw Exception('Car with id $id not found'),
    );
  }
}
