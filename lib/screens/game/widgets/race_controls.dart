import 'package:flutter/material.dart';

import '../../../game/race_hud_controller.dart';
import '../../../ui/style/app_style.dart';
import 'race_text_banner.dart';

class RaceControls extends StatelessWidget {
  final RaceHudController hudController;
  final VoidCallback onShiftUp;
  final VoidCallback onShiftDown;
  final VoidCallback onBrakeDown;
  final VoidCallback onBrakeUp;
  final VoidCallback onGasDown;
  final VoidCallback onGasUp;

  const RaceControls({
    super.key,
    required this.hudController,
    required this.onShiftUp,
    required this.onShiftDown,
    required this.onBrakeDown,
    required this.onBrakeUp,
    required this.onGasDown,
    required this.onGasUp,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final controlsHeight = height * 0.28;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: hudController,
              builder: (context, state, _) {
                if (state.winnerText.isEmpty && state.countdownText.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.l),
                  child: RaceTextBanner(
                    countdownText: state.countdownText,
                    winnerText: state.winnerText,
                  ),
                );
              },
            ),
            SizedBox(
              height: controlsHeight,
              child: Row(
                children: [
                  Expanded(
                    child: _HoldCircleButton(
                      label: 'BRAKE',
                      color: Colors.red,
                      onDown: onBrakeDown,
                      onUp: onBrakeUp,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.l),
                  Expanded(
                    child: _GearButtons(onUp: onShiftUp, onDown: onShiftDown),
                  ),
                  const SizedBox(width: AppSpacing.l),
                  Expanded(
                    child: _HoldCircleButton(
                      label: 'GAS',
                      color: Colors.green,
                      onDown: onGasDown,
                      onUp: onGasUp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GearButtons extends StatelessWidget {
  final VoidCallback onUp;
  final VoidCallback onDown;

  const _GearButtons({required this.onUp, required this.onDown});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _TapCircleButton(
            icon: Icons.arrow_upward,
            color: AppColors.primary,
            onTap: onUp,
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        Expanded(
          child: _TapCircleButton(
            icon: Icons.arrow_downward,
            color: Colors.orange,
            onTap: onDown,
          ),
        ),
      ],
    );
  }
}

class _TapCircleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _TapCircleButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: onTap,
        child: _CircleSurface(
          color: color,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.5,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(icon, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HoldCircleButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onDown;
  final VoidCallback onUp;

  const _HoldCircleButton({
    required this.label,
    required this.color,
    required this.onDown,
    required this.onUp,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w800,
      letterSpacing: 0.3,
    );

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTapDown: (_) => onDown(),
        onTapUp: (_) => onUp(),
        onTapCancel: () => onUp(),
        child: _CircleSurface(
          color: color,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(label, style: textStyle, maxLines: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleSurface extends StatelessWidget {
  final Color color;
  final Widget child;

  const _CircleSurface({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.82),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: AppBorders.regular),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: AppSpacing.l,
            spreadRadius: AppSpacing.xxs,
          ),
        ],
      ),
      child: child,
    );
  }
}
