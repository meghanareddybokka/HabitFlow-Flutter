import 'package:flutter/material.dart';

import '../state/habit_controller.dart';

/// Theme, demo data and reset options.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.controller});

  final HabitController controller;

  Future<void> _reset(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset all habits?'),
        content: const Text(
          'Every habit and its history will be deleted from this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
    if (ok == true) await controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode_rounded),
              title: const Text('Dark mode'),
              subtitle: const Text('Easier on the eyes at night'),
              value: controller.darkMode,
              onChanged: controller.setDarkMode,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.auto_awesome_rounded),
                  title: const Text('Load demo habits'),
                  subtitle: const Text(
                    'Six student habits with 6 weeks of history',
                  ),
                  onTap: controller.loadDemo,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.restart_alt_rounded,
                    color: Colors.red,
                  ),
                  title: const Text('Reset all habits'),
                  onTap: () => _reset(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'HabitFlow v1.0.0 · Built with Flutter',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
