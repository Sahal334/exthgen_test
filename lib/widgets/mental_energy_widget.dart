import 'package:exthgen_test/widgets/custom_gradient.dart';
import 'package:flutter/material.dart';

class MentalEnergyWidget extends StatefulWidget {
  final int energyPercentage;

  const MentalEnergyWidget({
    Key? key,
    required this.energyPercentage,
  }) : super(key: key);

  @override
  State<MentalEnergyWidget> createState() => _MentalEnergyWidgetState();
}

class _MentalEnergyWidgetState extends State<MentalEnergyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _barsAnimation;
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  int dayToIndex(String day) => days.indexOf(day);

  final List<RangeBarData> data = [
    RangeBarData('Green 1', 'Mon', 'Wed', Color(0xFFD5E660)),
    RangeBarData('Pink 2', 'Fri', 'Sun', Color(0xFFE8B4FD)),
    RangeBarData('Blue 1', 'Tue', 'Wed', Color(0xFFB4D4FF)),
    RangeBarData('Green 2', 'Fri', 'Sat', Color(0xFFD5E660)),
    RangeBarData('Pink 1', 'Tue', 'Thu', Color(0xFFE8B4FD)),
    RangeBarData('Blue 2', 'Thu', 'Sat', Color(0xFFB4D4FF)),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.energyPercentage.toDouble(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _barsAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return _buildMentalEnergySection();
      },
    );
  }

  Widget _buildMentalEnergySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color(0xFFE5E6E3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'YOUR MENTAL ENERGY',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFB5C54E),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${_progressAnimation.value.round()}',
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const TextSpan(
                        text: '%',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(double.infinity, 100),
                        painter: GridPainter(days.length),
                      ),
                      CustomPaint(
                        size: Size(double.infinity, 120),
                        painter: RangeBarPainter(
                          data,
                          dayToIndex,
                          _barsAnimation.value,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: days
                      .map((day) => Text(day, style: const TextStyle(color: Colors.grey)))
                      .toList(),
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Transform.scale(
                scale: 0.8 + (0.2 * _barsAnimation.value),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration:BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD5E660), Color(0xFFE8B4FD)],
                    ),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.psychology_outlined,
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RangeBarData {
  final String name;
  final String startDay;
  final String endDay;
  final Color color;

  RangeBarData(this.name, this.startDay, this.endDay, this.color);
}

class GridPainter extends CustomPainter {
  final int dayCount;

  GridPainter(this.dayCount);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0 || dayCount <= 0) return;

    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1;

    for (int i = 0; i <= dayCount; i++) {
      final x = (size.width / dayCount) * i;
      if (x.isFinite) {
        canvas.drawLine(
          Offset(x, 0),
          Offset(x, size.height),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RangeBarPainter extends CustomPainter {
  final List<RangeBarData> data;
  final int Function(String) dayToIndex;
  final double animationProgress;

  RangeBarPainter(this.data, this.dayToIndex, this.animationProgress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 ||
        size.height <= 0 ||
        !animationProgress.isFinite ||
        animationProgress < 0) {
      return;
    }

    final double dayWidth = size.width / 7;
    final double barHeight = 20;
    final double barSpacing = 8;

    if (!dayWidth.isFinite || dayWidth <= 0) return;

    for (int i = 0; i < data.length; i++) {
      final range = data[i];
      final startIndex = dayToIndex(range.startDay);
      final endIndex = dayToIndex(range.endDay);

      if (startIndex == -1 || endIndex == -1) continue;

      final double startX = startIndex * dayWidth + (dayWidth * 0.1);
      final double endX = (endIndex + 1) * dayWidth - (dayWidth * 0.1);
      final double y = (i % 3) * (barHeight + barSpacing) + 20;

      if (!startX.isFinite || !endX.isFinite || !y.isFinite || startX >= endX) {
        continue;
      }

      final double animatedWidth = (endX - startX) * animationProgress;

      if (!animatedWidth.isFinite || animatedWidth <= 0) {
        continue;
      }

      final double safeEndX = (startX + animatedWidth).clamp(startX, size.width);
      final double safeY = y.clamp(0.0, size.height - barHeight);

      final rect = Rect.fromLTRB(
          startX,
          safeY,
          safeEndX,
          safeY + barHeight
      );

      if (rect.width <= 0 || rect.height <= 0 || !rect.isFinite) {
        continue;
      }

      final animatedColor = range.color.withOpacity(animationProgress.clamp(0.0, 1.0));

      final paint = Paint()
        ..color = animatedColor
        ..style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        paint,
      );

      if (animationProgress < 1.0) {
        final glowOpacity = (0.3 * (1 - animationProgress)).clamp(0.0, 1.0);
        final glowPaint = Paint()
          ..color = range.color.withOpacity(glowOpacity)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(10)),
          glowPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}