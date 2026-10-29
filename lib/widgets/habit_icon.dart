import 'package:flutter/material.dart';

import '../models/habit.dart';
import '../models/habit_style.dart';

/// Rounded square with the habit's icon in its colour.
class HabitIcon extends StatelessWidget {
  const HabitIcon({super.key, required this.habit, this.size = 46});

  final Habit habit;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = HabitStyle.color(habit.colorIndex);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(size / 3),
      ),
      child: Icon(
        HabitStyle.icon(habit.iconIndex),
        color: color,
        size: size * 0.52,
      ),
    );
  }
}
