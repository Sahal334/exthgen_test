import 'dart:math';

import 'package:flutter/material.dart';

class MoodWheelCustomPainter extends CustomPainter {
  MoodWheelCustomPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 130.0;

    final circlePaint = Paint()
      ..color = const Color(0xFFD5E660)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, circlePaint);

    _drawDottedArc(canvas, center, radius);

    _drawSharpBumps(canvas, center, radius);

    _drawEmojisOnArc(canvas, center, radius);

    final moods = [
      {'label': 'Good', 'angle': -90.0, 'position': 'top'},
      {'label': 'Shied', 'angle': 180.0, 'position': 'left'},
      {'label': 'Stressed', 'angle': 0.0, 'position': 'right'},
      {'label': 'Angry', 'angle': 90.0, 'position': 'bottom'},
    ];

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    final moodColors = {
      'Good': const Color(0xFFC1D73F),
      'Shy': const Color(0xFFA7D1DE),
      'Stressed': const Color(0xFFE0B3B6),
      'Angry': const Color(0xFFDC6285),
    };

    for (final mood in moods) {
      final label = mood['label'] as String;
      final angle = mood['angle'] as double;

      final angleInRadians = angle * (3.14159 / 180);
      final textRadius = radius - 35;

      final textX = center.dx + textRadius * cos(angleInRadians);
      final textY = center.dy + textRadius * sin(angleInRadians);

      final moodColor = moodColors[label] ?? Colors.black;

      final textPainter = TextPainter(
        text: TextSpan(
            text: label.toUpperCase(),
            style: textStyle.copyWith(
              color: moodColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            )),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      final offsetX = textPainter.width / 2;
      final offsetY = textPainter.height / 2;

      textPainter.paint(
        canvas,
        Offset(textX - offsetX, textY - offsetY),
      );
    }
  }

  void _drawDottedArc(Canvas canvas, Offset center, double radius) {
    final arcRadius = radius + 50; // Increased arc radius (was 40)
    final paint = Paint()
      ..color = Colors.grey.shade400 // Changed to gray shade 500
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final startAngle = -170 * (pi / 180);
    final sweepAngle = 160 * (pi / 180);

    const dotLength = 0.1;
    const gapLength = 0.08;

    double currentAngle = startAngle;
    while (currentAngle < startAngle + sweepAngle) {
      final rect = Rect.fromCircle(center: center, radius: arcRadius);
      canvas.drawArc(rect, currentAngle, dotLength, false, paint);
      currentAngle += dotLength + gapLength;
    }
  }

  void _drawSharpBumps(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = const Color(0xFFD5E660).withOpacity(0.8)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final startAngle = -170 * (pi / 180);
    final sweepAngle = 160 * (pi / 180);

    for (int i = 0; i < 5; i++) {
      final bumpAngle = startAngle + (sweepAngle * i / (5 - 1));

      final startX = center.dx + radius * cos(bumpAngle);
      final startY = center.dy + radius * sin(bumpAngle);

      final endRadius = radius + 10;
      final endX = center.dx + endRadius * cos(bumpAngle);
      final endY = center.dy + endRadius * sin(bumpAngle);

      final path = Path();

      final perpAngle = bumpAngle + pi / 2;
      final baseWidth = 5;

      final baseX1 = startX + baseWidth * cos(perpAngle);
      final baseY1 = startY + baseWidth * sin(perpAngle);
      final baseX2 = startX - baseWidth * cos(perpAngle);
      final baseY2 = startY - baseWidth * sin(perpAngle);
      path.moveTo(baseX1, baseY1);

      final controlPoint1X = baseX1 + (endX - baseX1) * 0.7;
      final controlPoint1Y = baseY1 + (endY - baseY1) * 0.3;
      path.quadraticBezierTo(controlPoint1X, controlPoint1Y, endX, endY);

      final controlPoint2X = baseX2 + (endX - baseX2) * 0.7;
      final controlPoint2Y = baseY2 + (endY - baseY2) * 0.3;
      path.quadraticBezierTo(controlPoint2X, controlPoint2Y, baseX2, baseY2);

      final baseCenterX = (baseX1 + baseX2) / 2;
      final baseCenterY = (baseY1 + baseY2) / 2;
      path.quadraticBezierTo(baseCenterX, baseCenterY, baseX1, baseY1);

      final shadowPaint = Paint()
        ..color = const Color(0xFFD5E660).withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

      final shadowPath = Path.from(path);
      shadowPath.transform(Matrix4.translationValues(1, 1, 0).storage);
      canvas.drawPath(shadowPath, shadowPaint);

      canvas.drawPath(path, paint);
    }
  }

  void _drawEmojisOnArc(Canvas canvas, Offset center, double radius) {
    final arcRadius = radius + 50;
    final emojis = ['😊', '😍', '😎', '🤔', '😴'];

    final containerColors = [
      const Color(0xFFE7CDC3),
      const Color(0xFFA5D3E0),
      const Color(0xFFD9ED60),
      const Color(0xFFFFC300),
      const Color(0xFFF4D8D0),
    ];

    final startAngle = -170 * (pi / 180);
    final sweepAngle = 160 * (pi / 180);

    final textStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
    );

    final containerSize = 60.0;

    for (int i = 0; i < emojis.length; i++) {
      final emojiAngle = startAngle + (sweepAngle * i / (emojis.length - 1));

      final emojiX = center.dx + arcRadius * cos(emojiAngle);
      final emojiY = center.dy + arcRadius * sin(emojiAngle);

      final containerRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(emojiX, emojiY),
          width: containerSize,
          height: containerSize,
        ),
        const Radius.circular(10),
      );

      final containerPaint = Paint()
        ..color = containerColors[i]
        ..style = PaintingStyle.fill;

      canvas.drawRRect(containerRect, containerPaint);

      final borderPaint = Paint()
        ..color = containerColors[i].withOpacity(0.8)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawRRect(containerRect, borderPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: emojis[i],
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      final offsetX = textPainter.width / 2;
      final offsetY = textPainter.height / 2;

      textPainter.paint(
        canvas,
        Offset(emojiX - offsetX, emojiY - offsetY),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}

class IntakeData {
  IntakeData(this.day, this.value, this.color);
  final String day;
  final double value;
  final Color color;
}

class CircleChartData {
  CircleChartData(this.mood, this.value, this.color);
  final String mood;
  final double value;
  final Color color;
}