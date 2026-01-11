import 'package:flutter/material.dart';

import '../ui/style/app_style.dart';
import '../ui/widgets/bordered_icon_button.dart';
import '../ui/widgets/token_chip.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  static const routeName = '/shop';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/figma_design/shop_background.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.5),
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                children: [
                  _ShopTopBar(onBack: () => Navigator.maybePop(context)),
                  const SizedBox(height: AppSpacing.m),
                  const Expanded(child: _ShopContent()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShopTopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _ShopTopBar({required this.onBack});

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
                'Shop',
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
                    iconAsset: 'assets/icons/coin.png',
                    value: '15145.45',
                    iconBackground: AppColors.primary,
                  ),
                  SizedBox(width: AppSpacing.s),
                  TokenChip(
                    iconAsset: 'assets/icons/usdt.png',
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

class _ShopContent extends StatelessWidget {
  const _ShopContent();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            // Left side - Best choice card
            Expanded(
              flex: 2,
              child: _BestChoiceCard(
                coins: 10000.45,
                usdtPrice: 20.00,
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            // Right side - 2x2 grid of smaller cards
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _CoinPackageCard(
                            coins: 1000.45,
                            usdtPrice: 10.00,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s),
                        Expanded(
                          child: _CoinPackageCard(
                            coins: 1000.45,
                            usdtPrice: 15.00,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _CoinPackageCard(
                            coins: 1000.45,
                            usdtPrice: 2.00,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s),
                        Expanded(
                          child: _CoinPackageCard(
                            coins: 1000.45,
                            usdtPrice: 5.00,
                          ),
                        ),
                      ],
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

class _BestChoiceCard extends StatelessWidget {
  final double coins;
  final double usdtPrice;

  const _BestChoiceCard({
    required this.coins,
    required this.usdtPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.panel.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppRadii.l),
          border: Border.all(color: AppColors.border, width: AppBorders.regular),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final fontSize = (constraints.maxHeight * 0.08).clamp(10.0, 18.0);

            return Padding(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coin amount with icon
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
                            coins.toStringAsFixed(2),
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
                  // Best choice badge
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
                  // Coins image
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/icons/coins.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Price button
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
                          usdtPrice.toStringAsFixed(2),
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

class _CoinPackageCard extends StatelessWidget {
  final double coins;
  final double usdtPrice;

  const _CoinPackageCard({
    required this.coins,
    required this.usdtPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.panel.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppRadii.m),
          border: Border.all(color: AppColors.border, width: AppBorders.regular),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final fontSize = (constraints.maxHeight * 0.12).clamp(8.0, 14.0);

            return Padding(
              padding: const EdgeInsets.all(AppSpacing.s),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Coin amount with icon
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
                            coins.toStringAsFixed(2),
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
                  // Coins image
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Image.asset(
                        'assets/icons/coins.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Price button
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
                          usdtPrice.toStringAsFixed(2),
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
