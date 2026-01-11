import 'package:flutter/material.dart';

import '../../../../ui/style/app_style.dart';
import '../../domain/entities/garage_car.dart';
import '../../domain/entities/car_stat.dart';
import '../../../car/presentation/widgets/modular_car_preview.dart';
import '../../../car/domain/entities/car_config.dart';

class CarDisplaySection extends StatelessWidget {
  final GarageCar car;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const CarDisplaySection({
    super.key,
    required this.car,
    required this.onPrevious,
    required this.onNext,
  });

  /// Build car preview - uses modular system if car ID maps to modular car
  Widget _buildCarPreview(GarageCar car) {
    // Map garage car IDs to modular car configs
    // This provides a migration path from old imagePath to new modular system
    final carConfig = _getModularConfigForCar(car.id);

    if (carConfig != null) {
      return ModularCarPreview(
        config: carConfig,
        width: 300,
        height: 150,
        fit: BoxFit.contain,
      );
    }

    // Fallback to old image-based preview
    return Image.asset(car.imagePath, fit: BoxFit.contain);
  }

  /// Map garage car IDs to modular car configs
  CarConfig? _getModularConfigForCar(String carId) {
    switch (carId) {
      case '1':
        return const CarConfig(carId: 'car_01', skinId: 'base', wheelId: 'type_1');
      case '2':
        return const CarConfig(carId: 'car_02', skinId: 'base', wheelId: 'type_2');
      case '3':
        return const CarConfig(carId: 'car_03', skinId: 'base', wheelId: 'type_3');
      case '4':
        return const CarConfig(carId: 'car_04', skinId: 'base', wheelId: 'type_4');
      case '5':
        return const CarConfig(carId: 'car_05', skinId: 'base', wheelId: 'type_5');
      default:
        return null; // Use fallback image
    }
  }

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
                  child: _buildCarPreview(car),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _NavArrow(icon: Icons.chevron_left, onTap: onPrevious),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _NavArrow(icon: Icons.chevron_right, onTap: onNext),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Flexible(flex: 1, child: _StatsRow(stats: car.stats)),
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
      child: Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 48),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final List<CarStat> stats;

  const _StatsRow({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: _CircularStatGauge(stat: stat),
          ),
        );
      }).toList(),
    );
  }
}

class _CircularStatGauge extends StatefulWidget {
  final CarStat stat;

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
                          ? 'assets/icons/brake_icon_active.png'
                          : 'assets/icons/brake_icon.png',
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
