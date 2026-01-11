import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/style/app_style.dart';
import '../../../../ui/widgets/bordered_icon_button.dart';
import '../../../../ui/widgets/token_chip.dart';
import '../../domain/entities/nitro_level.dart';
import '../providers/nitro_providers.dart';
import '../widgets/nitro_level_card.dart';

class NitroPage extends ConsumerWidget {
  const NitroPage({super.key});

  static const routeName = '/nitro-new';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nitroState = ref.watch(nitroNotifierProvider);

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
                  _NitroTopBar(
                    onBack: () => Navigator.maybePop(context),
                    onHome: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Expanded(
                    child: nitroState.when(
                      initial: () =>
                          const Center(child: CircularProgressIndicator()),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      loaded: (levels, selectedIndex) => _LoadedContent(
                        levels: levels,
                        selectedIndex: selectedIndex,
                        onLevelSelected: (index) {
                          ref
                              .read(nitroNotifierProvider.notifier)
                              .selectLevel(index);
                        },
                      ),
                      error: (message) => _ErrorContent(
                        message: message,
                        onRetry: () =>
                            ref.read(nitroNotifierProvider.notifier).retry(),
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

class _NitroTopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onHome;

  const _NitroTopBar({required this.onBack, required this.onHome});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BorderedIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: AppSpacing.s),
        BorderedIconButton(icon: Icons.home_outlined, onTap: onHome),
        const SizedBox(width: AppSpacing.m),
        const Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'Nitro',
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

class _LoadedContent extends StatelessWidget {
  final List<NitroLevel> levels;
  final int selectedIndex;
  final void Function(int index) onLevelSelected;

  const _LoadedContent({
    required this.levels,
    required this.selectedIndex,
    required this.onLevelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Toyota Highlinder Fortune V5',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Expanded(
          flex: 3,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.55,
              heightFactor: 0.85,
              child: Image.asset(
                'assets/full_cars/toyota.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Flexible(
          flex: 1,
          child: Row(
            children: List.generate(levels.length, (index) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxs,
                  ),
                  child: NitroLevelCard(
                    level: levels[index],
                    isSelected: index == selectedIndex,
                    onTap: () => onLevelSelected(index),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
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
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: AppSpacing.m),
          Text(
            'Error: $message',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.l),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
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
          Icon(Icons.speed_outlined, size: 64, color: Colors.white54),
          SizedBox(height: AppSpacing.m),
          Text(
            'No nitro levels available',
            style: TextStyle(color: Colors.white54, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
