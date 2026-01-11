// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopPackageModel _$ShopPackageModelFromJson(Map<String, dynamic> json) =>
    ShopPackageModel(
      id: json['id'] as String,
      coins: (json['coins'] as num).toDouble(),
      usdtPrice: (json['usdtPrice'] as num).toDouble(),
      isBestChoice: json['isBestChoice'] as bool? ?? false,
    );

Map<String, dynamic> _$ShopPackageModelToJson(ShopPackageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coins': instance.coins,
      'usdtPrice': instance.usdtPrice,
      'isBestChoice': instance.isBestChoice,
    };
