import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/shop_package.dart';

part 'shop_package_model.g.dart';

@JsonSerializable()
class ShopPackageModel {
  final String id;
  final double coins;
  final double usdtPrice;
  final bool isBestChoice;

  const ShopPackageModel({
    required this.id,
    required this.coins,
    required this.usdtPrice,
    this.isBestChoice = false,
  });

  factory ShopPackageModel.fromJson(Map<String, dynamic> json) =>
      _$ShopPackageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopPackageModelToJson(this);

  ShopPackage toEntity() {
    return ShopPackage(
      id: id,
      coins: coins,
      usdtPrice: usdtPrice,
      isBestChoice: isBestChoice,
    );
  }

  factory ShopPackageModel.fromEntity(ShopPackage entity) {
    return ShopPackageModel(
      id: entity.id,
      coins: entity.coins,
      usdtPrice: entity.usdtPrice,
      isBestChoice: entity.isBestChoice,
    );
  }
}
