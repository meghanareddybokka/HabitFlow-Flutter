/// Groups that a habit can belong to.
enum HabitCategory {
  health('Health'),
  study('Study'),
  fitness('Fitness'),
  mindfulness('Mindfulness'),
  productivity('Productivity'),
  other('Other');

  const HabitCategory(this.label);

  final String label;

  static HabitCategory fromName(String name) => HabitCategory.values.firstWhere(
    (c) => c.name == name,
    orElse: () => HabitCategory.other,
  );
}
