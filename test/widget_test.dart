import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_flow/app.dart';
import 'package:habit_flow/services/habit_storage.dart';
import 'package:habit_flow/state/habit_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<HabitController> freshController() async {
  SharedPreferences.setMockInitialValues({});
  final c = HabitController(
    await HabitStorage.open(),
    clock: () => DateTime(2026, 10, 21, 9),
  );
  await c.load();
  return c;
}

void main() {
  testWidgets('user creates a habit and ticks it off', (tester) async {
    final controller = await freshController();
    await tester.binding.setSurfaceSize(const Size(430, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(HabitFlowApp(controller: controller));

    expect(find.text('No habits yet'), findsOneWidget);
    await tester.tap(find.byKey(const Key('new-habit-fab')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('habit-name')),
      'Read 10 pages',
    );
    await tester.tap(find.byKey(const Key('save-habit')));
    await tester.pumpAndSettle();

    final id = controller.habits.single.id;
    expect(find.text('0 of 1 done'), findsOneWidget);
    await tester.tap(find.byKey(Key('toggle-$id')));
    await tester.pumpAndSettle();
    expect(find.text('1 of 1 done'), findsOneWidget);
  });

  testWidgets('empty name shows a validation message', (tester) async {
    final controller = await freshController();
    await tester.pumpWidget(HabitFlowApp(controller: controller));
    await tester.tap(find.byKey(const Key('new-habit-fab')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('save-habit')));
    await tester.pump();
    expect(find.text('Please give the habit a name'), findsOneWidget);
  });
}
