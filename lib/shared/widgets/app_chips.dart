import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onSelected,
    this.semanticClass,
    this.enabled = true,
    super.key,
  });
  final String label;
  final IconData icon;
  final Color color;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final String? semanticClass;
  final bool enabled;

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticClass == null ? label : '$label, $semanticClass',
    selected: selected,
    child: FilterChip(
      avatar: Icon(icon, color: color),
      label: Text(label),
      selected: selected,
      onSelected: enabled ? onSelected : null,
    ),
  );
}

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.count,
    super.key,
  });
  final String label;
  final bool selected;
  final int? count;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) => FilterChip(
    label: Text(count == null ? label : '$label ($count)'),
    selected: selected,
    showCheckmark: true,
    onSelected: onSelected,
  );
}
