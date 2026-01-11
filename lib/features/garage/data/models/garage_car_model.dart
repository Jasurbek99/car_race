import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/garage_car.dart';
import 'car_stat_model.dart';

part 'garage_car_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GarageCarModel {
  final String id;
  final String name;
  final String imagePath;
  final List<CarStatModel> stats;

  const GarageCarModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.stats,
  });

  factory GarageCarModel.fromJson(Map<String, dynamic> json) =>
      _$GarageCarModelFromJson(json);

  Map<String, dynamic> toJson() => _$GarageCarModelToJson(this);

  GarageCar toEntity() {
    return GarageCar(
      id: id,
      name: name,
      imagePath: imagePath,
      stats: stats.map((stat) => stat.toEntity()).toList(),
    );
  }

  factory GarageCarModel.fromEntity(GarageCar entity) {
    return GarageCarModel(
      id: entity.id,
      name: entity.name,
      imagePath: entity.imagePath,
      stats: entity.stats.map((stat) => CarStatModel.fromEntity(stat)).toList(),
    );
  }
}
