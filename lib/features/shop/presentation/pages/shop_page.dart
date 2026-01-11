import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../screens/account/account_constants.dart';
import '../../../../ui/style/app_style.dart';
import '../../../../ui/widgets/bordered_icon_button.dart';
import '../../../../ui/widgets/token_chip.dart';
import '../../domain/entities/shop_package.dart';
import '../providers/shop_providers.dart';
import '../widgets/package_cards.dart';

class ShopPage extends ConsumerWidget {
  const ShopPage({super.key});

  static const routeName = '/shop-new';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopState = ref.watch(shopNotifierProvider);

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
                  Expanded(
                    child: shopState.when(
                      initial: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loaded: (packages) => _LoadedContent(packages: packages),
                      error: (message) => _ErrorContent(
                        message: message,
                        onRetry: () =>
                            ref.read(shopNotifierProvider.notifier).retry(),
                      ),
                      empty: () => const _EmptyContent(),
                    ),
                  ),
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
                    iconAsset: AccountAssets.coinIcon,
                    value: '15145.45',
                    iconBackground: AppColors.primary,
                  ),
                  SizedBox(width: AppSpacing.s),
                  TokenChip(
                    iconAsset: AccountAssets.usdtIcon,
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

class _LoadedContent extends StatelessWidget {
  final List<ShopPackage> packages;

  const _LoadedContent({required this.packages});

  @override
  Widget build(BuildContext context) {
    final bestChoice = packages.firstWhere(
      (p) => p.isBestChoice,
      orElse: () => packages.first,
    );
    final regularPackages = packages.where((p) => !p.isBestChoice).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: BestChoiceCard(
                package: bestChoice,
                onTap: () {},
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (regularPackages.isNotEmpty)
                          Expanded(
                            child: CoinPackageCard(
                              package: regularPackages[0],
                              onTap: () {},
                            ),
                          ),
                        if (regularPackages.length > 1) ...[
                          const SizedBox(width: AppSpacing.s),
                          Expanded(
                            child: CoinPackageCard(
                              package: regularPackages[1],
                              onTap: () {},
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (regularPackages.length > 2) ...[
                    const SizedBox(height: AppSpacing.s),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CoinPackageCard(
                              package: regularPackages[2],
                              onTap: () {},
                            ),
                          ),
                          if (regularPackages.length > 3) ...[
                            const SizedBox(width: AppSpacing.s),
                            Expanded(
                              child: CoinPackageCard(
                                package: regularPackages[3],
                                onTap: () {},
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorContent({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            'Error: $message',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.l),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: Colors.white54,
          ),
          SizedBox(height: AppSpacing.m),
          Text(
            'No packages available',
            style: TextStyle(color: Colors.white54, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
