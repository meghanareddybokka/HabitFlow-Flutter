# 🌱 HabitFlow – Daily Habit Tracker (Flutter)

![Flutter](https://img.shields.io/badge/Flutter-3.47-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.13-0175C2?logo=dart)
![Tests](https://img.shields.io/badge/tests-16%20passing-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)

**HabitFlow** is a simple mobile app that helps students build good daily habits – drinking water,
studying, exercising, sleeping on time. Tick a habit off with one tap, keep your streak alive,
and watch your progress in a calendar heatmap and weekly chart. All data stays on the device.

> One-week technical project · **Bokka Meghana Reddy (24AG1A0509)** · Department of CSE, ACE Engineering College
> · Project guide: **Mr. P. Satish Bhasker** · 15/10/2026 – 21/10/2026

## ✨ Features

| Feature | Description |
|---|---|
| ✅ Today | Progress ring (x of y done), one-tap check-off, streak badge and last-7-days dots for every habit |
| 🔥 Streaks | Current streak, best streak and 30-day completion rate per habit |
| 📅 Heatmap | 5-week calendar heatmap on the habit details screen |
| ➕ New / edit habit | Name, category, 12 icons, 8 colours, optional note – with validation |
| 📊 Statistics | Last-7-days bar chart (CustomPainter) and a streak leaderboard |
| ⚙️ Settings | Dark mode, demo habits, reset all data |
| 💾 Offline storage | Habits and history saved with `shared_preferences` |

## 📱 Screenshots (live execution)

Captured from the running app (`flutter run -d web-server`, phone-size window 412 × 892).

| Empty state | Today (demo data) | Ticking habits | Statistics |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/01_empty.png" width="200"> | <img src="docs/screenshots/02_today.png" width="200"> | <img src="docs/screenshots/03_ticked.png" width="200"> | <img src="docs/screenshots/04_stats.png" width="200"> |

| Habit details & heatmap | New habit | Validation | Habit created |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/05_detail.png" width="200"> | <img src="docs/screenshots/06_new_habit.png" width="200"> | <img src="docs/screenshots/08_validation.png" width="200"> | <img src="docs/screenshots/09_created.png" width="200"> |

| Settings | Dark mode | Reset dialog |
|:---:|:---:|:---:|
| <img src="docs/screenshots/07_settings.png" width="200"> | <img src="docs/screenshots/10_dark_mode.png" width="200"> | <img src="docs/screenshots/11_reset_dialog.png" width="200"> |

## 🖥️ Output

### Running the app
```text
$ flutter run -d web-server --web-port 8089 --release
Launching lib/main.dart on Web Server in release mode...
Compiling lib/main.dart for the Web...                             12.3s
✓ Built build/web
lib/main.dart is being served at http://127.0.0.1:8089
```
<img src="docs/terminal_run.png" width="700">

### Analyzer and tests
```text
$ flutter analyze
No issues found!

$ flutter test --reporter expanded
00:00 +0: test/habit_model_test.dart: current streak counts back from today
00:00 +1: test/habit_model_test.dart: current streak still counts when today is not ticked yet
00:00 +2: test/habit_model_test.dart: best streak finds the longest run
00:00 +3: test/habit_model_test.dart: toggled adds and removes today
00:00 +4: test/habit_model_test.dart: completion rate since creation
00:00 +5: test/habit_model_test.dart: JSON round trip keeps every field
00:00 +6: test/utils_test.dart: day keys are zero padded and reversible
00:00 +7: test/utils_test.dart: lastDays returns oldest first and ends today
00:00 +8: test/utils_test.dart: greeting depends on the time of day
00:00 +9: test/utils_test.dart: habit name validation
00:01 +10: test/widget_test.dart: user creates a habit and ticks it off
00:02 +11: test/widget_test.dart: empty name shows a validation message
00:02 +12: test/controller_test.dart: add, toggle and delete habits
00:02 +13: test/controller_test.dart: weekly completions cover the last seven days
00:02 +14: test/controller_test.dart: habits are saved and loaded again
00:02 +15: test/controller_test.dart: demo data ranks habits by streak
00:02 +16: All tests passed!
```
<img src="docs/terminal_test.png" width="700">

## 🏗️ Architecture

<img src="docs/architecture.png" width="800">

1. **UI layer** – screens (`lib/screens`) built from small widgets (`lib/widgets`), including a CustomPainter progress ring and bar chart.
2. **Logic layer** – `HabitController` (`ChangeNotifier`) toggles days, calculates streaks, rates and weekly totals; the UI rebuilds with `ListenableBuilder`.
3. **Data layer** – the `Habit` model stores completed days as `yyyy-MM-dd` keys and `HabitStorage` saves everything with `shared_preferences`.

## 📁 Project structure

```text
lib/
├── main.dart                 # restores saved habits, starts the app
├── app.dart                  # MaterialApp + light/dark theme
├── models/                   # Habit, HabitCategory, HabitStyle (icons & colours)
├── services/habit_storage.dart
├── state/habit_controller.dart
├── data/demo_habits.dart     # six demo habits with 6 weeks of history
├── theme/                    # colours + Material 3 themes
├── utils/                    # day keys, greeting, validators
├── widgets/                  # progress ring, habit card, heatmap, weekly chart …
└── screens/                  # home shell, today, details, new habit, stats, settings
test/                         # 16 unit + widget tests
docs/                         # screenshots, architecture diagram, terminal output
```
