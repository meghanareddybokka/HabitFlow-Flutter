import 'package:flutter/material.dart';

import '../models/habit.dart';
import '../models/habit_category.dart';
import '../state/habit_controller.dart';
import '../utils/habit_validators.dart';
import '../widgets/style_picker.dart';

/// Create a new habit or edit an existing one.
class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key, required this.controller, this.existing});

  final HabitController controller;
  final Habit? existing;

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.existing?.name);
  late final _note = TextEditingController(text: widget.existing?.note);
  late HabitCategory _category =
      widget.existing?.category ?? HabitCategory.health;
  late int _icon = widget.existing?.iconIndex ?? 0;
  late int _color = widget.existing?.colorIndex ?? 0;

  bool get _editing => widget.existing != null;

  @override
  void dispose() {
    _name.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final existing = widget.existing;
    if (existing != null) {
      await widget.controller.update(
        existing.copyWith(
          name: _name.text.trim(),
          category: _category,
          iconIndex: _icon,
          colorIndex: _color,
          note: _note.text.trim(),
        ),
      );
    } else {
      await widget.controller.add(
        Habit(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          name: _name.text.trim(),
          category: _category,
          iconIndex: _icon,
          colorIndex: _color,
          createdAt: widget.controller.today,
          note: _note.text.trim(),
        ),
      );
    }
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_editing ? 'Habit updated' : 'Habit added – keep it up!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_editing ? 'Edit habit' : 'New habit')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              key: const Key('habit-name'),
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Habit name',
                hintText: 'e.g. Read 10 pages',
                prefixIcon: Icon(Icons.flag_rounded),
              ),
              validator: HabitValidators.name,
            ),
            const SizedBox(height: 16),
            const Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in HabitCategory.values)
                  ChoiceChip(
                    label: Text(c.label),
                    selected: c == _category,
                    onSelected: (_) => setState(() => _category = c),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            StylePicker(
              iconIndex: _icon,
              colorIndex: _color,
              onIcon: (i) => setState(() => _icon = i),
              onColor: (i) => setState(() => _color = i),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _note,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                prefixIcon: Icon(Icons.notes_rounded),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              key: const Key('save-habit'),
              onPressed: _save,
              icon: const Icon(Icons.check_rounded),
              label: Text(_editing ? 'Update habit' : 'Create habit'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
