import 'package:flutter/material.dart';

enum ObstacleType { pothole, oilSpill, barrier, cone }

class Obstacle {
  final double xPosition; // Relative to track length (0.0-1.0)
  final ObstacleType type;
  final int lane; // 0 = top lane, 1 = bottom lane

  const Obstacle({
    required this.xPosition,
    required this.type,
    required this.lane,
  });

  Map<String, dynamic> toJson() => {
        'xPosition': xPosition,
        'type': type.toString(),
        'lane': lane,
      };

  factory Obstacle.fromJson(Map<String, dynamic> json) => Obstacle(
        xPosition: (json['xPosition'] as num).toDouble(),
        type: ObstacleType.values.firstWhere(
          (e) => e.toString() == json['type'],
        ),
        lane: json['lane'] as int,
      );
}

class Track {
  final String id;
  final String name;
  final String description;
  final int difficulty; // 1-5 stars
  final int unlockCost; // Currency needed
  final Color roadColor;
  final Color backgroundColor;
  final Color groundColor;
  final double length; // Multiplier for finishLineX (1.0 = normal, 1.5 = 50% longer)
  final int aiDifficulty; // AI aggressiveness 1-5
  final bool hasObstacles;
  final List<Obstacle> obstacles;

  const Track({
    required this.id,
    required this.name,
    required this.description,
    required this.difficulty,
    required this.unlockCost,
    required this.roadColor,
    required this.backgroundColor,
    required this.groundColor,
    required this.length,
    required this.aiDifficulty,
    required this.hasObstacles,
    required this.obstacles,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'difficulty': difficulty,
        'unlockCost': unlockCost,
        'roadColor': roadColor.toARGB32(),
        'backgroundColor': backgroundColor.toARGB32(),
        'groundColor': groundColor.toARGB32(),
        'length': length,
        'aiDifficulty': aiDifficulty,
        'hasObstacles': hasObstacles,
        'obstacles': obstacles.map((o) => o.toJson()).toList(),
      };

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        difficulty: json['difficulty'] as int,
        unlockCost: json['unlockCost'] as int,
        roadColor: Color(json['roadColor'] as int),
        backgroundColor: Color(json['backgroundColor'] as int),
        groundColor: Color(json['groundColor'] as int),
        length: (json['length'] as num).toDouble(),
        aiDifficulty: json['aiDifficulty'] as int,
        hasObstacles: json['hasObstacles'] as bool,
        obstacles: (json['obstacles'] as List)
            .map((o) => Obstacle.fromJson(o as Map<String, dynamic>))
            .toList(),
      );
}
