import 'package:flutter_test/flutter_test.dart';
import 'package:habit_flow/models/habit.dart';
import 'package:habit_flow/models/habit_category.dart';

Habit make(Set<String> days) => Habit(
  id: 'h',
  name: 'Read',
  category: HabitCategory.study,
  iconIndex: 1,
  colorIndex: 2,
  createdAt: DateTime(2026, 10, 1),
  completedDays: days,
);

void main() {
  final today = DateTime(2026, 10, 21, 9);

  test('current streak counts back from today', () {
    final h = make({'2026-10-19', '2026-10-20', '2026-10-21'});
    expect(h.currentStreak(today), 3);
  });

  test('current streak still counts when today is not ticked yet', () {
    final h = make({'2026-10-18', '2026-10-19', '2026-10-20'});
    expect(h.currentStreak(today), 3);
  });

  test('best streak finds the longest run', () {
    final h = make({
      '2026-10-01',
      '2026-10-02',
      '2026-10-03',
      '2026-10-04',
      '2026-10-10',
      '2026-10-11',
    });
    expect(h.bestStreak, 4);
  });

  test('toggled adds and removes today', () {
    final h = make({});
    final on = h.toggled(today);
    expect(on.isDoneOn(today), isTrue);
    expect(on.toggled(today).isDoneOn(today), isFalse);
  });

  test('completion rate since creation', () {
    final h = Habit(
      id: 'x',
      name: 'Walk',
      category: HabitCategory.fitness,
      iconIndex: 0,
      colorIndex: 0,
      createdAt: DateTime(2026, 10, 18),
      completedDays: {'2026-10-18', '2026-10-20'},
    );
    expect(h.completionRate(today), 0.5);
  });

  test('JSON round trip keeps every field', () {
    final h = make({'2026-10-20'});
    final back = Habit.fromJson(h.toJson());
    expect(back.name, 'Read');
    expect(back.category, HabitCategory.study);
    expect(back.completedDays, {'2026-10-20'});
    expect(back.createdAt, DateTime(2026, 10, 1));
  });
}
