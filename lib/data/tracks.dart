import 'package:flutter/material.dart';
import '../models/track.dart';

final List<Track> allTracks = [
  // Track 1: City Streets - Starting track (free)
  const Track(
    id: 'city_streets',
    name: 'City Streets',
    description: 'Race through downtown traffic',
    difficulty: 1,
    unlockCost: 0, // Free - starting track
    roadColor: Color(0xFF333333),
    backgroundColor: Color(0xFF87CEEB), // Sky blue
    groundColor: Color(0xFF808080), // Gray sidewalk
    length: 1.0,
    aiDifficulty: 2,
    hasObstacles: false,
    obstacles: [],
  ),

  // Track 2: Desert Highway
  const Track(
    id: 'desert_highway',
    name: 'Desert Highway',
    description: 'Hot asphalt under the burning sun',
    difficulty: 2,
    unlockCost: 100,
    roadColor: Color(0xFF444444),
    backgroundColor: Color(0xFFFFD700), // Golden sky
    groundColor: Color(0xFFDEB887), // Sandy ground
    length: 1.2,
    aiDifficulty: 3,
    hasObstacles: true,
    obstacles: [
      Obstacle(xPosition: 0.3, type: ObstacleType.cone, lane: 0),
      Obstacle(xPosition: 0.5, type: ObstacleType.oilSpill, lane: 1),
      Obstacle(xPosition: 0.7, type: ObstacleType.cone, lane: 0),
    ],
  ),

  // Track 3: Mountain Pass
  const Track(
    id: 'mountain_pass',
    name: 'Mountain Pass',
    description: 'Dangerous curves in the mountains',
    difficulty: 3,
    unlockCost: 250,
    roadColor: Color(0xFF2C2C2C),
    backgroundColor: Color(0xFF4A90E2), // Mountain blue sky
    groundColor: Color(0xFF8B7355), // Rocky ground
    length: 1.5,
    aiDifficulty: 4,
    hasObstacles: true,
    obstacles: [
      Obstacle(xPosition: 0.2, type: ObstacleType.barrier, lane: 1),
      Obstacle(xPosition: 0.4, type: ObstacleType.pothole, lane: 0),
      Obstacle(xPosition: 0.6, type: ObstacleType.barrier, lane: 0),
      Obstacle(xPosition: 0.8, type: ObstacleType.oilSpill, lane: 1),
    ],
  ),

  // Track 4: Night City
  const Track(
    id: 'night_city',
    name: 'Night City',
    description: 'Neon lights and midnight racing',
    difficulty: 4,
    unlockCost: 400,
    roadColor: Color(0xFF1A1A1A),
    backgroundColor: Color(0xFF0D1117), // Dark night sky
    groundColor: Color(0xFF2D2D2D), // Dark ground
    length: 1.3,
    aiDifficulty: 4,
    hasObstacles: true,
    obstacles: [
      Obstacle(xPosition: 0.25, type: ObstacleType.cone, lane: 0),
      Obstacle(xPosition: 0.35, type: ObstacleType.cone, lane: 1),
      Obstacle(xPosition: 0.55, type: ObstacleType.oilSpill, lane: 0),
      Obstacle(xPosition: 0.75, type: ObstacleType.barrier, lane: 1),
    ],
  ),

  // Track 5: Beach Road
  const Track(
    id: 'beach_road',
    name: 'Beach Road',
    description: 'Ocean breeze and sandy shores',
    difficulty: 5,
    unlockCost: 600,
    roadColor: Color(0xFF555555),
    backgroundColor: Color(0xFF87CEFD), // Ocean blue
    groundColor: Color(0xFFFAE5B8), // Sandy beach
    length: 1.8,
    aiDifficulty: 5,
    hasObstacles: true,
    obstacles: [
      Obstacle(xPosition: 0.15, type: ObstacleType.pothole, lane: 0),
      Obstacle(xPosition: 0.3, type: ObstacleType.cone, lane: 1),
      Obstacle(xPosition: 0.45, type: ObstacleType.barrier, lane: 0),
      Obstacle(xPosition: 0.6, type: ObstacleType.oilSpill, lane: 1),
      Obstacle(xPosition: 0.75, type: ObstacleType.cone, lane: 0),
      Obstacle(xPosition: 0.9, type: ObstacleType.pothole, lane: 1),
    ],
  ),
];

// Helper function to get track by ID
Track? getTrackById(String id) {
  try {
    return allTracks.firstWhere((track) => track.id == id);
  } catch (e) {
    return null;
  }
}

// Helper function to get all unlocked tracks for a player
List<Track> getUnlockedTracks(Set<String> unlockedTrackIds) {
  return allTracks.where((track) => unlockedTrackIds.contains(track.id)).toList();
}

// Helper function to get all locked tracks for a player
List<Track> getLockedTracks(Set<String> unlockedTrackIds) {
  return allTracks.where((track) => !unlockedTrackIds.contains(track.id)).toList();
}
