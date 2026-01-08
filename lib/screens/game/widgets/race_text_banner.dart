import 'package:flutter/material.dart';

import '../../../ui/style/app_style.dart';

class RaceTextBanner extends StatelessWidget {
  final String countdownText;
  final String winnerText;

  const RaceTextBanner({
    super.key,
    required this.countdownText,
    required this.winnerText,
  });

  @override
  Widget build(BuildContext context) {
    final isWinner = winnerText.isNotEmpty;
    final label = isWinner ? winnerText : countdownText;

    final textStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
      fontWeight: FontWeight.w900,
      color: isWinner ? Colors.greenAccent : Colors.redAccent,
      letterSpacing: 0.3,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: FractionallySizedBox(
            widthFactor: constraints.maxWidth.isFinite ? 0.92 : null,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.panelAlt.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(AppRadii.xl),
                border: Border.all(
                  color: AppColors.border,
                  width: AppBorders.regular,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: AppSpacing.xl,
                    offset: const Offset(0, AppSpacing.s),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.m,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: textStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
