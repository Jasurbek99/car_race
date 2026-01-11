import 'package:equatable/equatable.dart';

import 'car_stat.dart';

class GarageCar extends Equatable {
  final String id;
  final String name;
  final String imagePath;
  final List<CarStat> stats;

  const GarageCar({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.stats,
  });

  @override
  List<Object?> get props => [id, name, imagePath, stats];
}
