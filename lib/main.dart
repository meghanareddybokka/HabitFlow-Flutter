import 'package:flutter/material.dart';

import 'app.dart';
import 'services/habit_storage.dart';
import 'state/habit_controller.dart';

/// HabitFlow entry point: restores saved habits before showing the first screen.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HabitStorage.open();
  final controller = HabitController(storage);
  await controller.load();
  runApp(HabitFlowApp(controller: controller));
}
