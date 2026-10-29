import 'package:flutter/material.dart';

import '../state/habit_controller.dart';
import '../theme/habit_colors.dart';
import '../utils/day_key.dart';
import '../widgets/habit_icon.dart';
import '../widgets/stat_card.dart';
import '../widgets/streak_badge.dart';
import '../widgets/weekly_chart.dart';

/// Overall statistics: weekly chart, average completion and streak ranking.
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key, required this.controller});

  final HabitController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final week = controller.weeklyCompletions();
        final today = controller.today;
        final best = controller.longestStreakHabit;
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            const Text(
              'Statistics',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                StatCard(
                  icon: Icons.list_alt_rounded,
                  value: '${controller.habits.length}',
                  label: 'Habits',
                  color: Colors.teal,
                ),
                const SizedBox(width: 10),
                StatCard(
                  icon: Icons.percent_rounded,
                  value: '${(controller.averageRate * 100).round()}%',
                  label: 'Avg. 30-day rate',
                  color: Colors.indigo,
                ),
                const SizedBox(width: 10),
                StatCard(
                  icon: Icons.local_fire_department_rounded,
                  value: best == null ? '0' : '${best.currentStreak(today)}',
                  label: 'Top streak',
                  color: HabitColors.flame,
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'Habits completed – last 7 days',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: WeeklyChart(
                  values: week.map((e) => e.value).toList(),
                  labels: week.map((e) => DayKey.initial(e.key)).toList(),
                  maxValue: controller.habits.length,
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Streak leaderboard',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Card(
              child: Column(
                children: [
                  for (final h in controller.rankedByStreak)
                    ListTile(
                      leading: HabitIcon(habit: h, size: 40),
                      title: Text(
                        h.name,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        '${(h.completionRate(today) * 100).round()}% in last 30 days · best ${h.bestStreak}',
                      ),
                      trailing: StreakBadge(days: h.currentStreak(today)),
                    ),
                  if (controller.habits.isEmpty)
                    const ListTile(title: Text('No habits yet')),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
