import 'package:equatable/equatable.dart';

class ShopPackage extends Equatable {
  final String id;
  final double coins;
  final double usdtPrice;
  final bool isBestChoice;

  const ShopPackage({
    required this.id,
    required this.coins,
    required this.usdtPrice,
    this.isBestChoice = false,
  });

  @override
  List<Object?> get props => [id, coins, usdtPrice, isBestChoice];
}
