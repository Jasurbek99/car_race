import 'package:equatable/equatable.dart';

class NitroLevel extends Equatable {
  final String id;
  final int level;
  final int percentage;
  final double? price;
  final bool isOwned;
  final String carId;

  const NitroLevel({
    required this.id,
    required this.level,
    required this.percentage,
    this.price,
    required this.isOwned,
    required this.carId,
  });

  @override
  List<Object?> get props => [id, level, percentage, price, isOwned, carId];
}
