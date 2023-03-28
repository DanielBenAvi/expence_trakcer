import 'bar_graph_item.dart';

class BarData {
  final double sundayAmount;
  final double mondayAmount;
  final double tuesdayAmount;
  final double wednesdayAmount;
  final double thursdayAmount;
  final double fridayAmount;
  final double saturdayAmount;

  List<BarGraphItem> barGraphItems = [];

  BarData({
    required this.sundayAmount,
    required this.mondayAmount,
    required this.tuesdayAmount,
    required this.wednesdayAmount,
    required this.thursdayAmount,
    required this.fridayAmount,
    required this.saturdayAmount,
  });

  void initBarGraphItems() {
    barGraphItems = [
      BarGraphItem(x: 0, y: sundayAmount), // sunday
      BarGraphItem(x: 1, y: mondayAmount), // monday
      BarGraphItem(x: 2, y: tuesdayAmount), // tuesday
      BarGraphItem(x: 3, y: wednesdayAmount), // wednesday
      BarGraphItem(x: 4, y: thursdayAmount), // thursday
      BarGraphItem(x: 5, y: fridayAmount), // friday
      BarGraphItem(x: 6, y: saturdayAmount), // saturday
    ];
  }
}
