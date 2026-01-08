import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/account_screen.dart';
import 'screens/game_screen.dart';
import 'screens/garage_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/race_mode_screen.dart';

import 'ui/style/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      theme: buildAppTheme(),
      home: const MainMenuScreen(),
      routes: {
        AccountScreen.routeName: (_) => const AccountScreen(),
        GameScreen.routeName: (_) => const GameScreen(),
        'race_mode': (_) => const RaceModeScreen(),
        GarageScreen.routeName: (_) => const GarageScreen(),
      },
    );
  }
}
