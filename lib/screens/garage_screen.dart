import 'package:flutter/material.dart';

import '../ui/style/app_style.dart';
import '../ui/widgets/bordered_icon_button.dart';
import '../ui/widgets/token_chip.dart';

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
      imagePath: 'assets/images/main_screen/car.png',
      stats: [
        _CarStat(label: 'Acceleration', value: 0.65, color: Color(0xFFFFCC00)),
        _CarStat(label: 'Motor', value: 1.00, color: Color(0xFF31B157)),
        _CarStat(label: 'Power', value: 0.6, color: Color(0xFFE2514A)),
        _CarStat(label: 'Nitro', value: 0.5, color: Color(0xFFFFCC00)),
        _CarStat(label: 'Design', value: 0.8, color: Color(0xFF9B7BFF)),
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0B193B), Color(0xFF090B11)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                children: [
                  _GarageTopBar(onBack: () => Navigator.maybePop(context)),
                  const SizedBox(height: AppSpacing.l),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide =
                            constraints.maxWidth > constraints.maxHeight;
                        final carPanel = _CarDisplay(
                          car: car,
                          onPrevious: () => _shiftCar(-1),
                          onNext: () => _shiftCar(1),
                        );
                        final statsPanel = _CarStatsPanel(car: car);

                        if (isWide) {
                          return Row(
                            children: [
                              Expanded(child: carPanel),
                              const SizedBox(width: AppSpacing.l),
                              Expanded(child: statsPanel),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            Expanded(flex: 6, child: carPanel),
                            const SizedBox(height: AppSpacing.l),
                            Expanded(flex: 5, child: statsPanel),
                          ],
                        );
                      },
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
                    iconAsset: 'assets/images/icons/coin.png',
                    value: '15145.45',
                    iconBackground: AppColors.primary,
                  ),
                  SizedBox(width: AppSpacing.s),
                  TokenChip(
                    iconAsset: 'assets/images/icons/usdt.png',
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

class _CarDisplay extends StatelessWidget {
  final _GarageCar car;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _CarDisplay({
    required this.car,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.panel.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(AppRadii.l),
        border: Border.all(color: AppColors.border, width: AppBorders.regular),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: AppSpacing.xl,
            offset: const Offset(0, AppSpacing.s),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                car.name,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final arrowSize = constraints.maxWidth * 0.12;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        heightFactor: 0.9,
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(car.imagePath, fit: BoxFit.contain),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: onPrevious,
                          child: Container(
                            width: arrowSize,
                            height: arrowSize,
                            decoration: BoxDecoration(
                              color: AppColors.panelAlt.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.border,
                                width: AppBorders.regular,
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: onNext,
                          child: Container(
                            width: arrowSize,
                            height: arrowSize,
                            decoration: BoxDecoration(
                              color: AppColors.panelAlt.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.border,
                                width: AppBorders.regular,
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarStatsPanel extends StatelessWidget {
  final _GarageCar car;

  const _CarStatsPanel({required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.panelAlt.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(AppRadii.l),
              border: Border.all(
                color: AppColors.border,
                width: AppBorders.regular,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: AppSpacing.xl,
                  offset: const Offset(0, AppSpacing.s),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: ListView.separated(
                itemCount: car.stats.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.m),
                itemBuilder: (context, index) {
                  final stat = car.stats[index];
                  return _StatTile(stat: stat);
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C6AD9), Color(0xFF5655D6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppRadii.m),
              border: Border.all(
                color: AppColors.border,
                width: AppBorders.regular,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: AppSpacing.xl,
                  offset: const Offset(0, AppSpacing.s),
                ),
              ],
            ),
            child: const Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Select',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final _CarStat stat;

  const _StatTile({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                stat.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.s),
            Text(
              '${(stat.value * 100).toInt()}%',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: stat.color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.s),
          child: SizedBox(
            height: AppSpacing.m,
            child: LinearProgressIndicator(
              value: stat.value.clamp(0, 1),
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: AlwaysStoppedAnimation<Color>(stat.color),
            ),
          ),
        ),
      ],
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
