import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/race_hud_controller.dart';
import '../game/race_game.dart';
import 'game/widgets/race_hud.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  static const routeName = '/game';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final RaceHudController _hudController;
  late final RaceGame _game;

  @override
  void initState() {
    super.initState();
    _hudController = RaceHudController();
    _game = RaceGame(hudController: _hudController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: GameWidget(game: _game)),
          Positioned.fill(
            child: SafeArea(
              child: RaceHud(
                hudController: _hudController,
                onBack: () => Navigator.maybePop(context),
                onBrakeDown: _game.onBrakePressed,
                onBrakeUp: _game.onBrakeReleased,
                onGasDown: _game.onGasPressed,
                onGasUp: _game.onGasReleased,
                onShiftUp: _game.onShiftUp,
                onShiftDown: _game.onShiftDown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
