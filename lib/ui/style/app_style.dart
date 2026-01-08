import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Colors.black;
  static const Color panel = Color(0xFF222447);
  static const Color panelAlt = Color(0xFF26263D);
  static const Color border = Color(0xFF0F6BB7);
  static const Color primary = Color(0xFF5C5BD6);
  static const Color positive = Color(0xFF3AC182);
  static const Color textMuted = Color(0xFFBDBCC9);
}

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double s = 12;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;
}

abstract final class AppRadii {
  static const double s = 14;
  static const double m = 18;
  static const double l = 22;
  static const double xl = 28;
}

abstract final class AppBorders {
  static const double regular = 2;
}
