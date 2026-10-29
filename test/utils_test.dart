import 'package:flutter_test/flutter_test.dart';
import 'package:habit_flow/utils/day_key.dart';
import 'package:habit_flow/utils/greeting.dart';
import 'package:habit_flow/utils/habit_validators.dart';

void main() {
  test('day keys are zero padded and reversible', () {
    final d = DateTime(2026, 3, 5, 18, 30);
    expect(DayKey.of(d), '2026-03-05');
    expect(DayKey.parse('2026-03-05'), DateTime(2026, 3, 5));
  });

  test('lastDays returns oldest first and ends today', () {
    final days = DayKey.lastDays(DateTime(2026, 10, 21, 12), 7);
    expect(days.length, 7);
    expect(days.first, DateTime(2026, 10, 15));
    expect(days.last, DateTime(2026, 10, 21));
  });

  test('greeting depends on the time of day', () {
    expect(greetingFor(DateTime(2026, 10, 21, 8)), 'Good morning');
    expect(greetingFor(DateTime(2026, 10, 21, 14)), 'Good afternoon');
    expect(greetingFor(DateTime(2026, 10, 21, 20)), 'Good evening');
  });

  test('habit name validation', () {
    expect(HabitValidators.name(''), isNotNull);
    expect(HabitValidators.name('ab'), isNotNull);
    expect(HabitValidators.name('Read 10 pages'), isNull);
  });
}
