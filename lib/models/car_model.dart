class CarModel {
  final String id;
  final String name;
  final String bodyPath;
  final String tirePath;
  final int unlockCost;
  final CarStats stats;

  const CarModel({
    required this.id,
    required this.name,
    required this.bodyPath,
    required this.tirePath,
    required this.unlockCost,
    required this.stats,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'bodyPath': bodyPath,
        'tirePath': tirePath,
        'unlockCost': unlockCost,
        'stats': stats.toJson(),
      };

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json['id'] as String,
        name: json['name'] as String,
        bodyPath: json['bodyPath'] as String,
        tirePath: json['tirePath'] as String,
        unlockCost: json['unlockCost'] as int,
        stats: CarStats.fromJson(json['stats'] as Map<String, dynamic>),
      );
}

class CarStats {
  final double baseAcceleration; // Multiplier: 0.8 - 1.5
  final double baseMaxSpeed; // Multiplier: 0.8 - 1.5
  final double handling; // Future: affects lane switching
  final int gearCount; // 4 or 5 gears

  const CarStats({
    required this.baseAcceleration,
    required this.baseMaxSpeed,
    required this.handling,
    required this.gearCount,
  });

  Map<String, dynamic> toJson() => {
        'baseAcceleration': baseAcceleration,
        'baseMaxSpeed': baseMaxSpeed,
        'handling': handling,
        'gearCount': gearCount,
      };

  factory CarStats.fromJson(Map<String, dynamic> json) => CarStats(
        baseAcceleration: (json['baseAcceleration'] as num).toDouble(),
        baseMaxSpeed: (json['baseMaxSpeed'] as num).toDouble(),
        handling: (json['handling'] as num).toDouble(),
        gearCount: json['gearCount'] as int,
      );
}
