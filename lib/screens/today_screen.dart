import 'package:flutter/material.dart';

import '../state/habit_controller.dart';
import '../utils/day_key.dart';
import '../utils/greeting.dart';
import '../widgets/empty_habits.dart';
import '../widgets/habit_card.dart';
import '../widgets/today_header.dart';
import 'habit_detail_screen.dart';

/// Main screen: today's progress and the list of habits to tick off.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key, required this.controller});

  final HabitController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final today = controller.today;
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 100),
          children: [
            Text(
              '${greetingFor(today)}, Meghana 🌱',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Text(
              'HabitFlow',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),
            TodayHeader(
              done: controller.doneToday,
              total: controller.habits.length,
              dateLabel: DayKey.headline(today),
            ),
            const SizedBox(height: 18),
            if (controller.habits.isEmpty)
              EmptyHabits(onDemo: controller.loadDemo)
            else ...[
              const Text(
                "Today's habits",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              for (final h in controller.habits)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: HabitCard(
                    habit: h,
                    today: today,
                    onToggle: () => controller.toggleToday(h.id),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => HabitDetailScreen(
                          controller: controller,
                          habitId: h.id,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ],
        );
      },
    );
  }
}
