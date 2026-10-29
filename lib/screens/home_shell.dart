import 'package:flutter/material.dart';

import '../state/habit_controller.dart';
import 'add_habit_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';
import 'today_screen.dart';

/// Bottom navigation: Today, Stats, Settings.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.controller});

  final HabitController controller;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;

  void _addHabit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddHabitScreen(controller: widget.controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _tab,
          children: [
            TodayScreen(controller: widget.controller),
            StatsScreen(controller: widget.controller),
            SettingsScreen(controller: widget.controller),
          ],
        ),
      ),
      floatingActionButton: _tab == 0
          ? FloatingActionButton.extended(
              key: const Key('new-habit-fab'),
              onPressed: _addHabit,
              icon: const Icon(Icons.add_rounded),
              label: const Text('New habit'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline_rounded),
            selectedIcon: Icon(Icons.check_circle_rounded),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart_rounded),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
