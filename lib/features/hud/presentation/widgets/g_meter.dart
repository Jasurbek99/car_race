import 'package:flutter/material.dart';
import '../../../../core/constants/hud_constants.dart';
import '../../../../core/utils/math_utils.dart';

/// G-Meter widget (acceleration/braking gauge)
/// Shows positive G (acceleration) and negative G (braking) as a bar
class GMeter extends StatefulWidget {
  final double gForce;
  final double width;
  final double height;

  const GMeter({
    super.key,
    required this.gForce,
    this.width = HudConstants.gMeterBarWidth,
    this.height = HudConstants.gMeterBarHeight,
  });

  @override
  State<GMeter> createState() => _GMeterState();
}

class _GMeterState extends State<GMeter> {
  double _smoothedG = 0.0;

  @override
  void didUpdateWidget(GMeter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gForce != widget.gForce) {
      setState(() {
        // Smooth the G-force changes
        _smoothedG = MathUtils.smoothDamp(
          _smoothedG,
          widget.gForce,
          HudConstants.gSmoothing,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height + 30, // Extra space for label
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label
          Text(
            'G-FORCE',
            style: HudConstants.gaugeLabelStyle,
          ),
          const SizedBox(height: 4),

          // Gauge bar
          CustomPaint(
            size: Size(widget.width, widget.height),
            painter: _GMeterPainter(gForce: _smoothedG),
          ),

          const SizedBox(height: 4),

          // Value text
          Text(
            '${_smoothedG.toStringAsFixed(2)}G',
            style: HudConstants.gaugeValueStyle.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _GMeterPainter extends CustomPainter {
  final double gForce;

  _GMeterPainter({required this.gForce});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    // Draw background
    _drawBackground(canvas, size);

    // Draw grid lines
    _drawGridLines(canvas, size, centerX);

    // Draw G-force bar
    _drawGBar(canvas, size, centerX);

    // Draw center marker
    _drawCenterMarker(canvas, size, centerX);
  }

  void _drawBackground(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = HudConstants.gMeterBgColor;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      bgPaint,
    );
  }

  void _drawGridLines(Canvas canvas, Size size, double centerX) {
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..strokeWidth = 1;

    // Draw vertical grid lines
    for (int i = 0; i <= HudConstants.gMeterGridLines; i++) {
      final x = (size.width / HudConstants.gMeterGridLines) * i;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }
  }

  void _drawGBar(Canvas canvas, Size size, double centerX) {
    // Clamp G-force to valid range
    final clampedG = MathUtils.clamp(
      gForce,
      HudConstants.minGForce,
      HudConstants.maxGForce,
    );

    // Calculate bar width and position
    final maxBarWidth = size.width / 2;

    if (clampedG >= 0) {
      // Positive G (acceleration) - green bar to the right
      final barWidth = (clampedG / HudConstants.maxGForce) * maxBarWidth;
      final paint = Paint()..color = HudConstants.gMeterAccelColor;

      canvas.drawRect(
        Rect.fromLTWH(centerX, 0, barWidth, size.height),
        paint,
      );
    } else {
      // Negative G (braking) - red bar to the left
      final barWidth =
          (clampedG.abs() / HudConstants.minGForce.abs()) * maxBarWidth;
      final paint = Paint()..color = HudConstants.gMeterBrakeColor;

      canvas.drawRect(
        Rect.fromLTWH(centerX - barWidth, 0, barWidth, size.height),
        paint,
      );
    }
  }

  void _drawCenterMarker(Canvas canvas, Size size, double centerX) {
    final centerPaint = Paint()
      ..color = HudConstants.gMeterCenterColor
      ..strokeWidth = 2;

    // Draw center line
    canvas.drawLine(
      Offset(centerX, 0),
      Offset(centerX, size.height),
      centerPaint,
    );

    // Draw center dot
    canvas.drawCircle(
      Offset(centerX, size.height / 2),
      4,
      Paint()..color = HudConstants.gMeterCenterColor,
    );
  }

  @override
  bool shouldRepaint(_GMeterPainter oldDelegate) {
    return oldDelegate.gForce != gForce;
  }
}
