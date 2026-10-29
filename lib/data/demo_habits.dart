import 'dart:math';

import '../models/habit.dart';
import '../models/habit_category.dart';
import '../utils/day_key.dart';

/// Demo habits of a college student with realistic, slightly irregular history.
class DemoHabits {
  DemoHabits._();

  static List<Habit> build(DateTime today) {
    const specs = <(String, HabitCategory, int, int, double, String)>[
      (
        'Drink 8 glasses of water',
        HabitCategory.health,
        0,
        1,
        0.85,
        'Keep a bottle on the desk',
      ),
      ('Study 2 hours', HabitCategory.study, 1, 0, 0.75, 'DSA + Flutter'),
      ('Morning walk', HabitCategory.fitness, 2, 2, 0.6, '20 minutes'),
      ('Meditate 10 min', HabitCategory.mindfulness, 3, 3, 0.55, ''),
      ('Sleep before 11 pm', HabitCategory.health, 4, 4, 0.5, ''),
      (
        'Solve 1 coding problem',
        HabitCategory.productivity,
        5,
        5,
        0.7,
        'LeetCode / GFG',
      ),
    ];
    final rng = Random(7);
    final habits = <Habit>[];
    for (var i = 0; i < specs.length; i++) {
      final s = specs[i];
      final days = <String>{};
      for (final d in DayKey.lastDays(today, 45)) {
        final isToday = DayKey.of(d) == DayKey.of(today);
        if (!isToday && rng.nextDouble() < s.$5) days.add(DayKey.of(d));
      }
      if (i < 3) days.add(DayKey.of(today)); // a few already ticked today
      habits.add(
        Habit(
          id: 'demo-$i',
          name: s.$1,
          category: s.$2,
          iconIndex: s.$3,
          colorIndex: s.$4,
          createdAt: DayKey.dateOnly(today).subtract(const Duration(days: 44)),
          note: s.$6,
          completedDays: days,
        ),
      );
    }
    return habits;
  }
}
