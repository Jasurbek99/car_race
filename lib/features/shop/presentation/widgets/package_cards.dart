import 'package:flutter/material.dart';

import '../../../../ui/style/app_style.dart';
import '../../domain/entities/shop_package.dart';

class BestChoiceCard extends StatelessWidget {
  final ShopPackage package;
  final VoidCallback? onTap;

  const BestChoiceCard({super.key, required this.package, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.panel.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppRadii.l),
          border: Border.all(
            color: AppColors.border,
            width: AppBorders.regular,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final fontSize = (constraints.maxHeight * 0.08).clamp(10.0, 18.0);

            return Padding(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/coin.png',
                        width: fontSize * 1.2,
                        height: fontSize * 1.2,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            package.coins.toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize * 1.4,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  if (package.isBestChoice)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8A94C),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Best choise',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: fontSize * 0.7,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/icons/coins.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8A94C),
                      borderRadius: BorderRadius.circular(AppRadii.s),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/usdt.png',
                          width: fontSize,
                          height: fontSize,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          package.usdtPrice.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: fontSize,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CoinPackageCard extends StatelessWidget {
  final ShopPackage package;
  final VoidCallback? onTap;

  const CoinPackageCard({super.key, required this.package, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.panel.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppRadii.m),
          border: Border.all(
            color: AppColors.border,
            width: AppBorders.regular,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final fontSize = (constraints.maxHeight * 0.12).clamp(8.0, 14.0);

            return Padding(
              padding: const EdgeInsets.all(AppSpacing.s),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/coin.png',
                        width: fontSize,
                        height: fontSize,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            package.coins.toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Image.asset(
                        'assets/icons/coins.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8A94C),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/usdt.png',
                          width: fontSize * 0.9,
                          height: fontSize * 0.9,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          package.usdtPrice.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: fontSize * 0.9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
