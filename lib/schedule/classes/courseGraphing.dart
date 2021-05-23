import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:instiapp/schedule/classes/courseClass.dart';
import 'package:instiapp/schedule/classes/scoresClass.dart';

class CourseGraph extends StatefulWidget {
  Course course;
  CourseGraph(this.course);
  @override
  State<StatefulWidget> createState() => CourseGraphState();
}

class CourseGraphState extends State<CourseGraph> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          color: Colors.black87,
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Performance with Time',
                  style: TextStyle(
                      color: Colors.white,
                      // fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      sampleData1(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        horizontalInterval: 25,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          // rotateAngle: -30,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 8,
          reservedSize: 30,
          interval: 25,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      // maxX: 14,
      maxY: 100,
      minY: 0,
      lineBarsData: linesBarData(),
    );
  }

  List<LineChartBarData> linesBarData() {
    List<FlSpot> spots = [];

    for (int i = 0; i < widget.course.scores.length; i++) {
      Score score = widget.course.scores[i];
      spots.add(FlSpot(i.toDouble(), score.score * 100 / score.total));
    }
    var lineChartBarData1 = LineChartBarData(
      spots: spots,
      isCurved: false,
      colors: [Colors.white],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData:
          BarAreaData(show: true, colors: [Colors.white.withAlpha(50)]),
    );
    return [
      lineChartBarData1,
    ];
  }
}
