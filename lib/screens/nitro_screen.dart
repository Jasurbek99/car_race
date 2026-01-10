import 'package:flutter/material.dart';

import '../ui/style/app_style.dart';
import '../ui/widgets/bordered_icon_button.dart';
import '../ui/widgets/token_chip.dart';

class NitroScreen extends StatefulWidget {
  const NitroScreen({super.key});

  static const routeName = '/nitro';

  @override
  State<NitroScreen> createState() => _NitroScreenState();
}

class _NitroScreenState extends State<NitroScreen> {
  int _selectedLevel = 2;

  final List<_NitroLevel> _levels = const [
    _NitroLevel(level: 1, percentage: 10, price: null, isOwned: true),
    _NitroLevel(level: 2, percentage: 10, price: null, isOwned: true),
    _NitroLevel(level: 3, percentage: 10, price: 100.00, isOwned: false),
    _NitroLevel(level: 4, percentage: 10, price: 200.00, isOwned: false),
    _NitroLevel(level: 5, percentage: 10, price: 300.00, isOwned: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/figma_design/resources/garage_inside_background.png',
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
                    onHome: () => Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Expanded(
                    child: _NitroContent(
                      levels: _levels,
                      selectedLevel: _selectedLevel,
                      onLevelSelected: (index) {
                        setState(() => _selectedLevel = index);
                      },
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
        BorderedIconButton(
          icon: Icons.home_outlined,
          onTap: onHome,
        ),
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
                    iconAsset: 'assets/figma_design/resources/coin_icon.png',
                    value: '15145.45',
                    iconBackground: AppColors.primary,
                  ),
                  SizedBox(width: AppSpacing.s),
                  TokenChip(
                    iconAsset: 'assets/figma_design/resources/usdt_icon.png',
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

class _NitroContent extends StatelessWidget {
  final List<_NitroLevel> levels;
  final int selectedLevel;
  final void Function(int index) onLevelSelected;

  const _NitroContent({
    required this.levels,
    required this.selectedLevel,
    required this.onLevelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Toyota Highlinder Fortune V5',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
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
                'assets/figma_design/resources/car_from_garage.png',
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
                  child: _NitroLevelCard(
                    level: levels[index],
                    isSelected: index == selectedLevel,
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

class _NitroLevelCard extends StatelessWidget {
  final _NitroLevel level;
  final bool isSelected;
  final VoidCallback onTap;

  const _NitroLevelCard({
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
                        'assets/figma_design/resources/nitro_icon.png',
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
                              'assets/figma_design/resources/coin_icon.png',
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


class _NitroLevel {
  final int level;
  final int percentage;
  final double? price;
  final bool isOwned;

  const _NitroLevel({
    required this.level,
    required this.percentage,
    required this.price,
    required this.isOwned,
  });
}
