import 'package:flutter/material.dart';

import '../models/habit.dart';
import '../models/habit_style.dart';
import 'habit_icon.dart';
import 'streak_badge.dart';
import 'week_dots.dart';

/// One habit on the Today screen with a big tick button.
class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.habit,
    required this.today,
    required this.onToggle,
    this.onTap,
  });

  final Habit habit;
  final DateTime today;
  final VoidCallback onToggle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final done = habit.isDoneOn(today);
    final color = HabitStyle.color(habit.colorIndex);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              HabitIcon(habit: habit),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        decoration: done ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        StreakBadge(days: habit.currentStreak(today)),
                        const SizedBox(width: 10),
                        WeekDots(habit: habit, today: today),
                      ],
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: done ? color : Colors.transparent,
                  border: Border.all(color: color, width: 2.5),
                ),
                child: IconButton(
                  key: Key('toggle-${habit.id}'),
                  padding: EdgeInsets.zero,
                  onPressed: onToggle,
                  icon: Icon(
                    Icons.check_rounded,
                    color: done ? Colors.white : color.withValues(alpha: 0.35),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
