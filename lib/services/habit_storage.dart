import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/habit.dart';

/// Saves habits and settings on the device with shared_preferences.
class HabitStorage {
  HabitStorage._(this._prefs);

  static const _habitsKey = 'habits_v1';
  static const _darkKey = 'dark_mode';

  final SharedPreferences _prefs;

  static Future<HabitStorage> open() async =>
      HabitStorage._(await SharedPreferences.getInstance());

  List<Habit> readHabits() {
    final raw = _prefs.getString(_habitsKey);
    if (raw == null || raw.isEmpty) return [];
    return (jsonDecode(raw) as List<dynamic>)
        .map((e) => Habit.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> writeHabits(List<Habit> habits) => _prefs.setString(
    _habitsKey,
    jsonEncode(habits.map((h) => h.toJson()).toList()),
  );

  bool readDarkMode() => _prefs.getBool(_darkKey) ?? false;

  Future<void> writeDarkMode(bool value) => _prefs.setBool(_darkKey, value);
}
