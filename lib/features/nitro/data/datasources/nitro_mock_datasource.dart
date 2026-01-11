import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/nitro_level_model.dart';

abstract class NitroMockDataSource {
  Future<List<NitroLevelModel>> getNitroLevels(String carId);
}

class NitroMockDataSourceImpl implements NitroMockDataSource {
  static const String _mockDataPath = 'assets/mock_data/nitro_levels.json';

  @override
  Future<List<NitroLevelModel>> getNitroLevels(String carId) async {
    final jsonString = await rootBundle.loadString(_mockDataPath);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final levelsJson = jsonData['levels'] as List<dynamic>;

    return levelsJson
        .map((levelJson) =>
            NitroLevelModel.fromJson(levelJson as Map<String, dynamic>))
        .where((level) => level.carId == carId)
        .toList();
  }
}
