/// Converts dates to stable yyyy-MM-dd keys and formats them for display.
class DayKey {
  DayKey._();

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  static const _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  static String of(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static DateTime parse(String key) {
    final p = key.split('-').map(int.parse).toList();
    return DateTime(p[0], p[1], p[2]);
  }

  /// "Thursday, 29 Oct"
  static String headline(DateTime d) =>
      '${_days[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]}';

  /// "29 Oct 2026"
  static String format(DateTime d) =>
      '${d.day} ${_months[d.month - 1]} ${d.year}';

  /// Single letter weekday for charts: M T W T F S S
  static String initial(DateTime d) => _days[d.weekday - 1][0];

  /// Last [count] days ending today, oldest first.
  static List<DateTime> lastDays(DateTime today, int count) {
    final t = dateOnly(today);
    return List.generate(
      count,
      (i) => t.subtract(Duration(days: count - 1 - i)),
    );
  }
}
