import 'package:flutter/material.dart';

import 'screens/home_shell.dart';
import 'state/habit_controller.dart';
import 'theme/habit_theme.dart';

/// Root widget of HabitFlow.
class HabitFlowApp extends StatelessWidget {
  const HabitFlowApp({super.key, required this.controller});

  final HabitController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => MaterialApp(
        title: 'HabitFlow',
        debugShowCheckedModeBanner: false,
        theme: HabitTheme.light(),
        darkTheme: HabitTheme.dark(),
        themeMode: controller.darkMode ? ThemeMode.dark : ThemeMode.light,
        home: HomeShell(controller: controller),
      ),
    );
  }
}
