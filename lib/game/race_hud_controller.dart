import 'package:flutter/foundation.dart';

import 'race_game.dart';

@immutable
class RaceHudState {
  final GameState gameState;
  final int playerProgressPercent;
  final int aiProgressPercent;
  final int speedKmh;
  final int gear;
  final int maxGears;
  final String countdownText;
  final String winnerText;

  const RaceHudState({
    required this.gameState,
    required this.playerProgressPercent,
    required this.aiProgressPercent,
    required this.speedKmh,
    required this.gear,
    required this.maxGears,
    required this.countdownText,
    required this.winnerText,
  });

  factory RaceHudState.initial() => const RaceHudState(
    gameState: GameState.ready,
    playerProgressPercent: 0,
    aiProgressPercent: 0,
    speedKmh: 0,
    gear: 1,
    maxGears: 5,
    countdownText: 'TAP TO START',
    winnerText: '',
  );

  RaceHudState copyWith({
    GameState? gameState,
    int? playerProgressPercent,
    int? aiProgressPercent,
    int? speedKmh,
    int? gear,
    int? maxGears,
    String? countdownText,
    String? winnerText,
  }) {
    return RaceHudState(
      gameState: gameState ?? this.gameState,
      playerProgressPercent:
          playerProgressPercent ?? this.playerProgressPercent,
      aiProgressPercent: aiProgressPercent ?? this.aiProgressPercent,
      speedKmh: speedKmh ?? this.speedKmh,
      gear: gear ?? this.gear,
      maxGears: maxGears ?? this.maxGears,
      countdownText: countdownText ?? this.countdownText,
      winnerText: winnerText ?? this.winnerText,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RaceHudState &&
        other.gameState == gameState &&
        other.playerProgressPercent == playerProgressPercent &&
        other.aiProgressPercent == aiProgressPercent &&
        other.speedKmh == speedKmh &&
        other.gear == gear &&
        other.maxGears == maxGears &&
        other.countdownText == countdownText &&
        other.winnerText == winnerText;
  }

  @override
  int get hashCode => Object.hash(
    gameState,
    playerProgressPercent,
    aiProgressPercent,
    speedKmh,
    gear,
    maxGears,
    countdownText,
    winnerText,
  );
}

class RaceHudController extends ValueNotifier<RaceHudState> {
  RaceHudController() : super(RaceHudState.initial());
}
