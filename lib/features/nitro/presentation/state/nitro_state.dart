import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/nitro_level.dart';

part 'nitro_state.freezed.dart';

@freezed
class NitroState with _$NitroState {
  const factory NitroState.initial() = _Initial;
  const factory NitroState.loading() = _Loading;
  const factory NitroState.loaded({
    required List<NitroLevel> levels,
    required int selectedLevelIndex,
  }) = _Loaded;
  const factory NitroState.error(String message) = _Error;
  const factory NitroState.empty() = _Empty;
}
