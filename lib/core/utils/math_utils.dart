import 'dart:math' as math;
import 'dart:ui';

/// Math utility functions for the game
class MathUtils {
  MathUtils._();

  /// Linear interpolation between two values
  /// [a] - Start value
  /// [b] - End value
  /// [t] - Interpolation factor (0.0 to 1.0)
  /// Returns: Interpolated value
  static double lerp(double a, double b, double t) {
    return a + (b - a) * t;
  }

  /// Clamp a value between min and max
  /// [value] - Value to clamp
  /// [min] - Minimum value
  /// [max] - Maximum value
  /// Returns: Clamped value
  static double clamp(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// Clamp an integer value between min and max
  static int clampInt(int value, int min, int max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// Map a value from one range to another
  /// [value] - Input value
  /// [inMin] - Input range minimum
  /// [inMax] - Input range maximum
  /// [outMin] - Output range minimum
  /// [outMax] - Output range maximum
  /// Returns: Mapped value
  static double mapRange(
    double value,
    double inMin,
    double inMax,
    double outMin,
    double outMax,
  ) {
    return ((value - inMin) / (inMax - inMin)) * (outMax - outMin) + outMin;
  }

  /// Convert degrees to radians
  static double degreesToRadians(double degrees) {
    return degrees * math.pi / 180.0;
  }

  /// Convert radians to degrees
  static double radiansToDegrees(double radians) {
    return radians * 180.0 / math.pi;
  }

  /// Normalize an angle to be between 0 and 2*PI
  static double normalizeAngle(double angle) {
    while (angle < 0) {
      angle += 2 * math.pi;
    }
    while (angle >= 2 * math.pi) {
      angle -= 2 * math.pi;
    }
    return angle;
  }

  /// Smooth a value towards a target using exponential smoothing
  /// [current] - Current value
  /// [target] - Target value
  /// [smoothing] - Smoothing factor (0.0 to 1.0, lower = smoother)
  /// [dt] - Delta time (optional, defaults to 1.0)
  /// Returns: Smoothed value
  static double smoothDamp(
    double current,
    double target,
    double smoothing, [
    double dt = 1.0,
  ]) {
    return lerp(current, target, smoothing * dt * 60.0);
  }

  /// Convert normalized coordinates (0.0 to 1.0) to pixel offset
  /// [normalized] - Normalized offset (0.0 to 1.0)
  /// [canvasSize] - Canvas size in pixels
  /// Returns: Pixel offset
  static Offset normalizedToPixel(Offset normalized, Size canvasSize) {
    return Offset(
      normalized.dx * canvasSize.width,
      normalized.dy * canvasSize.height,
    );
  }

  /// Convert pixel offset to normalized coordinates (0.0 to 1.0)
  /// [pixel] - Pixel offset
  /// [canvasSize] - Canvas size in pixels
  /// Returns: Normalized offset
  static Offset pixelToNormalized(Offset pixel, Size canvasSize) {
    return Offset(
      pixel.dx / canvasSize.width,
      pixel.dy / canvasSize.height,
    );
  }

  /// Scale a size while maintaining aspect ratio to fit within max dimensions
  /// [original] - Original size
  /// [maxSize] - Maximum size
  /// Returns: Scaled size
  static Size scaleToFit(Size original, Size maxSize) {
    final widthRatio = maxSize.width / original.width;
    final heightRatio = maxSize.height / original.height;
    final scale = math.min(widthRatio, heightRatio);

    return Size(
      original.width * scale,
      original.height * scale,
    );
  }

  /// Calculate distance between two points
  static double distance(Offset a, Offset b) {
    final dx = b.dx - a.dx;
    final dy = b.dy - a.dy;
    return math.sqrt(dx * dx + dy * dy);
  }

  /// Calculate angle between two points (in radians)
  /// Returns angle from point a to point b
  static double angleBetween(Offset a, Offset b) {
    return math.atan2(b.dy - a.dy, b.dx - a.dx);
  }
}
