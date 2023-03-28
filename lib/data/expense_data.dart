import 'package:expence_trakcer/date_time/hive_database.dart';
import 'package:expence_trakcer/models/expense_item.dart';
import 'package:expence_trakcer/date_time/date_time_help.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  /// list of expenses
  List<ExpenseItem> _expenses = [];

  /// get total expenses
  List<ExpenseItem> get expenses => _expenses;

  /// prepare data to display
  final db = HiveDataBase();
  void prepareData() {
    // if there exists data in the box
    if (db.readData().isNotEmpty) {
      // read data from the box
      _expenses = db.readData();
    }
  }

  /// add expense to list
  void addExpense(ExpenseItem expense) {
    _expenses.add(expense);
    notifyListeners();
    db.writeData(expenses);
  }

  /// remove expense
  void removeExpense(ExpenseItem expense) {
    _expenses.remove(expense);
    notifyListeners();
    db.writeData(expenses);
  }

  /// get weekday from dateTime object
  String getWeekDay(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return 'Error';
    }
  }

  /// get the date for the start of the week
  DateTime getStartOfWeek(DateTime date) {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getWeekDay(today.subtract(Duration(days: i))) == 'Sat') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  // convert list to graph data
  Map<String, double> calculateDailyExpencesSummery() {
    Map<String, double> dailyExpenses = {
      // date (yyyymmdd): total expenses
    };

    for (ExpenseItem expense in _expenses) {
      String date = dateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      // check if date already exists
      if (dailyExpenses.containsKey(date)) {
        double currentAmount = dailyExpenses[date]!;
        dailyExpenses[date] = currentAmount + amount;
      } else {
        dailyExpenses[date] = amount;
      }
    }

    return dailyExpenses;
  }
}
