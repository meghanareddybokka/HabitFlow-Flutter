import 'package:flutter/material.dart';

import '../models/habit_style.dart';

/// Grid of selectable icons and a row of selectable colours.
class StylePicker extends StatelessWidget {
  const StylePicker({
    super.key,
    required this.iconIndex,
    required this.colorIndex,
    required this.onIcon,
    required this.onColor,
  });

  final int iconIndex;
  final int colorIndex;
  final ValueChanged<int> onIcon;
  final ValueChanged<int> onColor;

  @override
  Widget build(BuildContext context) {
    final color = HabitStyle.color(colorIndex);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Icon', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < HabitStyle.icons.length; i++)
              InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => onIcon(i),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: i == iconIndex
                        ? color.withValues(alpha: 0.18)
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: i == iconIndex ? color : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    HabitStyle.icons[i],
                    color: i == iconIndex ? color : null,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Colour', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: [
            for (var i = 0; i < HabitStyle.colors.length; i++)
              GestureDetector(
                onTap: () => onColor(i),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: HabitStyle.colors[i],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: i == colorIndex
                          ? Theme.of(context).colorScheme.onSurface
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: i == colorIndex
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 18,
                        )
                      : null,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
