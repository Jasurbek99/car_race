import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/garage_car.dart';

part 'garage_state.freezed.dart';

@freezed
class GarageState with _$GarageState {
  const factory GarageState.initial() = _Initial;
  const factory GarageState.loading() = _Loading;
  const factory GarageState.loaded(List<GarageCar> cars) = _Loaded;
  const factory GarageState.error(String message) = _Error;
  const factory GarageState.empty() = _Empty;
}
