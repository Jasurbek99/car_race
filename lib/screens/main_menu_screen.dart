import 'package:car_race/screens/garage_screen.dart';
import 'package:car_race/screens/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_screen.dart';
import 'game_screen.dart';

class MainMenuScreen extends StatelessWidget {
  static const routeName = '/';

  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    final textTheme = GoogleFonts.unboundedTextTheme(
      baseTheme.textTheme,
    ).apply(bodyColor: Colors.white, displayColor: Colors.white);

    return Theme(
      data: baseTheme.copyWith(textTheme: textTheme),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.asset(
                'assets/images/main_screen/background.png',
                fit: BoxFit.cover,
              ),
              // Dark overlay to match Figma contrast
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.55),
                      Colors.black.withValues(alpha: 0.50),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _TopBar(),
                          SizedBox(height: constraints.maxHeight * 0.03),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: FractionallySizedBox(
                                      heightFactor: 0.92,
                                      widthFactor: 0.9,
                                      alignment: Alignment.bottomLeft,
                                      child: Image.asset(
                                        'assets/images/main_screen/car.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: constraints.maxWidth * 0.02),
                                Flexible(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: constraints.maxWidth * 0.44,
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: constraints.maxWidth * 0.44,
                                          child: _MenuButtons(
                                            onAccount: () =>
                                                Navigator.pushNamed(
                                                  context,
                                                  AccountScreen.routeName,
                                                ),
                                            onGoRace: () => Navigator.pushNamed(
                                              context,
                                              GameScreen.routeName,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'MAIN MENU',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Flexible(
          child: Wrap(
            alignment: WrapAlignment.end,
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              _TokenChip(
                icon: Icons.currency_bitcoin_rounded,
                value: '15145.45',
                background: Color(0xFF222447),
                iconBackground: Color(0xFF6362D9),
              ),
              _TokenChip(
                icon: Icons.token_rounded,
                value: '1254.12',
                background: Color(0xFF222447),
                iconBackground: Color(0xFF3AC182),
              ),
              _BorderedIconButton(icon: Icons.settings_outlined),
            ],
          ),
        ),
      ],
    );
  }
}

class _TokenChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color background;
  final Color iconBackground;

  const _TokenChip({
    required this.icon,
    required this.value,
    required this.background,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: background.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF0F6BB7), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: iconBackground,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.add, color: Colors.white, size: 28),
        ],
      ),
    );
  }
}

class _BorderedIconButton extends StatelessWidget {
  final IconData icon;

  const _BorderedIconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF222447).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF0F6BB7), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}

class _MenuButtons extends StatelessWidget {
  final VoidCallback onAccount;
  final VoidCallback onGoRace;

  const _MenuButtons({required this.onAccount, required this.onGoRace});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _NavButton(
          text: 'Shop',
          onTap: () {
            Navigator.pushNamed(context, ShopScreen.routeName);
          },
        ),
        const SizedBox(height: 18),
        _NavButton(
          text: 'Garage',
          onTap: () {
            Navigator.pushNamed(context, GarageScreen.routeName);
          },
        ),
        const SizedBox(height: 18),
        _NavButton(text: 'Account', onTap: onAccount),
        const SizedBox(height: 24),
        _NavButton(text: 'GO RACE!', onTap: onGoRace, isPrimary: true),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isPrimary;

  const _NavButton({
    required this.text,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = const Color(0xFF0F6BB7);
    final baseColor = const Color(0xFF26263D);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? const LinearGradient(
                  colors: [Color(0xFF6C6AD9), Color(0xFF5655D6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isPrimary ? null : baseColor.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
