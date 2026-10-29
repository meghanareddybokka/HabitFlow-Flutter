import 'package:flutter_test/flutter_test.dart';
import 'package:habit_flow/models/habit.dart';
import 'package:habit_flow/models/habit_category.dart';
import 'package:habit_flow/services/habit_storage.dart';
import 'package:habit_flow/state/habit_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final now = DateTime(2026, 10, 21, 10);
  late HabitController controller;

  Habit habit(String id) => Habit(
    id: id,
    name: 'Habit $id',
    category: HabitCategory.health,
    iconIndex: 0,
    colorIndex: 0,
    createdAt: now,
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    controller = HabitController(await HabitStorage.open(), clock: () => now);
    await controller.load();
  });

  test('add, toggle and delete habits', () async {
    await controller.add(habit('a'));
    await controller.add(habit('b'));
    await controller.toggleToday('a');
    expect(controller.doneToday, 1);
    expect(controller.todayProgress, 0.5);
    await controller.delete('a');
    expect(controller.habits.single.id, 'b');
  });

  test('weekly completions cover the last seven days', () async {
    await controller.add(habit('a'));
    await controller.toggleToday('a');
    final week = controller.weeklyCompletions();
    expect(week.length, 7);
    expect(week.last.value, 1);
    expect(week.first.value, 0);
  });

  test('habits are saved and loaded again', () async {
    await controller.add(habit('a'));
    await controller.toggleToday('a');
    await controller.setDarkMode(true);
    final reloaded = HabitController(
      await HabitStorage.open(),
      clock: () => now,
    );
    await reloaded.load();
    expect(reloaded.habits.single.isDoneOn(now), isTrue);
    expect(reloaded.darkMode, isTrue);
  });

  test('demo data ranks habits by streak', () async {
    await controller.loadDemo();
    expect(controller.habits.length, 6);
    final ranked = controller.rankedByStreak;
    expect(
      ranked.first.currentStreak(now) >= ranked.last.currentStreak(now),
      isTrue,
    );
  });
}
