import 'package:flutter/material.dart';

import '../models/habit.dart';
import '../models/habit_style.dart';
import '../utils/day_key.dart';

/// Five-week calendar heatmap (one square per day) for a habit.
class HeatmapGrid extends StatelessWidget {
  const HeatmapGrid({
    super.key,
    required this.habit,
    required this.today,
    this.weeks = 5,
  });

  final Habit habit;
  final DateTime today;
  final int weeks;

  @override
  Widget build(BuildContext context) {
    final color = HabitStyle.color(habit.colorIndex);
    final days = DayKey.lastDays(today, weeks * 7);
    return LayoutBuilder(
      builder: (context, box) {
        const gap = 6.0;
        final cell = (box.maxWidth - gap * 6) / 7;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final d in days)
              Tooltip(
                message: DayKey.format(d),
                child: Container(
                  width: cell,
                  height: cell * 0.62,
                  decoration: BoxDecoration(
                    color: habit.isDoneOn(d)
                        ? color
                        : color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
