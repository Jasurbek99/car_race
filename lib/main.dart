import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/account_screen.dart';
import 'screens/game_screen.dart';
import 'screens/main_menu_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const CarRaceApp());
}

class CarRaceApp extends StatelessWidget {
  const CarRaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Race',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5C5BD6)),
      ),
      home: const MainMenuScreen(),
      routes: {
        AccountScreen.routeName: (_) => const AccountScreen(),
        GameScreen.routeName: (_) => const GameScreen(),
      },
    );
  }
}
