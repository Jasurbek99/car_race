import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/hud_constants.dart';
import '../../../../core/utils/math_utils.dart';

/// Tachometer widget (RPM gauge with needle)
/// Displays RPM with arc, ticks, needle, and shift hint
class Tachometer extends StatefulWidget {
  final double rpm;
  final double size;

  const Tachometer({
    super.key,
    required this.rpm,
    this.size = 120,
  });

  @override
  State<Tachometer> createState() => _TachometerState();
}

class _TachometerState extends State<Tachometer> {
  double _smoothedRpm = HudConstants.idleRpm;

  @override
  void didUpdateWidget(Tachometer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rpm != widget.rpm) {
      setState(() {
        // Smooth the RPM changes
        _smoothedRpm = MathUtils.smoothDamp(
          _smoothedRpm,
          widget.rpm,
          HudConstants.rpmSmoothing,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gauge arc and needle
          CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _TachometerPainter(rpm: _smoothedRpm),
          ),

          // RPM text value
          Positioned(
            bottom: widget.size * 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (_smoothedRpm / 1000).toStringAsFixed(1),
                  style: HudConstants.gaugeValueStyle.copyWith(
                    fontSize: widget.size * 0.15,
                  ),
                ),
                Text(
                  'x1000 RPM',
                  style: HudConstants.gaugeLabelStyle.copyWith(
                    fontSize: widget.size * 0.08,
                  ),
                ),
              ],
            ),
          ),

          // Shift hint (near redline)
          if (_smoothedRpm >= HudConstants.shiftHintRpm)
            Positioned(
              top: widget.size * 0.15,
              child: Text(
                'SHIFT!',
                style: HudConstants.shiftHintStyle.copyWith(
                  fontSize: widget.size * 0.12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TachometerPainter extends CustomPainter {
  final double rpm;

  _TachometerPainter({required this.rpm});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.85;

    // Draw background arc
    _drawArc(canvas, center, radius);

    // Draw ticks
    _drawTicks(canvas, center, radius);

    // Draw redline arc
    _drawRedline(canvas, center, radius);

    // Draw needle
    _drawNeedle(canvas, center, radius);
  }

  void _drawArc(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = HudConstants.tachArcColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      HudConstants.tachArcStartAngle,
      HudConstants.tachArcSweepAngle,
      false,
      paint,
    );
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    final majorPaint = Paint()
      ..color = HudConstants.tachTickColor
      ..strokeWidth = 2;

    final minorPaint = Paint()
      ..color = HudConstants.tachTickColor.withValues(alpha: 0.5)
      ..strokeWidth = 1;

    // Draw major ticks (0, 1, 2, ... 8)
    for (int i = 0; i <= HudConstants.tachMajorTickCount; i++) {
      final angle = HudConstants.tachArcStartAngle +
          (HudConstants.tachArcSweepAngle * i / HudConstants.tachMajorTickCount);

      // Tick line
      final tickStart = center +
          Offset(
            math.cos(angle) * (radius - 12),
            math.sin(angle) * (radius - 12),
          );
      final tickEnd = center +
          Offset(
            math.cos(angle) * (radius + 2),
            math.sin(angle) * (radius + 2),
          );

      canvas.drawLine(tickStart, tickEnd, majorPaint);

      // Draw minor ticks between major ticks
      if (i < HudConstants.tachMajorTickCount) {
        for (int j = 1; j < HudConstants.tachMinorTicksPerMajor; j++) {
          final minorAngle = angle +
              (HudConstants.tachArcSweepAngle /
                  HudConstants.tachMajorTickCount /
                  HudConstants.tachMinorTicksPerMajor *
                  j);

          final minorTickStart = center +
              Offset(
                math.cos(minorAngle) * (radius - 8),
                math.sin(minorAngle) * (radius - 8),
              );
          final minorTickEnd = center +
              Offset(
                math.cos(minorAngle) * (radius + 2),
                math.sin(minorAngle) * (radius + 2),
              );

          canvas.drawLine(minorTickStart, minorTickEnd, minorPaint);
        }
      }
    }
  }

  void _drawRedline(Canvas canvas, Offset center, double radius) {
    // Calculate redline start angle
    final redlineRatio =
        (HudConstants.redlineRpm - 0) / (HudConstants.maxRpm - 0);
    final redlineStartAngle = HudConstants.tachArcStartAngle +
        (HudConstants.tachArcSweepAngle * redlineRatio);
    final redlineSweepAngle =
        HudConstants.tachArcEndAngle - redlineStartAngle;

    final paint = Paint()
      ..color = HudConstants.tachRedlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      redlineStartAngle,
      redlineSweepAngle,
      false,
      paint,
    );
  }

  void _drawNeedle(Canvas canvas, Offset center, double radius) {
    // Calculate needle angle based on RPM
    final rpmRatio = MathUtils.clamp(
      (rpm - 0) / (HudConstants.maxRpm - 0),
      0.0,
      1.0,
    );
    final needleAngle = HudConstants.tachArcStartAngle +
        (HudConstants.tachArcSweepAngle * rpmRatio);

    final needleLength = radius * HudConstants.tachNeedleLength;
    final needleEnd = center +
        Offset(
          math.cos(needleAngle) * needleLength,
          math.sin(needleAngle) * needleLength,
        );

    final needlePaint = Paint()
      ..color = HudConstants.tachNeedleColor
      ..strokeWidth = HudConstants.tachNeedleWidth
      ..strokeCap = StrokeCap.round;

    // Draw needle
    canvas.drawLine(center, needleEnd, needlePaint);

    // Draw center dot
    canvas.drawCircle(
      center,
      6,
      Paint()..color = HudConstants.tachNeedleColor,
    );
  }

  @override
  bool shouldRepaint(_TachometerPainter oldDelegate) {
    return oldDelegate.rpm != rpm;
  }
}
