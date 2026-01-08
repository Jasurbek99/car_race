import 'package:flutter/material.dart';

import '../../../game/race_hud_controller.dart';
import '../../../ui/style/app_style.dart';

class RaceStatusPanels extends StatelessWidget {
  final RaceHudController hudController;

  const RaceStatusPanels({super.key, required this.hudController});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: hudController,
      builder: (context, state, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final gap = height < 260 ? AppSpacing.m : AppSpacing.l;

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        child: _HudCard(
                          title: 'SPEED',
                          value: '${state.speedKmh}',
                          suffix: 'km/h',
                        ),
                      ),
                      SizedBox(width: gap),
                      Expanded(
                        child: _HudCard(
                          title: 'GEAR',
                          value: '${state.gear}',
                          suffix: '/${state.maxGears}',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: gap),
                Flexible(
                  flex: 4,
                  child: _ProgressCard(
                    playerPercent: state.playerProgressPercent,
                    aiPercent: state.aiProgressPercent,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _HudCard extends StatelessWidget {
  final String title;
  final String value;
  final String suffix;

  const _HudCard({
    required this.title,
    required this.value,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
      color: AppColors.textMuted,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.3,
    );

    final valueStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900);

    final suffixStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w800,
      color: AppColors.textMuted,
    );

    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(value, style: valueStyle, maxLines: 1),
                ),
              ),
              const SizedBox(width: AppSpacing.s),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomLeft,
                  child: Text(suffix, style: suffixStyle, maxLines: 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final int playerPercent;
  final int aiPercent;

  const _ProgressCard({required this.playerPercent, required this.aiPercent});

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800);

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final rowGap = height < 180 ? AppSpacing.m : AppSpacing.l;
        final smallGap = height < 180 ? AppSpacing.xs : AppSpacing.s;

        return _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'YOU',
                      style: labelStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text('$playerPercent%', style: labelStyle, maxLines: 1),
                ],
              ),
              SizedBox(height: smallGap),
              _ProgressBar(
                value: playerPercent / 100,
                colors: const [Color(0xFF6C6AD9), Color(0xFF5655D6)],
              ),
              SizedBox(height: rowGap),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'AI',
                      style: labelStyle?.copyWith(color: AppColors.textMuted),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text('$aiPercent%', style: labelStyle, maxLines: 1),
                ],
              ),
              SizedBox(height: smallGap),
              _ProgressBar(
                value: aiPercent / 100,
                colors: const [Color(0xFF444C5A), Color(0xFF2A2F39)],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value;
  final List<Color> colors;

  const _ProgressBar({required this.value, required this.colors});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final barHeight = height < 120 ? AppSpacing.s : AppSpacing.m;

        return ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.s),
          child: SizedBox(
            height: barHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: value.clamp(0, 1),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: colors),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Panel extends StatelessWidget {
  final Widget child;

  const _Panel({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final padding = height < 120 ? AppSpacing.m : AppSpacing.l;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.panel.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(AppRadii.l),
            border: Border.all(
              color: AppColors.border,
              width: AppBorders.regular,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: AppSpacing.xl,
                offset: const Offset(0, AppSpacing.s),
              ),
            ],
          ),
          child: Padding(padding: EdgeInsets.all(padding), child: child),
        );
      },
    );
  }
}
