import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

abstract final class AppRadii {
  static const double control = 12;
  static const double card = 20;
  static const double sheet = 28;
  static const double pill = 999;
}

abstract final class AppElevations {
  static const double flat = 0;
  static const double raised = 2;
  static const double overlay = 8;
}

abstract final class AppDurations {
  static const Duration instant = Duration.zero;
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 250);
  static const Duration deliberate = Duration(milliseconds: 400);
}

abstract final class AppMotion {
  static Duration responsive(BuildContext context, Duration duration) {
    return MediaQuery.maybeOf(context)?.disableAnimations ?? false
        ? AppDurations.instant
        : duration;
  }
}
