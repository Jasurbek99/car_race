import 'package:flutter/material.dart';
import '../../../../core/constants/car_constants.dart';
import '../../application/services/car_render_spec.dart';
import '../../domain/entities/car_config.dart';

/// Widget that displays a modular car preview using Flutter Stack
/// This uses the same CarRenderSpec as the Flame component to ensure consistency
class ModularCarPreview extends StatelessWidget {
  final CarConfig config;
  final double width;
  final double height;
  final BoxFit fit;

  const ModularCarPreview({
    super.key,
    required this.config,
    this.width = CarConstants.defaultRenderWidth,
    this.height = CarConstants.defaultRenderHeight,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final renderSize = Size(width, height);
    final spec = CarRenderSpec(config);
    final plan = spec.getRenderingPlan(renderSize);

    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Car body (bottom layer)
            _buildBody(plan['bodyPath'] as String, renderSize),
            // Rear wheel (on top of body)
            _buildWheel(plan['rearWheel'] as Map<String, dynamic>, renderSize),

            // Front wheel (on top of body)
            _buildWheel(plan['frontWheel'] as Map<String, dynamic>, renderSize),

            // Helmet (top layer, if present)
            if (plan.containsKey('helmet'))
              _buildHelmet(plan['helmet'] as Map<String, dynamic>, renderSize),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(String path, Size renderSize) {
    return Transform.translate(
      offset: Offset(0, CarConstants.carBodyVerticalOffset),
      child: Center(
        child: Image.asset(
          path,
          width: renderSize.width,
          height: renderSize.height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            // Fallback if modular asset is missing
            return Image.asset(
              CarConstants.fallbackCarBody,
              width: renderSize.width,
              height: renderSize.height,
              fit: fit,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder(renderSize, Colors.blue, 'Car');
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildWheel(Map<String, dynamic> wheelData, Size renderSize) {
    final path = wheelData['path'] as String;
    final size = wheelData['size'] as Size;
    final offset = wheelData['offset'] as Offset;

    // Get adjustment values from wheelData (allows per-wheel customization)
    final sizeScale = (wheelData['sizeScale'] as double?) ?? 1.0;
    final topAdjust = (wheelData['topAdjust'] as double?) ?? 0.0;

    return Align(
      alignment: Alignment.center,
      child: Transform.translate(
        offset: Offset(
          offset.dx - (renderSize.width / 2),
          offset.dy - (renderSize.height / 2) + topAdjust + CarConstants.carBodyVerticalOffset,
        ),
        child: Image.asset(
          path,
          width: size.width * sizeScale,
          height: size.height * sizeScale,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback if wheel asset is missing
            return Image.asset(
              CarConstants.fallbackWheel,
              width: size.width,
              height: size.height,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder(size, Colors.grey, 'W');
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHelmet(Map<String, dynamic> helmetData, Size renderSize) {
    final path = helmetData['path'] as String;
    final size = helmetData['size'] as Size;
    final offset = helmetData['offset'] as Offset;

    return Align(
      alignment: Alignment.center,
      child: Transform.translate(
        offset: Offset(
          offset.dx - (renderSize.width / 2),
          offset.dy - (renderSize.height / 2) + CarConstants.carBodyVerticalOffset,
        ),
        child: Image.asset(
          path,
          width: size.width,
          height: size.height,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // If helmet fails to load, just hide it (optional cosmetic)
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildPlaceholder(Size size, Color color, String label) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.3),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.2,
          ),
        ),
      ),
    );
  }
}
