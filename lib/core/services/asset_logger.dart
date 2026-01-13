import 'package:flutter/foundation.dart';

/// Centralized logging for asset loading issues
class AssetLogger {
  AssetLogger._();

  static void logAssetLoadSuccess(String assetPath, String componentType) {
    if (kDebugMode) {
      debugPrint('[ASSET SUCCESS] $componentType loaded: $assetPath');
    }
  }

  static void logAssetLoadFailure(
    String assetPath,
    String componentType,
    Object error,
    StackTrace? stackTrace,
  ) {
    debugPrint('=' * 70);
    debugPrint('[ASSET ERROR] Failed to load $componentType');
    debugPrint('Path: $assetPath');
    debugPrint('Error: $error');
    if (stackTrace != null) {
      debugPrint('Stack trace:');
      debugPrint(stackTrace.toString());
    }
    debugPrint('=' * 70);
  }

  static void logCarLoadAttempt(String carId, String skinId, String wheelId) {
    if (kDebugMode) {
      debugPrint(
        '[CAR LOAD] Attempting to load: car=$carId, skin=$skinId, wheel=$wheelId',
      );
    }
  }
}
