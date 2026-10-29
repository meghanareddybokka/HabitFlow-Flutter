import 'package:flutter/material.dart';

/// Placeholder shown before any habit exists.
class EmptyHabits extends StatelessWidget {
  const EmptyHabits({super.key, required this.onDemo});

  final VoidCallback onDemo;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      child: Column(
        children: [
          Icon(
            Icons.eco_rounded,
            size: 76,
            color: scheme.primary.withValues(alpha: 0.45),
          ),
          const SizedBox(height: 12),
          const Text(
            'No habits yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Small daily actions build big results.\nTap "New habit" to add your first one.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton.tonalIcon(
            onPressed: onDemo,
            icon: const Icon(Icons.auto_awesome_rounded),
            label: const Text('Try demo habits'),
          ),
        ],
      ),
    );
  }
}
