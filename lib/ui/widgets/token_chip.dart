import 'package:flutter/material.dart';

import '../style/app_style.dart';

class TokenChip extends StatelessWidget {
  final String iconAsset;
  final String value;
  final Color iconBackground;

  const TokenChip({
    super.key,
    required this.iconAsset,
    required this.value,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.panel.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(AppRadii.m),
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
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.m,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.s),
                child: SizedBox.square(
                  dimension: AppSpacing.l,
                  child: Image.asset(iconAsset, fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Flexible(
              child: Text(
                value,
                style: valueStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.s),
            const Icon(Icons.add, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
