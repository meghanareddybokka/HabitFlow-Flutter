import 'package:flutter/foundation.dart';

import '../data/demo_habits.dart';
import '../models/habit.dart';
import '../services/habit_storage.dart';
import '../utils/day_key.dart';

/// Holds all habits, applies changes, saves them and notifies the UI.
class HabitController extends ChangeNotifier {
  HabitController(this._storage, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final HabitStorage _storage;
  final DateTime Function() _clock;
  List<Habit> _habits = [];
  bool _darkMode = false;

  List<Habit> get habits => List.unmodifiable(_habits);
  bool get darkMode => _darkMode;
  DateTime get today => _clock();

  Future<void> load() async {
    _habits = _storage.readHabits();
    _darkMode = _storage.readDarkMode();
    notifyListeners();
  }

  Habit? byId(String id) {
    for (final h in _habits) {
      if (h.id == id) return h;
    }
    return null;
  }

  Future<void> add(Habit habit) async {
    _habits = [..._habits, habit];
    await _save();
  }

  Future<void> update(Habit habit) async {
    _habits = [for (final h in _habits) h.id == habit.id ? habit : h];
    await _save();
  }

  Future<void> delete(String id) async {
    _habits = _habits.where((h) => h.id != id).toList();
    await _save();
  }

  Future<void> toggleToday(String id) async {
    final habit = byId(id);
    if (habit == null) return;
    await update(habit.toggled(today));
  }

  Future<void> loadDemo() async {
    _habits = DemoHabits.build(today);
    await _save();
  }

  Future<void> reset() async {
    _habits = [];
    await _save();
  }

  Future<void> setDarkMode(bool value) async {
    _darkMode = value;
    await _storage.writeDarkMode(value);
    notifyListeners();
  }

  // ------------------------------------------------------------- statistics
  int get doneToday => _habits.where((h) => h.isDoneOn(today)).length;

  double get todayProgress => _habits.isEmpty ? 0 : doneToday / _habits.length;

  /// Number of habits completed on each of the last 7 days (oldest first).
  List<MapEntry<DateTime, int>> weeklyCompletions() => [
    for (final d in DayKey.lastDays(today, 7))
      MapEntry(d, _habits.where((h) => h.isDoneOn(d)).length),
  ];

  double get averageRate {
    if (_habits.isEmpty) return 0;
    return _habits.map((h) => h.completionRate(today)).reduce((a, b) => a + b) /
        _habits.length;
  }

  Habit? get longestStreakHabit {
    if (_habits.isEmpty) return null;
    return _habits.reduce(
      (a, b) => a.currentStreak(today) >= b.currentStreak(today) ? a : b,
    );
  }

  List<Habit> get rankedByStreak => [..._habits]
    ..sort((a, b) => b.currentStreak(today).compareTo(a.currentStreak(today)));

  Future<void> _save() async {
    await _storage.writeHabits(_habits);
    notifyListeners();
  }
}
