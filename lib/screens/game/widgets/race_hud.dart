import 'package:flutter/material.dart';

import '../../../game/race_hud_controller.dart';
import '../../../ui/style/app_style.dart';
import '../../../ui/widgets/bordered_icon_button.dart';
import '../../../ui/widgets/token_chip.dart';
import 'race_controls.dart';
import 'race_status_panels.dart';

class RaceHud extends StatelessWidget {
  final RaceHudController hudController;
  final VoidCallback onBack;
  final VoidCallback onShiftUp;
  final VoidCallback onShiftDown;
  final VoidCallback onBrakeDown;
  final VoidCallback onBrakeUp;
  final VoidCallback onGasDown;
  final VoidCallback onGasUp;

  const RaceHud({
    super.key,
    required this.hudController,
    required this.onBack,
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
        final isWide = constraints.maxWidth > constraints.maxHeight;

        return Padding(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IgnorePointer(ignoring: true, child: _TopBar(onBack: onBack)),
              const SizedBox(height: AppSpacing.s),
              Expanded(
                flex: isWide ? 3 : 4,
                child: IgnorePointer(
                  ignoring: true,
                  child: isWide
                      ? Row(
                          children: [
                            Expanded(
                              child: RaceStatusPanels(
                                hudController: hudController,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.l),
                            const Expanded(child: SizedBox.shrink()),
                          ],
                        )
                      : RaceStatusPanels(hudController: hudController),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: isWide ? 3 : 4,
                child: RaceControls(
                  hudController: hudController,
                  onShiftUp: onShiftUp,
                  onShiftDown: onShiftDown,
                  onBrakeDown: onBrakeDown,
                  onBrakeUp: onBrakeUp,
                  onGasDown: onGasDown,
                  onGasUp: onGasUp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w800,
      letterSpacing: 0.2,
    );

    return Row(
      children: [
        BorderedIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text('RACE', style: titleStyle, maxLines: 1),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
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
