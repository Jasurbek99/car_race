import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/account/presentation/pages/account_page.dart';
import 'features/garage/presentation/pages/garage_page.dart';
import 'features/nitro/presentation/pages/nitro_page.dart';
import 'features/shop/presentation/pages/shop_page.dart';
import 'screens/account/account_screen.dart';
import 'screens/game_screen.dart';
import 'screens/garage_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/nitro_screen.dart';
import 'screens/race_mode_screen.dart';
import 'screens/shop_screen.dart';
import 'ui/style/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: kDebugMode,
        builder: (context) => const CarRaceApp(),
      ),
    ),
  );
}

class CarRaceApp extends StatelessWidget {
  const CarRaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Race',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const MainMenuScreen(),
      routes: {
        // Old screens (for comparison)
        AccountScreen.routeName: (_) => const AccountScreen(),
        GameScreen.routeName: (_) => const GameScreen(),
        'race_mode': (_) => const RaceModeScreen(),
        GarageScreen.routeName: (_) => const GarageScreen(),
        NitroScreen.routeName: (_) => const NitroScreen(),
        ShopScreen.routeName: (_) => const ShopScreen(),
        // New clean architecture pages
        AccountPage.routeName: (_) => const AccountPage(),
        GaragePage.routeName: (_) => const GaragePage(),
        NitroPage.routeName: (_) => const NitroPage(),
        ShopPage.routeName: (_) => const ShopPage(),
      },
    );
  }
}
