import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/shop_package_model.dart';

abstract class ShopMockDataSource {
  Future<List<ShopPackageModel>> getShopPackages();
  Future<ShopPackageModel> getPackageById(String id);
}

class ShopMockDataSourceImpl implements ShopMockDataSource {
  static const String _mockDataPath = 'assets/mock_data/shop_packages.json';

  @override
  Future<List<ShopPackageModel>> getShopPackages() async {
    final jsonString = await rootBundle.loadString(_mockDataPath);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final packagesJson = jsonData['packages'] as List<dynamic>;

    return packagesJson
        .map((packageJson) =>
            ShopPackageModel.fromJson(packageJson as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ShopPackageModel> getPackageById(String id) async {
    final packages = await getShopPackages();
    return packages.firstWhere(
      (package) => package.id == id,
      orElse: () => throw Exception('Package with id $id not found'),
    );
  }
}
