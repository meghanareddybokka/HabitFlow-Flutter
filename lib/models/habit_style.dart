import 'package:flutter/material.dart';

/// Fixed icon and colour choices. Habits store an index into these lists, which keeps
/// the saved data small and lets Flutter tree-shake unused icon glyphs.
class HabitStyle {
  HabitStyle._();

  static const icons = <IconData>[
    Icons.water_drop_rounded,
    Icons.menu_book_rounded,
    Icons.directions_run_rounded,
    Icons.self_improvement_rounded,
    Icons.bedtime_rounded,
    Icons.code_rounded,
    Icons.fitness_center_rounded,
    Icons.local_florist_rounded,
    Icons.edit_note_rounded,
    Icons.no_food_rounded,
    Icons.music_note_rounded,
    Icons.savings_rounded,
  ];

  static const colors = <Color>[
    Color(0xFF0D9488),
    Color(0xFF2563EB),
    Color(0xFFF97316),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
    Color(0xFF16A34A),
    Color(0xFFEAB308),
    Color(0xFFEF4444),
  ];

  static IconData icon(int index) => icons[index % icons.length];

  static Color color(int index) => colors[index % colors.length];
}
