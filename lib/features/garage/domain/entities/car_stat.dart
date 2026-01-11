import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CarStat extends Equatable {
  final String label;
  final double value;
  final Color color;

  const CarStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  List<Object?> get props => [label, value, color];
}
