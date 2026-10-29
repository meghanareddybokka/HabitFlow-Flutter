import 'package:flutter/material.dart';

/// Bar chart of completed habits per day, drawn with CustomPainter.
class WeeklyChart extends StatelessWidget {
  const WeeklyChart({
    super.key,
    required this.values,
    required this.labels,
    required this.maxValue,
  });

  final List<int> values;
  final List<String> labels;
  final int maxValue;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 190,
      child: CustomPaint(
        size: Size.infinite,
        painter: _ChartPainter(
          values,
          labels,
          maxValue,
          scheme.primary,
          scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  _ChartPainter(this.values, this.labels, this.maxValue, this.color, this.text);

  final List<int> values;
  final List<String> labels;
  final int maxValue;
  final Color color;
  final Color text;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    const bottom = 22.0;
    const top = 18.0;
    final h = size.height - bottom - top;
    final slot = size.width / values.length;
    final w = slot * 0.5;
    final top0 = maxValue <= 0 ? 1 : maxValue;
    for (var i = 0; i < values.length; i++) {
      final barH = h * values[i] / top0;
      final x = i * slot + (slot - w) / 2;
      final isLast = i == values.length - 1;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, top + h - barH, w, barH),
          const Radius.circular(9),
        ),
        Paint()..color = isLast ? color : color.withValues(alpha: 0.4),
      );
      _text(
        canvas,
        '${values[i]}',
        Offset(x + w / 2, top + h - barH - 16),
        FontWeight.w700,
      );
      _text(
        canvas,
        labels[i],
        Offset(x + w / 2, size.height - 16),
        FontWeight.w600,
      );
    }
  }

  void _text(Canvas canvas, String s, Offset center, FontWeight weight) {
    final tp = TextPainter(
      text: TextSpan(
        text: s,
        style: TextStyle(color: text, fontSize: 12, fontWeight: weight),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy));
  }

  @override
  bool shouldRepaint(covariant _ChartPainter old) =>
      old.values != values || old.maxValue != maxValue;
}
