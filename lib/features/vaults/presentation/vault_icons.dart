import 'package:flutter/material.dart';

const Map<String, IconData> vaultIcons = <String, IconData>{
  'shield': Icons.shield_outlined,
  'school': Icons.school_outlined,
  'dns': Icons.dns_outlined,
  'auto_awesome': Icons.auto_awesome_outlined,
  'memory': Icons.memory_outlined,
  'trending_up': Icons.trending_up,
  'flight_takeoff': Icons.flight_takeoff_outlined,
  'beach_access': Icons.beach_access_outlined,
  'savings': Icons.savings_outlined,
  'flag': Icons.flag_outlined,
  'star': Icons.star_outline,
  'home_work': Icons.home_work_outlined,
  'directions_car': Icons.directions_car_outlined,
  'favorite': Icons.favorite_outline,
  'celebration': Icons.celebration_outlined,
  'more_horiz': Icons.more_horiz,
};

IconData vaultIconFor(String iconKey) =>
    vaultIcons[iconKey] ?? Icons.savings_outlined;

const Map<String, Color> vaultColorSwatch = <String, Color>{
  'primary': Color(0xFF6E56CF),
  'investment': Color(0xFF1FAD66),
  'necessity': Color(0xFF6B7A99),
  'consumption': Color(0xFFE0A32E),
  'income': Color(0xFF1FAD66),
  'category1': Color(0xFF6E56CF),
  'category2': Color(0xFF357A9A),
  'category3': Color(0xFFB4562F),
  'category4': Color(0xFF3F8F6D),
  'category5': Color(0xFF9A4A6B),
  'category6': Color(0xFF7A6B3F),
  'category7': Color(0xFF4A6B9A),
  'category8': Color(0xFF6B6B6B),
};

Color vaultColorFor(String colorToken) =>
    vaultColorSwatch[colorToken] ?? const Color(0xFF6E56CF);
