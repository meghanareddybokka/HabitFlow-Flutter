import '../utils/day_key.dart';
import 'habit_category.dart';

/// A habit and the set of days on which it was completed.
class Habit {
  Habit({
    required this.id,
    required this.name,
    required this.category,
    required this.iconIndex,
    required this.colorIndex,
    required this.createdAt,
    Set<String>? completedDays,
    this.note = '',
  }) : completedDays = completedDays ?? <String>{};

  final String id;
  final String name;
  final HabitCategory category;
  final int iconIndex;
  final int colorIndex;
  final DateTime createdAt;
  final String note;

  /// Days stored as yyyy-MM-dd keys.
  final Set<String> completedDays;

  bool isDoneOn(DateTime day) => completedDays.contains(DayKey.of(day));

  Habit copyWith({
    String? name,
    HabitCategory? category,
    int? iconIndex,
    int? colorIndex,
    String? note,
    Set<String>? completedDays,
  }) {
    return Habit(
      id: id,
      name: name ?? this.name,
      category: category ?? this.category,
      iconIndex: iconIndex ?? this.iconIndex,
      colorIndex: colorIndex ?? this.colorIndex,
      createdAt: createdAt,
      note: note ?? this.note,
      completedDays: completedDays ?? {...this.completedDays},
    );
  }

  /// Returns a copy with [day] ticked or unticked.
  Habit toggled(DateTime day) {
    final key = DayKey.of(day);
    final days = {...completedDays};
    if (!days.remove(key)) days.add(key);
    return copyWith(completedDays: days);
  }

  /// Consecutive completed days ending today (or yesterday if today is still open).
  int currentStreak(DateTime today) {
    var day = DayKey.dateOnly(today);
    if (!isDoneOn(day)) day = day.subtract(const Duration(days: 1));
    var streak = 0;
    while (isDoneOn(day)) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }

  /// Longest run of consecutive completed days ever.
  int get bestStreak {
    final days = completedDays.map(DayKey.parse).toList()..sort();
    var best = 0;
    var run = 0;
    DateTime? previous;
    for (final d in days) {
      run = (previous != null && d.difference(previous).inDays == 1)
          ? run + 1
          : 1;
      if (run > best) best = run;
      previous = d;
    }
    return best;
  }

  /// Share of days completed in the last [days] days (or since creation if newer).
  double completionRate(DateTime today, {int days = 30}) {
    final start = DayKey.dateOnly(today).subtract(Duration(days: days - 1));
    final created = DayKey.dateOnly(createdAt);
    final from = created.isAfter(start) ? created : start;
    final total = DayKey.dateOnly(today).difference(from).inDays + 1;
    if (total <= 0) return 0;
    var done = 0;
    for (var i = 0; i < total; i++) {
      if (isDoneOn(from.add(Duration(days: i)))) done++;
    }
    return done / total;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category.name,
    'icon': iconIndex,
    'color': colorIndex,
    'createdAt': createdAt.toIso8601String(),
    'note': note,
    'done': completedDays.toList()..sort(),
  };

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
    id: json['id'] as String,
    name: json['name'] as String,
    category: HabitCategory.fromName(json['category'] as String),
    iconIndex: json['icon'] as int,
    colorIndex: json['color'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
    note: (json['note'] as String?) ?? '',
    completedDays: {...(json['done'] as List<dynamic>).cast<String>()},
  );
}
