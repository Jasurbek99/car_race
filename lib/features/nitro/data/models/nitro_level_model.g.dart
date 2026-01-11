// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nitro_level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NitroLevelModel _$NitroLevelModelFromJson(Map<String, dynamic> json) =>
    NitroLevelModel(
      id: json['id'] as String,
      level: (json['level'] as num).toInt(),
      percentage: (json['percentage'] as num).toInt(),
      price: (json['price'] as num?)?.toDouble(),
      isOwned: json['isOwned'] as bool,
      carId: json['carId'] as String,
    );

Map<String, dynamic> _$NitroLevelModelToJson(NitroLevelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'percentage': instance.percentage,
      'price': instance.price,
      'isOwned': instance.isOwned,
      'carId': instance.carId,
    };
