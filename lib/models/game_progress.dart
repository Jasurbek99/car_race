import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GameProgress {
  int totalWins;
  int totalLosses;
  int currency; // Earned from winning races
  Set<String> unlockedTracks;
  Set<String> unlockedCars;
  String selectedCar;
  Map<String, int> trackBestTimes; // track ID -> time in milliseconds

  GameProgress({
    required this.totalWins,
    required this.totalLosses,
    required this.currency,
    required this.unlockedTracks,
    required this.unlockedCars,
    required this.selectedCar,
    required this.trackBestTimes,
  });

  // Create default progress for new players
  factory GameProgress.defaultProgress() {
    return GameProgress(
      totalWins: 0,
      totalLosses: 0,
      currency: 0,
      unlockedTracks: {'city_streets'}, // First track is unlocked
      unlockedCars: {'mini'}, // First car is unlocked
      selectedCar: 'mini',
      trackBestTimes: {},
    );
  }

  // Save to SharedPreferences
  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'totalWins': totalWins,
      'totalLosses': totalLosses,
      'currency': currency,
      'unlockedTracks': unlockedTracks.toList(),
      'unlockedCars': unlockedCars.toList(),
      'selectedCar': selectedCar,
      'trackBestTimes': trackBestTimes,
    };
    await prefs.setString('game_progress', jsonEncode(data));
  }

  // Load from SharedPreferences
  static Future<GameProgress> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('game_progress');

    if (jsonString == null) {
      // Return default progress for new players
      return GameProgress.defaultProgress();
    }

    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      return GameProgress.fromJson(data);
    } catch (e) {
      // If there's an error loading, return default progress
      return GameProgress.defaultProgress();
    }
  }

  // Convert from JSON
  factory GameProgress.fromJson(Map<String, dynamic> json) {
    return GameProgress(
      totalWins: json['totalWins'] as int? ?? 0,
      totalLosses: json['totalLosses'] as int? ?? 0,
      currency: json['currency'] as int? ?? 0,
      unlockedTracks: (json['unlockedTracks'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toSet() ??
          {'city_streets'},
      unlockedCars: (json['unlockedCars'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toSet() ??
          {'mini'},
      selectedCar: json['selectedCar'] as String? ?? 'mini',
      trackBestTimes: (json['trackBestTimes'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, value as int)) ??
          {},
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'totalWins': totalWins,
        'totalLosses': totalLosses,
        'currency': currency,
        'unlockedTracks': unlockedTracks.toList(),
        'unlockedCars': unlockedCars.toList(),
        'selectedCar': selectedCar,
        'trackBestTimes': trackBestTimes,
      };

  // Add a win and reward currency
  void addWin(int reward) {
    totalWins++;
    currency += reward;
  }

  // Add a loss
  void addLoss() {
    totalLosses++;
  }

  // Unlock a track
  bool unlockTrack(String trackId, int cost) {
    if (currency >= cost && !unlockedTracks.contains(trackId)) {
      currency -= cost;
      unlockedTracks.add(trackId);
      return true;
    }
    return false;
  }

  // Unlock a car
  bool unlockCar(String carId, int cost) {
    if (currency >= cost && !unlockedCars.contains(carId)) {
      currency -= cost;
      unlockedCars.add(carId);
      return true;
    }
    return false;
  }

  // Select a car (must be unlocked)
  bool selectCar(String carId) {
    if (unlockedCars.contains(carId)) {
      selectedCar = carId;
      return true;
    }
    return false;
  }

  // Update best time for a track
  void updateBestTime(String trackId, int timeMs) {
    if (!trackBestTimes.containsKey(trackId) ||
        timeMs < trackBestTimes[trackId]!) {
      trackBestTimes[trackId] = timeMs;
    }
  }

  // Get best time for a track (returns null if no time recorded)
  int? getBestTime(String trackId) {
    return trackBestTimes[trackId];
  }
}
