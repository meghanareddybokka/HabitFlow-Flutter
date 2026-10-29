/// Validation for the add / edit habit form.
class HabitValidators {
  HabitValidators._();

  static String? name(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Please give the habit a name';
    if (v.length < 3) return 'Name is too short';
    if (v.length > 30) return 'Keep the name under 30 characters';
    return null;
  }
}
