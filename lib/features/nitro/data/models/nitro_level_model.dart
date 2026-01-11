import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/nitro_level.dart';

part 'nitro_level_model.g.dart';

@JsonSerializable()
class NitroLevelModel {
  final String id;
  final int level;
  final int percentage;
  final double? price;
  final bool isOwned;
  final String carId;

  const NitroLevelModel({
    required this.id,
    required this.level,
    required this.percentage,
    this.price,
    required this.isOwned,
    required this.carId,
  });

  factory NitroLevelModel.fromJson(Map<String, dynamic> json) =>
      _$NitroLevelModelFromJson(json);

  Map<String, dynamic> toJson() => _$NitroLevelModelToJson(this);

  NitroLevel toEntity() {
    return NitroLevel(
      id: id,
      level: level,
      percentage: percentage,
      price: price,
      isOwned: isOwned,
      carId: carId,
    );
  }

  factory NitroLevelModel.fromEntity(NitroLevel entity) {
    return NitroLevelModel(
      id: entity.id,
      level: entity.level,
      percentage: entity.percentage,
      price: entity.price,
      isOwned: entity.isOwned,
      carId: entity.carId,
    );
  }
}
