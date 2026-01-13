import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// Diagnostic utility to verify asset availability
class AssetDiagnostic {
  AssetDiagnostic._();

  /// Check if an asset exists and can be loaded
  static Future<bool> assetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Verify all car assets for a given configuration
  static Future<Map<String, bool>> verifyCarAssets({
    required String carId,
    required String skinId,
    required String wheelId,
  }) async {
    final results = <String, bool>{};

    final bodyPath = 'assets/cars/$carId/$skinId.png';
    final wheelPath = 'assets/cars/wheels/$wheelId.png';

    results[bodyPath] = await assetExists(bodyPath);
    results[wheelPath] = await assetExists(wheelPath);

    return results;
  }

  /// Print diagnostic report for car assets
  static Future<void> printAssetReport({
    required String carId,
    required String skinId,
    required String wheelId,
  }) async {
    debugPrint('=' * 70);
    debugPrint('ASSET DIAGNOSTIC REPORT');
    debugPrint('Car ID: $carId, Skin: $skinId, Wheel: $wheelId');
    debugPrint('-' * 70);

    final results = await verifyCarAssets(
      carId: carId,
      skinId: skinId,
      wheelId: wheelId,
    );

    results.forEach((path, exists) {
      final status = exists ? '✓ EXISTS' : '✗ MISSING';
      debugPrint('$status: $path');
    });

    debugPrint('=' * 70);
  }
}
