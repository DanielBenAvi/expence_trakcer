import 'package:expence_trakcer/components/bar_graph/bar_graph.dart';
import 'package:expence_trakcer/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../date_time/date_time_help.dart';

class Summary extends StatelessWidget {
  final DateTime startOfWeek;
  const Summary({
    super.key,
    required this.startOfWeek,
  });

  @override
  Widget build(BuildContext context) {
    String sunday = dateTimeToString(startOfWeek);
    String monday = dateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday = dateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        dateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        dateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday = dateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        dateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: 100,
          sundayAmount: value.calculateDailyExpencesSummery()[sunday] ?? 0,
          mondayAmount: value.calculateDailyExpencesSummery()[monday] ?? 0,
          tuesdayAmount: value.calculateDailyExpencesSummery()[tuesday] ?? 0,
          wednesdayAmount:
              value.calculateDailyExpencesSummery()[wednesday] ?? 0,
          thursdayAmount: value.calculateDailyExpencesSummery()[thursday] ?? 0,
          fridayAmount: value.calculateDailyExpencesSummery()[friday] ?? 0,
          saturdayAmount: value.calculateDailyExpencesSummery()[saturday] ?? 0,
        ),
      ),
    );
  }
}
