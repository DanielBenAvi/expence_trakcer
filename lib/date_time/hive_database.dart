import 'package:hive/hive.dart';
import '../models/expense_item.dart';

class HiveDataBase {
  /// reference to the Hive box
  final _myBox = Hive.box('expenses_database');
  final String key = 'expenses';

  /// write data to the box
  /// [expenses] list of expenses to be written to the box
  ///
  /// hive doesn't support list of complex objects
  /// we need to modify the list of objects to a list of lists
  void writeData(List<ExpenseItem> expenses) {
    _myBox.put(key, expenses);
  }

  /// read data from the box
  /// return a list of expenses
  ///
  /// hive doesn't support list of complex objects
  /// convert the list of lists to a list of objects
  /// return the list of objects
  dynamic readData() {
    List<ExpenseItem> expenses = _myBox.get(key) ?? [];

    return expenses;
  }
}
