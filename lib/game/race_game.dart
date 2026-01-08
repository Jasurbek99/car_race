import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/car.dart';

enum GameState { ready, racing, finished }

class RaceGame extends FlameGame with TapCallbacks, KeyboardEvents {
  late Car playerCar;
  late Car aiCar;

  GameState gameState = GameState.ready;

  double finishLineX = 0; // Will be set in onLoad
  String? winner;

  // Road components
  late RectangleComponent road;
  late RectangleComponent roadDivider;
  List<RectangleComponent> roadMarkers = [];
  late RectangleComponent finishLine;

  // UI
  late TextComponent distanceText;
  late TextComponent speedText;
  late TextComponent gearText;
  late TextComponent countdownText;
  late TextComponent winnerText;

  double countdownTimer = 3;
  bool countdownComplete = false;

  // Background scroll
  double roadOffset = 0;

  @override
  Future<void> onLoad() async {
    // Set up sky background
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF87CEEB),
    ));

    // Ground
    add(RectangleComponent(
      position: Vector2(0, size.y * 0.7),
      size: Vector2(size.x, size.y * 0.3),
      paint: Paint()..color = const Color(0xFF228B22),
    ));

    // Road
    road = RectangleComponent(
      position: Vector2(0, size.y * 0.45),
      size: Vector2(size.x, size.y * 0.35),
      paint: Paint()..color = const Color(0xFF333333),
    );
    add(road);

    // Road lane divider
    roadDivider = RectangleComponent(
      position: Vector2(0, size.y * 0.62),
      size: Vector2(size.x, 4),
      paint: Paint()..color = Colors.white,
    );
    add(roadDivider);

    // Add road markers
    for (int i = 0; i < 10; i++) {
      final marker = RectangleComponent(
        position: Vector2(i * (size.x / 5), size.y * 0.62),
        size: Vector2(size.x / 10, 4),
        paint: Paint()..color = Colors.yellow,
      );
      roadMarkers.add(marker);
      add(marker);
    }

    // Set finish line position (90% of screen width)
    finishLineX = size.x * 0.9;

    // Add finish line visual (checkered flag pattern)
    finishLine = RectangleComponent(
      position: Vector2(finishLineX, size.y * 0.45),
      size: Vector2(10, size.y * 0.35),
      paint: Paint()..color = Colors.white,
    );
    add(finishLine);

    // Add checkered pattern to finish line
    for (int i = 0; i < 7; i++) {
      add(RectangleComponent(
        position: Vector2(finishLineX, size.y * 0.45 + (i * size.y * 0.05)),
        size: Vector2(10, size.y * 0.025),
        paint: Paint()..color = i.isEven ? Colors.black : Colors.white,
      ));
    }

    // Car sizes
    final carSize = Vector2(size.x * 0.2, size.y * 0.12);

    // Player car (bottom lane) - using mini car
    playerCar = Car(
      carBodyPath: 'mini/car-body.png',
      tirePath: 'mini/tire.png',
      position: Vector2(size.x * 0.1, size.y * 0.65),
      size: carSize,
      carColor: Colors.blue,
    );
    add(playerCar);

    // AI car (top lane) - using car1
    aiCar = Car(
      carBodyPath: 'car1/car-body.png',
      tirePath: 'car1/tire.png',
      position: Vector2(size.x * 0.1, size.y * 0.48),
      size: carSize,
      carColor: Colors.red,
    );
    add(aiCar);

    // UI elements
    distanceText = TextComponent(
      text: 'RACE TO THE FINISH!',
      position: Vector2(20, 20),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(distanceText);

    speedText = TextComponent(
      text: 'Speed: 0 km/h',
      position: Vector2(20, 50),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(speedText);

    gearText = TextComponent(
      text: 'Gear: 1/5',
      position: Vector2(size.x - 120, 20),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(gearText);

    countdownText = TextComponent(
      text: 'TAP TO START',
      position: Vector2(size.x / 2, size.y / 3),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.red,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(countdownText);

    winnerText = TextComponent(
      text: '',
      position: Vector2(size.x / 2, size.y / 2.5),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.green,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(winnerText);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameState == GameState.racing) {
      if (!countdownComplete) {
        countdownTimer -= dt;
        if (countdownTimer > 0) {
          countdownText.text = countdownTimer.ceil().toString();
        } else {
          countdownText.text = 'GO!';
          countdownComplete = true;
        }
        return;
      }

      if (countdownText.text == 'GO!') {
        Future.delayed(const Duration(milliseconds: 500), () {
          countdownText.text = '';
        });
      }

      // AI car behavior - random acceleration
      final random = Random();
      if (random.nextDouble() > 0.3) {
        aiCar.accelerate();
      } else {
        aiCar.brake();
      }

      // Move cars forward based on their speed
      playerCar.position.x += playerCar.speed * dt;
      aiCar.position.x += aiCar.speed * dt;

      // Update road markers for scrolling effect
      final avgSpeed = (playerCar.speed + aiCar.speed) / 2;
      roadOffset += avgSpeed * dt * 0.5;

      for (int i = 0; i < roadMarkers.length; i++) {
        roadMarkers[i].position.x -= avgSpeed * dt * 0.5;
        if (roadMarkers[i].position.x < -size.x / 10) {
          roadMarkers[i].position.x = size.x;
        }
      }

      // Update UI
      final playerProgress = ((playerCar.position.x / finishLineX) * 100).clamp(0, 100).toInt();
      final aiProgress = ((aiCar.position.x / finishLineX) * 100).clamp(0, 100).toInt();
      distanceText.text = 'You: $playerProgress% | AI: $aiProgress%';
      speedText.text = 'Speed: ${(playerCar.speed * 3.6).toInt()} km/h';
      gearText.text = 'Gear: ${playerCar.getCurrentGear()}/${playerCar.maxGears}';

      // Check for winner - first car to reach finish line wins
      if (playerCar.position.x >= finishLineX && aiCar.position.x < finishLineX) {
        gameState = GameState.finished;
        winner = 'YOU WIN!';
        winnerText.text = winner!;
        winnerText.textRenderer = TextPaint(
          style: const TextStyle(
            color: Colors.green,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        );
        countdownText.text = 'TAP TO RESTART';
        playerCar.brake();
        aiCar.brake();
      } else if (aiCar.position.x >= finishLineX && playerCar.position.x < finishLineX) {
        gameState = GameState.finished;
        winner = 'AI WINS!';
        winnerText.text = winner!;
        winnerText.textRenderer = TextPaint(
          style: const TextStyle(
            color: Colors.red,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        );
        countdownText.text = 'TAP TO RESTART';
        playerCar.brake();
        aiCar.brake();
      } else if (playerCar.position.x >= finishLineX && aiCar.position.x >= finishLineX) {
        // Both crossed at the same time - it's a tie!
        gameState = GameState.finished;
        winner = 'TIE!';
        winnerText.text = winner!;
        winnerText.textRenderer = TextPaint(
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        );
        countdownText.text = 'TAP TO RESTART';
        playerCar.brake();
        aiCar.brake();
      }
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (gameState == GameState.ready) {
      gameState = GameState.racing;
      countdownTimer = 3;
      countdownComplete = false;
    } else if (gameState == GameState.racing && countdownComplete) {
      playerCar.accelerate();
    } else if (gameState == GameState.finished) {
      resetGame();
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (gameState == GameState.racing && countdownComplete) {
      playerCar.brake();
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (gameState == GameState.ready &&
        event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.space) {
      gameState = GameState.racing;
      countdownTimer = 3;
      countdownComplete = false;
      return KeyEventResult.handled;
    }

    if (gameState == GameState.racing && countdownComplete) {
      if (event is KeyDownEvent &&
          event.logicalKey == LogicalKeyboardKey.space) {
        playerCar.accelerate();
        return KeyEventResult.handled;
      }
      if (event is KeyUpEvent && event.logicalKey == LogicalKeyboardKey.space) {
        playerCar.brake();
        return KeyEventResult.handled;
      }
      // Gear shifting with arrow keys
      if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.arrowUp) {
        playerCar.shiftUp();
        return KeyEventResult.handled;
      }
      if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.arrowDown) {
        playerCar.shiftDown();
        return KeyEventResult.handled;
      }
    }

    if (gameState == GameState.finished &&
        event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.space) {
      resetGame();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void resetGame() {
    gameState = GameState.ready;
    playerCar.reset();
    aiCar.reset();
    winner = null;
    winnerText.text = '';
    countdownText.text = 'TAP TO START';
    countdownTimer = 3;
    countdownComplete = false;

    // Reset car positions
    playerCar.position.x = size.x * 0.1;
    aiCar.position.x = size.x * 0.1;

    // Reset road markers
    for (int i = 0; i < roadMarkers.length; i++) {
      roadMarkers[i].position.x = i * (size.x / 5);
    }
  }

  // Button control methods
  void onGasPressed() {
    if (gameState == GameState.ready) {
      gameState = GameState.racing;
      countdownTimer = 3;
      countdownComplete = false;
    } else if (gameState == GameState.racing && countdownComplete) {
      playerCar.accelerate();
    } else if (gameState == GameState.finished) {
      resetGame();
    }
  }

  void onGasReleased() {
    if (gameState == GameState.racing && countdownComplete) {
      playerCar.stopAccelerating();
    }
  }

  void onBrakePressed() {
    if (gameState == GameState.racing && countdownComplete) {
      playerCar.activeBrake();
    }
  }

  void onBrakeReleased() {
    if (gameState == GameState.racing && countdownComplete) {
      playerCar.stopBraking();
    }
  }

  // Gear control methods
  void onShiftUp() {
    if (gameState == GameState.racing && countdownComplete) {
      playerCar.shiftUp();
    }
  }

  void onShiftDown() {
    if (gameState == GameState.racing && countdownComplete) {
      playerCar.shiftDown();
    }
  }
}

