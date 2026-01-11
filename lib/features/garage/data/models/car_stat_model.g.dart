// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_stat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarStatModel _$CarStatModelFromJson(Map<String, dynamic> json) => CarStatModel(
  label: json['label'] as String,
  value: (json['value'] as num).toDouble(),
  colorHex: json['colorHex'] as String,
);

Map<String, dynamic> _$CarStatModelToJson(CarStatModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'colorHex': instance.colorHex,
    };
