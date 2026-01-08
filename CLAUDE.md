# Car Race Game

## Project Overview
A Flutter-based side-view car racing game where two cars compete on a track.

## Game Features
- **Two Cars Racing**:
  - User-controlled car (with gas and brake buttons)
  - Bot-controlled car (AI opponent)
- **Side View Perspective**: Cars race horizontally across the screen
- **Simple Controls**: Gas button to accelerate, brake button to slow down
- **Car Assets**: Car images stored in assets folder

## Technical Stack
- **Framework**: Flutter
- **Platform**: Android (configured for Kotlin)
- **Language**: Dart

## Project Structure
- `/lib/main.dart` - Main entry point
- `/assets/` - Car images and game assets
- `/android/` - Android platform configuration

## How to Run
```bash
flutter pub get
flutter run
```

## Development Notes
- Side-view racing game (horizontal scrolling)
- User controls one car with gas/brake buttons
- Bot car uses simple AI logic to race
- Game uses Flutter's animation framework for smooth movement
