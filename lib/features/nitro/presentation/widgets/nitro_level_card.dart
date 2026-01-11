import 'package:flutter/material.dart';

import '../../../../ui/style/app_style.dart';
import '../../domain/entities/nitro_level.dart';

class NitroLevelCard extends StatelessWidget {
  final NitroLevel level;
  final bool isSelected;
  final VoidCallback onTap;

  const NitroLevelCard({
    super.key,
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.panel.withValues(alpha: 0.95)
              : AppColors.panelAlt.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(AppRadii.s),
          border: Border.all(
            color: isSelected ? AppColors.border : Colors.transparent,
            width: AppBorders.regular,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxs),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableHeight = constraints.maxHeight;
              final gaugeSize = (availableHeight * 0.35).clamp(15.0, 45.0);
              final fontSize = (availableHeight * 0.14).clamp(6.0, 10.0);

              return FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nitro Lv ${level.level}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        '${level.percentage} %',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: fontSize * 0.85,
                        ),
                      ),
                      Image.asset(
                        'assets/icons/nitro_icon.png',
                        width: gaugeSize,
                        height: gaugeSize,
                        fit: BoxFit.contain,
                      ),
                      if (isSelected && level.isOwned)
                        Text(
                          'Selected',
                          style: TextStyle(
                            color: AppColors.positive,
                            fontSize: fontSize * 0.9,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      else if (level.price != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/icons/coin.png',
                              width: fontSize,
                              height: fontSize,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              level.price!.toStringAsFixed(2),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize * 0.9,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        )
                      else
                        SizedBox(height: fontSize),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
