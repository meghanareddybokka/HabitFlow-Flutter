import 'package:flutter/material.dart';

import '../theme/habit_colors.dart';

/// Small "🔥 5" streak pill.
class StreakBadge extends StatelessWidget {
  const StreakBadge({super.key, required this.days});

  final int days;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: HabitColors.flame.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            size: 15,
            color: HabitColors.flame,
          ),
          const SizedBox(width: 3),
          Text(
            '$days',
            style: const TextStyle(
              color: HabitColors.flame,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
