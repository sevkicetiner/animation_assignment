import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF75AEA6);
  static const Color background = Color(0xFF1A1A1A);
  static const Color grey = Colors.grey;
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static Color primaryWithOpacity(double opacity) => primary.withOpacity(opacity);
  static Color greyWithOpacity(double opacity) => grey.withOpacity(opacity);
  static Color blackWithOpacity(double opacity) => black.withOpacity(opacity);
} 