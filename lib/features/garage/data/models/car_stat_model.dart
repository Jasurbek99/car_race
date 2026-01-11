import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/car_stat.dart';

part 'car_stat_model.g.dart';

@JsonSerializable()
class CarStatModel {
  final String label;
  final double value;
  final String colorHex;

  const CarStatModel({
    required this.label,
    required this.value,
    required this.colorHex,
  });

  factory CarStatModel.fromJson(Map<String, dynamic> json) =>
      _$CarStatModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarStatModelToJson(this);

  CarStat toEntity() {
    return CarStat(
      label: label,
      value: value,
      color: Color(int.parse(colorHex)),
    );
  }

  factory CarStatModel.fromEntity(CarStat entity) {
    return CarStatModel(
      label: entity.label,
      value: entity.value,
      colorHex: '0x${entity.color.toARGB32().toRadixString(16).padLeft(8, '0')}',
    );
  }
}
