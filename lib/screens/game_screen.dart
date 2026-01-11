import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game/race_hud_controller.dart';
import '../game/race_game.dart';
import '../features/car/application/providers/car_selection_provider.dart';
import '../features/car/domain/entities/car_config.dart';
import 'game/widgets/race_hud.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  static const routeName = '/game';

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late final RaceHudController _hudController;
  RaceGame? _game;

  @override
  void initState() {
    super.initState();
    _hudController = RaceHudController();
    _initGame();
  }

  Future<void> _initGame() async {
    // Read selected car from provider
    final selectedCarAsync = ref.read(carSelectionProvider);
    CarConfig? selectedCar;

    await selectedCarAsync.when(
      data: (config) {
        selectedCar = config;
        debugPrint('GameScreen: Loading race with selected car: $config');
      },
      loading: () {
        debugPrint('GameScreen: Car selection loading...');
      },
      error: (error, stack) {
        debugPrint('GameScreen: Error loading car selection: $error');
      },
    );

    if (mounted) {
      setState(() {
        _game = RaceGame(
          hudController: _hudController,
          playerCarConfig: selectedCar,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_game == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: GameWidget(game: _game!)),
          Positioned.fill(
            child: SafeArea(
              child: RaceHud(
                hudController: _hudController,
                onBack: () => Navigator.maybePop(context),
                onBrakeDown: _game!.onBrakePressed,
                onBrakeUp: _game!.onBrakeReleased,
                onGasDown: _game!.onGasPressed,
                onGasUp: _game!.onGasReleased,
                onShiftUp: _game!.onShiftUp,
                onShiftDown: _game!.onShiftDown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
