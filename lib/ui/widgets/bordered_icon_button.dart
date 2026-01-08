import 'package:flutter/material.dart';

import '../style/app_style.dart';

class BorderedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const BorderedIconButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final content = DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.panel.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppRadii.s),
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
        padding: const EdgeInsets.all(AppSpacing.m),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );

    if (onTap == null) return content;
    return GestureDetector(onTap: onTap, child: content);
  }
}
