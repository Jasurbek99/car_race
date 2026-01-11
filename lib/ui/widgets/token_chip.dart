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
          horizontal: AppSpacing.m,
          vertical: AppSpacing.s,
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
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: SizedBox.square(
                  dimension: AppSpacing.m,
                  child: Image.asset(iconAsset, fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.s),
            Flexible(
              child: Text(
                value,
                style: valueStyle?.copyWith(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(Icons.add, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}
