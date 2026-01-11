import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/shop_package.dart';

part 'shop_state.freezed.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState.initial() = _Initial;
  const factory ShopState.loading() = _Loading;
  const factory ShopState.loaded(List<ShopPackage> packages) = _Loaded;
  const factory ShopState.error(String message) = _Error;
  const factory ShopState.empty() = _Empty;
}
