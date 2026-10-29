import 'package:flutter/material.dart';

import '../models/habit_style.dart';
import '../state/habit_controller.dart';
import '../theme/habit_colors.dart';
import '../utils/day_key.dart';
import '../widgets/habit_icon.dart';
import '../widgets/heatmap_grid.dart';
import '../widgets/stat_card.dart';
import 'add_habit_screen.dart';

/// Streaks, completion rate and a 5-week heatmap for one habit.
class HabitDetailScreen extends StatelessWidget {
  const HabitDetailScreen({
    super.key,
    required this.controller,
    required this.habitId,
  });

  final HabitController controller;
  final String habitId;

  Future<void> _confirmDelete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete habit?'),
        content: const Text('Its whole history will be removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      Navigator.of(context).pop();
      await controller.delete(habitId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final habit = controller.byId(habitId);
        if (habit == null) return const Scaffold();
        final today = controller.today;
        final color = HabitStyle.color(habit.colorIndex);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Habit details'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_rounded),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        AddHabitScreen(controller: controller, existing: habit),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: () => _confirmDelete(context),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  HabitIcon(habit: habit, size: 58),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habit.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '${habit.category.label} · since ${DayKey.format(habit.createdAt)}',
                        ),
                        if (habit.note.isNotEmpty)
                          Text(
                            habit.note,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  StatCard(
                    icon: Icons.local_fire_department_rounded,
                    value: '${habit.currentStreak(today)}',
                    label: 'Current streak',
                    color: HabitColors.flame,
                  ),
                  const SizedBox(width: 10),
                  StatCard(
                    icon: Icons.emoji_events_rounded,
                    value: '${habit.bestStreak}',
                    label: 'Best streak',
                    color: Colors.amber.shade700,
                  ),
                  const SizedBox(width: 10),
                  StatCard(
                    icon: Icons.percent_rounded,
                    value: '${(habit.completionRate(today) * 100).round()}%',
                    label: '30-day rate',
                    color: color,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Last 5 weeks',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: HeatmapGrid(habit: habit, today: today),
                ),
              ),
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: () => controller.toggleToday(habit.id),
                icon: Icon(
                  habit.isDoneOn(today)
                      ? Icons.undo_rounded
                      : Icons.check_rounded,
                ),
                label: Text(
                  habit.isDoneOn(today)
                      ? 'Mark as not done today'
                      : 'Mark as done today',
                ),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: color,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
