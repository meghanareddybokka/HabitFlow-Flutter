import 'package:flutter/material.dart';

import '../models/habit.dart';
import '../models/habit_style.dart';
import '../utils/day_key.dart';

/// Seven small circles showing the last week for one habit.
class WeekDots extends StatelessWidget {
  const WeekDots({super.key, required this.habit, required this.today});

  final Habit habit;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final color = HabitStyle.color(habit.colorIndex);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final d in DayKey.lastDays(today, 7))
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: habit.isDoneOn(d)
                    ? color
                    : color.withValues(alpha: 0.18),
              ),
            ),
          ),
      ],
    );
  }
}
