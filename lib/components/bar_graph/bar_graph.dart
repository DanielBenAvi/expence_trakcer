import 'package:expence_trakcer/components/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sundayAmount;
  final double mondayAmount;
  final double tuesdayAmount;
  final double wednesdayAmount;
  final double thursdayAmount;
  final double fridayAmount;
  final double saturdayAmount;

  const MyBarGraph({
    super.key,
    this.maxY,
    this.sundayAmount = 0,
    this.mondayAmount = 0,
    this.tuesdayAmount = 0,
    this.wednesdayAmount = 0,
    this.thursdayAmount = 0,
    this.fridayAmount = 0,
    this.saturdayAmount = 0,
  });

  @override
  Widget build(BuildContext context) {
    // init bar data
    BarData barData = BarData(
      sundayAmount: sundayAmount,
      mondayAmount: mondayAmount,
      tuesdayAmount: tuesdayAmount,
      wednesdayAmount: wednesdayAmount,
      thursdayAmount: thursdayAmount,
      fridayAmount: fridayAmount,
      saturdayAmount: saturdayAmount,
    );
    barData.initBarGraphItems();

    return BarChart(BarChartData(
      maxY: maxY ?? 0,
      minY: 0,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getButtomTitles,
        )),
      ),
      barGroups: barData.barGraphItems
          .map((data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.amber[800]!,
                    width: 24,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      color: Colors.white,
                      toY: maxY,
                    ),
                  ),
                ],
              ))
          .toList(),
    ));
  }
}

Widget getButtomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.amber,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget title = Container();
  switch (value.toInt()) {
    case 0:
      title = const Text('S', style: style);
      break;
    case 1:
      title = const Text('M', style: style);
      break;
    case 2:
      title = const Text('T', style: style);
      break;
    case 3:
      title = const Text('W', style: style);
      break;
    case 4:
      title = const Text('T', style: style);
      break;
    case 5:
      title = const Text('F', style: style);
      break;
    case 6:
      title = const Text('S', style: style);
      break;
    default:
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: title,
  );
}
