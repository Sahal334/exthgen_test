import 'dart:math';

import 'package:exthgen_test/second_screen.dart';
import 'package:exthgen_test/widgets/custom_gradient.dart';
import 'package:exthgen_test/widgets/mood_wheel_custom_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  String selectedMood = 'GOOD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDailyReflection(),
                  _buildMoodSelector(),
                  _buildBottomSection(),
                  _buildSaveMoodButton(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 28,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                    child: const Icon(
                      Icons.more_horiz_outlined,
                      size: 28,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                    child: const Icon(
                      Icons.space_dashboard_outlined,
                      size: 28,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyReflection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily Reflection',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'What is your mood today?',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade900),
              ),
            ],
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFE8D5FF),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.chat_outlined,
              color: Colors.black,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSelector() {
    return SizedBox(
      width: 350,
      height: 350,
      child: CustomPaint(
        painter: MoodWheelCustomPainter(),
        child: Stack(
          children: [
            Positioned.fill(
              child: moodWheelChart(context),
            ),
            Positioned(
              left: 195 - 60,
              top: 195 - 60,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mood',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,fontWeight: FontWeight.w700
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      selectedMood,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC1D73F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomCard(
            'Intake',
            'Deep Talk',
            _buildIntakeChart(),
            Colors.grey.shade200,"💬"
          ),
          _buildBottomCard(
            'Mental\nEffect',
            'Very High',
            _buildMentalEffectChart(),
            Colors.grey.shade200,"🧠"
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCard(
      String title,
      String subtitle,
      Widget content,
      Color bgColor,
      String text,
      ) {
    return Container(
      width: 160,
      height: 160,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade300,
                ),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 1),
          Expanded(child: content),
        ],
      ),
    );
  }


  Widget _buildIntakeChart() {
    final List<IntakeData> chartData = [
      IntakeData('Mon', 75, const Color(0xFFE8B4FD)),
      IntakeData('Tue', 45, const Color(0xFFD5E660)),
      IntakeData('Wed', 85, const Color(0xFFB4D4FF)),
      IntakeData('Thu', 60, const Color(0xFFE8B4FD)),
      IntakeData('Fri', 90, const Color(0xFFDDD6FE)),
      IntakeData('Sat', 55, const Color(0xFFD5E660)),
      IntakeData('Sun', 70, const Color(0xFFB4D4FF)),
    ];

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: const CategoryAxis(
        isVisible: false,
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
      ),
      primaryYAxis: const NumericAxis(
        isVisible: false,
        minimum: 0,
        maximum: 100,
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
      ),
      series: <CartesianSeries<IntakeData, String>>[
        ColumnSeries<IntakeData, String>(
          dataSource: chartData,
          xValueMapper: (IntakeData data, _) => data.day,
          yValueMapper: (IntakeData data, _) => data.value,
          pointColorMapper: (IntakeData data, _) => data.color,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          spacing: 0.1,
          width: 0.8,
        ),
      ],
    );
  }

  Widget _buildMentalEffectChart() {
    final List<ChartData> chartData = [
      ChartData(0, 20),
      ChartData(1, 35),
      ChartData(2, 65),
      ChartData(3, 45),
      ChartData(4, 80),
      ChartData(5, 90),
    ];

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: const NumericAxis(isVisible: false, minimum: 0, maximum: 5),
      primaryYAxis: const NumericAxis(
        isVisible: false,
        minimum: 0,
        maximum: 100,
      ),
      series: <CartesianSeries<ChartData, double>>[
        SplineAreaSeries<ChartData, double>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: const Color(0xFFD5E660).withOpacity(0.3),
          borderColor: const Color(0xFFD5E660),
          borderWidth: 3,
          splineType: SplineType.cardinal,
        ),
      ],
    );
  }

  Widget _buildSaveMoodButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: customGradientButtonDecoration(),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Save Mood',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.save_alt, color: Color(0xFF1A1A1A), size: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget moodWheelChart(BuildContext context) {
    final List<CircleChartData> chartData = [
      CircleChartData('Happy', 20, const Color(0xFFF5D6D0)),
      CircleChartData('Excited', 25, const Color(0xFFF2C4B7)),
      CircleChartData('Calm', 25, const Color(0xFFF7FFD4)),
      CircleChartData('Energetic', 45, const Color(0xFFD5E660)),
    ];

    return Center(
      child: SfCircularChart(
        margin: EdgeInsets.zero,
        series: <CircularSeries>[
          DoughnutSeries<CircleChartData, String>(
            dataSource: chartData,
            pointColorMapper: (CircleChartData data, _) => data.color,
            xValueMapper: (CircleChartData data, _) => data.mood,
            yValueMapper: (CircleChartData data, _) => data.value,
            innerRadius: '80%',
            radius: '30%',
            strokeWidth: 0,
          )
        ],
      ),
    );
  }
}








