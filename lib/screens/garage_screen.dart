import 'package:flutter/material.dart';

import '../ui/style/app_style.dart';
import '../ui/widgets/bordered_icon_button.dart';
import '../ui/widgets/token_chip.dart';
import 'nitro_screen.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  static const routeName = '/garage';

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  int _currentCarIndex = 0;

  final List<_GarageCar> _cars = const [
    _GarageCar(
      name: 'Toyota Highlinder Fortune V5',
      imagePath: 'assets/figma_design/resources/car_from_garage.png',
      stats: [
        _CarStat(label: 'Acceleration', value: 0.50, color: Color(0xFFFFCC00)),
        _CarStat(label: 'Motor', value: 1.00, color: Color(0xFF31B157)),
        _CarStat(label: 'Power', value: 0.60, color: Color(0xFFE2514A)),
        _CarStat(label: 'Nitro', value: 0.50, color: Color(0xFFFFCC00)),
        _CarStat(label: 'Design', value: 0.50, color: Color(0xFF9B7BFF)),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final car = _cars[_currentCarIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/figma_design/resources/garage_inside_background.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                children: [
                  _GarageTopBar(onBack: () => Navigator.maybePop(context)),
                  const SizedBox(height: AppSpacing.m),
                  Expanded(
                    child: _CarDisplaySection(
                      car: car,
                      onPrevious: () => _shiftCar(-1),
                      onNext: () => _shiftCar(1),
                      onStatTap: (stat) => _handleStatTap(stat),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shiftCar(int delta) {
    setState(() {
      _currentCarIndex =
          (_currentCarIndex + delta + _cars.length) % _cars.length;
    });
  }

  void _handleStatTap(_CarStat stat) {
    if (stat.label == 'Nitro') {
      Navigator.pushNamed(context, NitroScreen.routeName);
    }
  }
}

class _GarageTopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _GarageTopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BorderedIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: AppSpacing.m),
        const Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'Garage',
                maxLines: 1,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        const Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TokenChip(
                    iconAsset: 'assets/figma_design/resources/coin_icon.png',
                    value: '15145.45',
                    iconBackground: AppColors.primary,
                  ),
                  SizedBox(width: AppSpacing.s),
                  TokenChip(
                    iconAsset: 'assets/figma_design/resources/usdt_icon.png',
                    value: '1254.12',
                    iconBackground: AppColors.positive,
                  ),
                  SizedBox(width: AppSpacing.s),
                  BorderedIconButton(icon: Icons.settings_outlined),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CarDisplaySection extends StatelessWidget {
  final _GarageCar car;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final void Function(_CarStat stat) onStatTap;

  const _CarDisplaySection({
    required this.car,
    required this.onPrevious,
    required this.onNext,
    required this.onStatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              car.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Expanded(
          flex: 3,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.65,
                  heightFactor: 0.85,
                  child: Image.asset(car.imagePath, fit: BoxFit.contain),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _NavArrow(
                  icon: Icons.chevron_left,
                  onTap: onPrevious,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _NavArrow(
                  icon: Icons.chevron_right,
                  onTap: onNext,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Flexible(
          flex: 1,
          child: _StatsRow(stats: car.stats, onStatTap: onStatTap),
        ),
      ],
    );
  }
}

class _NavArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavArrow({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: Colors.white.withValues(alpha: 0.9),
        size: 48,
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final List<_CarStat> stats;
  final void Function(_CarStat stat) onStatTap;

  const _StatsRow({required this.stats, required this.onStatTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: GestureDetector(
              onTap: () => onStatTap(stat),
              child: _CircularStatGauge(stat: stat),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _CircularStatGauge extends StatefulWidget {
  final _CarStat stat;

  const _CircularStatGauge({required this.stat});

  @override
  State<_CircularStatGauge> createState() => _CircularStatGaugeState();
}

class _CircularStatGaugeState extends State<_CircularStatGauge> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight;
        final availableWidth = constraints.maxWidth;
        final iconSize = (availableHeight * 0.5).clamp(25.0, 60.0);
        final fontSize = (availableHeight * 0.14).clamp(8.0, 11.0);

        return GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          child: SizedBox(
            width: availableWidth,
            height: availableHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.stat.label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${(widget.stat.value * 100).toInt()}%',
                  style: TextStyle(
                    color: widget.stat.color,
                    fontSize: fontSize * 0.85,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      _isPressed
                          ? 'assets/figma_design/resources/brake_icon_active.png'
                          : 'assets/figma_design/resources/brake_icon.png',
                      width: iconSize,
                      height: iconSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class _GarageCar {
  final String name;
  final String imagePath;
  final List<_CarStat> stats;

  const _GarageCar({
    required this.name,
    required this.imagePath,
    required this.stats,
  });
}

class _CarStat {
  final String label;
  final double value;
  final Color color;

  const _CarStat({
    required this.label,
    required this.value,
    required this.color,
  });
}
