// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage_car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GarageCarModel _$GarageCarModelFromJson(Map<String, dynamic> json) =>
    GarageCarModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
      stats: (json['stats'] as List<dynamic>)
          .map((e) => CarStatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GarageCarModelToJson(GarageCarModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imagePath': instance.imagePath,
      'stats': instance.stats.map((e) => e.toJson()).toList(),
    };
