import 'package:flutter/material.dart';

@immutable
final class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.income,
    required this.expense,
    required this.investment,
    required this.necessity,
    required this.consumption,
    required this.success,
    required this.warning,
    required this.info,
    required this.progressTrack,
    required this.progressFill,
    required this.categoryPalette,
    required this.chartPalette,
  });

  final Color income;
  final Color expense;
  final Color investment;
  final Color necessity;
  final Color consumption;
  final Color success;
  final Color warning;
  final Color info;
  final Color progressTrack;
  final Color progressFill;
  final List<Color> categoryPalette;
  final List<Color> chartPalette;

  static const AppSemanticColors light = AppSemanticColors(
    income: Color(0xFF2E7D5B),
    expense: Color(0xFFB04747),
    investment: Color(0xFF357A68),
    necessity: Color(0xFF496A9A),
    consumption: Color(0xFF9B6A45),
    success: Color(0xFF2E7D5B),
    warning: Color(0xFF9A6700),
    info: Color(0xFF4169A1),
    progressTrack: Color(0xFFDDE7E3),
    progressFill: Color(0xFF357A68),
    categoryPalette: <Color>[
      Color(0xFF496A9A),
      Color(0xFF9B6A45),
      Color(0xFF7C6098),
      Color(0xFF397D84),
      Color(0xFF9B5264),
      Color(0xFF6D7540),
      Color(0xFF765C45),
      Color(0xFF5D6773),
    ],
    chartPalette: <Color>[
      Color(0xFF357A68),
      Color(0xFF496A9A),
      Color(0xFF9B6A45),
      Color(0xFF7C6098),
    ],
  );

  static const AppSemanticColors dark = AppSemanticColors(
    income: Color(0xFF74C69D),
    expense: Color(0xFFF08B8B),
    investment: Color(0xFF75C5AA),
    necessity: Color(0xFF93B7EA),
    consumption: Color(0xFFD8A374),
    success: Color(0xFF74C69D),
    warning: Color(0xFFF0C36A),
    info: Color(0xFF9FC1F1),
    progressTrack: Color(0xFF33433E),
    progressFill: Color(0xFF75C5AA),
    categoryPalette: <Color>[
      Color(0xFF93B7EA),
      Color(0xFFD8A374),
      Color(0xFFC3A1E0),
      Color(0xFF7DC4CA),
      Color(0xFFE69AA9),
      Color(0xFFB9C576),
      Color(0xFFC2A281),
      Color(0xFFAAB4C0),
    ],
    chartPalette: <Color>[
      Color(0xFF75C5AA),
      Color(0xFF93B7EA),
      Color(0xFFD8A374),
      Color(0xFFC3A1E0),
    ],
  );

  @override
  AppSemanticColors copyWith({
    Color? income,
    Color? expense,
    Color? investment,
    Color? necessity,
    Color? consumption,
    Color? success,
    Color? warning,
    Color? info,
    Color? progressTrack,
    Color? progressFill,
    List<Color>? categoryPalette,
    List<Color>? chartPalette,
  }) {
    return AppSemanticColors(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      investment: investment ?? this.investment,
      necessity: necessity ?? this.necessity,
      consumption: consumption ?? this.consumption,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      progressTrack: progressTrack ?? this.progressTrack,
      progressFill: progressFill ?? this.progressFill,
      categoryPalette: categoryPalette ?? this.categoryPalette,
      chartPalette: chartPalette ?? this.chartPalette,
    );
  }

  @override
  AppSemanticColors lerp(covariant AppSemanticColors? other, double t) {
    if (other == null) {
      return this;
    }
    return AppSemanticColors(
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      investment: Color.lerp(investment, other.investment, t)!,
      necessity: Color.lerp(necessity, other.necessity, t)!,
      consumption: Color.lerp(consumption, other.consumption, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      progressTrack: Color.lerp(progressTrack, other.progressTrack, t)!,
      progressFill: Color.lerp(progressFill, other.progressFill, t)!,
      categoryPalette: _lerpPalette(categoryPalette, other.categoryPalette, t),
      chartPalette: _lerpPalette(chartPalette, other.chartPalette, t),
    );
  }
}

List<Color> _lerpPalette(List<Color> from, List<Color> to, double t) =>
    List<Color>.unmodifiable(
      List<Color>.generate(
        from.length,
        (int index) => Color.lerp(from[index], to[index], t)!,
      ),
    );
