import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Constants for HUD gauges (tachometer and G-meter)
class HudConstants {
  HudConstants._();

  // === TACHOMETER (RPM Gauge) ===

  // RPM ranges
  static const double idleRpm = 800.0;
  static const double redlineRpm = 7000.0;
  static const double maxRpm = 8000.0;

  // RPM calculation from speed
  // rpm = idleRpm + (speed / maxSpeed) * (maxRpm - idleRpm) * gearFactor
  static const double rpmFactor = 1.0;

  // Gear multipliers for RPM calculation (lower gears = higher RPM at same speed)
  static const Map<int, double> gearRpmMultipliers = {
    1: 2.5,
    2: 2.0,
    3: 1.5,
    4: 1.2,
    5: 1.0,
  };

  // Visual settings
  static const double tachArcStartAngle = math.pi * 0.75; // 135 degrees (bottom-left)
  static const double tachArcEndAngle = math.pi * 2.25; // 405 degrees (bottom-right)
  static const double tachArcSweepAngle = tachArcEndAngle - tachArcStartAngle; // 270 degrees

  static const int tachMajorTickCount = 8; // Major ticks (0, 1, 2, ... 7, 8)
  static const int tachMinorTicksPerMajor = 5; // Minor ticks between major ticks

  static const double tachNeedleLength = 0.7; // Relative to radius
  static const double tachNeedleWidth = 3.0;

  // Colors
  static const Color tachArcColor = Color(0xFF333333);
  static const Color tachNeedleColor = Colors.red;
  static const Color tachRedlineColor = Colors.red;
  static const Color tachTickColor = Colors.white70;
  static const Color tachTextColor = Colors.white;

  // Smoothing (lerp factor)
  static const double rpmSmoothing = 0.12; // Lower = smoother but more lag

  // Shift hint
  static const double shiftHintRpm = 6500.0; // Show "SHIFT!" hint at this RPM

  // === G-METER (Accelerometer) ===

  // G-force ranges
  static const double minGForce = -1.5; // Braking (negative)
  static const double maxGForce = 1.5; // Acceleration (positive)

  // Smoothing
  static const double gSmoothing = 0.15; // Lower = smoother but more lag

  // Visual settings
  static const double gMeterBarHeight = 20.0;
  static const double gMeterBarWidth = 200.0;

  // Colors
  static const Color gMeterBgColor = Color(0xFF222222);
  static const Color gMeterAccelColor = Colors.green; // Positive G (acceleration)
  static const Color gMeterBrakeColor = Colors.red; // Negative G (braking)
  static const Color gMeterCenterColor = Colors.white;
  static const Color gMeterTextColor = Colors.white;

  // Grid lines
  static const int gMeterGridLines = 5; // Number of vertical grid lines

  // === SHARED ===

  // Update rate
  static const double hudUpdateInterval = 1.0 / 60.0; // 60 FPS target

  // Text styles
  static const TextStyle gaugeValueStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle gaugeLabelStyle = TextStyle(
    color: Colors.white70,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle shiftHintStyle = TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
