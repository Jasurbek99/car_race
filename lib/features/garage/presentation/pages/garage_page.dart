import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../screens/account/account_constants.dart';
import '../../../../ui/style/app_style.dart';
import '../../../../ui/widgets/bordered_icon_button.dart';
import '../../../../ui/widgets/token_chip.dart';
import '../../domain/entities/garage_car.dart';
import '../providers/garage_providers.dart';
import '../widgets/car_display_section.dart';

class GaragePage extends ConsumerWidget {
  const GaragePage({super.key});

  static const routeName = '/garage-new';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final garageState = ref.watch(garageNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/backgrounds/garage_inside_background.png', 
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                children: [
                  _GarageTopBar(onBack: () => Navigator.maybePop(context)),
                  const SizedBox(height: AppSpacing.m),
                  Expanded(
                    child: garageState.when(
                      initial: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loaded: (cars) => _LoadedContent(cars: cars),
                      error: (message) => _ErrorContent(
                        message: message,
                        onRetry: () =>
                            ref.read(garageNotifierProvider.notifier).retry(),
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

class _GarageTopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _GarageTopBar({required this.onBack});

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
                'Garage',
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

class _LoadedContent extends StatefulWidget {
  final List<GarageCar> cars;

  const _LoadedContent({required this.cars});

  @override
  State<_LoadedContent> createState() => _LoadedContentState();
}

class _LoadedContentState extends State<_LoadedContent> {
  int _currentCarIndex = 0;

  @override
  Widget build(BuildContext context) {
    final car = widget.cars[_currentCarIndex];

    return CarDisplaySection(
      car: car,
      onPrevious: () => _shiftCar(-1),
      onNext: () => _shiftCar(1),
    );
  }

  void _shiftCar(int delta) {
    setState(() {
      _currentCarIndex =
          (_currentCarIndex + delta + widget.cars.length) % widget.cars.length;
    });
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
            Icons.garage_outlined,
            size: 64,
            color: Colors.white54,
          ),
          SizedBox(height: AppSpacing.m),
          Text(
            'No cars in garage',
            style: TextStyle(color: Colors.white54, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
