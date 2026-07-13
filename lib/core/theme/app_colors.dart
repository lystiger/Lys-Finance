import 'package:flutter/material.dart';

@immutable
final class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.investment,
    required this.necessity,
    required this.consumption,
    required this.success,
    required this.warning,
    required this.info,
  });

  final Color investment;
  final Color necessity;
  final Color consumption;
  final Color success;
  final Color warning;
  final Color info;

  static const AppSemanticColors light = AppSemanticColors(
    investment: Color(0xFF357A68),
    necessity: Color(0xFF496A9A),
    consumption: Color(0xFF9B6A45),
    success: Color(0xFF2E7D5B),
    warning: Color(0xFF9A6700),
    info: Color(0xFF4169A1),
  );

  static const AppSemanticColors dark = AppSemanticColors(
    investment: Color(0xFF75C5AA),
    necessity: Color(0xFF93B7EA),
    consumption: Color(0xFFD8A374),
    success: Color(0xFF74C69D),
    warning: Color(0xFFF0C36A),
    info: Color(0xFF9FC1F1),
  );

  @override
  AppSemanticColors copyWith({
    Color? investment,
    Color? necessity,
    Color? consumption,
    Color? success,
    Color? warning,
    Color? info,
  }) {
    return AppSemanticColors(
      investment: investment ?? this.investment,
      necessity: necessity ?? this.necessity,
      consumption: consumption ?? this.consumption,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  AppSemanticColors lerp(covariant AppSemanticColors? other, double t) {
    if (other == null) {
      return this;
    }
    return AppSemanticColors(
      investment: Color.lerp(investment, other.investment, t)!,
      necessity: Color.lerp(necessity, other.necessity, t)!,
      consumption: Color.lerp(consumption, other.consumption, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
