import 'package:flutter/material.dart';

import '../theme/habit_colors.dart';
import 'progress_ring.dart';

/// Gradient header with today's progress ring.
class TodayHeader extends StatelessWidget {
  const TodayHeader({
    super.key,
    required this.done,
    required this.total,
    required this.dateLabel,
  });

  final int done;
  final int total;
  final String dateLabel;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : done / total;
    final message = total == 0
        ? 'Add your first habit to get started'
        : done == total
        ? 'All habits done – great job!'
        : '${total - done} habit${total - done == 1 ? '' : 's'} left for today';
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [HabitColors.heroStart, HabitColors.heroEnd],
        ),
        boxShadow: [
          BoxShadow(
            color: HabitColors.heroStart.withValues(alpha: 0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateLabel,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$done of $total done',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(message, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
          ProgressRing(
            value: progress,
            child: Text(
              '${(progress * 100).round()}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
